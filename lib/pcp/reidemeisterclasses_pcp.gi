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
        inn_pn := InnerAutomorphismNC( GK, pn );
        Coin := CoincidenceGroup2( hom1p*inn_pn, hom2p );
        if not IsFinite( Coin ) then TryNextMethod(); fi;
        n := PreImagesRepresentativeNC( p, pn );
        conj_n := ConjugatorAutomorphismNC( K, n );
        inn_n_hom1K := hom1K*conj_n;
        RclM := RepresentativesReidemeisterClassesOp( inn_n_hom1K, hom2K, M );
        if RclM = fail then
            return fail;
        fi;
        inRclM := [];
        inn_n := InnerAutomorphismNC( G, n );
        tc := TwistedConjugation( hom1*inn_n, hom2 );
        Coin := List( Coin, qh -> PreImagesRepresentativeNC( q, qh ) );
        for m1 in RclM do
            isNew := true;
            for h in Coin do
                m2 := tc( m1, h );
                inn_nm2_hom1K := inn_n_hom1K*InnerAutomorphismNC( K, m2 );
                if ForAny(
                    inRclM,
                    k -> RepresentativeTwistedConjugationOp(
                        inn_nm2_hom1K,
                        hom2K,
                        m2^-1*k
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
        Append( Rcl, List( inRclM, m -> n*m ) );
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
        inn_n := InnerAutomorphismNC( G, n );
        inn_pn := InnerAutomorphismNC( GK, pn );
        C_n := CoincidenceGroup2( hom1p*inn_pn, hom2p );
        hom1_n := RestrictedHomomorphism( hom1*inn_n, C_n, G );
        hom2_n := RestrictedHomomorphism( hom2, C_n, G );
        RclM := RepresentativesReidemeisterClassesOp( hom1_n, hom2_n, M );
        if RclM = fail then
            return fail;
        fi;
        Append( Rcl, List( RclM, m -> n*m ) );
    od;
    return Rcl;
end;

RepsReidClassesABCDStep3@ := function( G, H, hom1, hom2, A )
    local q, Hab, igs, prei, imgs1, imgs2, n, auts, diff, S, iHab, iA,
          embsHab, embsA, l, r, N, Rcl;
    q := NaturalHomomorphismByNormalSubgroupNC( H, DerivedSubgroup( H ) );
    Hab := ImagesSource( q );
    igs := Igs( Hab );
    prei := List( igs, qh -> PreImagesRepresentativeNC( q, qh ) );
    imgs1 := List( prei, h -> ImagesRepresentative( hom1, h ) );
    auts := List(
        imgs1,
        h -> ConjugatorAutomorphismNC( A, h )
    );

    S := SemidirectProductPcpGroups@( A, Hab, auts );
    if not IsNilpotentByFinite( S ) then return fail; fi;
    
    imgs2 := List( prei, h -> ImagesRepresentative( hom2, h ) );
    n := Length( igs );
    diff := List( [1..n],
        i -> imgs1[i]^-1*imgs2[i]
    );
    
    
    iHab := Embedding( S, 1 );
    iA := Embedding( S, 2 );
    embsHab := List( igs, qh -> ImagesRepresentative( iHab, qh ) );
    embsA := List( diff, a -> ImagesRepresentative( iA, a ) );
    l := GroupHomomorphismByImages( Hab, S, igs, embsHab );
    r := GroupHomomorphismByImages( Hab, S, igs,
        List( [1..n],
            i -> embsHab[i]*embsA[i]
        )
    ); #TODO check order of multiplication?
    N := ImagesSource( iA );
    Rcl := RepresentativesReidemeisterClassesOp( l, r, N );
    if Rcl = fail then return fail; fi;
    return List( Rcl, a -> PreImagesRepresentativeNC( iA, a ) );
end;

RepsReidClassesABCDStep2@ := function( G, H, hom1, hom2, A )
    local HH, delta, dHH, p, q, hom1p, hom2p, pG, pA, Rcl;
    HH := DerivedSubgroup( H );
    delta := DifferenceGroupHomomorphisms@( hom1, hom2, HH, A );
    dHH := ImagesSource( delta );
    p := NaturalHomomorphismByNormalSubgroupNC( G, dHH );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    pG := ImagesSource( p );
    pA := ImagesSet( p, A );
    Rcl := RepsReidClassesABCDStep3@( pG, H, hom1p, hom2p, pA );
    if Rcl = fail then return fail; fi;
    return List( Rcl, pa -> PreImagesRepresentativeNC( p, pa ) );
end;

RepsReidClassesABCDStep1@ := function( G, H, hom1, hom2, A )
    local K, l, r;
    K := ClosureGroup( ImagesSource( hom1 ), A );
    l := RestrictedHomomorphism( hom1, H, K );
    r := RestrictedHomomorphism( hom2, H, K );
    return RepsReidClassesABCDStep2@( K, H, l, r, A );
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
    "for infinite source and finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    8,
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
    "for infinite source and nilpotent range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    5,
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
    "for infinite source and nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    4,
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
    "for abelian subgroup commuting with the derived subgroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    2,
    function( hom1, hom2, N )
        local G, H, C;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsFinite( H ) and
            IsPcpGroup( G ) and
            not IsNilpotentByFinite( G ) and
            IsAbelian( N ) and
            not IsCentral( G, N )
        ) then TryNextMethod(); fi;
        C := CommutatorSubgroup( N, DerivedSubgroup( G ) );
        if not IsTrivial( C ) then TryNextMethod(); fi;
        return RepsReidClassesABCDStep1@( G, H, hom1, hom2, N );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for infinite source and nilpotent-by-abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    1,
    function( hom1, hom2, N )
        local G, H, K;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsFinite( H ) and
            IsPcpGroup( G ) and
            IsNilpotentByAbelian( G ) and
            not IsNilpotentByFinite( G )
        ) then TryNextMethod(); fi;
        K := Center( DerivedSubgroup( G ) );
        return ReidemeisterClassesByNormalSubgroup@( hom1, hom2, N, K );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for infinite source and range",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    0,
    function( hom1, hom2, N )
        local G, H, K;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsFinite( H ) and
            IsPcpGroup( G ) and
            not IsNilpotentByAbelian( G ) and
            not IsNilpotentByFinite( G )
        ) then TryNextMethod(); fi;
        K := NilpotentByAbelianByFiniteSeries( G )[2];
        return ReidemeisterClassesByFiniteQuotient@( hom1, hom2, N, K );
    end
);
