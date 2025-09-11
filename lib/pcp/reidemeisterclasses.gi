###############################################################################
##
## RepresentativesReidemeisterClassesOp( hom1, hom2, N, one )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          normal subgroup of G with hom1 = hom2 mod N
##      one:        boolean to toggle returning fail as soon as there is more
##                  than one Reidemeister class
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class in N, or fail if there are
##                  infinitely many
##
InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ],
    7,
    function( hom1, hom2, N, one )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsTrivial( G ) and
            not IsFinite( H ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        return TWC_ReidemeisterClassesByTrivialSubgroup(
            G, H, hom1, hom2, N, one
        );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for nilpotent range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ],
    4,
    function( hom1, hom2, N, one )
        local G, H, C;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            not IsFinite( H ) and
            not IsFinite( G ) and
            IsNilpotentGroup( G )
        ) then TryNextMethod(); fi;
        C := Center( G );
        return TWC_ReidemeisterClassesByNormalSubgroup(
            G, H, hom1, hom2, N, C, one
        );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ],
    3,
    function( hom1, hom2, N, one )
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
        return TWC_ReidemeisterClassesByFiniteQuotient(
            G, H, hom1, hom2, N, F, one
        );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for abelian subgroup commuting with the derived subgroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ],
    2,
    function( hom1, hom2, N, one )
        local G, H, D;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            not IsFinite( H ) and
            not IsNilpotentByFinite( G ) and
            IsAbelian( N )
        ) then TryNextMethod(); fi;
        D := DerivedSubgroup( G );
        if ForAny( GeneratorsOfGroup( N ), n ->
            ForAny( GeneratorsOfGroup( D ), d -> d * n <> n * d )
        ) then TryNextMethod(); fi;
        return TWC_RepsReidClassesStep1( G, H, hom1, hom2, N, one );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for nilpotent-by-abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ],
    1,
    function( hom1, hom2, N, one )
        local G, H, K;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            not IsFinite( H ) and
            not IsNilpotentByFinite( G ) and
            IsNilpotentByAbelian( G )
        ) then TryNextMethod(); fi;
        K := Center( DerivedSubgroup( G ) );
        return TWC_ReidemeisterClassesByNormalSubgroup(
            G, H, hom1, hom2, N, K, one
        );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for polycyclic range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ],
    0,
    function( hom1, hom2, N, one )
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
        return TWC_ReidemeisterClassesByFiniteQuotient(
            G, H, hom1, hom2, N, K, one
        );
    end
);
