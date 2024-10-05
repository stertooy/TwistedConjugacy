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
