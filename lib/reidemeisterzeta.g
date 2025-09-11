###############################################################################
##
## TWC_RemovePeriodsList( L )
##
##  INPUT:
##      L:          periodic list
##
##  OUTPUT:
##      M:          sublist consisting of single period
##
BindGlobal(
    "TWC_RemovePeriodsList",
    function( L )
        local n, i, M;
        n := Length( L );
        for i in DivisorsInt( n ) do
            M := L{[ 1 .. i ]};
            if L = Concatenation( ListWithIdenticalEntries( n / i, M ) ) then
                return M;
            fi;
        od;
    end
);

###############################################################################
##
## TWC_DecomposePeriodicList( L )
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
BindGlobal(
    "TWC_DecomposePeriodicList",
    function( L )
        local n, l, i, per, ei;
        n := Length( L );
        l := ListWithIdenticalEntries( n, 0 );
        for i in [ 1 .. n ] do
            if n mod i <> 0 then
                if L[i] <> 0 then
                    return fail;
                fi;
                continue;
            fi;
            l[i] := L[i] / i;
            if not IsInt( l[i] ) then
                return fail;
            fi;
            per := ListWithIdenticalEntries( i - 1, 0 );
            Add( per, i );
            ei := Concatenation( ListWithIdenticalEntries( n / i, per ) );
            L := L - l[i] * ei;
        od;
        return l;
    end
);
