###############################################################################
##
## RepTwistConjToIdByTrivialSubgroup@( hom1, hom2 )
##
RepTwistConjToIdByTrivialSubgroup@ := function ( hom1, hom2, g )
    local G, H, N, id, q, hom1HN, hom2HN, qh;
    G := Range( hom1 );
    H := Source( hom1 );
    N := IntersectionKernels@( hom1, hom2 );
    id := IdentityMapping( G );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    hom1HN := InducedHomomorphism( q, id, hom1 );
    hom2HN := InducedHomomorphism( q, id, hom2 );
    qh := RepTwistConjToId( hom1HN, hom2HN, g );
    if qh = fail then
        return fail;
    fi;
    return PreImagesRepresentative( q, qh );
end;


###############################################################################
##
## RepTwistConjToIdByFiniteQuotient@( hom1, hom2, g, N, M )
##
RepTwistConjToIdByFiniteQuotient@ := function ( hom1, hom2, g, N, M )
    local G, H, p, q, hom1HN, hom2HN, pg, qh1, Coin, h1, tc, m1, hom1N, hom2N,
        qh2, h2, m2, n;
    G := Range( hom1 );
    H := Source( hom1 );
    p := NaturalHomomorphismByNormalSubgroupNC( G, M );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    hom1HN := InducedHomomorphism( q, p, hom1 );
    hom2HN := InducedHomomorphism( q, p, hom2 );
    pg := ImagesRepresentative( p, g );
    qh1 := RepTwistConjToId( hom1HN, hom2HN, pg );
    if qh1 = fail then
        return fail;
    fi;
    Coin := CoincidenceGroup2( hom1HN, hom2HN );
    if not IsFinite( Coin ) then TryNextMethod(); fi;
    h1 := PreImagesRepresentative( q, qh1 );
    tc := TwistedConjugation( hom1, hom2 );
    m1 := tc( g, h1 );
    hom1N := RestrictedHomomorphism( hom1, N, M );
    hom2N := RestrictedHomomorphism( hom2, N, M );
    for qh2 in Coin do
        h2 := PreImagesRepresentative( q, qh2 );
        m2 := tc( m1, h2 );
        n := RepTwistConjToId( hom1N, hom2N, m2 );
        if n <> fail then
            return h1*h2*n;
        fi;
    od;
    return fail;
end;


###############################################################################
##
## RepTwistConjToIdByCentralSubgroup@( hom1, hom2, g, N, M)
##
RepTwistConjToIdByCentralSubgroup@ := function ( hom1, hom2, g, N, M )
    local G, H, p, q, hom1HN, hom2HN, pg, qh1, h1, tc, m1, CoinHN, Coin, delta,
        h2, m2, hom1N, hom2N, n;
    G := Range( hom1 );
    H := Source( hom1 );
    p := NaturalHomomorphismByNormalSubgroupNC( G, M );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    hom1HN := InducedHomomorphism( q, p, hom1 );
    hom2HN := InducedHomomorphism( q, p, hom2 );
    pg := ImagesRepresentative( p, g );
    qh1 := RepTwistConjToId( hom1HN, hom2HN, pg );
    if qh1 = fail then
        return fail;
    fi;
    h1 := PreImagesRepresentative( q, qh1 );
    tc := TwistedConjugation( hom1, hom2 );
    m1 := tc( g, h1 );
    CoinHN := CoincidenceGroup2( hom1HN, hom2HN );
    Coin := PreImagesSet( q, CoinHN );
    delta := DifferenceGroupHomomorphisms@ ( hom1, hom2, Coin, G );
    if not m1 in ImagesSource( delta ) then
        return fail;
    fi;
    h2 := PreImagesRepresentative( delta, m1 );
    m2 := tc( m1, h2 );
    hom1N := RestrictedHomomorphism( hom1, N, M );
    hom2N := RestrictedHomomorphism( hom2, N, M );
    n := RepTwistConjToId( hom1N, hom2N, m2 );
    return h1*h2*n;
end;


###############################################################################
##
## RepTwistConjToId( hom1, hom2, g )
##
InstallMethod(
    RepTwistConjToId,
    "for infinite polycyclic source and finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    6,
    function ( hom1, hom2, g )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsFinite( G ) and
            not IsTrivial( G )
        ) then TryNextMethod(); fi;
        return RepTwistConjToIdByTrivialSubgroup@( hom1, hom2, g );
    end
);

InstallMethod(
    RepTwistConjToId,
    "for infinite polycyclic source and infinite nilpotent range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    3,
    function ( hom1, hom2, g )
        local G, H, M, N;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            IsNilpotentGroup( G ) and
            not IsAbelian( G )
        ) then TryNextMethod(); fi;
        M := Centre( G );
        N := IntersectionPreImage@( hom1, hom2, M );
        return RepTwistConjToIdByCentralSubgroup@( hom1, hom2, g, N, M );
    end
);

InstallMethod(
    RepTwistConjToId,
    "for infinite polycyclic source and infinite nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    2,
    function ( hom1, hom2, g )
        local G, H, M, N;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            IsNilpotentByFinite( G ) and
            not IsNilpotentGroup( G )
        ) then TryNextMethod(); fi;
        M := FittingSubgroup( G );
        N := IntersectionPreImage@( hom1, hom2, M );
        return RepTwistConjToIdByFiniteQuotient@( hom1, hom2, g, N, M );
    end
);

InstallMethod(
    RepTwistConjToId,
    "for infinite polycyclic source and range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    1,
    function ( hom1, hom2, g )
        local G, H, M, N;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G )
        ) then TryNextMethod(); fi;
        M := DerivedSubgroup( G );
        N := IntersectionPreImage@( hom1, hom2, M );
        return RepTwistConjToIdByFiniteQuotient@( hom1, hom2, g, N, M );
    end
);

InstallMethod(
    RepTwistConjToId,
    "for isomorphisms with infinite polycyclic source and range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    0,
    function ( aut1, aut2, g )
        local G, H, aut, S, emb, s, pcp, hs;
        G := Range( aut1 );
        H := Source( aut1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            IsBijective( aut1 ) and
            IsBijective( aut2 )
        ) then TryNextMethod(); fi;
        aut := aut2 * Inverse( aut1 );
        S := SemidirectProductWithAutomorphism@( H, aut );
        emb := Embedding( S, 2 );
        s := ImagesRepresentative( emb, PreImagesRepresentative( aut1, g ) );
        pcp := PcpsOfEfaSeries( S );
        hs := ConjugacyElementsBySeries( S, S.1, S.1*s, pcp );
        if hs = false then
            return fail;
        fi;
        hs := S.1^( -ExponentsByPcp( Pcp( S ), hs )[1] ) * hs;
        return PreImagesRepresentative( emb, hs )^-1;
    end
);
