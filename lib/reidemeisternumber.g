###############################################################################
##
## ImgsMatrix( homs, ccG, repsH )
##
##  INPUT:
##      homs:       homomorphisms H -> G
##      ccG:        conjugacy classes of G (as sets)
##      repsH:      representatives of the conjugacy classes of H
##
##  OUTPUT:
##      imgs:       matrix containing info on conjugacy class mapping
##
TWC.ImgsMatrix := function( homs, ccG, repsH )
    local nrHoms, kH, kG, imgs, i, hom, j, img, k;
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
## CalcFromImgs( imgs1, imgs2, sizesG, sizesH )
##
##  INPUT:
##      imgs1:      list containing info on conjugacy class mapping of hom1
##      imgs2:      list containing info on conjugacy class mapping of hom2
##      sizesG:     sizes of the conjugacy classes of G
##      sizesH:     sizes of the conjugacy classes of H
##
##  OUTPUT:
##      R:          Reidemeister number of the pair ( hom1, hom2 )
##
TWC.CalcFromImgs := function( imgs1, imgs2, sizesG, sizesH )
    local kH, R, k;
    kH := Length( imgs1 );
    R := 0;
    for k in [ 1 .. kH ] do
        if imgs1[ k ] = imgs2[ k ] then
            R := R + sizesH[ k ] / sizesG[ imgs1[ k ] ];
        fi;
    od;
    return R;
end;
