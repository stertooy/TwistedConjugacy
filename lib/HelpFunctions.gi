###############################################################################
##
## InducedHomomorphism( epi1, epi2, hom )
##
InstallGlobalFunction(
	InducedHomomorphism,
	function ( epi1, epi2, hom )
		local GM, HN, ind, inv;
		GM := Range( epi2 );
		HN := Range( epi1 );
		ind := function( h )
			return ImagesRepresentative(
				epi2,
				ImagesRepresentative(
					hom,
					PreImagesRepresentative(
						epi1,
						h
					)
				)
			);
		end;
		inv := function( g )
			return ImagesRepresentative(
				epi1,
				PreImagesRepresentative( 
					hom,
					PreImagesRepresentative(
						epi2,
						g
					)
				)
			);
		end;
		return GroupHomomorphismByFunction(	HN, GM, ind, false, inv );
	end
);


###############################################################################
##
## RestrictedHomomorphism( hom, N, M )
##
InstallGlobalFunction(
	RestrictedHomomorphism,
	function ( hom, N, M )
		local res, inv;
		res := function( n )
			return ImagesRepresentative( hom, n );
		end;
		inv := function( m )
			return PreImagesRepresentative( hom, m );
		end;
		return GroupHomomorphismByFunction( N, M, res, false, inv );
	end
);


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
