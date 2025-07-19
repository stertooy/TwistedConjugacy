###############################################################################
##
## AsElementOfProductGroups@( g, U, V )
##
##  INPUT:
##      g:          element of a group G
##      U:          subgroup of G
##      V:          subgroup of G
##
##  OUTPUT:
##      u:          element of U such that g = u*v
##      v:          element of V such that g = u*v
##
##  REMARKS:
##      returns "fail" if no such u and v exist
##
AsElementOfProductGroups@ := function( g, U, V )
    local G, UxV, l, r, s, u, v;

    G := PcpGroupByCollectorNC( Collector( U ) );
    UxV := DirectProduct( U, V );

    l := Projection( UxV, 1 ) * InclusionHomomorphism( U, G );
    r := Projection( UxV, 2 ) * InclusionHomomorphism( V, G );

    s := RepresentativeTwistedConjugationOp( l, r, g );
    if s = fail then
        return fail;
    fi;

    u := ImagesRepresentative( l, s );
    v := ImagesRepresentative( r, s ) ^ -1;

    return [ u, v ];
end;

###############################################################################
##
## DirectProductInclusions@( G, U, V )
##
##  INPUT:
##      G:          group
##      U:          subgroup of G
##      V:          subgroup of G
##
##  OUTPUT:
##      l:          map U x V -> G: (u,v) -> u
##      r:          map U x V -> G: (u,v) -> v
##
DirectProductInclusions@ := function( G, U, V )
    local UV, iU, iV, l, r;
    UV := DirectProduct( U, V );
    iU := InclusionHomomorphism( U, G );
    iV := InclusionHomomorphism( V, G );
    l := Projection( UV, 1 ) * iU;
    r := Projection( UV, 2 ) * iV;
    return [ l, r ];
end;

###############################################################################
##
## Intersection2( U, V )
##
##  INPUT:
##      U:          subgroup of a PcpGroup G
##      V:          subgroup of a PcpGroup G
##
##  OUTPUT:
##      I:          intersection of U and V
##
InstallMethod(
    Intersection2,
    "for pcp groups, using coincidence groups",
    [ IsPcpGroup, IsPcpGroup ],
    1,
    function( U, V )
        local G, dp, l, r, I;

        # Catch trivial cases
        if IsSubset( V, U ) then
            return U;
        elif IsSubset( U, V ) then
            return V;
        fi;

        # Defer to polycyclic's implementation
        if IsNormal( V, U ) or IsNormal( U, V ) then TryNextMethod(); fi;

        # Use CoincidenceGroup
        G := PcpGroupByCollectorNC( Collector( U ) );
        dp := DirectProductInclusions@( G, U, V );
        l := dp[1];
        r := dp[2];

        I := ImagesSet( l, CoincidenceGroup2( l, r ) );
        if ASSERT@ then
            if not (
                IsSubset( U, I ) and
                IsSubset( V, I )
            ) then Error( "Assertion failure" ); fi;
        fi;
        return I;
    end
);

###############################################################################
##
## Intersection2( U, V )
##
##  INPUT:
##      Ux:         right coset of a PcpGroup G
##      Vy:         right coset of a PcpGroup G
##
##  OUTPUT:
##      Iz:         intersection of Ux and Vy
##
InstallMethod(
    Intersection2,
    "for cosets of pcp groups",
    [ IsRightCoset and IsPcpElementCollection,
      IsRightCoset and IsPcpElementCollection ],
    function( Ux, Vy )
        local U, V, x, y, s, I, z;

        U := ActingDomain( Ux );
        V := ActingDomain( Vy );

        x := Representative( Ux );
        y := Representative( Vy );

        s := AsElementOfProductGroups@( x * y ^ -1, U, V );
        if s = fail then
            return [];
        fi;

        I := Intersection2( U, V );
        z := s[2] * y;

        if ASSERT@ then
            if not (
                IsSubgroup( U, I ) and
                IsSubgroup( V, I ) and
                z in Ux and
                z in Vy
            ) then Error( "Assertion failure" ); fi;
        fi;
        return RightCoset( I, z );
    end
);

###############################################################################
##
## \in( y, UxV )
##
##  INPUT:
##      y:          element of a PcpGroup G
##      UxV:        double coset of a PcpGroup G
##
##  OUTPUT:
##      bool:       true if y belongs to UxV, otherwise false
##
InstallMethod(
    \in,
    "for double cosets of pcp groups",
    [ IsPcpElement, IsDoubleCoset and IsPcpElementCollection ],
    function( y, UxV )
        local U, V, T, x, z, s;

        U := LeftActingGroup( UxV );
        V := RightActingGroup( UxV );

        x := Representative( UxV );
        T := OnPoints( U, x );
        z := OnLeftInverse( y, x );

        s := AsElementOfProductGroups@( z, T, V );
        if ASSERT@ then
            if not IsBool( s ) and not(
                z = s[1] * s[2] and
                s[1] in T and
                s[2] in V
            ) then Error( "Assertion failure" ); fi;
        fi;
        return not IsBool( s );
    end
);

###############################################################################
##
## \=( UxV, UyV )
##
##  INPUT:
##      UxV:        double coset of a PcpGroup G
##      UyV:        double coset of a PcpGroup G
##
##  OUTPUT:
##      bool:       true if UxV = UyV, otherwise false
##
InstallMethod(
    \=,
    "for double cosets of pcp groups",
    [ IsDoubleCoset and IsPcpElementCollection,
      IsDoubleCoset and IsPcpElementCollection ],
    function( UxV, UyV )
        if (
            LeftActingGroup( UxV ) <> LeftActingGroup( UyV ) or
            RightActingGroup( UxV ) <> RightActingGroup( UyV )
        ) then
            return false;
        fi;
        return Representative( UxV ) in UyV;
    end
);

###############################################################################
##
## Size( UxV )
##
##  INPUT:
##      UxV:        double coset of a PcpGroup G
##
##  OUTPUT:
##      size:       the size of the double coset
##
InstallMethod(
    Size,
    "for a double coset of a pcp group",
    [ IsDoubleCoset and IsPcpElementCollection ],
    function( UxV )
        local U, V, x, G, dp, tcc;
        U := LeftActingGroup( UxV );
        V := RightActingGroup( UxV );
        x := Representative( UxV );
        G := PcpGroupByCollectorNC( Collector( U ) );
        dp := DirectProductInclusions@( G, U, V );
        tcc := ReidemeisterClass( dp[1], dp[2], x );
        return Size( tcc );
    end
);

###############################################################################
##
## DoubleCosetRepsAndSizes( G, U, V )
##
##  INPUT:
##      G:          PcpGroup
##      U:          subgroup of G
##      V:          subgroup of G
##
##  OUTPUT:
##      L:          List of double coset representatives and sizes
##
InstallMethod(
    DoubleCosetRepsAndSizes,
    "for pcp groups",
    [ IsPcpGroup, IsPcpGroup, IsPcpGroup ],
    function( G, U, V )
        local dp, Rcl, tcc;
        dp := DirectProductInclusions@( G, U, V );
        Rcl := CallFuncList( ReidemeisterClasses, dp );
        if Rcl = fail then
            return fail;
        fi;
        return List( Rcl, tcc -> [ Representative( tcc ), Size( tcc ) ] );
    end
);

###############################################################################
##
## DoubleCosetsNC( G, U, V )
##
##  INPUT:
##      G:          PcpGroup
##      U:          subgroup of G
##      V:          subgroup of G
##
##  OUTPUT:
##      L:          List of DoubleCosets
##
InstallMethod(
    DoubleCosetsNC,
    "for pcp groups",
    [ IsPcpGroup, IsPcpGroup, IsPcpGroup ],
    function( G, U, V )
        local dp, Rcl, g;
        dp := DirectProductInclusions@( G, U, V );
        Rcl := CallFuncList( RepresentativesReidemeisterClasses, dp );
        if Rcl = fail then
            return fail;
        fi;
        return List( Rcl, g -> DoubleCoset( U, g, V ) );
    end
);
