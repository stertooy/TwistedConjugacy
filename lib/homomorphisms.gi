###############################################################################
##
## InducedHomomorphism( epi1, epi2, hom )
##
##  INPUT:
##      epi1:       epimorphism H -> H/N
##      epi2:       epimorphism G -> G/M
##      hom:        group homomorphism H -> G
##
##  OUTPUT:
##      hom2:       induced group homomorphism H/N -> G/M
##
InstallGlobalFunction(
    InducedHomomorphism,
    function( epi1, epi2, hom )
        local GM, HN, gens, imgs;
        GM := ImagesSource( epi2 );
        HN := ImagesSource( epi1 );
        gens := SmallGeneratingSet( HN );
        imgs := List( gens, h -> ImagesRepresentative(
            epi2,
            ImagesRepresentative( hom, PreImagesRepresentativeNC( epi1, h ) )
        ));
        return GroupHomomorphismByImagesNC( HN, GM, gens, imgs );
    end
);


###############################################################################
##
## RestrictedHomomorphism( hom, N, M )
##
##  INPUT:
##      hom:        group homomorphism H -> G
##      N:          subgroup of H
##      M:          subgroup of G
##
##  OUTPUT:
##      hom2:       restricted group homomorphism N -> M
##
InstallGlobalFunction(
    RestrictedHomomorphism,
    function( hom, N, M )
        local gens, imgs;
        gens := SmallGeneratingSet( N );
        imgs := List( gens, n -> ImagesRepresentative( hom, n ) );
        return GroupHomomorphismByImagesNC( N, M, gens, imgs );
    end
);


###############################################################################
##
## InclusionHomomorphism( H, G )
##
##  INPUT:
##      H:          subgroup of G
##      G:          group
##
##  OUTPUT:
##      hom:        natural inclusion H -> G
##
InstallGlobalFunction(
    InclusionHomomorphism,
    function( H, G )
        local gens;
        gens := GeneratorsOfGroup( H );
        return GroupHomomorphismByImagesNC( H, G, gens, gens );
    end
);


###############################################################################
##
## RepresentativesHomomorphismClasses( H, G )
##
##  INPUT:
##      H:          group
##      G:          group
##
##  OUTPUT:
##      L:          list of all group homomorphisms H -> G, up to inner
##                  automorphisms of G
##
InstallGlobalFunction(
    RepresentativesHomomorphismClasses,
    function( H, G )
        IsFinite( H );
        IsAbelian( H );
        IsCyclic( H );
        IsTrivial( H );
        IsFinite( G );
        IsAbelian( G );
        IsTrivial( G );
        return RepresentativesHomomorphismClassesOp( H, G );
    end
);


###############################################################################
##
## RepresentativesEndomorphismClasses( G )
##
##  INPUT:
##      G:          group
##
##  OUTPUT:
##      L:          list of all endomorphisms of G, up to inner automorphisms
##
InstallGlobalFunction(
    RepresentativesEndomorphismClasses,
    function( G )
        IsFinite( G );
        IsAbelian( G );
        IsTrivial( G );
        return RepresentativesEndomorphismClassesOp( G );
    end
);


###############################################################################
##
## RepresentativesAutomorphismClasses( G )
##
##  INPUT:
##      G:          group
##
##  OUTPUT:
##      L:          list of all automorphisms of G, up to inner automorphisms
##
InstallGlobalFunction(
    RepresentativesAutomorphismClasses,
    function( G )
        IsAbelian( G );
        return RepresentativesAutomorphismClassesOp( G );
    end
);


###############################################################################
##
## KernelsOfHomomorphismClasses@( H, KerOrbits, ImgOrbits )
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
##      Isos:       Matrix containing a homomorphism from G to ImgOrbits[j][1],
##                  factoring through G/KerOrbits[i][1], for all [i,j] in Pairs
##
KernelsOfHomomorphismClasses@ := function( H, KerOrbits, ImgOrbits )
    local AutH, asAuto, Pairs, Heads, Isos, i, N, p, Q, j, M, iso, kerOrbit,
          possibleImgs;
    AutH := AutomorphismGroup( H );
    asAuto := function( A, aut ) return ImagesSet( aut, A ); end;
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
            [ 1 .. Size( ImgOrbits ) ], j ->
            Size( ImgOrbits[j][1] ) = IndexNC( H, N )
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
                Isos[i][j] := p*iso;
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
end;


###############################################################################
##
## ImagesOfHomomorphismClasses@( Pairs, ImgOrbits, Reps, G )
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
ImagesOfHomomorphismClasses@ := function( Pairs, ImgOrbits, Reps, G )
    local Tails, AutG, asAuto, j, imgOrbit, M, AutM, InnGM, head, tail;
    asAuto := function( A, aut ) return ImagesSet( aut, A ); end;
    AutG := AutomorphismGroup( G );
    Tails := [];
    for j in Set( Pairs, x -> x[2] ) do
        imgOrbit := ImgOrbits[j];
        M := imgOrbit[1];
        AutM := AutomorphismGroup( M );
        InnGM := SubgroupNC( AutM, List(
            SmallGeneratingSet( NormalizerInParent( M ) ),
            g ->  ConjugatorAutomorphismNC( M, g )
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
end;


###############################################################################
##
## FuseHomomorphismClasses@( Pairs, Heads, Isos, Tails )
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
FuseHomomorphismClasses@ := function( Pairs, Heads, Isos, Tails )
    local homs, pair, head, tail, iso;
    homs := [];
    for pair in Pairs do
        head := Heads[ pair[1] ];
        tail := Tails[ pair[2] ];
        iso := Isos[ pair[1] ][ pair[2] ];
        if Length( head ) < Length( tail ) then
            head := head*iso;
        else
            tail := iso*tail;
        fi;
        Append( homs, ListX( head, tail, \* ) );
    od;
    return homs;
end;


###############################################################################
##
## RepresentativesHomomorphismClasses2Generated@( G )
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
RepresentativesHomomorphismClasses2Generated@ := function( H, G )
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
                        gens[k] := gens[k] ^ ( go / Random( Factors( go ) ) );
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
end;


###############################################################################
##
## RepresentativesHomomorphismClassesAbelian@( H, G )
##
##  INPUT:
##      H:          abelian group
##      G:          abelian group
##
##  OUTPUT:
##      L:          list of all group homomorphisms H -> G, up to inner
##                  automorphisms of G
##
RepresentativesHomomorphismClassesAbelian@ := function( H, G )
    local gensH, gensG, imgs, h, oh, imgsG, g, og, pows, e;
    gensH := IndependentGeneratorsOfAbelianGroup( H );
    gensG := IndependentGeneratorsOfAbelianGroup( G );
    imgs := [];
    for h in gensH do
        oh := Order( h );
        imgsG := [];
        for g in gensG do
            og := Order( g );
            pows := Filtered( [0..og-1], x -> ((x*oh) mod og) = 0 );
            Add( imgsG, List( pows, x -> g^x ) );
        od;
        Add( imgs, List( Cartesian( imgsG ), Product ) );
    od;
    e := [];
    for imgsG in IteratorOfCartesianProduct( imgs ) do
        Add( e, GroupHomomorphismByImagesNC( H, G, gensH, imgsG ) );
    od;
    return e;
end;


###############################################################################
##
## RepresentativesHomomorphismClassesOp( H, G )
##
##  INPUT:
##      H:          group
##      G:          group
##
##  OUTPUT:
##      L:          list of all group homomorphisms H -> G, up to inner
##                  automorphisms of G
##
InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for trivial source",
    [ IsGroup and IsTrivial, IsGroup and IsFinite ],
    4*SUM_FLAGS+5,
    function( H, G )
        if not IsTrivial( H ) then TryNextMethod(); fi;
        return [ GroupHomomorphismByImagesNC(
            H, G,
            [ One( H ) ], [ One( G ) ]
        )];
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for trivial range",
    [ IsGroup and IsFinite, IsGroup and IsTrivial ],
    3*SUM_FLAGS+4,
    function( H, G )
        local gens, imgs;
        gens := SmallGeneratingSet( H );
        imgs := List( gens, h -> One( G ) );
        return [ GroupHomomorphismByImagesNC( H, G, gens, imgs ) ];
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for non-abelian source and abelian range",
    [ IsGroup and IsFinite, IsGroup and IsFinite and IsAbelian ],
    2*SUM_FLAGS+3,
    function( H, G )
        local p;
        if IsAbelian( H ) then TryNextMethod(); fi;
        p := NaturalHomomorphismByNormalSubgroupNC( H, DerivedSubgroup( H ) );
        return List(
        RepresentativesHomomorphismClasses( ImagesSource( p ), G ),
            hom -> p*hom
        );
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for abelian source and abelian range",
    [ IsGroup and IsFinite and IsAbelian, IsGroup and IsFinite and IsAbelian ],
    SUM_FLAGS+2,
    RepresentativesHomomorphismClassesAbelian@
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for cyclic source and non-abelian range",
    [ IsGroup and IsFinite and IsCyclic, IsGroup and IsFinite ],
    SUM_FLAGS+2,
    function( H, G )
        local h, o, L;
        if IsAbelian( G ) then TryNextMethod(); fi;
        h := MinimalGeneratingSet( H )[1];
        o := Order( h );
        L := List( ConjugacyClasses( G ), Representative );
        L := Filtered( L, g -> IsInt( o / Order( g ) ) );
        return List( L, g -> GroupHomomorphismByImagesNC(
            H, G,
            [ h ], [ g ]
        ));
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for 2-generated source",
    [ IsGroup and IsFinite, IsGroup and IsFinite ],
    1,
    function( H, G )
        if Size( SmallGeneratingSet( H ) ) <> 2 then TryNextMethod(); fi;
        return RepresentativesHomomorphismClasses2Generated@( H, G );
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for abitrary finite groups",
    [ IsGroup and IsFinite, IsGroup and IsFinite ],
    0,
    function( H, G )
        local asAuto, AutH, AutG, gensAutG, gensAutH, Conj, c, r, ImgReps,
              ImgOrbits, KerOrbits, Pairs, Heads, Tails, Isos, KerInfo, Reps;

        # Step 1: Determine automorphism groups of H and G
        asAuto := function( A, aut ) return ImagesSet( aut, A ); end;
        AutH := AutomorphismGroup( H );
        AutG := AutomorphismGroup( G );
        gensAutG := SmallGeneratingSet( AutG );
        gensAutH := SmallGeneratingSet( AutH );

        # Step 2: Determine all possible kernels and images, i.e.
        # the normal subgroups of H and the subgroups of G
        Conj := ConjugacyClassesSubgroups( G );
        for c in Conj do
            r := Representative( c );
            SetNormalizerInParent( r, StabilizerOfExternalSet( c ) );
        od;
        ImgReps := List( Conj, Representative );
        ImgOrbits := OrbitsDomain(
            AutG, Flat( List( Conj, List ) ),
            gensAutG, gensAutG,
            asAuto
        );
        ImgOrbits := List( ImgOrbits, x -> Filtered( ImgReps, y -> y in x ) );
        KerOrbits := OrbitsDomain(
            AutH, NormalSubgroups( H ),
            gensAutH, gensAutH,
            asAuto
        );

        # Step 3: Calculate info on kernels
        KerInfo := KernelsOfHomomorphismClasses@( H, KerOrbits, ImgOrbits );
        Pairs := KerInfo[1];
        Heads := KerInfo[2];
        Isos := KerInfo[3];

        # Step 4: Calculate info on images
        Reps := EmptyPlist( Length( ImgOrbits ) );
        Tails := ImagesOfHomomorphismClasses@( Pairs, ImgOrbits, Reps, G );

        # Step 5: Calculate the homomorphisms
        return FuseHomomorphismClasses@( Pairs, Heads, Isos, Tails );;
    end
);


###############################################################################
##
## RepresentativesEndomorphismClassesOp( G )
##
##  INPUT:
##      G:          group
##
##  OUTPUT:
##      L:          list of all endomorphisms of G, up to inner automorphisms
##
InstallMethod(
    RepresentativesEndomorphismClassesOp,
    "for trivial groups",
    [ IsGroup and IsTrivial ],
    2*SUM_FLAGS+3,
    function( G )
        return [ GroupHomomorphismByImagesNC(
            G, G,
            [ One( G ) ], [ One( G ) ]
        )];
    end
);

InstallMethod(
    RepresentativesEndomorphismClassesOp,
    "for finite abelian groups",
    [ IsGroup and IsFinite and IsAbelian ],
    SUM_FLAGS+2,
    function( G )
        return RepresentativesHomomorphismClassesAbelian@( G, G );
    end
);

InstallMethod(
    RepresentativesEndomorphismClassesOp,
    "for finite 2-generated groups",
    [ IsGroup and IsFinite ],
    1,
    function( G )
        if Size( SmallGeneratingSet( G ) ) <> 2 then TryNextMethod(); fi;
        return RepresentativesHomomorphismClasses2Generated@( G, G );
    end
);

InstallMethod(
    RepresentativesEndomorphismClassesOp,
    "for abitrary finite groups",
    [ IsGroup and IsFinite ],
    0,
    function( G )
        local asAuto, AutG, gensAutG, Conj, c, r, norm, SubReps, SubOrbits,
              Pairs, Reps, i, Tails, Isos, KerInfo, KerOrbits;

        # Step 1: Determine automorphism group of G
        asAuto := function( A, aut ) return ImagesSet( aut, A ); end;
        AutG := AutomorphismGroup( G );
        gensAutG := SmallGeneratingSet( AutG );

        # Step 2: Determine all possible kernels and images, i.e.
        # the (normal) subgroups of G
        Conj := ConjugacyClassesSubgroups( G );
        for c in Conj do
            r := Representative( c );
            norm := StabilizerOfExternalSet( c );
            SetIsNormalInParent( r, IndexNC( G, norm ) = 1 );
            SetNormalizerInParent( r, norm );
        od;

        SubReps := List( Conj, Representative );
        SubOrbits := OrbitsDomain(
            AutG, Flat( List( Conj, List ) ),
            gensAutG, gensAutG,
            asAuto
        );
        SubOrbits := List( SubOrbits, x -> Filtered( SubReps, y -> y in x ) );

        KerOrbits := EmptyPlist( Length( SubOrbits ) );
        for i in [ 1..Length( SubOrbits ) ] do
            r := SubOrbits[i][1];
            if IsNormalInParent( r ) and not IsTrivial( r ) then
                KerOrbits[i] := SubOrbits[i];
            fi;
        od;

        # Step 3: Calculate info on kernels
        KerInfo := KernelsOfHomomorphismClasses@( G, KerOrbits, SubOrbits );
        Pairs := KerInfo[1];
        Reps := KerInfo[2];
        Isos := KerInfo[3];

        # Step 4: Calculate info on images
        Tails := ImagesOfHomomorphismClasses@( Pairs, SubOrbits, Reps, G );

        # Step 5: Calculate the homomorphisms
        return Concatenation(
            RepresentativesAutomorphismClasses( G ),
            FuseHomomorphismClasses@( Pairs, Reps, Isos, Tails )
        );
    end
);


###############################################################################
##
## RepresentativesAutomorphismClassesOp( G )
##
##  INPUT:
##      G:          group
##
##  OUTPUT:
##      L:          list of all automorphisms of G, up to inner automorphisms
##
InstallMethod(
    RepresentativesAutomorphismClassesOp,
    "for finite abelian groups",
    [ IsGroup and IsFinite and IsAbelian ],
    function( G )
        return List( AutomorphismGroup( G ) );
    end
);

InstallMethod(
    RepresentativesAutomorphismClassesOp,
    "for arbitrary finite groups",
    [ IsGroup and IsFinite ],
    function( G )
        local AutG, InnG;
        AutG := AutomorphismGroup( G );
        InnG := InnerAutomorphismsAutomorphismGroup( AutG );
        return List( RightTransversal( AutG, InnG ) );
    end
);
