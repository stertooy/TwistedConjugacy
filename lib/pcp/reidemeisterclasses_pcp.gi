###############################################################################
##
## ReidemeisterClassesByTrivialSubgroup@( hom1, hom2, N )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          normal subgroup of G with hom1 = hom2 mod N
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class in N, or fail if there are
##                  infinitely many
##
##  REMARKS:
##      Calculates the representatives by calculating the representatives of
##      hom1HL, hom2HL: H/L -> G, with L the intersection of Ker(hom1) and
##      Ker(hom2).
##
ReidemeisterClassesByTrivialSubgroup@ := function( hom1, hom2, N )
    local G, H, L, id, q, hom1HL, hom2HL;
    G := Range( hom1 );
    H := Source( hom1 );
    L := IntersectionKernels@( hom1, hom2 );
    id := IdentityMapping( G );
    q := NaturalHomomorphismByNormalSubgroupNC( H, L );
    hom1HL := InducedHomomorphism( q, id, hom1 );
    hom2HL := InducedHomomorphism( q, id, hom2 );
    return RepresentativesReidemeisterClassesOp( hom1HL, hom2HL, N );
end;


###############################################################################
## 
## ReidemeisterClassesByFiniteQuotient@( hom1, hom2, N, K )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          normal subgroup of G with hom1 = hom2 mod N
##      M:          normal subgroup of G
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class in N, or fail if there are
##                  infinitely many
##
##  REMARKS:
##      Calculates the representatives of (hom1,hom2) by first calculating the
##      representatives of (hom1p,hom2p), with hom1p, hom2p: H/L -> G/K,
##      where L is normal in H. Only works if Coin(inn*hom1p,hom2p) is finite
##      for any inner automorphism inn of G/K.
##
ReidemeisterClassesByFiniteQuotient@ := function( hom1, hom2, N, K )
    local G, H, L, p, q, GK, pN, hom1p, hom2p, RclGK, Rcl, hom1K, hom2K, M, pn,
          inn_pn, Coin, n, conj_n, inn_n_hom1K, RclM, inRclM, inn_n, tc, m1,
          isNew, h, m2, inn_nm2_hom1K;
    G := Range( hom1 );
    H := Source( hom1 );
    L := IntersectionPreImage@( hom1, hom2, K );
    p := NaturalHomomorphismByNormalSubgroupNC( G, K );
    q := NaturalHomomorphismByNormalSubgroupNC( H, L );
    GK := ImagesSource( p );
    pN := ImagesSet( p, N );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    RclGK := RepresentativesReidemeisterClassesOp( hom1p, hom2p, pN );
    if RclGK = fail then
        return fail;
    fi;
    Rcl := [];
    hom1K := RestrictedHomomorphism( hom1, L, K );
    hom2K := RestrictedHomomorphism( hom2, L, K );
    M := NormalIntersection( N, K );
    for pn in RclGK do
        inn_pn := InnerAutomorphismNC( GK, pn^-1 );
        Coin := CoincidenceGroup2( hom1p*inn_pn, hom2p );
        if not IsFinite( Coin ) then TryNextMethod(); fi;
        n := PreImagesRepresentativeNC( p, pn );
        conj_n := ConjugatorAutomorphismNC( K, n^-1 );
        inn_n_hom1K := hom1K*conj_n;
        RclM := RepresentativesReidemeisterClassesOp( inn_n_hom1K, hom2K, M );
        if RclM = fail then
            return fail;
        fi;
        inRclM := [];
        inn_n := InnerAutomorphismNC( G, n^-1 );
        tc := TwistedConjugation( hom1*inn_n, hom2 );
        Coin := List( Coin, qh -> PreImagesRepresentativeNC( q, qh ) );
        for m1 in RclM do
            isNew := true;
            for h in Coin do
                m2 := tc( m1, h )^-1;
                inn_nm2_hom1K := inn_n_hom1K*InnerAutomorphismNC( K, m2 );
                if ForAny(
                    inRclM,
                    k -> RepresentativeTwistedConjugationOp(
                        inn_nm2_hom1K,
                        hom2K,
                        k*m2
                    ) <> fail
                ) then
                    isNew := false;
                    break;
                fi;
            od;
            if isNew then
                Add( inRclM, m1 );
            fi;
        od;
        Append( Rcl, List( inRclM, m -> m*n ) );
    od;
    return Rcl;
end;


###############################################################################
##
## ReidemeisterClassesByNormalSubgroup@( hom1, hom2, N, K )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          normal subgroup of G with hom1 = hom2 mod N
##      M:          normal subgroup of G
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class in N, or fail if there are
##                  infinitely many
##
##  REMARKS:
##      Calculates the representatives of (hom1,hom2) by first calculating the
##      representatives of (hom1p,hom2p), with hom1p, hom2p: H -> G/K.
##
ReidemeisterClassesByNormalSubgroup@ := function( hom1, hom2, N, K )
    local G, H, p, idH, pN, hom1p, hom2p, RclGK, Rcl, M, pn, n, inn_n, C_n,
          hom1_n, hom2_n, RclM, inn_pn, GK;
    G := Range( hom1 );
    H := Source( hom1 );
    p := NaturalHomomorphismByNormalSubgroupNC( G, K );
    idH := IdentityMapping( H );
    pN := ImagesSet( p, N );
    hom1p := InducedHomomorphism( idH, p, hom1 );
    hom2p := InducedHomomorphism( idH, p, hom2 );
    RclGK := RepresentativesReidemeisterClassesOp( hom1p, hom2p, pN );
    if RclGK = fail then
        return fail;
    fi;
    Rcl := [];
    M := NormalIntersection( N, K );
    GK := ImagesSource( p );
    for pn in RclGK do
        n := PreImagesRepresentativeNC( p, pn );
        inn_n := InnerAutomorphismNC( G, n^-1 );
        inn_pn := InnerAutomorphismNC( GK, pn^-1 );
        C_n := CoincidenceGroup2( hom1p*inn_pn, hom2p );
        hom1_n := RestrictedHomomorphism( hom1*inn_n, C_n, G );
        hom2_n := RestrictedHomomorphism( hom2, C_n, G );
        RclM := RepresentativesReidemeisterClassesOp( hom1_n, hom2_n, M );
        if RclM = fail then
            return fail;
        fi;
        Append( Rcl, List( RclM, m -> m*n ) );
    od;
    return Rcl;
end;


###############################################################################
##
## RepresentativesReidemeisterClassesOp( hom1, hom2, N )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          normal subgroup of G with hom1 = hom2 mod N
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class in N, or fail if there are
##                  infinitely many
##
InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for infinite pcp source and finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    5,
    function( hom1, hom2, N )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsFinite( H ) and
            IsFinite( G ) and
            not IsTrivial( G )
        ) then TryNextMethod(); fi;
        return ReidemeisterClassesByTrivialSubgroup@( hom1, hom2, N );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for infinite pcp source and infinite nilpotent pcp range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    2,
    function( hom1, hom2, N )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsFinite( H ) and
            IsPcpGroup( G ) and
            IsNilpotentGroup( G ) and
            not IsFinite( G )
        ) then TryNextMethod(); fi;
        return ReidemeisterClassesByNormalSubgroup@(
            hom1, hom2,
            N, Centre( G )
        );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for infinite pcp source and infinite nilpotent-by-finite pcp range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    1,
    function( hom1, hom2, N )
        local G, H, F;
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
        F := FittingSubgroup( G );
        return ReidemeisterClassesByFiniteQuotient@( hom1, hom2, N, F );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for infinite pcp source and infinite pcp range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    0,
    function( hom1, hom2, N )
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
        return ReidemeisterClassesByFiniteQuotient@( hom1, hom2, N, M );
    end
);
