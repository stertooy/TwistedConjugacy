###############################################################################
##
## IsTwistedConjugateMultiple( hom1L, hom2L, g1L, g2L )
##
##  INPUT:
##      hom1L:      group homomorphism H -> G
##      hom2L:      group homomorphism H -> G (optional)
##      g1L:        element of G
##      g2L:        element of G (optional)
##
##  OUTPUT:
##      boolL:      true if there exists an element h of H such that
##                  (h^hom2_i)^-1 * g_1_i * h^hom1_i = g_2_i, or false
##                  otherwise
##
##  REMARKS:
##      If no hom2L is given, it is assumed that hom1L consists of
##      endomorphisms G -> G and hom2L are assumed to be identity mappings of
##      G. If no g2L is given, it is assumed to be a list of 1's.
##
InstallGlobalFunction(
    IsTwistedConjugateMultiple,
    function( arg... )
        return CallFuncList(
            RepresentativeTwistedConjugationMultiple,
            arg
        ) <> fail;
    end
);


###############################################################################
##
## RepresentativeTwistedConjugationMultiple( hom1, hom2, g1, g2 )
##
##  INPUT:
##      hom1L:      group homomorphism H -> G
##      hom2L:      group homomorphism H -> G (optional)
##      g1L:        element of G
##      g2L:        element of G (optional)
##
##  OUTPUT:
##      h:          element of H such that (h^hom2_i)^-1 * g_1_i * h^hom1_i =
##                  g_2_i, or fail if no such element exists
##
##  REMARKS:
##      If no hom2L is given, it is assumed that hom1L consists of
##      endomorphisms G -> G and hom2L are assumed to be identity mappings of
##      G. If no g2L is given, it is assumed to be a list of 1's.
##
InstallGlobalFunction(
    RepresentativeTwistedConjugationMultiple,
    function( arg... )
        local G, n;
        if Length( arg ) < 4 then
            G := Range( arg[1][1] );
            if arg[2][1] in G then
                n := Length( arg[1] );
                Add(
                    arg,
                    ListWithIdenticalEntries( n, IdentityMapping( G ) ),
                    2
                );
            fi;
        fi;
        return CallFuncList( RepresentativeTwistedConjugationMultOp, arg );
    end
);


###############################################################################
##
## RepresentativeTwistedConjugationMultOp( hom1, hom2, g1, g2 )
##
##  INPUT:
##      hom1L:      group homomorphism H -> G
##      hom2L:      group homomorphism H -> G
##      g1L:        element of G
##      g2L:        element of G (optional)
##
##  OUTPUT:
##      h:          element of H such that (h^hom2_i)^-1 * g_1_i * h^hom1_i =
##                  g_2_i, or fail if no such element exists
##
##  REMARKS:
##      If no g2L is given, it is assumed to be a list of 1's.
##
InstallMethod(
    RepresentativeTwistedConjugationMultOp,
    "for two lists of homomorphisms and two lists of elements",
    [ IsList, IsList, IsList, IsList ],
    function( hom1L, hom2L, g1L, g2L )
        local n, ighom1L, gL, i, G, g2inv, inn;
        n := Length( hom1L );
        ighom1L := ShallowCopy( hom1L );
        gL := ShallowCopy( g1L );
        for i in [1..n] do
            G := Range( hom1L[i] );
            g2inv := g2L[i]^-1;
            inn := InnerAutomorphismNC( G, g2inv );
            ighom1L[i] := hom1L[i]*inn;
            gL[i] := g1L[i]*g2inv;
        od;
        return RepresentativeTwistedConjugationMultOp( ighom1L, hom2L, gL );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationMultOp,
    "for two lists of homomorphisms and one list of elements",
    [ IsList, IsList, IsList ],
    function( hom1L, hom2L, gL )
        local hom1, hom2, h, n, i, Coin, tc, g, G, hi;
        hom1 := hom1L[1];
        hom2 := hom2L[1];
        h := RepresentativeTwistedConjugationOp( hom1, hom2, gL[1] );
        if h = fail then
            return fail;
        fi;
        n := Length( hom1L );
        for i in [2..n] do
            Coin := CoincidenceGroup2( hom1, hom2 );
            hom1 := hom1L[i];
            hom2 := hom2L[i];
            tc := TwistedConjugation( hom1, hom2 );
            g := tc( gL[i], h );
            G := Range( hom1 );
            hom1 := RestrictedHomomorphism( hom1, Coin, G );
            hom2 := RestrictedHomomorphism( hom2, Coin, G );
            hi := RepresentativeTwistedConjugationOp( hom1, hom2, g );
            if hi = fail then
                return fail;
            fi;
            h := h*hi;
        od;
        return h;
    end
);
