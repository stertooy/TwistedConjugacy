###############################################################################
##
## InducedEndomorphism( epi, endo )
##
InstallGlobalFunction(
	InducedEndomorphism,
	function ( epi, endo )
    	local H, gens, indu;
    	H := Range( epi );
		gens := GeneratorsOfGroup( H );
		indu := GroupHomomorphismByImagesNC(
			H, H, gens, List( gens, 
				h -> ( PreImagesRepresentative( epi, h )^endo )^epi
			)
		);
		SetIsEndoGeneralMapping( indu, true );
		return indu;
	end
);


###############################################################################
##
## RestrictedEndomorphism( endo, N )
##
InstallGlobalFunction(
	RestrictedEndomorphism,
	function ( endo, N )
    	local gens, rest;
		gens := GeneratorsOfGroup( N );
		rest := GroupHomomorphismByImagesNC(
			N, N, gens, List( gens, n -> n^endo )
		);
		SetIsEndoGeneralMapping( rest, true );
		return rest;
	end
);


###############################################################################
##
## DifferenceGroupHomomorphisms@( hom1, hom2 )
##
##	Returns the homomorphism that maps g to g^hom2*( g^hom1 )^-1
##
DifferenceGroupHomomorphisms@ := function ( hom1, hom2 )
  	local G, gens, hom;
	G := Source( hom1 );
	gens := GeneratorsOfGroup( G );
	hom := GroupHomomorphismByImagesNC(
		G, Range( hom1 ),
		gens, List( gens, g -> g^hom2*( g^hom1 )^-1 )
	);
	if HasIsEndoGeneralMapping( hom1 ) and IsEndoGeneralMapping( hom1 ) then
		SetIsEndoGeneralMapping( hom, true );
	fi;
	return hom;
end;


###############################################################################
##
## ComposeWithInnerAutomorphism@( g, hom )
##
##	Returns the homorphism that maps h to ( h^hom )^g
##
ComposeWithInnerAutomorphism@ := function ( g, hom )
    local gens, comp;
	gens := MappingGeneratorsImages( hom );
	comp := GroupHomomorphismByImagesNC(
		Source( hom ), Range( hom ),
		gens[1], List( gens[2], h -> h^g )
	);
	if HasIsEndoGeneralMapping( hom ) and IsEndoGeneralMapping( hom ) then
		SetIsEndoGeneralMapping( comp, true );
	fi;
	return comp;
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
