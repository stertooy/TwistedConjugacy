###############################################################################
##
## IsNilpotentByAbelian( G )
##
##  INPUT:
##      G:          group
##
##  OUTPUT:
##      bool:       true iff G is nilpotent-by-abelian
##
InstallMethod(
    IsNilpotentByAbelian,
    [ IsGroup ],
    G -> IsNilpotentGroup( DerivedSubgroup( G ) )
);

###############################################################################
##
## TWC_IntersectionOfKernels( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      N:          intersection of Ker(hom1) and Ker(hom2)
##
InstallGlobalFunction(
    TWC_IntersectionOfKernels,
    { hom1, hom2 } -> NormalIntersection(
        KernelOfMultiplicativeGeneralMapping( hom1 ),
        KernelOfMultiplicativeGeneralMapping( hom2 )
    )
);

###############################################################################
##
## TWC_IntersectionOfPreImages( hom1, hom2, M )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      M:          normal subgroup of G
##
##  OUTPUT:
##      N:          intersection of hom1^-1(M) and hom2^-1(M)
##
InstallGlobalFunction(
    TWC_IntersectionOfPreImages,
    { hom1, hom2, M } -> NormalIntersection(
        # TODO: replace by PreImagesSet eventually
        PreImagesSetNC( hom1, NormalIntersection( M, ImagesSource( hom1 ) ) ),
        PreImagesSetNC( hom2, NormalIntersection( M, ImagesSource( hom2 ) ) )
    )
);
