###############################################################################
##
## IntersectionKernels@( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      N:          intersection of Ker(hom1) and Ker(hom2)
##
IntersectionKernels@ := function( hom1, hom2 )
    return NormalIntersection( Kernel( hom1 ), Kernel( hom2 ) );
end;


###############################################################################
##
## IntersectionPreImage@( hom1, hom2, N )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      M:          normal subgroup of G
##
##  OUTPUT:
##      N:          intersection of hom1^-1(M) and hom2^-1(M)
##
IntersectionPreImage@ := function( hom1, hom2, M )
    return NormalIntersection(
        # TODO: replace by PreImagesSet eventually
        PreImagesSetNC( hom1, NormalIntersection( M, ImagesSource( hom1 ) ) ),
        PreImagesSetNC( hom2, NormalIntersection( M, ImagesSource( hom2 ) ) )
    );
end;


###############################################################################
##
## IsNilpotentByAbelian( G )
##
##  INPUT:
##      G:          group
##
##  OUTPUT:
##      bool:       true iff G is nilpotent-by-abelian
##
InstallTrueMethod( IsNilpotentByAbelian, IsNilpotentGroup );

InstallMethod(
    IsNilpotentByAbelian,
    [ IsGroup ],
    function( G )
        return IsNilpotentGroup( DerivedSubgroup( G ) );
    end
);


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
    local G, UV, l, r, s, u, v;
    
    G := PcpGroupByCollectorNC( Collector( U ) );
    UV := DirectProduct( U, V );
    
    l := Projection( UV, 1 ) * InclusionHomomorphism( U, G );
    r := Projection( UV, 2 ) * InclusionHomomorphism( V, G );
    
    s := RepresentativeTwistedConjugationOp( r, l, g );
    if s = fail then return fail; fi;
    
    u := ImagesRepresentative( l, s );
    v := ImagesRepresentative( r, s )^-1;

    return [ u, v ];
end;


###############################################################################
##
## MultipleConjugacySolver@( G, r, s )
##
##  INPUT:
##      G:          acting group
##      r:          list of elements of G
##      s:          list of elements of G
##
##  OUTPUT:
##      a:          element of G that simultaneously conjugates every element
##                  of r to the corresponding element of s, or fail if no such
##                  element exists
##
##  REMARKS:
##      Only for PcpGroups
##
MultipleConjugacySolver@ := function( G, r, s )
    local a, i, Gi, ai, pcp;
    a := One( G );
    for i in [1..Length( r )] do
        if i = 1 then
            Gi := G;
        else
            Gi := Centraliser( Gi, s[i-1] );
        fi;
        pcp := PcpsOfEfaSeries( Gi );
        ai := ConjugacyElementsBySeries( Gi, r[i]^a, s[i], pcp );
        if ai = false then
            return fail;
        fi;
        a := a*ai;
    od;
    return a;
end;
