###############################################################################
##
## RepresentativeTwistedConjugationOp( hom1L, hom2L, g1L, g2L )
##
##  INPUT:
##      hom1L:      list of group homomorphisms H -> G_i
##      hom2L:      list of group homomorphisms H -> G_i
##      g1L:        list of elements of G_i
##      g2L:        list of elements of G_i (optional)
##
##  OUTPUT:
##      h:          element of H such that (h^hom2_i)^-1 * g_1_i * h^hom1_i =
##                  g_2_i, or fail if no such element exists
##
##  REMARKS:
##      If no g2L is given, it is assumed to be a list of 1's.
##
InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for two lists of homomorphisms and two lists of elements",
    [ IsList, IsList, IsList, IsList ],
    function( hom1L, hom2L, g1L, g2L )
        local n, ighom1L, gL, i, G, inn;
        n := Length( hom1L );
        ighom1L := ShallowCopy( hom1L );
        gL := ShallowCopy( g1L );
        for i in [ 1 .. n ] do
            G := Range( hom1L[i] );
            inn := InnerAutomorphismNC( G, g2L[i] );
            ighom1L[i] := hom1L[i] * inn;
            gL[i] := g2L[i] ^ -1 * g1L[i];
        od;
        return RepresentativeTwistedConjugationOp( ighom1L, hom2L, gL );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
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
        for i in [ 2 .. n ] do
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
            h := h * hi;
        od;
        return h;
    end
);
