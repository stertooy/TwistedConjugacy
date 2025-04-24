InstallTrueMethod( IsMapping, IsGroupDerivation );
InstallTrueMethod( RespectsOne, IsGroupDerivation );

InstallTrueMethod( IsGroupDerivation, IsGroupDerivationByImages );
InstallTrueMethod( IsGroupDerivation, IsGroupDerivationByFunction );

InstallGlobalFunction(
    GroupDerivationByImages,
    function( H, G, gens, imgs, act )
        local derv, type;
        derv := rec(
            act := act,
        );
        type := NewType(
            GeneralMappingsFamily(
                ElementsFamily( FamilyObj( H ) ),
                ElementsFamily( FamilyObj( G ) )
            ),
            IsGroupDerivationByImages and HasSource and HasRange and
                HasMappingGeneratorsImages
        );
        ObjectifyWithAttributes(
            derv, type,
            Source, H,
            Range, G,
            MappingGeneratorsImages, [ gens, imgs ]
        );
        return derv;
    end
);

InstallGlobalFunction(
    GroupDerivationByFunction,
    function( H, G, fnc, act )
        local derv, type;
        derv := rec(
            act := act,
            fnc := fnc
        );
        type := NewType(
            GeneralMappingsFamily(
                ElementsFamily( FamilyObj( H ) ),
                ElementsFamily( FamilyObj( G ) )
            ),
            IsGroupDerivationByFunction and HasSource and HasRange
        );
        ObjectifyWithAttributes(
            derv, type,
            Source, H,
            Range, G
        );
        return derv;
    end
);

InstallMethod(
    GroupDerivationInfo,
    [ IsGroupDerivationByImages ],
    function( derv )
        local H, G, act, S, embH, embG, gens, imgs, embsH, embsG, rhs;

        H := Source( derv );
        G := Range( derv );
        act := derv!.act;
        S := SemidirectProduct( H, act, G );

        embH := Embedding( S, 1 );
        embG := Embedding( S, 2 );

        gens := MappingGeneratorsImages( derv )[1];
        imgs := MappingGeneratorsImages( derv )[2];

        embsH := List( gens, h -> ImagesRepresentative( embH, h ) );
        embsG := List( imgs, g -> ImagesRepresentative( embG, g ) );

        rhs := GroupHomomorphismByImages(
            H, S,
            gens, List( [ 1 .. Length( gens ) ], i -> embsH[i] * embsG[i] )
        );
        return rec( lhs := embH, rhs := rhs, sdp := S );
    end
);

InstallMethod(
    GroupDerivationInfo,
    [ IsGroupDerivationByFunction ],
    function( derv )
        local H, G, act, S, embH, embG, rhs;

        H := Source( derv );
        G := Range( derv );
        act := derv!.act;
        S := SemidirectProduct( H, act, G );

        embH := Embedding( S, 1 );
        embG := Embedding( S, 2 );

        rhs := GroupHomomorphismByFunction(
            H, S,
            h -> ImagesRepresentative( embH, h ) *
                ImagesRepresentative( embG, derv!.fnc( h ) )
        );
        return rec( lhs := embH, rhs := rhs, sdp := S );
    end
);

InstallMethod(
    ImagesRepresentative,
    [ IsGroupDerivationByFunction, IsMultiplicativeElementWithInverse ],
    { derv, h } -> derv!.fnc( h )
);

InstallMethod(
    ImagesRepresentative,
    [ IsGroupDerivation, IsMultiplicativeElementWithInverse ],
    function( derv, h )
        local info, img;
        info := GroupDerivationInfo( derv );
        img := ImagesRepresentative( info!.lhs, h ) ^ -1 *
            ImagesRepresentative( info!.rhs, h );
        return PreImagesRepresentative( Embedding( info!.sdp, 2 ), img );
    end
);

InstallMethod(
    ImagesElm,
    [ IsGroupDerivation, IsMultiplicativeElementWithInverse ],
    { derv, h } -> [ ImagesRepresentative( derv, h ) ]
);

InstallMethod(
    PreImagesRepresentative,
    [ IsGroupDerivation, IsMultiplicativeElementWithInverse ],
    function( derv, g )
        local info, S, embG, s, tcr;
        info := GroupDerivationInfo( derv );
        S := info!.sdp;
        embG := Embedding( S, 2 );
        s := ImagesRepresentative( embG, g );
        tcr := RepresentativeTwistedConjugation( info!.lhs, info!.rhs, s );
        if tcr = fail then return fail; fi;
        return tcr ^ -1;
    end
);

InstallMethod(
    PreImagesElm,
    [ IsGroupDerivation, IsMultiplicativeElementWithInverse ],
    function( derv, g )
        local prei;
        prei := PreImagesRepresentative( derv, g );
        if prei = fail then return []; fi;
        return RightCoset( KernelOfGroupDerivation( derv ), prei );
    end
);

InstallMethod(
    ImagesSource,
    [ IsGroupDerivation ],
    derv -> GroupDerivationImage( derv )
);

InstallMethod(
    ImagesSet,
    [ IsGroupDerivation, IsGroup ],
    { derv, K } -> GroupDerivationImage( derv, K )
);

InstallGlobalFunction(
    GroupDerivationImage,
    function( derv, arg... )
        local G, info, S, lhs, rhs, emb, K, tcc, img;
        G := Range( derv );
        info := GroupDerivationInfo( derv );
        S := info!.sdp;
        lhs := info!.lhs;
        rhs := info!.rhs;
        emb := Embedding( S, 2 );
        if Length( arg ) > 0 then
            K := arg[1];
            lhs := RestrictedHomomorphism( lhs, K, S );
            rhs := RestrictedHomomorphism( rhs, K, S );
        fi;
        tcc := ReidemeisterClass( lhs, rhs, One( S ) );
        img := rec(
            tcc := tcc,
            emb := emb
        );
        ObjectifyWithAttributes(
            img, NewType(
                FamilyObj( G ),
                IsGroupDerivationImageRep
            ),
            Representative, One( G )
        );
        return img;
    end
);

InstallMethod(
    ViewObj,
    [ IsGroupDerivationImageRep ],
    function( img )
        Print("Derivation image in ", Source( img!.emb ) );
    end
);

InstallMethod(
    PrintObj,
    [ IsGroupDerivationImageRep ],
    function( img )
        Print("Derivation image in ", Source( img!.emb ) );
    end
);

InstallMethod(
    \in,
    [ IsMultiplicativeElementWithInverse, IsGroupDerivationImageRep ],
    function( g, img )
        local s;
        s := ImagesRepresentative( img!.emb, g );
        return s in img!.tcc;
    end
);


###############################################################################
##
## Random( rs, tcc )
##
##  INPUT:
##      rs:         random generator
##      img:        group derivation image
##
##  OUTPUT:
##      g:          random element of tcc
##
InstallMethodWithRandomSource(
    Random,
    "for a random source and a group derivation image",
    [ IsRandomSource, IsGroupDerivationImageRep ],
    function( rs, img )
        local s;
        s := Random( rs, img!.tcc );
        return PreImagesRepresentative( img!.emb, s );
    end
);


###############################################################################
##
## Size( tcc )
##
##  INPUT:
##      tcc:        twisted conjugacy class
##
##  OUTPUT:
##      n:          number of elements in tcc (or infinity)
##
InstallMethod(
    Size,
    "for Reidemeister classes",
    [ IsGroupDerivationImageRep ],
    img -> Size( img!.tcc )
);


###############################################################################
##
## ListOp( tcc )
##
##  INPUT:
##      tcc:        twisted conjugacy class
##
##  OUTPUT:
##      L:          list containing the elements of tcc, or fail if tcc has
##                  infinitely many elements
##
InstallMethod(
    ListOp,
    "for Reidemeister classes",
    [ IsGroupDerivationImageRep ],
    function( img )
        local tcc;
        tcc := img!.tcc;
        if Size( tcc ) = infinity then return fail; fi;
        return List( tcc, s -> PreImagesRepresentative( img!.emb, s ) );
    end
);


InstallMethod(
    KernelOfGroupDerivation,
    [ IsGroupDerivation ],
    function( derv )
        local info;
        info := GroupDerivationInfo( derv );
        return CoincidenceGroup2( info!.lhs, info!.rhs );
    end
);

InstallMethod(
    Kernel,
    [ IsGroupDerivation ],
    KernelOfGroupDerivation
);

InstallMethod(
    IsInjective,
    "for Reidemeister classes",
    [ IsGroupDerivation ],
    derv -> IsTrivial( KernelOfGroupDerivation( derv ) )
);

InstallMethod(
    IsSurjective,
    "for Reidemeister classes",
    [ IsGroupDerivation ],
    function( derv )
        local info, S, emb, sub, lhs, rhs, R;
        info := GroupDerivationInfo( derv );
        S := info!.sdp;
        emb := Embedding( S, 2 );
        sub := ImagesSource( emb );
        lhs := info!.lhs;
        rhs := info!.rhs;
        R := RepresentativesReidemeisterClassesOp( lhs, rhs, sub );
        return R <> fail and Length( R ) = 1;
    end
);
