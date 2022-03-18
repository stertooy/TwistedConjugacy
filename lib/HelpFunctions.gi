###############################################################################
##
## Fingerprint@( G )
##
##  Note: this is an expanded version of code suggested by A. Hulpke at
##  https://math.stackexchange.com/q/4113275
##
Fingerprint@ := function( G )
	# Ideally we would use IdGroupsAvailable here if we drop GAP 4.9 support
	if ID_AVAILABLE( Size( G ) ) <> fail then
		return IdGroup( G );
	elif IsAbelian( G ) then
		return Collected( AbelianInvariants( G ) );
	else 
		return Collected( List(
			ConjugacyClasses( G ),
			c -> [ Order( Representative( c ) ), Size( c ) ]
		));
	fi;
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
			fi;
			continue;
		fi;
		l[i] := L[i]/i;
		if not IsInt( l[i] ) then
			return fail;
		fi;
		per := ListWithIdenticalEntries( i-1, 0 );
		Add( per, i );
		ei := Concatenation( ListWithIdenticalEntries( n/i, per ) );
		L := L - l[i]*ei;
	od;
	return l;
end;
