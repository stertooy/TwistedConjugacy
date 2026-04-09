###############################################################################
##
## AsElementOfProductGroups( g, U, V )
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
TWC.AsElementOfProductGroups := function( g, U, V )
    local G, UxV, l, r, s, u, v;

    G := PcpGroupByCollectorNC( Collector( U ) );
    UxV := DirectProduct( U, V );

    l := Projection( UxV, 1 ) * TWC.InclusionHomomorphism( U, G );
    r := Projection( UxV, 2 ) * TWC.InclusionHomomorphism( V, G );

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
## DirectProductInclusions( G, U, V )
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
TWC.DirectProductInclusions := function( G, U, V )
    local UV, iU, iV, l, r;
    UV := DirectProduct( U, V );
    iU := TWC.InclusionHomomorphism( U, G );
    iV := TWC.InclusionHomomorphism( V, G );
    l := Projection( UV, 1 ) * iU;
    r := Projection( UV, 2 ) * iV;
    return [ l, r ];
end;
