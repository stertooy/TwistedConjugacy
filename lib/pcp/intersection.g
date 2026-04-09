###############################################################################
##
## NormalIntersectionPcp( U, V )
##
##  INPUT:
##      U:          subgroup of a PcpGroup G
##      V:          subgroup of a PcpGroup G that normalises U
##
##  OUTPUT:
##      I:          intersection of U and V
##
TWC.NormalIntersectionPcp := function( N, U )
    local q, gens, imgs, phi;
    q := NaturalHomomorphismByNormalSubgroupNC( ClosureGroup( U, N ), N );
    gens := GeneratorsOfGroup( U );
    imgs := List( gens, u -> ImagesRepresentative( q, u ) );
    phi := GroupHomomorphismByImagesNC( U, ImagesSource( q ), gens, imgs );
    return KernelOfMultiplicativeGeneralMapping( phi );
end;

###############################################################################
##
## IntersectionPcp( U, V )
##
##  INPUT:
##      U:          subgroup of a PcpGroup G
##      V:          subgroup of a PcpGroup G
##
##  OUTPUT:
##      I:          intersection of U and V
##
TWC.IntersectionPcp := function( U, V )
    local G, dp, l, r;

    # Catch trivial cases
    if IsSubset( V, U ) then
        return U;
    elif IsSubset( U, V ) then
        return V;
    fi;

    # Defer to polycyclic's implementation
    if IsNormal( V, U ) then
        return TWC.NormalIntersectionPcp( U, V );
    elif IsNormal( U, V ) then
        return TWC.NormalIntersectionPcp( V, U );
    fi;

    # Use CoincidenceGroup
    G := PcpGroupByCollectorNC( Collector( U ) );
    dp := TWC.DirectProductInclusions( G, U, V );
    l := dp[1];
    r := dp[2];

    return ImagesSet( l, CoincidenceGroup2( l, r ) );
end;

###############################################################################
##
## IntersectionOfKernels( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      N:          intersection of Ker(hom1) and Ker(hom2)
##
TWC.IntersectionOfKernels := { hom1, hom2 } -> TWC.NormalIntersectionPcp(
    KernelOfMultiplicativeGeneralMapping( hom1 ),
    KernelOfMultiplicativeGeneralMapping( hom2 )
);

###############################################################################
##
## IntersectionOfPreImages( hom1, hom2, M )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      M:          normal subgroup of G
##
##  OUTPUT:
##      N:          intersection of hom1^-1(M) and hom2^-1(M)
##
TWC.IntersectionOfPreImages := { hom1, hom2, M } -> TWC.NormalIntersectionPcp(
    # TODO: replace by PreImagesSet eventually
    PreImagesSetNC(
        hom1,
        TWC.NormalIntersectionPcp( M, ImagesSource( hom1 ) )
    ),
    PreImagesSetNC(
        hom2,
        TWC.NormalIntersectionPcp( M, ImagesSource( hom2 ) )
    )
);
