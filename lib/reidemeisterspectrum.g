###############################################################################
##
## CoinSpec( homs, ccG, repsH, sizesG, sizesH )
##
##  INPUT:
##      homs:       homomorphisms H -> G
##      ccG:        conjugacy classes of G (as sets)
##      repsH:      representatives of the conjugacy classes of H
##      sizesG:     sizes of the conjugacy classes of G
##      sizesH:     sizes of the conjugacy classes of H
##
##  OUTPUT:
##      Spec:       Coincidence Reidemeister spectrum of G, up to a factor
##
TWC.CoinSpec := function( homs, ccG, repsH, sizesG, sizesH )
    local nrImgs, imgs, i, j, SpecR, R;
    imgs := Set( TWC.ImgsMatrix( homs, ccG, repsH ) );
    nrImgs := Length( imgs );
    SpecR := [];
    for i in [ 1 .. nrImgs ] do
        for j in [ i .. nrImgs ] do
            R := TWC.CalcFromImgs( imgs[ i ], imgs[ j ], sizesG, sizesH );
            AddSet( SpecR, R );
        od;
    od;
    return SpecR;
end;
