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
TWC.IntersectionOfKernels := { hom1, hom2 } -> NormalIntersection(
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
TWC.IntersectionOfPreImages := { hom1, hom2, M } -> NormalIntersection(
    PreImagesSet( hom1, M ),
    PreImagesSet( hom2, M )
);
