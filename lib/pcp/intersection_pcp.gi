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
        local UV, G, l, r;
        
        # Catch trivial cases
        if IsSubset( V, U ) then
            return U;
        elif IsSubset( U, V ) then
            return V;
        fi;
        
        # Refer to NormalIntersection
        if IsNormal( V, U ) then
            return NormalIntersection( U, V );
        elif IsNormal( U, V ) then
            return NormalIntersection( V, U );
        fi;
        
        # Use CoincidenceGroup
        UV := DirectProduct( U, V );
        G := ClosureGroup( U, V );
        
        l := Projection( UV, 1 ) * InclusionHomomorphism( U, G );
        r := Projection( UV, 2 ) * InclusionHomomorphism( V, G );
        
        return ImagesSet( l, CoincidenceGroup2( l, r ) );
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
        local U, V, x, y, z, s;
        
        U := ActingDomain( Ux );
        V := ActingDomain( Vy );
        
        x := Representative( Ux );
        y := Representative( Vy );
        
        z := x*y^-1;
        s := AsElementOfProductGroups@( z, U, V );
        if s = fail then return []; fi;
        
        return RightCoset( Intersection2( U, V ), s[2]*y );
        
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
        # TODO add assertion here
        return not IsBool( s );
    end
);
