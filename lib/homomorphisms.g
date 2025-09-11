###############################################################################
##
## TWC_KernelsOfHomomorphismClasses( H, KerOrbits, ImgOrbits )
##
##  INPUT:
##      H:          group
##      KerOrbits:  List of orbits of the natural action of Aut(H) on the set
##                  of all normal subgroups of H
##      ImgOrbits:  List of orbits of the natural action of Aut(G) on the set
##                  of all subgroups of G (up to conjugacy), for some group G
##
##  OUTPUT:
##      Pairs:      List of pairs of indices [i,j] such that G/KerOrbits[i][1]
##                  is isomorphic to ImgOrbits[j][1]
##      Heads:      List of lists of automorphisms of H that map
##                  KerOrbits[i][1] to KerOrbits[i][k], for all k > 1
##      Isos:       Matrix containing a homomorphism from H to ImgOrbits[j][1],
##                  factoring through H/KerOrbits[i][1], for all [i,j] in Pairs
##
BindGlobal(
    "TWC_KernelsOfHomomorphismClasses",
    function( H, KerOrbits, ImgOrbits )
        local AutH, asAuto, Pairs, Heads, Isos, i, N, p, Q, j, M, iso,
              kerOrbit, possibleImgs;
        AutH := AutomorphismGroup( H );
        asAuto := { A, aut } -> ImagesSet( aut, A );
        Pairs := [];
        Heads := [];
        Isos := [];
        for i in [ 1 .. Size( KerOrbits ) ] do
            if not IsBound( KerOrbits[i] ) then
                continue;
            fi;
            kerOrbit := KerOrbits[i];
            N := kerOrbit[1];
            possibleImgs := Filtered(
                [ 1 .. Size( ImgOrbits ) ],
                j -> Size( ImgOrbits[j][1] ) = IndexNC( H, N )
            );
            if IsEmpty( possibleImgs ) then
                continue;
            fi;
            Isos[i] := [];
            p := NaturalHomomorphismByNormalSubgroupNC( H, N );
            Q := ImagesSource( p );
            p := RestrictedHomomorphism( p, H, Q );
            for j in possibleImgs do
                M := ImgOrbits[j][1];
                iso := IsomorphismGroups( Q, M );
                if iso <> fail then
                    Isos[i][j] := p * iso;
                    Add( Pairs, [ i, j ] );
                fi;
            od;
            if not IsEmpty( SetX( Pairs, x -> x[1] = i, x -> x[1] ) ) then
                Heads[i] := List(
                    kerOrbit,
                    x -> RepresentativeAction( AutH, N, x, asAuto )
                );
            fi;
        od;
        return [ Pairs, Heads, Isos ];
    end
);

###############################################################################
##
## TWC_ImagesOfHomomorphismClasses( Pairs, ImgOrbits, Reps, G )
##
##  INPUT:
##      Pairs:      List of pairs of indices [i,j] such that G/KerOrbits[i][1]
##                  is isomorphic to ImgOrbits[j][1]
##      ImgOrbits:  List of orbits of the natural action of Aut(G) on the set
##                  of all subgroups of G (up to conjugacy), for some group G
##      Reps:       List of lists of automorphisms of G that map
##                  ImgOrbits[i][1] to ImgOrbits[i][k], for all k > 1
##      G:          group
##
##  OUTPUT:
##      Tails:      List of all homomorphisms from ImgOrbits[i][1] to G, up to
##                  inner automorphisms of G, for all i where [i,j] in Pairs
##
BindGlobal(
    "TWC_ImagesOfHomomorphismClasses",
    function( Pairs, ImgOrbits, Reps, G )
        local Tails, AutG, asAuto, j, imgOrbit, M, AutM, InnGM, head, tail;
        asAuto := { A, aut } -> ImagesSet( aut, A );
        AutG := AutomorphismGroup( G );
        Tails := [];
        for j in Set( Pairs, x -> x[2] ) do
            imgOrbit := ImgOrbits[j];
            M := imgOrbit[1];
            AutM := AutomorphismGroup( M );
            InnGM := SubgroupNC( AutM, List(
                SmallGeneratingSet( Normalizer( G, M ) ),
                g -> ConjugatorAutomorphismNC( M, g )
            ));
            head := RightTransversal( AutM, InnGM );
            if not IsBound( Reps[j] ) then
                tail := List(
                    imgOrbit,
                    x -> RepresentativeAction( AutG, M, x, asAuto )
                );
            else
                tail := Reps[j];
            fi;
            head := List( head, x -> GroupHomomorphismByImagesNC( M, G,
                MappingGeneratorsImages( x )[1],
                MappingGeneratorsImages( x )[2]
            ));
            Tails[j] := ListX( head, tail, \* );
        od;
        return Tails;
    end
);

###############################################################################
##
## TWC_FuseHomomorphismClasses( Pairs, Heads, Isos, Tails )
##
##  INPUT:
##      Pairs:      List of pairs of indices [i,j] such that G/KerOrbits[i][1]
##                  is isomorphic to ImgOrbits[j][1]
##      Heads:      List of lists of automorphisms of H that map
##                  KerOrbits[i][1] to KerOrbits[i][k], for all k > 1
##      Isos:       Matrix containing a homomorphism from G to ImgOrbits[j][1],
##                  factoring through G/KerOrbits[i][1], for all [i,j] in Pairs
##      Tails:      List of all homomorphisms from ImgOrbits[i][1] to G, up to
##                  inner automorphisms of G, for all i where [i,j] in Pairs
##
##  OUTPUT:
##      L:          list of all group homomorphisms H -> G, up to inner
##                  automorphisms of G
##
BindGlobal(
    "TWC_FuseHomomorphismClasses",
    function( Pairs, Heads, Isos, Tails )
        local homs, pair, head, tail, iso;
        homs := [];
        for pair in Pairs do
            head := Heads[ pair[1] ];
            tail := Tails[ pair[2] ];
            iso := Isos[ pair[1] ][ pair[2] ];
            if Length( head ) < Length( tail ) then
                head := head * iso;
            else
                tail := iso * tail;
            fi;
            Append( homs, ListX( head, tail, \* ) );
        od;
        return homs;
    end
);

###############################################################################
##
## TWC_RepresentativesHomomorphismClasses2Generated( G )
##
##  INPUT:
##      H:          2-generated group
##      G:          group
##
##  OUTPUT:
##      L:          list of all group homomorphisms H -> G, up to inner
##                  automorphisms of G
##
##  REMARKS:
##      This is essentially the code of AllHomomorphismClasses, but with some
##      minor changes to remove redundant code. It assumes H is generated by
##      exactly 2 elements.
##
BindGlobal(
    "TWC_RepresentativesHomomorphismClasses2Generated",
    function( H, G )
        local cl, cnt, bg, bw, bo, bi, k, gens, go, imgs, params, i, prod;
        cl := ConjugacyClasses( G );
        bw := infinity;
        bo := [ 0, 0 ];
        cnt := 0;
        repeat
            if cnt = 0 then
                gens := SmallGeneratingSet( H );
            else
                repeat
                    gens := [ Random( H ), Random( H ) ];
                    for k in [ 1, 2 ] do
                        go := Order( gens[k] );
                        if Random( 1, 6 ) = 1 then
                            gens[k] := gens[k] ^ (
                                go / Random( Factors( go ) )
                            );
                        fi;
                    od;
                until IndexNC( H, SubgroupNC( H, gens ) ) = 1;
            fi;
            go := List( gens, Order );
            imgs := List( go, i -> Filtered(
                cl,
                j -> IsInt( i / Order( Representative( j ) ) )
            ));
            prod := Product( imgs, i -> Sum( i, Size ) );
            if prod < bw then
                bg := gens;
                bo := go;
                bi := imgs;
                bw := prod;
            elif Set( go ) = Set( bo ) then
                cnt := cnt + Int( bw / Size( G ) * 3 );
            fi;
            cnt := cnt + 1;
        until bw / Size( G ) * 3 < cnt;
        params := rec(
            gens := bg,
            from := H
        );
        return MorClassLoop( G, bi, params, 9 );
    end
);

###############################################################################
##
## TWC_RepresentativesHomomorphismClassesAbelian( H, G )
##
##  INPUT:
##      H:          abelian group
##      G:          abelian group
##
##  OUTPUT:
##      L:          list of all group homomorphisms H -> G, up to inner
##                  automorphisms of G
##
BindGlobal(
    "TWC_RepresentativesHomomorphismClassesAbelian",
    function( H, G )
        local gensH, gensG, imgs, h, oh, imgsG, g, og, pows, e;
        gensH := IndependentGeneratorsOfAbelianGroup( H );
        gensG := IndependentGeneratorsOfAbelianGroup( G );
        imgs := [];
        for h in gensH do
            oh := Order( h );
            imgsG := [];
            for g in gensG do
                og := Order( g );
                pows := Filtered(
                    [ 0 .. og - 1 ],
                    x -> ( ( x * oh ) mod og ) = 0
                );
                Add( imgsG, List( pows, x -> g ^ x ) );
            od;
            Add( imgs, List( Cartesian( imgsG ), Product ) );
        od;
        e := [];
        for imgsG in IteratorOfCartesianProduct( imgs ) do
            Add( e, GroupHomomorphismByImagesNC( H, G, gensH, imgsG ) );
        od;
        return e;
    end
);
