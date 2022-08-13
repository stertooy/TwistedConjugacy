###############################################################################
##
## RepTwistConjToIdByTrivialSubgroup@( hom1, hom2, g )
##
RepTwistConjToIdByTrivialSubgroup@ := function( hom1, hom2, g )
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
## RepTwistConjToIdByFiniteQuotient@( hom1, hom2, g, M )
##
RepTwistConjToIdByFiniteQuotient@ := function( hom1, hom2, g, M )
    local G, H, N, p, q, hom1HN, hom2HN, pg, qh1, Coin, h1, tc, m1, hom1N,
        hom2N, qh2, h2, m2, n;
    G := Range( hom1 );
    H := Source( hom1 );
    N := IntersectionPreImage@( hom1, hom2, M );
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
## RepTwistConjToIdByCentre@( hom1, hom2, g )
##
RepTwistConjToIdByCentre@ := function( hom1, hom2, g )
    local G, H, C, p, q, hom1p, hom2p, pg, h1, tc, c, Coin, d, h2;
    G := Range( hom1 );
    H := Source( hom1 );
    C := Centre( G );
    p := NaturalHomomorphismByNormalSubgroupNC( G, C );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    pg := ImagesRepresentative( p, g );
    h1 := RepTwistConjToId( hom1p, hom2p, pg );
    if h1 = fail then
        return fail;
    fi;
    tc := TwistedConjugation( hom1, hom2 );
    c := tc( g, h1 );
    Coin := CoincidenceGroup2( hom1p, hom2p );
    d := DifferenceGroupHomomorphisms@ ( hom1, hom2, Coin, G );
    if not c in ImagesSource( d ) then
        return fail;
    fi;
    h2 := PreImagesRepresentative( d, c );
    return h1*h2;
end;


###############################################################################
##
## RepTwistConjToIdStep5@( hom1, hom2, a, A )
##
RepTwistConjToIdStep5@ := function( hom1, hom2, a, A ) 
    local H, G, hi, n, tc, ai, bi, g, p, q, pg;
    H := Source( hom1 );
    G := Range( hom1 );
    hi := SmallGeneratingSet( H );
    n := Length( hi );
    tc := TwistedConjugation( hom1, hom2 );
    ai := List( [1..n], i -> tc( One( G ), hi[i]^-1 ) );
    bi := List( [1..n], i -> Comm( ImagesRepresentative( hom2, hi[i] )^-1, a^-1 )*ai[i] );
    g := MultipleConjugacySolver@( G, bi, ai );
    if g = fail then
        return fail;
    fi;
    p := NaturalHomomorphismByNormalSubgroupNC( G, A );
    q := IdentityMapping( H );
    pg := ImagesRepresentative( p, g );
    return PreImagesRepresentative( InducedHomomorphism( q, p, hom2 ), pg );
end;


###############################################################################
##
## RepTwistConjToIdStep4@( hom1, hom2, a, A )
##
RepTwistConjToIdStep4@ := function( hom1, hom2, a, A ) 
    local G, H, C, p, q, hom1p, hom2p, pa, A2, h1, tc, c, Coin, delta, h2;
    G := Range( hom1 );
    H := Source( hom1 );
    if IsNilpotentByFinite( G ) then
        return RepTwistConjToId( hom1, hom2, a );
    fi;
    C := Center( G );
    if IsTrivial( C ) then
        return RepTwistConjToIdStep5@( hom1, hom2, a, A );
    fi;
    p := NaturalHomomorphismByNormalSubgroupNC( G, C );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    pa := ImagesRepresentative( p, a );
    A2 := ImagesSet( p, A );
    h1 := RepTwistConjToIdStep4@( hom1p, hom2p, pa, A2 );
    if h1 = fail then
        return fail;
    fi;
    tc := TwistedConjugation( hom1, hom2 );
    c := tc( a, h1 );
    Coin := CoincidenceGroup2( hom1p, hom2p );
    delta := DifferenceGroupHomomorphisms@( hom1, hom2, Coin, G );
    if not c in ImagesSource( delta ) then
        return fail;
    fi;
    h2 := PreImagesRepresentative( delta, c );
    return h1*h2;
end;


###############################################################################
##
## RepTwistConjToIdStep3@( hom1, hom2, a, A )
##
RepTwistConjToIdStep3@ := function( hom1, hom2, a, A )
    local H, G, HH, delta, dHH, p, q, hom1p,hom2p, A2, pa, h1, tc, c, h2;
    H := Source( hom1 );
    G := Range( hom1 );
    if IsNilpotentByFinite( G ) then
        return RepTwistConjToId( hom1, hom2, a );
    fi;
    HH := DerivedSubgroup( H );
    delta := DifferenceGroupHomomorphisms@( hom1, hom2, HH, G );
    dHH := ImagesSource( delta );
    p := NaturalHomomorphismByNormalSubgroupNC( G, dHH );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    A2 := ImagesSet( p, A );
    pa := ImagesRepresentative( p, a );
    h1 := RepTwistConjToIdStep4@( hom1p, hom2p, pa, A2 );
    if h1 = fail then
        return fail;
    fi;
    tc := TwistedConjugation( hom1, hom2 );
    c := tc( a, h1 );
    h2 := PreImagesRepresentative( delta, c );
    return h1*h2;
end;


###############################################################################
##
## RepTwistConjToIdStep2@( hom1, hom2, a, A )
##
RepTwistConjToIdStep2@ := function( hom1, hom2, a, A )
    local H, G, img1, img2, Gr, A2, hom1r, hom2r;
    H := Source( hom1 );
    G := Range( hom2 );
    img1 := ImagesSource( hom1 );
    img2 := ImagesSource( hom2 );
    Gr := ClosureGroup( img1, img2 ); 
    if not a in Gr then
        return fail;
    fi;
    A2 := NormalIntersection( A, Gr );
    hom1r := RestrictedHomomorphism( hom1, H, Gr );
    hom2r := RestrictedHomomorphism( hom2, H, Gr );
    return RepTwistConjToIdStep3@( hom1r, hom2r, a, A2 );
end;


###############################################################################
##
## RepTwistConjToIdStep1@( hom1, hom2, g )
##
RepTwistConjToIdStep1@ := function( hom1, hom2, g )
    local H, G, A, p, q, hom1p, hom2p, pg, h1, tc, a, Coin, hom1r, hom2r, h2;
    H := Source( hom1 );
    G := Range( hom2 );
    A := Center( DerivedSubgroup( G ) );
    # LCS := LowerCentralSeries( DerivedSubgroup( G ) );
    # C := LCS[Length(LCS)-1];
    p := NaturalHomomorphismByNormalSubgroupNC( G, A );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    pg := ImagesRepresentative( p, g );
    h1 := RepTwistConjToId( hom1p, hom2p, pg );
    if h1 = fail then
        return fail;
    fi;
    tc := TwistedConjugation( hom1, hom2 );
    a := tc( g, h1 );
    Coin := CoincidenceGroup( hom1p, hom2p );
    hom1r := RestrictedHomomorphism( hom1, Coin, G );
    hom2r := RestrictedHomomorphism( hom2, Coin, G );
    h2 := RepTwistConjToIdStep2@( hom1r, hom2r, a, A );
    if h2 = fail then
        return fail;
    fi;
    return h1*h2;
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
    function( hom1, hom2, g )
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
    function( hom1, hom2, g )
        local G, H, M;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            IsNilpotentGroup( G ) and
            not IsAbelian( G )
        ) then TryNextMethod(); fi;
        return RepTwistConjToIdByCentre@( hom1, hom2, g );
    end
);

InstallMethod(
    RepTwistConjToId,
    "for infinite polycyclic source and infinite nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    2,
    function( hom1, hom2, g )
        local G, H, M;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            IsNilpotentByFinite( G ) and
            not IsNilpotentGroup( G )
        ) then TryNextMethod(); fi;
        M := FittingSubgroup( G );
        return RepTwistConjToIdByFiniteQuotient@( hom1, hom2, g, M );
    end
);

InstallMethod(
    RepTwistConjToId,
    "for infinite polycyclic source and infinite nilpotent-by-abelian range",
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
            IsNilpotentByAbelian( G ) and
            not IsNilpotentByFinite( G )
        ) then TryNextMethod(); fi;
        return RepTwistConjToIdStep1@( hom1, hom2, g );
    end
);

InstallMethod(
    RepTwistConjToId,
    "for infinite polycyclic source and range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    0,
    function( hom1, hom2, g )
        local G, H, M;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            not IsNilpotentByAbelian( G )
        ) then TryNextMethod(); fi;
        M := NilpotentByAbelianNormalSubgroup( G );
        return RepTwistConjToIdByFiniteQuotient@( hom1, hom2, g, M );
    end
);
