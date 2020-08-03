###############################################################################
##
## InducedHomomorphism( epi1, epi2, hom )
##
InstallGlobalFunction(
	InducedHomomorphism,
	function ( epi1, epi2, hom )
    	local H, G, gens, indu;
		H := Range( epi1 );
    	G := Range( epi2 );
		gens := GeneratorsOfGroup( H );
		indu := GroupHomomorphismByImagesNC(
			H, G, gens, List( gens,
				h -> ( PreImagesRepresentative( epi1, h )^hom )^epi2
			)
		);
		return indu;
	end
);


###############################################################################
##
## RestrictedHomomorphism( hom, N, M )
##
InstallGlobalFunction(
	RestrictedHomomorphism,
	function ( hom, N, M )
    	local gens, rest;
		gens := GeneratorsOfGroup( N );
		rest := GroupHomomorphismByImagesNC(
			N, M, gens, List( gens, n -> n^hom )
		);
		return rest;
	end
);


###############################################################################
##
## DifferenceGroupHomomorphisms@( hom1, hom2 )
##
##	Returns the homomorphism that maps h to h^hom2*( h^hom1 )^-1
##
DifferenceGroupHomomorphisms@ := function ( hom1, hom2 )
  	local H, gens, hom;
	H := Source( hom1 );
	gens := GeneratorsOfGroup( H );
	hom := GroupHomomorphismByImagesNC(
		H, Range( hom1 ),
		gens, List( gens, h -> h^hom2*( h^hom1 )^-1 )
	);
	return hom;
end;


###############################################################################
##
## ComposeWithInnerAutomorphism@( g, hom )
##
##	Returns the homorphism that maps h to ( h^hom )^g
##  Note that g is not necessarily an element of the range of hom
##
ComposeWithInnerAutomorphism@ := function ( g, hom )
    local gens, comp;
	gens := MappingGeneratorsImages( hom );
	comp := GroupHomomorphismByImagesNC(
		Source( hom ), Range( hom ),
		gens[1], List( gens[2], h -> h^g )
	);
	return comp;
end;


###############################################################################
##
## IntersectionPreImage@( hom1, hom2, G )
##
IntersectionPreImage@ := function ( hom1, hom2, G )
	return Intersection(
		PreImage( hom1, Intersection( Image( hom1 ), G ) ),
		PreImage( hom2, Intersection( Image( hom2 ), G ) )
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
	return c;
end;
