###############################################################################
##
## RepresentativeTwistedConjugationOp( hom1, hom2, g1, g2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      g1:         element of G
##      g2:         element of G (optional)
##
##  OUTPUT:
##      h:          element of H such that (h^hom1)^-1 * g_1 * h^hom2 = g_2, or
##                  fail if no such element exists
##
##  REMARKS:
##      If no g2 is given, it is assumed to be 1.
##
InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    6,
    function( hom1, hom2, g )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsFinite( H ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        return TWC_RepTwistConjToIdByTrivialSubgroup( G, H, hom1, hom2, g );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for nilpotent range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    3,
    function( hom1, hom2, g )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            not IsFinite( H ) and
            not IsFinite( G ) and
            not IsAbelian( G ) and
            IsNilpotentGroup( G )
        ) then TryNextMethod(); fi;
        return TWC_RepTwistConjToIdByCentre( G, H, hom1, hom2, g );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    2,
    function( hom1, hom2, g )
        local G, H, F;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            not IsFinite( H ) and
            not IsFinite( G ) and
            not IsNilpotentGroup( G ) and
            IsNilpotentByFinite( G )
        ) then TryNextMethod(); fi;
        F := FittingSubgroup( G );
        return TWC_RepTwistConjToIdByFiniteQuotient( G, H, hom1, hom2, g, F );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for infinite source and nilpotent-by-abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    1,
    function( hom1, hom2, g )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            not IsFinite( H ) and
            not IsNilpotentByFinite( G ) and
            IsNilpotentByAbelian( G )
        ) then TryNextMethod(); fi;
        return TWC_RepTwistConjToIdStep1( G, H, hom1, hom2, g );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for infinite source and range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    0,
    function( hom1, hom2, g )
        local G, H, K;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            not IsFinite( H ) and
            not IsNilpotentByFinite( G ) and
            not IsNilpotentByAbelian( G )
        ) then TryNextMethod(); fi;
        K := NilpotentByAbelianByFiniteSeries( G )[2];
        return TWC_RepTwistConjToIdByFiniteQuotient( G, H, hom1, hom2, g, K );
    end
);
