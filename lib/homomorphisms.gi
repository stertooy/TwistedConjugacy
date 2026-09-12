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
        ) );
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
        if Source( hom ) = N and HasMappingGeneratorsImages( hom ) then
            gens := MappingGeneratorsImages( hom )[ 1 ];
            imgs := MappingGeneratorsImages( hom )[ 2 ];
        else
            gens := SmallGeneratingSet( N );
            imgs := List( gens, n -> ImagesRepresentative( hom, n ) );
        fi;
        return GroupHomomorphismByImagesNC( N, M, gens, imgs );
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
## RepresentativesEndomorphismClasses( G, auts )
##
##  INPUT:
##      G:          group
##      auts:       boolean (optional)
##
##  OUTPUT:
##      L:          list of all endomorphisms of G, up to inner automorphisms
##
InstallGlobalFunction(
    RepresentativesEndomorphismClasses,
    function( G, arg... )
        local auts;
        IsFinite( G );
        IsQuasisimpleGroup( G );
        IsAbelian( G );
        IsTrivial( G );
        auts := IsEmpty( arg ) or arg[ 1 ];
        return RepresentativesEndomorphismClassesOp( G, auts );
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
    [ IsGroup and IsTrivial, IsGroup ],
    4 * SUM_FLAGS + 5,
    function( H, G )
        return [ GroupHomomorphismByImagesNC(
            H, G,
            [ One( H ) ], [ One( G ) ]
        ) ];
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for trivial range",
    [ IsGroup, IsGroup and IsTrivial ],
    3 * SUM_FLAGS + 4,
    function( H, G )
        local gens, imgs;
        gens := GeneratorsOfGroup( H );
        imgs := ListWithIdenticalEntries( Length( gens ), One( G ) );
        return [ GroupHomomorphismByImagesNC( H, G, gens, imgs ) ];
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for non-abelian source and abelian range",
    [ IsGroup, IsGroup and IsAbelian ],
    2 * SUM_FLAGS + 3,
    function( H, G )
        local p;
        if IsAbelian( H ) then TryNextMethod(); fi;
        p := NaturalHomomorphismByNormalSubgroupNC( H, DerivedSubgroup( H ) );
        p := RestrictedHomomorphism( p, H, ImagesSource( p ) );
        return List(
            RepresentativesHomomorphismClasses( ImagesSource( p ), G ),
            hom -> p * hom
        );
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for abelian source and abelian range",
    [ IsGroup and IsFinite and IsAbelian, IsGroup and IsFinite and IsAbelian ],
    SUM_FLAGS + 2,
    { H, G } -> TWC.RepsHomClassesAbelian( H, G, true )
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for cyclic source and non-abelian range",
    [ IsGroup and IsFinite and IsCyclic, IsGroup and IsFinite ],
    SUM_FLAGS + 2,
    function( H, G )
        local h, o, L;
        if IsAbelian( G ) then TryNextMethod(); fi;
        h := MinimalGeneratingSet( H )[ 1 ];
        o := Order( h );
        L := List( ConjugacyClasses( G ), Representative );
        L := Filtered( L, g -> IsInt( o / Order( g ) ) );
        return List( L,
            g -> GroupHomomorphismByImagesNC( H, G, [ h ], [ g ] )
        );
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for non-abelian simple source",
    [ IsGroup and IsFinite and IsNonabelianSimpleGroup, IsGroup and IsFinite ],
    function( H, G )
        local ccls, ords, gens, poss, cents, free, rels, imgs, triv, params;
        ccls := ConjugacyClasses( G );
        ords := List( ccls, c -> Order( Representative( c ) ) );
        gens := SmallGeneratingSet( H );
        poss := List( gens, q -> ccls{ Positions( ords, Order( q ) ) } );
        cents := List( gens, q -> Size( Centraliser( H, q ) ) );
        poss := List( [ 1, 2 ], i -> Filtered( poss[ i ],
            c -> ( Size( G ) / Size( c ) ) mod cents[ i ] = 0 and
                 Size( c ) * cents[ i ] >= Size( H )
        ) );
        free := GeneratorsOfGroup( FreeGroup( 2 ) );
        rels := [
            [ free[ 1 ] * free[ 2 ],
              Order( gens[ 1 ] * gens[ 2 ] ) ],
            [ Comm( free[ 1 ], free[ 2 ] ),
              Order( Comm( gens[ 1 ], gens[ 2 ] ) ) ]
        ];
        imgs := ListWithIdenticalEntries( Length( gens ), One( G ) );
        triv := GroupHomomorphismByImagesNC( H, G, gens, imgs );
        params := rec( gens := gens, from := H, free := free, rels := rels );
        return Concatenation(
            MorClassLoop( G, poss, params, 11 ),
            [ triv ]
        );
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for 2-generated source",
    [ IsGroup and IsFinite, IsGroup and IsFinite ],
    1,
    function( H, G )
        if Size( SmallGeneratingSet( H ) ) <> 2 then TryNextMethod(); fi;
        return TWC.RepsHomClasses2Gen( H, G, true );
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for arbitrary finite groups",
    [ IsGroup and IsFinite, IsGroup and IsFinite ],
    0,
    function( H, G )
        local asAuto, AutH, AutG, gensAutG, gensAutH, Conj, ImgReps, ImgOrbits,
              KerOrbits, Pairs, Heads, Tails, Isos, KerInfo, Reps, Norms,
              quoSizes, imgSizes;

        # Step 1: Determine automorphism groups of H and G
        asAuto := { A, aut } -> ImagesSet( aut, A );
        AutH := AutomorphismGroup( H );
        AutG := AutomorphismGroup( G );
        gensAutG := SmallGeneratingSet( AutG );
        gensAutH := SmallGeneratingSet( AutH );
        Norms := NormalSubgroups( H );

        # Step 2: Determine all possible images (subgroups of G)
        quoSizes := Set( Norms, N -> Size( H ) / Size( N ) );
        Conj := Filtered(
            ConjugacyClassesSubgroups( G ),
            c -> Size( Representative( c ) ) in quoSizes
        );
        ImgReps := List( Conj, Representative );
        ImgOrbits := OrbitsDomain(
            AutG, Flat( List( Conj, List ) ),
            gensAutG, gensAutG,
            asAuto
        );
        ImgOrbits := List( ImgOrbits, x -> Filtered( ImgReps, y -> y in x ) );

        # Step 3: Determine all possible kernels (normal subgroups of H)
        imgSizes := Set( ImgReps, Size );
        KerOrbits := OrbitsDomain(
            AutH, Filtered( Norms, N -> Size( H ) / Size( N ) in imgSizes ),
            gensAutH, gensAutH,
            asAuto
        );

        # Step 4: Calculate info on kernels
        KerInfo := TWC.KernelsOfHomomorphismClasses( H, KerOrbits, ImgOrbits );
        Pairs := KerInfo[ 1 ];
        Heads := KerInfo[ 2 ];
        Isos := KerInfo[ 3 ];

        # Step 5: Calculate info on images
        Reps := EmptyPlist( Length( ImgOrbits ) );
        Tails := TWC.ImagesOfHomomorphismClasses( Pairs, ImgOrbits, Reps, G );

        # Step 6: Calculate the homomorphisms
        return TWC.FuseHomomorphismClasses( Pairs, Heads, Isos, Tails );
    end
);

###############################################################################
##
## RepresentativesEndomorphismClassesOp( G, auts )
##
##  INPUT:
##      G:          group
##      auts:       boolean
##
##  OUTPUT:
##      L:          list of all endomorphisms of G, up to inner automorphisms
##
InstallMethod(
    RepresentativesEndomorphismClassesOp,
    "for trivial groups",
    [ IsGroup and IsTrivial, IsBool ],
    2 * SUM_FLAGS + 3,
    function( G, auts )
        if auts then
            return [ GroupHomomorphismByImagesNC(
                G, G,
                [ One( G ) ], [ One( G ) ]
            ) ];
        fi;
        return [];
    end
);

InstallMethod(
    RepresentativesEndomorphismClassesOp,
    "for finite quasisimple groups",
    [ IsGroup and IsFinite and IsQuasisimpleGroup, IsBool ],
    SUM_FLAGS + 2,
    function( G, auts )
        local gens, imgs, ends;
        gens := GeneratorsOfGroup( G );
        imgs := ListWithIdenticalEntries( Length( gens ), One( G ) );
        ends := [ GroupHomomorphismByImagesNC( G, G, gens, imgs ) ];
        if auts then
            ends := Concatenation(
                RepresentativesAutomorphismClasses( G ),
                ends
            );
        fi;
        return ends;
    end
);

InstallMethod(
    RepresentativesEndomorphismClassesOp,
    "for finite abelian groups",
    [ IsGroup and IsFinite and IsAbelian, IsBool ],
    SUM_FLAGS + 2,
    { G, auts } -> TWC.RepsHomClassesAbelian( G, G, auts )
);

InstallMethod(
    RepresentativesEndomorphismClassesOp,
    "for finite 2-generated groups",
    [ IsGroup and IsFinite, IsBool ],
    1,
    function( G, auts )
        if Size( SmallGeneratingSet( G ) ) <> 2 then TryNextMethod(); fi;
        return TWC.RepsHomClasses2Gen( G, G, auts );
    end
);

InstallMethod(
    RepresentativesEndomorphismClassesOp,
    "for arbitrary finite groups",
    [ IsGroup and IsFinite, IsBool ],
    0,
    function( G, auts )
        local asAuto, AutG, gensAutG, Conj, r, SubReps, SubOrbits, Pairs, Reps,
              i, Tails, Isos, KerInfo, KerOrbits, Ends, Norms, quoSizes,
              kerSizes;

        # Step 1: Determine automorphism group of G
        asAuto := function( A, aut ) return ImagesSet( aut, A ); end;
        AutG := AutomorphismGroup( G );
        gensAutG := SmallGeneratingSet( AutG );
        Norms := Filtered( NormalSubgroups( G ), N -> not IsTrivial( N ) );

        # Step 2: Determine all possible kernels and images, i.e.
        # the (normal) subgroups of G
        kerSizes := Set( Norms, Size );
        quoSizes := Set( kerSizes, i -> Size( G ) / i );
        Conj := Filtered(
            ConjugacyClassesSubgroups( G ),
            c -> Size( Representative( c ) ) in Union( quoSizes, kerSizes )
        );

        SubReps := List( Conj, Representative );
        SubOrbits := OrbitsDomain(
            AutG, Flat( List( Conj, List ) ),
            gensAutG, gensAutG,
            asAuto
        );
        SubOrbits := List( SubOrbits, x -> Filtered( SubReps, y -> y in x ) );

        KerOrbits := EmptyPlist( Length( SubOrbits ) );
        for i in [ 1 .. Length( SubOrbits ) ] do
            r := SubOrbits[ i ][ 1 ];
            if Size( r ) in kerSizes and r in Norms then
                KerOrbits[ i ] := SubOrbits[ i ];
            fi;
        od;

        # Step 3: Calculate info on kernels
        KerInfo := TWC.KernelsOfHomomorphismClasses( G, KerOrbits, SubOrbits );
        Pairs := KerInfo[ 1 ];
        Reps := KerInfo[ 2 ];
        Isos := KerInfo[ 3 ];

        # Step 4: Calculate info on images
        Tails := TWC.ImagesOfHomomorphismClasses( Pairs, SubOrbits, Reps, G );

        # Step 5: Calculate the homomorphisms
        Ends := TWC.FuseHomomorphismClasses( Pairs, Reps, Isos, Tails );
        if auts then
            Ends := Concatenation(
                RepresentativesAutomorphismClasses( G ),
                Ends
            );
        fi;
        return Ends;
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
    G -> List( AutomorphismGroup( G ) )
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
