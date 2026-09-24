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
## GoodGenSet( G )
##
##  INPUT:
##      G:          finite group
##
##  OUTPUT:
##      gens:       generators of G
##
##  REMARKS:
##      Not necessarily minimal, but a good balance between small and minimal
##      generating sets.
##
TWC.GoodGenSet := function( G )
    local gens;
    if HasMinimalGeneratingSet( G ) then
        return MinimalGeneratingSet( G );
    fi;
    gens := SmallGeneratingSet( G );
    if (
        Length( gens ) > 2 and
        not IsPrimePowerInt( Size( G ) ) and
        IsSolvableGroup( G )
    ) then
        return MinimalGeneratingSet( G );
    fi;
    return gens;
end;

###############################################################################
##
## HomClasses2GenData( H, G )
##
##  INPUT:
##      H:          finite 2-generated group
##      G:          finite group
##
##  OUTPUT:
##      data:       record
##
TWC.HomClasses2GenData := function( H, G )
    local ccls, bg, bw, bi, gens, a, b, pairs, pair, imgs, prod, ords,
          cclOrds, imgsByOrder, elms, ordsS, sizesByOrder, sizes;
    ccls := ConjugacyClasses( G );
    cclOrds := List( ccls, c -> Order( Representative( c ) ) );
    gens := TWC.GoodGenSet( H );
    a := gens[ 1 ];
    b := gens[ 2 ];
    elms := [ a, b, a * b, a * b ^ -1 ];
    ords := List( elms, Order );
    pairs := [ [ 1, 2 ], [ 1, 3 ], [ 1, 4 ], [ 2, 3 ], [ 2, 4 ] ];
    ordsS := Set( ords );
    imgsByOrder := List(
        ordsS,
        i -> ccls{ Filtered(
            [ 1 .. Length( ccls ) ],
            j -> i mod cclOrds[ j ] = 0
        ) }
    );
    if IsPcGroup( H ) then
        sizesByOrder := List( imgsByOrder,
            classes -> Collected( List( classes, Size ) ) );
    fi;
    bw := infinity;
    for pair in pairs do
        imgs := List( pair, i -> imgsByOrder[ Position( ordsS, ords[ i ] ) ] );
        if IsPcGroup( H ) then
            sizes := List(
                pair,
                i -> sizesByOrder[ Position( ordsS, ords[ i ] ) ]
            );
            prod := Sum( sizes[ 1 ], c -> Sum(
                sizes[ 2 ],
                d -> c[ 2 ] * d[ 2 ] * Minimum( c[ 1 ], d[ 1 ] )
            ) );
        else
            prod := Product( imgs, i -> Sum( i, Size ) );
        fi;
        if prod < bw then
            bg := pair;
            bi := imgs;
            bw := prod;
        fi;
    od;
    return rec(
        gens := List( bg, i -> elms[ i ] ),
        imgs := bi,
        ords := cclOrds,
        weight := bw
    );
end;

###############################################################################
##
## RepsHomClasses2Gen( H, G, auts, data )
##
##  INPUT:
##      H:          finite 2-generated group
##      G:          finite group
##      auts:       boolean
##      data:       record
##
##  OUTPUT:
##      L:          homomorphisms H -> G
##
TWC.RepsHomClasses2Gen := function( H, G, auts, arg... )
    local data, free, bg, rels, exps, params;
    if IsEmpty( arg ) then
        data := TWC.HomClasses2GenData( H, G );
    else
        data := arg[ 1 ];
    fi;
    free := GeneratorsOfGroup( FreeGroup( 2 ) );
    bg := data.gens;
    rels := [
        [ free[ 1 ] * free[ 2 ], Order( bg[ 1 ] * bg[ 2 ] ) ],
        [ Comm( free[ 1 ], free[ 2 ] ), Order( Comm( bg[ 1 ], bg[ 2 ] ) ) ]
    ];
    if IsPcGroup( H ) then
        exps := [ Lcm( data.ords ), Exponent( DerivedSubgroup( G ) ) ];
        rels := rels{ Filtered(
            [ 1, 2 ],
            i -> rels[ i ][ 2 ] mod exps[ i ] <> 0
        ) };
    fi;
    params := rec( gens := bg, from := H, free := free, rels := rels );
    if not auts then
        params.condition := hom -> not IsBijective( hom );
    fi;
    return MorClassLoop( G, data.imgs, params, 9 );
end;

###############################################################################
##
## RepsHomClassesAbelian( H, G, auts )
##
##  INPUT:
##      H:          finite abelian group
##      G:          finite abelian group
##      auts:       boolean
##
##  OUTPUT:
##      L:          homomorphisms H -> G
##
TWC.RepsHomClassesAbelian := function( H, G, auts )
    local gensH, gensG, imgs, h, oh, imgsG, g, og, pows, step, homs, elms,
          coords, pdivs, pos, mat, imgPos, inds, primeTest;
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
        pos := List( pdivs, p -> Filtered(
            [ 1 .. Length( gensG ) ],
            i -> Order( gensG[ i ] ) mod p = 0
        ) );
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

###############################################################################
##
## RepsHomClassesAbelianSource( H, G )
##
##  INPUT:
##      H:          nontrivial finite abelian group
##      G:          finite group
##
##  OUTPUT:
##      homs:       homomorphisms H -> G
##
TWC.RepsHomClassesAbelianSource := function( H, G )
    local gens, ords, imgs, homs, srch;
    gens := IndependentGeneratorsOfAbelianGroup( H );
    ords := List( gens, Order );
    imgs := [];
    homs := [];
    srch := function( C, i )
        local c, img;
        for c in ConjugacyClasses( C ) do
            img := Representative( c );
            if ords[ i ] mod Order( img ) <> 0 then
                continue;
            fi;
            imgs[ i ] := img;
            if i = Length( gens ) then
                Add( homs, GroupHomomorphismByImagesNC(
                    H, G, gens, ShallowCopy( imgs )
                ) );
            elif Size( c ) = 1 then
                srch( C, i + 1 );
            else
                srch( Centraliser( C, img ), i + 1 );
            fi;
        od;
    end;
    srch( G, 1 );
    return homs;
end;

###############################################################################
##
## RepsAutClassesQuasisimple( G )
##
##  INPUT:
##      G:          finite quasisimple group
##
##  OUTPUT:
##      L:          automorphisms of G, or fail
##
TWC.RepsAutClassesQuasisimple := function( G )
    local gens, ords, size, ccls, poss, free, params, rels;
    if Size( G ) > 360 then return fail; fi;
    gens := TWC.GoodGenSet( G );
    if Length( gens ) <> 2 then return fail; fi;
    ords := List( gens, Order );
    size := List( gens, g -> IndexNC( G, Centraliser( G, g ) ) );
    ccls := ConjugacyClasses( G );
    poss := List( [ 1, 2 ], i -> Filtered(
        ccls,
        c -> Order( Representative( c ) ) = ords[ i ] and Size( c ) = size[ i ]
    ) );
    free := GeneratorsOfGroup( FreeGroup( 2 ) );
    rels := [
        [ free[ 1 ] * free[ 2 ], Order( gens[ 1 ] * gens[ 2 ] ) ],
        [ Comm( free[ 1 ], free[ 2 ] ), Order( Comm( gens[ 1 ], gens[ 2 ] ) ) ]
    ];
    params := rec( gens := gens, from := G, free := free, rels := rels );
    return MorClassLoop( G, poss, params, 11 );
end;

###############################################################################
##
## DirectFactorsOrFail( G )
##
##  INPUT:
##      G:          finite group
##
##  OUTPUT:
##      facs:       internal direct factors, or fail
##
TWC.DirectFactorsOrFail := function( G )
    local facs, info, orbs, gens;
    if HasDirectProductInfo( G ) then
        info := DirectProductInfo( G ).groups;
        facs := List(
            [ 1 .. Length( info ) ],
            i -> ImagesSource( Embedding( G, i ) )
        );
    elif HasDirectFactorsOfGroup( G ) then
        facs := DirectFactorsOfGroup( G );
    elif IsPermGroup( G ) then
        orbs := OrbitsDomain( G, MovedPoints( G ) );
        if Length( orbs ) < 2 then return fail; fi;
        gens := GeneratorsOfGroup( G );
        facs := List(
            orbs,
            orb -> Group( List( gens, g -> RestrictedPermNC( g, orb ) ) )
        );
        if Product( facs, Size ) <> Size( G ) then return fail; fi;
    else
        return fail;
    fi;
    facs := Filtered( facs, D -> not IsTrivial( D ) );
    if Length( facs ) < 2 then return fail; fi;
    SortBy( facs, D -> -Size( D ) );
    return facs;
end;

###############################################################################
##
## RepsHomClassesSourceFactors( H, G )
##
##  INPUT:
##      H:          finite group
##      G:          finite group
##
##  OUTPUT:
##      homs:       homomorphisms H -> G, or fail
##
TWC.RepsHomClassesSourceFactors := function( H, G )
    local facs, gens, imgs, homs, srch;
    if (
        ( IsPrimePowerInt( Size( H ) ) and IsPrimePowerInt( Size( G ) ) ) or
        ( Size( H ) > Size( G ) and Length( SmallGeneratingSet( H ) ) = 2 )
    ) then
        return fail;
    fi;
    facs := TWC.DirectFactorsOrFail( H );
    if facs = fail then return fail; fi;
    gens := [];
    imgs := [];
    homs := [];
    srch := function( C, i )
        local hom, pair;
        for hom in RepresentativesHomomorphismClasses( facs[ i ], C ) do
            pair := MappingGeneratorsImages( hom );
            gens[ i ] := pair[ 1 ];
            imgs[ i ] := pair[ 2 ];
            if i = Length( facs ) then
                Add( homs, GroupHomomorphismByImagesNC(
                    H, G, Concatenation( gens ), Concatenation( imgs )
                ) );
            elif ForAll( imgs[ i ], IsOne ) or IsAbelian( C ) then
                srch( C, i + 1 );
            else
                srch( Centraliser( C, ImagesSource( hom ) ), i + 1 );
            fi;
        od;
    end;
    srch( G, 1 );
    return homs;
end;

###############################################################################
##
## RepsHomClassesTargetFactors( H, G, auts )
##
##  INPUT:
##      H:          finite group
##      G:          finite group
##      auts:       boolean
##
##  OUTPUT:
##      homs:       homomorphisms H -> G, or fail
##
TWC.RepsHomClassesTargetFactors := function( H, G, auts )
    local facs, gens, vecs, tupl, imgs, homs;
    facs := TWC.DirectFactorsOrFail( G );
    if facs = fail then return fail; fi;
    gens := GeneratorsOfGroup( H );
    vecs := List( facs, D -> List(
        RepresentativesHomomorphismClasses( H, D ),
        function( hom )
            local pair, imgs;
            pair := MappingGeneratorsImages( hom );
            if pair[ 1 ] = gens then
                imgs := pair[ 2 ];
            else
                imgs := List( gens, g -> ImagesRepresentative( hom, g ) );
            fi;
            return rec( imgs := imgs, okay := auts or IsSurjective( hom ) );
        end
    ) );
    homs := [];
    for tupl in IteratorOfCartesianProduct( vecs ) do
        imgs := List(
            [ 1 .. Length( gens ) ],
            i -> Product( tupl, vector -> vector.imgs[ i ] )
        );
        if (
            auts or
            ForAny( tupl, vector -> not vector.okay ) or
            Size( SubgroupNC( G, imgs ) ) < Size( G )
        ) then
            Add( homs, GroupHomomorphismByImagesNC( H, G, gens, imgs ) );
        fi;
    od;
    return homs;
end;
