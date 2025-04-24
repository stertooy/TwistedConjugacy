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
        img := ImagesRepresentative( info!.lhs, h ) ^ - 1 *
            ImagesRepresentative( info!.rhs, h );
        return PreImagesRepresentative( Embedding( info!.sdp, 2 ), img );
    end
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
        return tcr ^ -1;
    end
);
