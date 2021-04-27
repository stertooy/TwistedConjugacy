###############################################################################
##
## DifferenceGroupHomomorphisms@( hom1, hom2 )
##
##	Returns the homomorphism that maps h to h^hom2*( h^hom1 )^-1
##  No verification is done to make sure this is actually a homomorphism
##
DifferenceGroupHomomorphisms@ := function ( hom1, hom2 )
  	local G, H, gens, imgs;
	G := Range( hom1 );
	H := Source( hom1 );
	gens := GeneratorsOfGroup( H );
	imgs := List( gens, h -> h^hom2 * ( h^hom1 )^-1 );
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
	return Intersection(
		PreImage( hom1, Intersection( N, Image( hom1 ) ) ),
		PreImage( hom2, Intersection( N, Image( hom2 ) ) )
	);
end;
