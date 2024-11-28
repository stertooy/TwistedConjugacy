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
        local UV, G, l, r, I;
        
        # Catch trivial cases
        if IsSubset( V, U ) then
            return U;
        elif IsSubset( U, V ) then
            return V;
        fi;
        
        # Defer to polycyclic's implementation
        if IsNormal( V, U ) or IsNormal( U, V ) then TryNextMethod(); fi;
        
        # Use CoincidenceGroup
        UV := DirectProduct( U, V );
        G := PcpGroupByCollectorNC( Collector( U ) );
        
        l := Projection( UV, 1 ) * InclusionHomomorphism( U, G );
        r := Projection( UV, 2 ) * InclusionHomomorphism( V, G );

        I := ImagesSet( l, CoincidenceGroup2( l, r ) );
        if ASSERT@ then
            if not (
                IsSubset( U, I ) and
                IsSubset( V, I )
            ) then Error("Assertion failure"); fi;
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
        
        s := AsElementOfProductGroups@( x*y^-1, U, V );
        if s = fail then return []; fi;

        I := Intersection2( U, V );
        z := s[2]*y;

        if ASSERT@ then
            if not (
                IsSubgroup( U, I ) and
                IsSubgroup( V, I ) and
                z in Ux and
                z in Vy
            ) then Error("Assertion failure"); fi;
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
                z = s[1]*s[2] and
                s[1] in T and
                s[2] in V
            ) then Error("Assertion failure"); fi;
        fi;
        return not IsBool( s );
    end
);
