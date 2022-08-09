###############################################################################
##
## IntersectionPreImage@( hom1, hom2, N )
##
##  Returns hom1^-1(N) cap hom2^-1(N)
##  Note that N must be a normal subgroup
##
IntersectionPreImage@ := function( hom1, hom2, N )
    return NormalIntersection(
        PreImagesSet( hom1, NormalIntersection( N, ImagesSource( hom1 ) ) ),
        PreImagesSet( hom2, NormalIntersection( N, ImagesSource( hom2 ) ) )
    );
end;


###############################################################################
##
## IntersectionKernels@( hom1, hom2 )
##
IntersectionKernels@ := function( hom1, hom2 )
    return NormalIntersection( Kernel( hom1 ), Kernel( hom2 ) );
end;


###############################################################################
##
## IsNilpotentByAbelian( G )
##
IsNilpotentByAbelian := function( G )
    return IsNilpotent( DerivedSubgroup( G ) );
end;


###############################################################################
##
## MultipleConjugacySolver@( G, r, s )
##
MultipleConjugacySolver@ := function( G, r, s )
    local a, i, Gi, ai, pcp;
    a := One( G );
    for i in [1..Length( r )] do
        if i = 1 then
            Gi := G;
        else
            Gi := Centraliser( Gi, s[i-1] );
        fi;
        pcp := PcpsOfEfaSeries( Gi );
        ai := ConjugacyElementsBySeries( Gi, r[i]^a, s[i], pcp );
        if ai = false then
            return fail;
        fi;
        a := a*ai;
    od;
    return a;
end;
