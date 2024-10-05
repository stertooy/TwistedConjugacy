###############################################################################
##
## ReidemeisterClassesByTrivialSubgroup@( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class, or fail if there are infinitely
##                  many
##
##  REMARKS:
##      Calculates the representatives by calculating the representatives of
##      hom1HN, hom2HN: H/N -> G, with N the intersection of Ker(hom1) and
##      Ker(hom2).
##
ReidemeisterClassesByTrivialSubgroup@ := function( hom1, hom2 )
    local G, H, N, id, q, hom1HN, hom2HN;
    G := Range( hom1 );
    H := Source( hom1 );
    N := IntersectionKernels@( hom1, hom2 );
    id := IdentityMapping( G );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    hom1HN := InducedHomomorphism( q, id, hom1 );
    hom2HN := InducedHomomorphism( q, id, hom2 );
    return RepresentativesReidemeisterClassesOp( hom1HN, hom2HN );
end;


###############################################################################
##
## ReidemeisterClassesByFiniteQuotient@( hom1, hom2, M )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      M:          normal subgroup of G
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class, or fail if there are infinitely
##                  many
##
##  REMARKS:
##      Calculates the representatives of (hom1,hom2) by first calculating the
##      representatives of (hom1HN,hom2HN), with hom1HN, hom2HN: H/N -> G/M,
##      where N is normal in H. Only works if Coin(inn*hom1HN,hom2HN) is finite
##      for any inner automorphism inn of GM.
##
ReidemeisterClassesByFiniteQuotient@ := function( hom1, hom2, M )
    local G, H, N, p, q, GM, hom1p, hom2p, RclGM, Rcl, hom1N, hom2N, pg,
          inn_pg, Coin, g, conj_g, inn_g_hom1N, RclM, igRclM, inn_g, tc, m1,
          isNew, qh, h, m2;
    G := Range( hom1 );
    H := Source( hom1 );
    N := IntersectionPreImage@( hom1, hom2, M );
    p := NaturalHomomorphismByNormalSubgroupNC( G, M );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    GM := ImagesSource( p );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    RclGM := RepresentativesReidemeisterClassesOp( hom1p, hom2p );
    if RclGM = fail then
        return fail;
    fi;
    Rcl := [];
    hom1N := RestrictedHomomorphism( hom1, N, M );
    hom2N := RestrictedHomomorphism( hom2, N, M );
    for pg in RclGM do
        inn_pg := InnerAutomorphismNC( GM, pg^-1 );
        Coin := CoincidenceGroup2( hom1p*inn_pg, hom2p );
        if not IsFinite( Coin ) then TryNextMethod(); fi;
        g := PreImagesRepresentativeNC( p, pg );
        conj_g := ConjugatorAutomorphismNC( M, g^-1 );
        inn_g_hom1N := hom1N*conj_g;
        RclM := RepresentativesReidemeisterClassesOp( inn_g_hom1N, hom2N );
        if RclM = fail then
            return fail;
        fi;
        igRclM := [];
        inn_g := InnerAutomorphismNC( G, g^-1 );
        tc := TwistedConjugation( hom1*inn_g, hom2 );
        for m1 in RclM do
            isNew := true;
            for qh in Coin do
                h := PreImagesRepresentativeNC( q, qh );
                m2 := tc( m1, h );
                if ForAny(
                    igRclM,
                    k -> IsTwistedConjugate( inn_g_hom1N, hom2N, k, m2 )
                ) then
                    isNew := false;
                    break;
                fi;
            od;
            if isNew then
                Add( igRclM, m1 );
            fi;
        od;
        Append( Rcl, List( igRclM, m -> m*g ) );
    od;
    return Rcl;
end;


###############################################################################
##
## ReidemeisterClassesByCentre@( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      M:          normal subgroup of G
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class, or fail if there are infinitely
##                  many
##
##  REMARKS:
##      Calculates the representatives of (hom1,hom2) by first calculating the
##      representatives of (hom1p,hom2p), with hom1p, hom2HN: H -> G/C, with
##      C the centre of G.
##
ReidemeisterClassesByCentre@ := function( hom1, hom2 )
    local G, H, C, p, q, hom1p, hom2p, RclGM, GM, Rcl, pg, inn_pg, Coin, g,
          inn_g, d, r, coker, rm, m;
    G := Range( hom1 );
    H := Source( hom1 );
    C := Center( G );
    p := NaturalHomomorphismByNormalSubgroupNC( G, C );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    RclGM := RepresentativesReidemeisterClassesOp( hom1p, hom2p );
    if RclGM = fail then
        return fail;
    fi;
    GM := ImagesSource( p );
    Rcl := [];
    for pg in RclGM do
        inn_pg := InnerAutomorphismNC( GM, pg^-1 );
        Coin := CoincidenceGroup2( hom1p*inn_pg, hom2p );
        g := PreImagesRepresentative( p, pg );
        inn_g := InnerAutomorphismNC( G, g^-1 );
        d := DifferenceGroupHomomorphisms@ ( hom1*inn_g, hom2, Coin, G );
        r := NaturalHomomorphismByNormalSubgroupNC( C, ImagesSource( d ) );
        coker := Range( r );
        if not IsFinite( coker ) then
            return fail;
        fi;
        for rm in coker do
            # TODO: replace by PreImagesRepresentative eventually
            m := PreImagesRepresentativeNC( r, rm );
            Add( Rcl, m*g );
        od;
    od;
    return Rcl;
end;


###############################################################################
##
## RepresentativesReidemeisterClassesOp( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class, or fail if there are infinitely
##                  many
##
InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for infinite pcp source and finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    5,
    function( hom1, hom2 )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsFinite( H ) and
            IsFinite( G ) and
            not IsTrivial( G )
        ) then TryNextMethod(); fi;
        return ReidemeisterClassesByTrivialSubgroup@( hom1, hom2 );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for infinite pcp source and infinite nilpotent pcp range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    2,
    function( hom1, hom2 )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsFinite( H ) and
            IsPcpGroup( G ) and
            IsNilpotentGroup( G ) and
            not IsFinite( G ) and
            not IsAbelian( G )
        ) then TryNextMethod(); fi;
        return ReidemeisterClassesByCentre@( hom1, hom2 );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    1,
    function( hom1, hom2 )
        local G, H, M;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsFinite( H ) and
            IsPcpGroup( G ) and
            IsNilpotentByFinite( G ) and
            not IsFinite( G ) and
            not IsNilpotentGroup( G )
        ) then TryNextMethod(); fi;
        M := FittingSubgroup( G );
        return ReidemeisterClassesByFiniteQuotient@( hom1, hom2, M );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for polycyclic range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    0,
    function( hom1, hom2 )
        local G, H, M;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsFinite( H ) and
            IsPcpGroup( G ) and
            not IsNilpotentByFinite( G )
        ) then TryNextMethod(); fi;
        M := DerivedSubgroup( G );
        return ReidemeisterClassesByFiniteQuotient@( hom1, hom2, M );
    end
);
