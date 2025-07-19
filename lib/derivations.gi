###############################################################################
##
## CreateGroupDerivationInfo@( derv, bool )
##
##  INPUT:
##      derv:       group derivation
##      bool:       true if the function should check this is indeed a
##                  derivation
##
##  OUTPUT:
##      info:       record containing useful information
##
CreateGroupDerivationInfo@ := function( derv, check )
    local H, G, act, S, embH, embG, gens, imgs, embsH, embsG, rhs;

    H := Source( derv );
    G := Range( derv );
    act := derv!.act;
    S := SemidirectProduct( H, act, G );

    embH := Embedding( S, 1 );
    embG := Embedding( S, 2 );

    if IsBound( derv!.fun ) then
        rhs := GroupHomomorphismByFunction(
            H, S,
            h -> ImagesRepresentative( embH, h ) *
                ImagesRepresentative( embG, derv!.fun( h ) )
        );
    else
        gens := MappingGeneratorsImages( derv )[1];

        embsH := List( gens, h -> ImagesRepresentative( embH, h ) );
        embsG := List(
            MappingGeneratorsImages( derv )[2],
            g -> ImagesRepresentative( embG, g )
        );

        imgs := List( [ 1 .. Length( gens ) ], i -> embsH[i] * embsG[i] );

        if check then
            rhs := GroupHomomorphismByImages( H, S, gens, imgs );
        else
            rhs := GroupHomomorphismByImagesNC( H, S, gens, imgs );
        fi;
    fi;
    return rec( lhs := embH, rhs := rhs, sdp := S );
end;

###############################################################################
##
## GroupDerivationByImagesNC( H, G, arg... )
##
##  INPUT:
##      H:          group
##      G:          group
##      arg:        info on the underlying map H -> G
##
##  OUTPUT:
##      derv:       group derivation
##
InstallGlobalFunction(
    GroupDerivationByImagesNC,
    function( H, G, arg... )
        local derv, filt, type, imgs, gens;
        derv := rec(
            act := Remove( arg ),
        );
        filt := IsGroupDerivationByImages and HasSource and HasRange and
            HasMappingGeneratorsImages;
        type := NewType( GeneralMappingsFamily(
            ElementsFamily( FamilyObj( H ) ),
            ElementsFamily( FamilyObj( G ) )
        ), filt );
        if not IsEmpty( arg ) then
            imgs := Remove( arg );
        else
            imgs := GeneratorsOfGroup( G );
        fi;
        if not IsEmpty( arg ) then
            gens := Remove( arg );
        else
            gens := GeneratorsOfGroup( H );
        fi;
        ObjectifyWithAttributes(
            derv, type,
            Source, H,
            Range, G,
            MappingGeneratorsImages, [ gens, imgs ]
        );
        return derv;
    end
);

###############################################################################
##
## GroupDerivationByImages( arg... )
##
##  INPUT:
##      arg:        info on the group derivation
##
##  OUTPUT:
##      derv:       group derivation
##
InstallGlobalFunction(
    GroupDerivationByImages,
    function( arg... )
        local derv, info;
        derv := CallFuncList( GroupDerivationByImagesNC, arg );
        info := CreateGroupDerivationInfo@( derv, true );
        if info!.rhs = fail then
            return fail;
        fi;
        SetGroupDerivationInfo( derv, info );
        return derv;
    end
);

###############################################################################
##
## GroupDerivationByFunction( H, G, fun, act )
##
##  INPUT:
##      H:          group
##      G:          group
##      fun:        function H -> G
##      act:        group homomorphism H -> Aut(G)
##
##  OUTPUT:
##      derv:       group derivation
##
InstallGlobalFunction(
    GroupDerivationByFunction,
    function( H, G, fun, act )
        local derv, filt, type;
        derv := rec(
            act := act,
            fun := fun
        );
        filt := IsGroupDerivationByFunction and HasSource and HasRange;
        type := NewType( GeneralMappingsFamily(
            ElementsFamily( FamilyObj( H ) ),
            ElementsFamily( FamilyObj( G ) )
        ), filt );
        ObjectifyWithAttributes(
            derv, type,
            Source, H,
            Range, G
        );
        return derv;
    end
);

###############################################################################
##
## GroupDerivationInfo( derv )
##
##  INPUT:
##      derv:       group derivation
##
##  OUTPUT:
##      info:       record containing useful information
##
InstallMethod(
    GroupDerivationInfo,
    [ IsGroupDerivation ],
    derv -> CreateGroupDerivationInfo@( derv, false )
);

###############################################################################
##
## ViewObj( derv )
##
##  INPUT:
##      derv:       group derivation
##
InstallMethod(
    ViewObj,
    "for group derivations by images",
    [ IsGroupDerivationByImages ],
    function( derv )
        local gens, imgs;
        gens := MappingGeneratorsImages( derv )[1];
        imgs := MappingGeneratorsImages( derv )[2];
        Print( "Group derivation ", gens, " -> ", imgs );
    end
);

InstallMethod(
    ViewObj,
    "for group derivations by a function",
    [ IsGroupDerivationByFunction ],
    function( derv )
        local fun;
        fun := derv!.fun;
        Print( "Group derivation via ", ViewString( derv!.fun ) );
    end
);

###############################################################################
##
## PrintObj( derv )
##
##  INPUT:
##      derv:       group derivation
##
InstallMethod(
    PrintObj,
    "for group derivations",
    [ IsGroupDerivation ],
    function( derv )
        Print(
            "<group derivation: ",
            Source( derv ), " -> ",
            Range( derv ), " >"
        );
    end
);

###############################################################################
##
## KernelOfGroupDerivation( derv )
##
##  INPUT:
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      K:          kernel of derv
##
InstallMethod(
    KernelOfGroupDerivation,
    [ IsGroupDerivation ],
    function( derv )
        local info;
        info := GroupDerivationInfo( derv );
        return CoincidenceGroup2( info!.lhs, info!.rhs );
    end
);

###############################################################################
##
## Kernel( derv )
##
##  INPUT:
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      K:          kernel of derv
##
InstallMethod(
    Kernel,
    "for group derivations",
    [ IsGroupDerivation ],
    KernelOfGroupDerivation
);

###############################################################################
##
## ImagesRepresentative( derv, h )
##
##  INPUT:
##      derv:       group derivation H -> G
##      h:          element of H
##
##  OUTPUT:
##      g:          image of h under derv
##
InstallMethod(
    ImagesRepresentative,
    "for group derivations with an underlying function",
    [ IsGroupDerivationByFunction, IsMultiplicativeElementWithInverse ],
    { derv, h } -> derv!.fun( h )
);

InstallMethod(
    ImagesRepresentative,
    "for group derivations",
    [ IsGroupDerivation, IsMultiplicativeElementWithInverse ],
    function( derv, h )
        local info, emb, img;
        info := GroupDerivationInfo( derv );
        emb := Embedding( info!.sdp, 2 );
        img := ImagesRepresentative( info!.lhs, h ) ^ -1 *
            ImagesRepresentative( info!.rhs, h );
        return PreImagesRepresentative( emb, img );
    end
);

###############################################################################
##
## ImagesElm( derv, h )
##
##  INPUT:
##      derv:       group derivation H -> G
##      h:          element of H
##
##  OUTPUT:
##      L:          List of images of h under derv
##
InstallMethod(
    ImagesElm,
    "for group derivations",
    [ IsGroupDerivation, IsMultiplicativeElementWithInverse ],
    { derv, h } -> [ ImagesRepresentative( derv, h ) ]
);

###############################################################################
##
## PreImagesRepresentative( derv, g )
##
##  INPUT:
##      derv:       group derivation H -> G
##      g:          element of G
##
##  OUTPUT:
##      h:          preimage of g under derv, or fail if no preimage exists
##
InstallMethod(
    PreImagesRepresentative,
    "for group derivations",
    [ IsGroupDerivation, IsMultiplicativeElementWithInverse ],
    function( derv, g )
        local info, S, embG, s, tcr;
        info := GroupDerivationInfo( derv );
        S := info!.sdp;
        embG := Embedding( S, 2 );
        s := ImagesRepresentative( embG, g );
        tcr := RepresentativeTwistedConjugation( info!.lhs, info!.rhs, s );
        if tcr = fail then
            return fail;
        fi;
        return tcr ^ -1;
    end
);

###############################################################################
##
## PreImagesElm( derv, g )
##
##  INPUT:
##      derv:       group derivation H -> G
##      g:          element of G
##
##  OUTPUT:
##      S:          set of preimages of g under derv
##
InstallMethod(
    PreImagesElm,
    "for group derivations",
    [ IsGroupDerivation, IsMultiplicativeElementWithInverse ],
    function( derv, g )
        local prei;
        prei := PreImagesRepresentative( derv, g );
        if prei = fail then
            return [];
        fi;
        return RightCoset( KernelOfGroupDerivation( derv ), prei );
    end
);

###############################################################################
##
## ImagesSet( derv, K )
##
##  INPUT:
##      derv:       group derivation H -> G
##      K:          subgroup of H
##
##  OUTPUT:
##      I:          image of K under derv
##
InstallMethod(
    ImagesSet,
    "for group derivations",
    [ IsGroupDerivation, IsGroup ],
    function( derv, K )
        local G, info, S, lhs, rhs, emb, tcc, img, fnc;
        G := Range( derv );
        info := GroupDerivationInfo( derv );
        S := info!.sdp;
        lhs := info!.lhs;
        rhs := info!.rhs;
        emb := Embedding( S, 2 );
        if K <> Source( derv ) then
            lhs := RestrictedHomomorphism( lhs, K, S );
            rhs := RestrictedHomomorphism( rhs, K, S );
        fi;
        tcc := ReidemeisterClass( lhs, rhs, One( S ) );
        img := rec(
            tcc := tcc,
            emb := emb
        );
        fnc := function( g, k )
            local tc, inv, s, t;
            tc := TwistedConjugation( lhs, rhs );
            inv := RestrictedInverseGeneralMapping( emb );
            s := ImagesRepresentative( emb, g );
            t := tc( s, k );
            return ImagesRepresentative( inv, t );
        end;
        ObjectifyWithAttributes(
            img, NewType(
                FamilyObj( G ),
                IsGroupDerivationImageRep and
                HasRepresentative and
                HasActingDomain and
                HasFunctionAction
            ),
            Representative, One( G ),
            ActingDomain, K,
            FunctionAction, fnc
        );
        return img;
    end
);

###############################################################################
##
## ViewObj( img )
##
##  INPUT:
##      img:        image of a group derivation H -> G
##
InstallMethod(
    ViewObj,
    "for group derivation images",
    [ IsGroupDerivationImageRep ],
    function( img )
        local G;
        G := Source( img!.emb );
        Print( "Group derivation image in ", G );
    end
);

###############################################################################
##
## PrintObj( img )
##
##  INPUT:
##      img:        image of a group derivation H -> G
##
InstallMethod(
    PrintObj,
    "for group derivation images",
    [ IsGroupDerivationImageRep ],
    function( img )
        local G, K;
        G := Source( img!.emb );
        K := ActingDomain( img!.tcc );
        Print( "<group derivation image: ", K, " -> ", G, " >" );
    end
);

###############################################################################
##
## \in( img, g )
##
##  INPUT:
##      img:        image of a group derivation H -> G
##      g:          element of G
##
##  OUTPUT:
##      bool:       true if g lies in img, otherwise false
##
InstallMethod(
    \in,
    "for group derivation images",
    [ IsMultiplicativeElementWithInverse, IsGroupDerivationImageRep ],
    function( g, img )
        local s;
        s := ImagesRepresentative( img!.emb, g );
        return s in img!.tcc;
    end
);

###############################################################################
##
## Size( img )
##
##  INPUT:
##      img:        image of a group derivation H -> G
##
##  OUTPUT:
##      n:          number of elements in img (or infinity)
##
InstallMethod(
    Size,
    "for group derivation images",
    [ IsGroupDerivationImageRep ],
    img -> Size( img!.tcc )
);

###############################################################################
##
## StabilizerOfExternalSet( img )
##
##  INPUT:
##      img:        image of a group derivation H -> G
##
##  OUTPUT:
##      stab:       stabiliser of the representative of img
##
InstallMethod(
    StabilizerOfExternalSet,
    "for group derivation images",
    [ IsGroupDerivationImageRep ],
    img -> StabilizerOfExternalSet( img!.tcc )
);

###############################################################################
##
## IsInjective( derv )
##
##  INPUT:
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      bool:       true if derv is injective, otherwise false
##
InstallMethod(
    IsInjective,
    "for group derivations",
    [ IsGroupDerivation ],
    derv -> IsTrivial( KernelOfGroupDerivation( derv ) )
);

###############################################################################
##
## IsSurjective( derv )
##
##  INPUT:
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      bool:       true if derv is surjective, otherwise false
##
InstallMethod(
    IsSurjective,
    "for group derivations",
    [ IsGroupDerivation ],
    function( derv )
        local info, S, emb, sub, lhs, rhs, R;
        info := GroupDerivationInfo( derv );
        S := info!.sdp;
        emb := Embedding( S, 2 );
        sub := ImagesSource( emb );
        lhs := info!.lhs;
        rhs := info!.rhs;
        R := RepresentativesReidemeisterClassesOp( lhs, rhs, sub, true );
        return R <> fail;
    end
);
