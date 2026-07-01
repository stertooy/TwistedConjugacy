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
    local nrHoms, imgs, i, j, SpecR, R;
    nrHoms := Length( homs );
    imgs := TWC.ImgsMatrix( homs, ccG, repsH );
    SpecR := [];
    for i in [ 1 .. nrHoms ] do
        for j in [ i .. nrHoms ] do
            R := TWC.CalcFromImgs( imgs[ i ], imgs[ j ], sizesG, sizesH );
            AddSet( SpecR, R );
        od;
    od;
    return SpecR;
end;
