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
        local H, G, act, S, embH, embG, gens, imgs, embsH, embsG, rhs, info;

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

        rhs := GroupHomomorphismByImagesNC(
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
        local H, G, act, S, embH, embG, fnc, rhs, info;

        H := Source( derv );
        G := Range( derv );
        act := derv!.act;
        S := SemidirectProduct( H, act, G );

        embH := Embedding( S, 1 );
        embG := Embedding( S, 2 );

        fnc := derv!.fnc;

        rhs := function( h )
            return ImagesRepresentative( embH, h ) *
                ImagesRepresentative( embG, ImagesRepresentative( fnc, h ) );
        end;
        return rec( lhs := embH, rhs := rhs, sdp := S );
    end
);
