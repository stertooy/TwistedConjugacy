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
##      l:          list of rational numbers such that L = sum_i l_i ei
##
##  REMARKS:
##      This is essentially the inverse Discrete Fourier Transform.
##
TWC.DecomposePeriodicList := function( L )
    local n, l, i, per, ei;
    n := Length( L );
    l := ListWithIdenticalEntries( n, 0 );
    for i in [ 1 .. n ] do
        l[i] := Sum( DivisorsInt( i ), d -> MoebiusMu( n / d ) * L[i] ) / i;
    od;
    return l;
end;
