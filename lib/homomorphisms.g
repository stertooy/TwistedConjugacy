###############################################################################
##
##  DifferenceGroupHomomorphisms( hom1, hom2, N, M )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          subgroup of H
##      M:          subgroup of G
##
##  OUTPUT:
##      diff:       group homomorphism N -> M: n -> n^hom1 * ( n^hom2 )^-1
##
##  REMARKS:
##      Does not verify whether diff is a well-defined group homomorphism.
##
TWC.DifferenceGroupHomomorphisms := function( hom1, hom2, N, M )
    local gens, imgs;
    gens := GeneratorsOfGroup( N );
    imgs := List(
        gens,
        n -> ImagesRepresentative( hom1, n ) /
            ImagesRepresentative( hom2, n )
    );
    return GroupHomomorphismByImagesNC( N, M, gens, imgs );
end;

###############################################################################
##
## KernelsOfHomomorphismClasses( H, KerOrbits, ImgOrbits )
##
##  INPUT:
##      H:          group
##      KerOrbits:  list of orbits of the natural action of Aut(H) on the set
##                  of all normal subgroups of H
##      ImgOrbits:  list of orbits of the natural action of Aut(G) on the set
##                  of all subgroups of G (up to conjugacy), for some group G
##
##  OUTPUT:
##      Pairs:      list of pairs of indices [ i, j ] such that
##                  H / KerOrbits[ i ][ 1 ] is isomorphic to
##                  ImgOrbits[ j ][ 1 ]
##      Heads:      list of lists of automorphisms of H that map
##                  KerOrbits[ i ][ k ] to KerOrbits[ i ][ 1 ], for every k
##      Isos:       matrix containing a homomorphism from H to
##                  ImgOrbits[ j ][ 1 ], factoring through
##                  H / KerOrbits[ i ][ 1 ], for all [ i, j ] in Pairs
##
TWC.KernelsOfHomomorphismClasses := function( H, KerOrbits, ImgOrbits )
    local AutH, asAuto, Pairs, Heads, Isos, i, N, p, Q, j, M, iso,
          kerOrbit, possibleImgs, quoSize, hasPair, imgSizes;
    AutH := AutomorphismGroup( H );
    asAuto := { A, aut } -> ImagesSet( aut, A );
    Pairs := [];
    Heads := [];
    Isos := [];
    imgSizes := List( ImgOrbits, x -> Size( x[ 1 ] ) );
    for i in [ 1 .. Size( KerOrbits ) ] do
        if not IsBound( KerOrbits[ i ] ) then
            continue;
        fi;
        kerOrbit := KerOrbits[ i ];
        N := kerOrbit[ 1 ];
        quoSize := Size( H ) / Size( N );
        possibleImgs := Positions( imgSizes, quoSize );
        if IsEmpty( possibleImgs ) then
            continue;
        fi;
        Isos[ i ] := [];
        p := NaturalHomomorphismByNormalSubgroupNC( H, N );
        Q := ImagesSource( p );
        p := RestrictedHomomorphism( p, H, Q );
        hasPair := false;
        for j in possibleImgs do
            M := ImgOrbits[ j ][ 1 ];
            iso := IsomorphismGroups( Q, M );
            if iso <> fail then
                Isos[ i ][ j ] := p * iso;
                Add( Pairs, [ i, j ] );
                hasPair := true;
            fi;
        od;
        if hasPair then
            Heads[ i ] := List(
                kerOrbit,
                x -> RepresentativeAction( AutH, x, N, asAuto )
            );
        fi;
    od;
    return [ Pairs, Heads, Isos ];
end;

###############################################################################
##
## ImagesOfHomomorphismClasses( Pairs, ImgOrbits, Reps, G )
##
##  INPUT:
##      Pairs:      list of pairs of indices [ i, j ] such that
##                  H / KerOrbits[ i ][ 1 ] is isomorphic to
##                  ImgOrbits[ j ][ 1 ]
##      ImgOrbits:  list of orbits of the natural action of Aut(G) on the set
##                  of all subgroups of G (up to conjugacy), for some group G
##      Reps:       list of lists of automorphisms of G that map
##                  ImgOrbits[ j ][ k ] to ImgOrbits[ j ][ 1 ], for every k
##                  (Reps[ j ] may be unbound)
##      G:          group
##
##  OUTPUT:
##      Tails:      list of lists of embeddings ImgOrbits[ j ][ 1 ] -> G,
##                  up to inner automorphisms of G, with images in
##                  ImgOrbits[ j ], for each second index j occurring in Pairs
##
TWC.ImagesOfHomomorphismClasses := function( Pairs, ImgOrbits, Reps, G )
    local Tails, AutG, asAuto, j, imgOrbit, M, AutM, InnGM, head, tail;
    asAuto := { A, aut } -> ImagesSet( aut, A );
    AutG := AutomorphismGroup( G );
    Tails := [];
    for j in Set( Pairs, x -> x[ 2 ] ) do
        imgOrbit := ImgOrbits[ j ];
        M := imgOrbit[ 1 ];
        AutM := AutomorphismGroup( M );
        InnGM := SubgroupNC( AutM, List(
            SmallGeneratingSet( Normalizer( G, M ) ),
            g -> ConjugatorAutomorphismNC( M, g )
        ) );
        head := List(
            RightTransversal( AutM, InnGM ),
            function( x )
                local gens;
                gens := MappingGeneratorsImages( x )[ 1 ];
                return GroupHomomorphismByImagesNC(
                    M,
                    G,
                    gens,
                    List( gens, g -> PreImagesRepresentativeNC( x, g ) )
                );
            end
        );
        if not IsBound( Reps[ j ] ) then
            tail := List(
                imgOrbit,
                x -> RepresentativeAction( AutG, M, x, asAuto )
            );
        else
            tail := List( Reps[ j ], x -> x ^ -1 );
        fi;
        Tails[ j ] := ListX( head, tail, \* );
    od;
    return Tails;
end;

###############################################################################
##
## FuseHomomorphismClasses( Pairs, Heads, Isos, Tails )
##
##  INPUT:
##      Pairs:      list of pairs of indices [ i, j ] such that
##                  H / KerOrbits[ i ][ 1 ] is isomorphic to
##                  ImgOrbits[ j ][ 1 ]
##      Heads:      list of lists of automorphisms of H that map
##                  KerOrbits[ i ][ k ] to KerOrbits[ i ][ 1 ], for every k
##      Isos:       matrix containing a homomorphism from H to
##                  ImgOrbits[ j ][ 1 ], factoring through
##                  H / KerOrbits[ i ][ 1 ], for all [ i, j ] in Pairs
##      Tails:      list of lists of embeddings ImgOrbits[ j ][ 1 ] -> G,
##                  up to inner automorphisms of G, with images in
##                  ImgOrbits[ j ], for each second index j occurring in Pairs
##
##  OUTPUT:
##      L:          list of all group homomorphisms H -> G, up to inner
##                  automorphisms of G
##
TWC.FuseHomomorphismClasses := function( Pairs, Heads, Isos, Tails )
    local homs, pair, head, tail, iso;
    homs := [];
    for pair in Pairs do
        head := Heads[ pair[ 1 ] ];
        tail := Tails[ pair[ 2 ] ];
        iso := Isos[ pair[ 1 ] ][ pair[ 2 ] ];
        if Length( head ) < Length( tail ) then
            head := head * iso;
        else
            tail := iso * tail;
        fi;
        Append( homs, ListX( head, tail, \* ) );
    od;
    return homs;
end;

###############################################################################
##
## RepsHomClasses2Gen( H, G[, auts] )
##
##  INPUT:
##      H:          2-generated group
##      G:          group
##      auts:       boolean
##
##  OUTPUT:
##      L:          list of all group homomorphisms H -> G, up to inner
##                  automorphisms of G
##
TWC.RepsHomClasses2Gen := function( H, G, auts )
    local ccls, bg, bw, bi, gens, a, b, pairs, pair, imgs, params, i, prod,
          ords, cclOrds, imgsByOrder, free, rels, elms, ordsS;
    ccls := ConjugacyClasses( G );
    cclOrds := List( ccls, c -> Order( Representative( c ) ) );
    gens := SmallGeneratingSet( H );
    a := gens[ 1 ];
    b := gens[ 2 ];
    elms := [ a, b, a * b, b * a, a * b ^ -1, b * a ^ -1 ];
    ords := List( elms, Order );
    pairs := [
        [ 1, 2 ],
        [ 1, 3 ], [ 1, 4 ], [ 1, 5 ], [ 1, 6 ],
        [ 2, 3 ], [ 2, 4 ], [ 2, 5 ], [ 2, 6 ]
    ];
    ordsS := Set( ords );
    imgsByOrder := List(
        ordsS,
        i -> ccls{ Filtered(
            [ 1 .. Length( ccls ) ],
            j -> i mod cclOrds[ j ] = 0
        ) }
    );
    bw := infinity;
    for pair in pairs do
        imgs := List( pair, i -> imgsByOrder[ Position( ordsS, ords[ i ] ) ] );
        prod := Product( imgs, i -> Sum( i, Size ) );
        if prod < bw then
            bg := pair;
            bi := imgs;
            bw := prod;
        fi;
    od;
    free := GeneratorsOfGroup( FreeGroup( 2 ) );
    bg := List( bg, i -> elms[ i ] );
    rels := [
        [ free[ 1 ] * free[ 2 ],
          Order( bg[ 1 ] * bg[ 2 ] ) ],
        [ Comm( free[ 1 ], free[ 2 ] ),
          Order( Comm( bg[ 1 ], bg[ 2 ] ) ) ]
    ];
    params := rec( gens := bg, from := H, free := free, rels := rels );
    if not auts then
        params.condition := hom -> not IsBijective( hom );
    fi;
    return MorClassLoop( G, bi, params, 9 );
end;

###############################################################################
##
## RepsHomClassesAbelian( H, G[, auts] )
##
##  INPUT:
##      H:          abelian group
##      G:          abelian group
##      auts:       boolean
##
##  OUTPUT:
##      L:          list of all group homomorphisms H -> G, up to inner
##                  automorphisms of G
##
TWC.RepsHomClassesAbelian := function( H, G, auts )
    local gensH, gensG, imgs, h, oh, imgsG, g, og, pows, step, homs, elms,
          coords, pdivs, pos, mat, imgPos, inds, i, primeTest;
    gensH := IndependentGeneratorsOfAbelianGroup( H );
    gensG := IndependentGeneratorsOfAbelianGroup( G );
    imgs := [];
    homs := [];
    for h in gensH do
        oh := Order( h );
        imgsG := [];
        for g in gensG do
            og := Order( g );
            step := og / GcdInt( oh, og );
            pows := [ 0, step .. og - step ];
            Add( imgsG, List( pows, x -> g ^ x ) );
        od;
        Add( imgs, List( Cartesian( imgsG ), Product ) );
    od;
    if not auts then
        elms := Union( imgs );
        coords := List( elms, g -> IndependentGeneratorExponents( G, g ) );
        imgPos := List( imgs,
            imgsG -> List( imgsG, g -> PositionSorted( elms, g ) )
        );
        pdivs := PrimeDivisors( Size( G ) );
        pos := List( pdivs, p -> Filtered( [ 1 .. Length( gensG ) ],
            i -> Order( gensG[ i ] ) mod p = 0 )
        );
        primeTest := i -> DeterminantMat(
            List( pos[ i ], j -> mat[ j ]{ pos[ i ] } )
        ) mod pdivs[ i ] <> 0;
        for inds in IteratorOfCartesianProduct(
            List( imgs, imgsG -> [ 1 .. Length( imgsG ) ] )
        ) do
            mat := List( [ 1 .. Length( inds ) ], i ->
                coords[ imgPos[ i ][ inds[ i ] ] ]
            );
            if ForAll( [ 1 .. Length( pdivs ) ], primeTest ) then
                continue;
            fi;
            Add( homs, GroupHomomorphismByImagesNC(
                H, G, gensH,
                List( [ 1 .. Length( inds ) ],
                    i -> imgs[ i ][ inds[ i ] ]
                )
            ) );
        od;
    else
        for imgsG in IteratorOfCartesianProduct( imgs ) do
            Add( homs, GroupHomomorphismByImagesNC( H, G, gensH, imgsG ) );
        od;
    fi;
    return homs;
end;
