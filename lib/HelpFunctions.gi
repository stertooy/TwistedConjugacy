###############################################################################
##
## InducedHomomorphism( epi1, epi2, hom )
##
InstallGlobalFunction(
	InducedHomomorphism,
	function ( epi1, epi2, hom )
		return GroupHomomorphismByFunction( Range( epi1 ), Range( epi2 ),
			h -> ( PreImagesRepresentative( epi1, h )^hom )^epi2,
			false,
			g -> PreImagesRepresentative( 
				hom, 
				PreImagesRepresentative( epi2, g )
			)^epi1
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
		return GroupHomomorphismByFunction(
			N, M, 
			n -> n^hom,
			false,
			m -> PreImagesRepresentative( hom, m )
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
##  into a linear combination of the sequences  ei = (0,0,0,i,0,0,0,i,...).
##  The output is [l_1, ..., l_n] such that L = sum_i l_i ei.
##  Returns fail if some l_i is not an integer, or if the decomposition does
##  not exist.
##  Essentially, this is the inverse Discrete Fourier Transform
##
DecomposePeriodicList@ := function ( L )
	local n, l, i, per, ei;
	n := Length( L );
	l := ListWithIdenticalEntries( n, 0 );
	for i in [1..n] do
		if n mod i <> 0 then
			if L[i] <> 0 then
				return fail;
			else
				continue;
			fi;
		fi;
		l[i] := L[i]/i;
		if not IsInt( l[i] ) then
			return fail;
		fi;
		per := Concatenation( ListWithIdenticalEntries( i-1, 0 ), [ i ] );
		ei := Concatenation( ListWithIdenticalEntries( n/i, per ) );
		L := L - l[i]*ei;
	od;
	return l;
end;
