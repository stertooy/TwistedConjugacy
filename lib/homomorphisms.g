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
          kerOrbit, possibleImgs;
    AutH := AutomorphismGroup( H );
    asAuto := { A, aut } -> ImagesSet( aut, A );
    Pairs := [];
    Heads := [];
    Isos := [];
    for i in [ 1 .. Size( KerOrbits ) ] do
        if not IsBound( KerOrbits[ i ] ) then
            continue;
        fi;
        kerOrbit := KerOrbits[ i ];
        N := kerOrbit[ 1 ];
        possibleImgs := Filtered(
            [ 1 .. Size( ImgOrbits ) ],
            j -> Size( ImgOrbits[ j ][ 1 ] ) = IndexNC( H, N )
        );
        if IsEmpty( possibleImgs ) then
            continue;
        fi;
        Isos[ i ] := [];
        p := NaturalHomomorphismByNormalSubgroupNC( H, N );
        Q := ImagesSource( p );
        p := RestrictedHomomorphism( p, H, Q );
        for j in possibleImgs do
            M := ImgOrbits[ j ][ 1 ];
            iso := IsomorphismGroups( Q, M );
            if iso <> fail then
                Isos[ i ][ j ] := p * iso;
                Add( Pairs, [ i, j ] );
            fi;
        od;
        if not IsEmpty( SetX( Pairs, x -> x[ 1 ] = i, x -> x[ 1 ] ) ) then
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
        head := List( head, x -> GroupHomomorphismByImagesNC( M, G,
            MappingGeneratorsImages( x )[ 1 ],
            MappingGeneratorsImages( x )[ 2 ]
        ) );
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
    local ccls, ords, gens, homs, cache, N, p, Q, R, gensQ, embs, data, iso,
          poss, cents, free, rels, emb, hom;
    ccls := ConjugacyClasses( G );
    ords := List( ccls, c -> Order( Representative( c ) ) );
    gens := SmallGeneratingSet( H );
    homs := [];
    cache := [];
    for N in NormalSubgroups( H ) do
        if (
            ( not auts and IsTrivial( N ) ) or
            Size( G ) mod ( Size( H ) / Size( N ) ) <> 0
        ) then
            continue;
        fi;
        if IsTrivial( N ) then
            Q := H;
            p := IdentityMapping( H );
            gensQ := gens;
        else
            p := NaturalHomomorphismByNormalSubgroupNC( H, N );
            Q := ImagesSource( p );
            gensQ := List( gens, h -> ImagesRepresentative( p, h ) );
            p := GroupHomomorphismByImagesNC( H, Q, gens, gensQ );
        fi;
        embs := fail;
        for data in cache do
            R := data.grp;
            if Size( R ) = Size( Q ) then
                iso := IsomorphismGroups( Q, R );
                if iso <> fail then
                    p := p * iso;
                    embs := data.emb;
                    break;
                fi;
            fi;
        od;
        if embs = fail then
            poss := List( gensQ, q -> ccls{ Positions( ords, Order( q ) ) } );
            cents := List( gensQ, q -> Size( Centraliser( Q, q ) ) );
            poss := List( [ 1, 2 ], i -> Filtered( poss[ i ],
                c -> ( Size( G ) / Size( c ) ) mod cents[ i ] = 0 and
                     Size( c ) * cents[ i ] >= Size( Q )
            ) );
            free := GeneratorsOfGroup( FreeGroup( 2 ) );
            rels := [
                [ free[ 1 ] * free[ 2 ],
                  Order( gensQ[ 1 ] * gensQ[ 2 ] ) ],
                [ Comm( free[ 1 ], free[ 2 ] ),
                  Order( Comm( gensQ[ 1 ], gensQ[ 2 ] ) ) ]
            ];
            embs := MorClassLoop( G, poss, rec(
                gens := gensQ, from := Q, free := free, rels := rels
            ), 11 );
            Add( cache, rec( grp := Q, emb := embs ) );
        fi;
        for emb in embs do
            hom := p * emb;
            SetKernelOfMultiplicativeGeneralMapping( hom, N );
            Add( homs, hom );
        od;
    od;
    return homs;
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
    local gensH, gensG, imgs, h, oh, imgsG, g, og, pows, step, e, elts, coords,
          primes, pos, mat;
    gensH := IndependentGeneratorsOfAbelianGroup( H );
    gensG := IndependentGeneratorsOfAbelianGroup( G );
    imgs := [];
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
        elts := Union( imgs );
        coords := List( elts, g -> IndependentGeneratorExponents( G, g ) );
        primes := PrimeDivisors( Size( G ) );
        pos := List( primes, p -> Filtered( [ 1 .. Length( gensG ) ],
            i -> Order( gensG[ i ] ) mod p = 0 ) );
    fi;
    e := [];
    for imgsG in IteratorOfCartesianProduct( imgs ) do
        if not auts then
            mat := List( imgsG, g -> coords[ PositionSorted( elts, g ) ] );
            if ForAll(
                [ 1 .. Length( primes ) ], i -> DeterminantMat(
                    List( pos[ i ], j -> mat[ j ]{ pos[ i ] } )
                ) mod primes[ i ] <> 0
            ) then
                continue;
            fi;
        fi;
        Add( e, GroupHomomorphismByImagesNC( H, G, gensH, imgsG ) );
    od;
    return e;
end;
