###############################################################################
##
## CoinSpec( homs, ccG, repsH, sizesG, sizesH )
##
##  INPUT:
##      homs:       homomorphisms H -> G
##      ccG:        conjugacy classes of G (as sets)
##      repsH:      representatives of the conjugacy classes of H
##      sizesG:     sizes of the conjugacy classes of G
##      sizesG:     sizes of the conjugacy classes of H
##
##  OUTPUT:
##      Spec:       Coincidence Reidemeister spectrum of G, up to a factor
##
TWC.ImgsMatrix := function( homs, ccG, repsH )
    local nrHoms, kH, kG, imgs, i, hom, j, img, k, SpecR, R;
    nrHoms := Length( homs );
    kH := Length( repsH );
    kG := Length( ccG );
    imgs := NullMat( nrHoms, kH );
    for i in [ 1 .. nrHoms ] do
        hom := homs[ i ];
        for j in [ 1 .. kH ] do
            img := ImagesRepresentative( hom, repsH[ j ] );
            imgs[ i ][ j ] := First( [ 1 .. kG ], k -> img in ccG[ k ] );
        od;
    od;
    return imgs;
end;

###############################################################################
##
## CoinSpec( homs, ccG, repsH, sizesG, sizesH )
##
##  INPUT:
##      homs:       homomorphisms H -> G
##      ccG:        conjugacy classes of G (as sets)
##      repsH:      representatives of the conjugacy classes of H
##      sizesG:     sizes of the conjugacy classes of G
##      sizesG:     sizes of the conjugacy classes of H
##
##  OUTPUT:
##      Spec:       Coincidence Reidemeister spectrum of G, up to a factor
##
TWC.CalcFromImgs := function( imgsI, imgsJ, sizesG, sizesH )
    local kH, R, k;
    kH := Length( imgsI );
    R := 0;
    for k in [ 1 .. kH ] do
        if igmsI[ k ] = imgsJ[ k ] then
            R := R + sizesH[ k ] / sizesG[ imgsI[ k ] ];
        fi;
    od;
    return R;
end;
