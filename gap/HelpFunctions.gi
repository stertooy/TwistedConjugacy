###############################################################################
##
## InducedHomomorphism( epi1, epi2, hom )
##
InstallGlobalFunction(
	InducedHomomorphism,
	function ( epi1, epi2, hom )
    	local H, G, gens;
		H := Range( epi1 );
    	G := Range( epi2 );
		gens := GeneratorsOfGroup( H );
		return GroupHomomorphismByImagesNC(
			H, G, gens, List( gens,
				h -> ( PreImagesRepresentative( epi1, h )^hom )^epi2
			)
		);
	end
);


###############################################################################
##
## RestrictedHomomorphism( hom, N, M )
##
InstallGlobalFunction(
	RestrictedHomomorphism,
	function ( hom, N, M )
    	local gens;
		gens := GeneratorsOfGroup( N );
		return GroupHomomorphismByImagesNC(
			N, M, gens, List( gens, n -> n^hom )
		);
	end
);


###############################################################################
##
## DifferenceGroupHomomorphisms@( hom1, hom2 )
##
##	Returns the homomorphism that maps h to h^hom2*( h^hom1 )^-1
##
DifferenceGroupHomomorphisms@ := function ( hom1, hom2, H, G )
  	local gens;
	gens := GeneratorsOfGroup( H );
	return GroupHomomorphismByImagesNC(
		H, G,
		gens, List( gens, h -> h^hom2 * ( h^hom1 )^-1 )
	);
end;


###############################################################################
##
## ComposeWithInnerAutomorphism@( g, hom )
##
##	Returns the homorphism that maps h to ( h^hom )^g
##  Note that g is not necessarily an element of the range of hom
##
ComposeWithInnerAutomorphism@ := function ( g, hom )
    local gens;
	gens := MappingGeneratorsImages( hom );
	return GroupHomomorphismByImagesNC(
		Source( hom ), Range( hom ),
		gens[1], List( gens[2], h -> h^g )
	);
end;


###############################################################################
##
## IntersectionPreImage@( hom1, hom2, N )
##
##  Note that N must be a normal subgroup
##
IntersectionPreImage@ := function ( hom1, hom2, N )
	return Intersection(
		PreImage( hom1, Intersection( N, Image( hom1 ) ) ),
		PreImage( hom2, Intersection( N, Image( hom2 ) ) )
	);
end;


###############################################################################
##
## RemovePeriodsList( L )
##
##  Returns the smallest sublist M of L such that L is the concatenation
##  of a number of times of M.
##
RemovePeriodsList@ := function ( L )
	local n, i, M;
	n := Length( L );
	for i in DivisorsInt( n ) do
		M := L{ [ 1..i ] };
		if L = Concatenation( ListWithIdenticalEntries( n/i, M ) ) then
			return M;
		fi;
	od;
end;


###############################################################################
##
## DecomposePeriodicList@( L )
##
##  Decomposes the list L, interpreted as an infinite periodic sequence,
##  into a linear combination of the sequences  a^i = (0,0,0,i,0,0,0,i,...).
##  The output is [c_1, ..., c_n] such that L = sum_i c_i a^i
##
DecomposePeriodicList@ := function ( L )
	local n, c, i, per, ai;
	n := Length( L );
	c := ListWithIdenticalEntries( n, 0 );
	for i in DivisorsInt( n ) do
		c[i] := L[i]/i;
		per := Concatenation( ListWithIdenticalEntries( i-1, 0 ), [ i ] );
		ai := Concatenation( ListWithIdenticalEntries( n/i, per ) );
		L := L - c[i]*ai;
	od;
	if L <> ListWithIdenticalEntries( n, 0 ) then
		return fail;
	fi;
	return c;
end;
