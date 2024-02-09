###############################################################################
##
##  DifferenceGroupHomomorphisms@( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          subgroup of H
##      M:          subgroup of G
##
##  OUTPUT:
##      diff:       group homomorphism N -> M: n -> n^hom2 * ( n^hom1 )^-1
##
##  REMARKS:
##      Does not verify whether diff is a well-defined group homomorphism.
##
DifferenceGroupHomomorphisms@ := function( hom1, hom2, N, M )
    local gens, imgs;
    gens := SmallGeneratingSet( N );
    imgs := List(
        gens,
        n -> ImagesRepresentative( hom2, n ) / ImagesRepresentative( hom1, n )
    );
    return GroupHomomorphismByImagesNC( N, M, gens, imgs );
end;


###############################################################################
##
##  IntersectionKernels@( hom1, hom2 )
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
        PreImagesSet( hom1, NormalIntersection( M, ImagesSource( hom1 ) ) ),
        PreImagesSet( hom2, NormalIntersection( M, ImagesSource( hom2 ) ) )
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
InstallMethod(
    IsNilpotentByAbelian,
    [ IsGroup ],
    function( G )
        return IsNilpotentGroup( DerivedSubgroup( G ) );
    end
);


###############################################################################
##
## IsNilpotentByFinite( G )
##
##  INPUT:
##      G:          polycyclic-by-finite group
##
##  OUTPUT:
##      bool:       true iff G is nilpotent-by-finite
##
InstallMethod(
    IsNilpotentByFinite,
    [ IsPolycyclicByFinite ],
    function( G )
        return IsInt( IndexNC( G, FittingSubgroup( G ) ) );
    end
);


###############################################################################
##
## NilpotentByAbelianNormalSubgroup@( G )
##
##  INPUT:
##      G:          polycyclic-by-finite group
##
##  OUTPUT:
##      NA:         nilpotent-by-abelian normal subgroup of G
##
##  REMARKS:
##      NA is not necessarily maximal.
##
NilpotentByAbelianNormalSubgroup@ := function( G )
    local p, A, NA;
    p := NaturalHomomorphismByNormalSubgroupNC( G, FittingSubgroup( G ) );
    A := Centre( FittingSubgroup( ImagesSource( p ) ) );
    NA := PreImagesSet( p, A );
    SetIsNilpotentByAbelian( NA, true );
    SetIsNilpotentByFinite( NA, IsFinite( A ) );
    return NA;
end;
