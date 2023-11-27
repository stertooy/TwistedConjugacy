###############################################################################
##
## DifferenceGroupHomomorphisms@( hom1, hom2 )
##
##  Returns the homomorphism that maps h to h^hom2*( h^hom1 )^-1
##  No verification is done to make sure this is actually a homomorphism
##
DifferenceGroupHomomorphisms@ := function( hom1, hom2, N, M )
    local gens, imgs;
    gens := SmallGeneratingSet( N );
    imgs := List(
        gens,
        n -> ImagesRepresentative( hom2, n ) / ImagesRepresentative( hom1, n )
    );
    return GroupHomomorphismByImagesNC( N, M, gens, imgs );
end;


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
## IsNilpotentByFinite( G )
##
InstallMethod(
    IsNilpotentByFinite,
    [ IsPolycyclicGroup ],
    function( G )
        return IsInt( IndexNC( G, FittingSubgroup( G ) ) );
    end
);


###############################################################################
##
## IsNilpotentByAbelian( G )
##
InstallMethod(
    IsNilpotentByAbelian,
    [ IsGroup ],
    function( G )
        return IsNilpotentGroup( DerivedSubgroup( G ) );
    end
);


###############################################################################
##
## NilpotentByAbelianNormalSubgroup@( G )
##
NilpotentByAbelianNormalSubgroup@ := function( G )
    local N, p, A, NA;
    N := FittingSubgroup( G );
    p := NaturalHomomorphismByNormalSubgroupNC( G, N );
    A := Centre( FittingSubgroup( ImagesSource( p ) ) );
    NA := PreImagesSet( p, A );
    SetIsNilpotentByAbelian( NA, true );
    SetIsNilpotentByFinite( NA, IsFinite( A ) );
    return NA;
end;


###############################################################################
##
## MultipleConjugacySolver@( G, r, s )
##
MultipleConjugacySolver@ := function( G, r, s )
    local a, i, Gi, ai;
    a := One( G );
    for i in [1..Length( r )] do
        if i = 1 then
            Gi := G;
        else
            Gi := Centraliser( Gi, s[i-1] );
        fi;
        ai := RepresentativeAction( Gi, r[i]^a, s[i], OnPoints );
        if ai = fail then
            return fail;
        fi;
        a := a*ai;
    od;
    return a;
end;
