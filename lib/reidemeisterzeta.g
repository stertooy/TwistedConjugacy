###############################################################################
##
## RemovePeriodsList( L )
##
##  INPUT:
##      L:          periodic list
##
##  OUTPUT:
##      M:          sublist consisting of single period
##
TWC.RemovePeriodsList := function( L )
    local n, i, M;
    n := Length( L );
    for i in DivisorsInt( n ) do
        M := L{[ 1 .. i ]};
        if L = Concatenation( ListWithIdenticalEntries( n / i, M ) ) then
            return M;
        fi;
    od;
end;

###############################################################################
##
## DecomposePeriodicList( L )
##
##  INPUT:
##      L:          periodic list that is a finite linear combination
##                  of the sequences ei = (0,0,0,i,0,0,0,i,...)
##
##  OUTPUT:
##      l:          list of integers such that L = sum_i l_i ei, or fail if
##                  no such list of integers exists
##
##  REMARKS:
##      This is essentially the inverse Discrete Fourier Transform.
##
TWC.DecomposePeriodicList := function( L )
    local N, l, n, k;
    N := Length( L );
    l := ListWithIdenticalEntries( N, 0 );
    for n in [ 0 .. N-1 ] do
        l[n+1] := Sum( [0..N-1], k -> L[k+1] * E(N)^(k*n) )/N;
    od;
    return l;
end;
