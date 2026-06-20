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
TWC.CoinSpec := function( homs, ccG, repsH, sizesG, sizesH )
    local kG, kH, nrHoms, preimgs, L, hom, i, j, k, l, I, SpecR, R;
    nrHoms := Length( homs );
    kH := Length( repsH );
    kG := Length( ccG );
    preimgs := [];
    for i in [ 1 .. nrHoms ] do
        hom := homs[ i ];
        # do NOT use ListWithIdenticalEntries here
        L := List( [ 1 .. kG ], j -> [] );
        for j in [ 1 .. kH ] do
            k := First(
                [ 1 .. kG ],
                l -> ImagesRepresentative( hom, repsH[ j ] ) in ccG[ l ]
            );
            AddSet( L[ k ], j );
        od;
        Add( preimgs, L );
    od;
    SpecR := [];
    for i in [ 1 .. nrHoms ] do
        for j in [ i .. nrHoms ] do
            R := 0;
            for k in [ 1 .. kG ] do
                I := Intersection2( preimgs[ i ][ k ], preimgs[ j ][ k ] );
                R := R + Sum( I, l -> sizesH[ l ] ) / sizesG[ k ];
            od;
            AddSet( SpecR, R );
        od;
    od;
    return SpecR;
end;
