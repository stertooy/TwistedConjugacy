###############################################################################
##
## DifferenceGroupHomomorphisms@( hom1, hom2 )
##
##  Returns the homomorphism that maps h to h^hom2*( h^hom1 )^-1
##  No verification is done to make sure this is actually a homomorphism
##
DifferenceGroupHomomorphisms@ := function ( hom1, hom2, N, M )
    local gens, imgs;
    gens := GeneratorsOfGroup( N );
    imgs := List(
        gens,
        n -> ImagesRepresentative( hom2, n ) / ImagesRepresentative( hom1, n )
    );
    return GroupHomomorphismByImagesNC( N, M, gens, imgs );
end;
