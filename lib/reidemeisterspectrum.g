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
    local kG, kH, nrHoms, imgs, img, L, hom, i, j, k, SpecR, R, ords, ord;
    nrHoms := Length( homs );
    kH := Length( repsH );
    kG := Length( ccG );
    imgs := [];
    ords := List( ccG, i -> Order( First( i ) ) );
    for i in [ 1 .. nrHoms ] do
        hom := homs[ i ];
        L := ListWithIdenticalEntries( kH, 0 );
        for j in [ 1 .. kH ] do
            img := ImagesRepresentative( hom, repsH[ j ] );
            ord := Order( img );
            L[ j ] := First(
            	[ 1 .. kG ],
            	k -> ord = ords[k] and img in ccG[ k ]
            );
        od;
        Add( imgs, L );
    od;
    SpecR := [];
    for i in [ 1 .. nrHoms ] do
        for j in [ i .. nrHoms ] do
            R := 0;
            for k in [ 1 .. kH ] do
                if imgs[ i ][ k ] = imgs[ j ][ k ] then
                    R := R + sizesH[ k ] / sizesG[ imgs[ i ][ k ] ];
                fi;
            od;
            AddSet( SpecR, R );
        od;
    od;
    return SpecR;
end;
