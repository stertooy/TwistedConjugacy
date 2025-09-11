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
        if Source( hom ) = N and HasMappingGeneratorsImages( hom ) then
            gens := MappingGeneratorsImages( hom )[1];
            imgs := MappingGeneratorsImages( hom )[2];
        else
            gens := SmallGeneratingSet( N );
            imgs := List( gens, n -> ImagesRepresentative( hom, n ) );
        fi;
        return GroupHomomorphismByImagesNC( N, M, gens, imgs );
    end
);

###############################################################################
##
## TWC_InclusionHomomorphism( H, G )
##
##  INPUT:
##      H:          subgroup of G
##      G:          group
##
##  OUTPUT:
##      hom:        natural inclusion H -> G
##
InstallGlobalFunction(
    TWC_InclusionHomomorphism,
    function( H, G )
        local gens;
        gens := GeneratorsOfGroup( H );
        return GroupHomomorphismByImagesNC( H, G, gens, gens );
    end
);

###############################################################################
##
##  TWC_DifferenceGroupHomomorphisms( hom1, hom2, N, M )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          subgroup of H
##      M:          subgroup of G
##
##  OUTPUT:
##      diff:       group homomorphism N -> M: n -> n^hom2 * ( n^hom1 )^-1
##
##  REMARKS:
##      Does not verify whether diff is a well-defined group homomorphism.
##
InstallGlobalFunction(
    TWC_DifferenceGroupHomomorphisms,
    function( hom1, hom2, N, M )
        local gens, imgs;
        gens := GeneratorsOfGroup( N );
        imgs := List(
            gens,
            n -> ImagesRepresentative( hom1, n ) /
                ImagesRepresentative( hom2, n )
        );
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
        )];
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
    TWC_RepresentativesHomomorphismClassesAbelian
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for cyclic source and non-abelian range",
    [ IsGroup and IsFinite and IsCyclic, IsGroup and IsFinite ],
    SUM_FLAGS + 2,
    function( H, G )
        local h, o, L;
        if IsAbelian( G ) then TryNextMethod(); fi;
        h := MinimalGeneratingSet( H )[1];
        o := Order( h );
        L := List( ConjugacyClasses( G ), Representative );
        L := Filtered( L, g -> IsInt( o / Order( g ) ) );
        return List( L, g -> GroupHomomorphismByImagesNC( H, G, [h], [g] ) );
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for 2-generated source",
    [ IsGroup and IsFinite, IsGroup and IsFinite ],
    1,
    function( H, G )
        if Size( SmallGeneratingSet( H ) ) <> 2 then TryNextMethod(); fi;
        return TWC_RepresentativesHomomorphismClasses2Generated( H, G );
    end
);

InstallMethod(
    RepresentativesHomomorphismClassesOp,
    "for abitrary finite groups",
    [ IsGroup and IsFinite, IsGroup and IsFinite ],
    0,
    function( H, G )
        local asAuto, AutH, AutG, gensAutG, gensAutH, Conj, ImgReps, ImgOrbits,
              KerOrbits, Pairs, Heads, Tails, Isos, KerInfo, Reps;

        # Step 1: Determine automorphism groups of H and G
        asAuto := { A, aut } -> ImagesSet( aut, A );
        AutH := AutomorphismGroup( H );
        AutG := AutomorphismGroup( G );
        gensAutG := SmallGeneratingSet( AutG );
        gensAutH := SmallGeneratingSet( AutH );

        # Step 2: Determine all possible kernels and images, i.e.
        # the normal subgroups of H and the subgroups of G
        Conj := ConjugacyClassesSubgroups( G );
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
        KerInfo := TWC_KernelsOfHomomorphismClasses( H, KerOrbits, ImgOrbits );
        Pairs := KerInfo[1];
        Heads := KerInfo[2];
        Isos := KerInfo[3];

        # Step 4: Calculate info on images
        Reps := EmptyPlist( Length( ImgOrbits ) );
        Tails := TWC_ImagesOfHomomorphismClasses( Pairs, ImgOrbits, Reps, G );

        # Step 5: Calculate the homomorphisms
        return TWC_FuseHomomorphismClasses( Pairs, Heads, Isos, Tails );
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
    2 * SUM_FLAGS + 3,
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
    SUM_FLAGS + 2,
    G -> TWC_RepresentativesHomomorphismClassesAbelian( G, G )
);

InstallMethod(
    RepresentativesEndomorphismClassesOp,
    "for finite 2-generated groups",
    [ IsGroup and IsFinite ],
    1,
    function( G )
        if Size( SmallGeneratingSet( G ) ) <> 2 then TryNextMethod(); fi;
        return TWC_RepresentativesHomomorphismClasses2Generated( G, G );
    end
);

InstallMethod(
    RepresentativesEndomorphismClassesOp,
    "for abitrary finite groups",
    [ IsGroup and IsFinite ],
    0,
    function( G )
        local asAuto, AutG, gensAutG, Conj, r, SubReps, SubOrbits, Pairs, Reps,
              i, Tails, Isos, KerInfo, KerOrbits;

        # Step 1: Determine automorphism group of G
        asAuto := function( A, aut ) return ImagesSet( aut, A ); end;
        AutG := AutomorphismGroup( G );
        gensAutG := SmallGeneratingSet( AutG );

        # Step 2: Determine all possible kernels and images, i.e.
        # the (normal) subgroups of G
        Conj := ConjugacyClassesSubgroups( G );

        SubReps := List( Conj, Representative );
        SubOrbits := OrbitsDomain(
            AutG, Flat( List( Conj, List ) ),
            gensAutG, gensAutG,
            asAuto
        );
        SubOrbits := List( SubOrbits, x -> Filtered( SubReps, y -> y in x ) );

        KerOrbits := EmptyPlist( Length( SubOrbits ) );
        for i in [ 1 .. Length( SubOrbits ) ] do
            r := SubOrbits[i][1];
            if IsNormal( G, r ) and not IsTrivial( r ) then
                KerOrbits[i] := SubOrbits[i];
            fi;
        od;

        # Step 3: Calculate info on kernels
        KerInfo := TWC_KernelsOfHomomorphismClasses( G, KerOrbits, SubOrbits );
        Pairs := KerInfo[1];
        Reps := KerInfo[2];
        Isos := KerInfo[3];

        # Step 4: Calculate info on images
        Tails := TWC_ImagesOfHomomorphismClasses( Pairs, SubOrbits, Reps, G );

        # Step 5: Calculate the homomorphisms
        return Concatenation(
            RepresentativesAutomorphismClasses( G ),
            TWC_FuseHomomorphismClasses( Pairs, Reps, Isos, Tails )
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
