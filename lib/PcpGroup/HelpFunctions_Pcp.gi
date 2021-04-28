###############################################################################
##
## DifferenceGroupHomomorphisms@( hom1, hom2 )
##
##	Returns the homomorphism that maps h to h^hom2*( h^hom1 )^-1
##  No verification is done to make sure this is actually a homomorphism
##
DifferenceGroupHomomorphisms@ := function ( hom1, hom2 )
  	local G, H, gens, diff, imgs;
	G := Range( hom1 );
	H := Source( hom1 );
	gens := GeneratorsOfGroup( H );
	diff := function( h )
		return ImagesRepresentative( hom2, h ) *
			ImagesRepresentative( hom1, h )^-1;
	end;
	imgs := List( gens, diff );
	return GroupHomomorphismByImagesNC( H, G, gens, imgs );
end;


###############################################################################
##
## IntersectionPreImage@( hom1, hom2, N )
##
##  Returns hom1^-1(N) cap hom2^-1(N)
##  Note that N must be a normal subgroup
##
IntersectionPreImage@ := function ( hom1, hom2, N )
	return Intersection2(
		PreImagesSet( hom1, Intersection2( N, ImagesSource( hom1 ) ) ),
		PreImagesSet( hom2, Intersection2( N, ImagesSource( hom2 ) ) )
	);
end;
