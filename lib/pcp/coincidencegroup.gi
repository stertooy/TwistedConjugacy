###############################################################################
##
## CoincidenceGroup2( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which h^hom1 = h^hom2
##
InstallMethod(
    CoincidenceGroup2,
    "for finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    6,
    function( hom1, hom2 )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsTrivial( G ) and
            not IsFinite( H ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        return TWC_CoincidenceGroupByTrivialSubgroup( G, H, hom1, hom2 );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for nilpotent range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    3,
    function( hom1, hom2 )
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
        return TWC_CoincidenceGroupByCentre( G, H, hom1, hom2 );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    2,
    function( hom1, hom2 )
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
        return TWC_CoincidenceGroupByFiniteQuotient( G, H, hom1, hom2, F );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for infinite source and nilpotent-by-abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    1,
    function( hom1, hom2 )
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
        return TWC_CoincidenceGroupStep1( G, H, hom1, hom2 );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for infinite source and range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    0,
    function( hom1, hom2 )
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
        return TWC_CoincidenceGroupByFiniteQuotient( G, H, hom1, hom2, K );
    end
);
