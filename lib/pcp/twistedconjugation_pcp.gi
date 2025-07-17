###############################################################################
##
## MultipleConjugacySolver@( G, r, s )
##
##  INPUT:
##      G:          acting group
##      r:          list of elements of G
##      s:          list of elements of G
##
##  OUTPUT:
##      a:          element of G that simultaneously conjugates every element
##                  of r to the corresponding element of s, or fail if no such
##                  element exists
##
##  REMARKS:
##      Only for PcpGroups
##
MultipleConjugacySolver@ := function( G, r, s )
    local a, i, Gi, ai, pcp;
    a := One( G );
    for i in [ 1 .. Length( r ) ] do
        if i = 1 then
            Gi := G;
        else
            Gi := Centraliser( Gi, s[ i - 1 ] );
        fi;
        pcp := PcpsOfEfaSeries( Gi );
        ai := ConjugacyElementsBySeries( Gi, r[i] ^ a, s[i], pcp );
        if ai = false then
            return fail;
        fi;
        a := a * ai;
    od;
    return a;
end;

###############################################################################
##
## RepTwistConjToIdByTrivialSubgroup@( G, H, hom1, hom2, g )
##
##  INPUT:
##      G:          finite group
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      g:          element of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * g * h^hom1 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Used for factoring the calculation of h through
##      H -> H/N -> G, with N the intersection of Ker(hom1) and Ker(hom2).
##
RepTwistConjToIdByTrivialSubgroup@ := function( G, H, hom1, hom2, g )
    local N, id, q, hom1HN, hom2HN, qh;
    N := IntersectionOfKernels( hom1, hom2 );
    id := IdentityMapping( G );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    hom1HN := InducedHomomorphism( q, id, hom1 );
    hom2HN := InducedHomomorphism( q, id, hom2 );
    qh := RepresentativeTwistedConjugationOp( hom1HN, hom2HN, g );
    if qh = fail then
        return fail;
    fi;
    return PreImagesRepresentativeNC( q, qh );
end;

###############################################################################
##
## RepTwistConjToIdByFiniteQuotient@( G, H, hom1, hom2, g, M )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      g:          element of G
##      M:          normal subgroup of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * g * h^hom1 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Calculates h by first calculating translating the problem to hom1N,
##      hom2N: N -> M (with N normal in H) and hom1HN, hom2HN: H/N -> G/M. Only
##      works if Coin(hom1HN,hom2HN) is finite.
##
RepTwistConjToIdByFiniteQuotient@ := function( G, H, hom1, hom2, g, M )
    local N, p, q, hom1HN, hom2HN, pg, qh1, Coin, h1, tc, m1, hom1N,
          hom2N, qh2, h2, m2, n;
    N := IntersectionOfPreImages( hom1, hom2, M );
    p := NaturalHomomorphismByNormalSubgroupNC( G, M );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    hom1HN := InducedHomomorphism( q, p, hom1 );
    hom2HN := InducedHomomorphism( q, p, hom2 );
    pg := ImagesRepresentative( p, g );
    qh1 := RepresentativeTwistedConjugationOp( hom1HN, hom2HN, pg );
    if qh1 = fail then
        return fail;
    fi;
    Coin := CoincidenceGroup2( hom1HN, hom2HN );
    h1 := PreImagesRepresentativeNC( q, qh1 );
    tc := TwistedConjugation( hom1, hom2 );
    m1 := tc( g, h1 );
    hom1N := RestrictedHomomorphism( hom1, N, M );
    hom2N := RestrictedHomomorphism( hom2, N, M );
    for qh2 in Coin do
        h2 := PreImagesRepresentativeNC( q, qh2 );
        m2 := tc( m1, h2 );
        n := RepresentativeTwistedConjugationOp( hom1N, hom2N, m2 );
        if n <> fail then
            return h1 * h2 * n;
        fi;
    od;
    return fail;
end;

###############################################################################
##
## RepTwistConjToIdByCentre@( G, H, hom1, hom2, g )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      g:          element of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * g * h^hom1 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Used for factoring the calculation of h through H -> G -> G/C, with C
##      the centre of G.
##
RepTwistConjToIdByCentre@ := function( G, H, hom1, hom2, g )
    local C, p, q, hom1p, hom2p, pg, h1, tc, c, Coin, d, h2;
    C := Centre( G );
    p := NaturalHomomorphismByNormalSubgroupNC( G, C );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    pg := ImagesRepresentative( p, g );
    h1 := RepresentativeTwistedConjugationOp( hom1p, hom2p, pg );
    if h1 = fail then
        return fail;
    fi;
    tc := TwistedConjugation( hom1, hom2 );
    c := tc( g, h1 );
    Coin := CoincidenceGroup2( hom1p, hom2p );
    d := DifferenceGroupHomomorphisms( hom1, hom2, Coin, G );
    if not c in ImagesSource( d ) then
        return fail;
    fi;
    # TODO: Replace by PreImagesRepresentative eventually
    h2 := PreImagesRepresentativeNC( d, c );
    return h1 * h2;
end;

###############################################################################
##
## RepTwistConjToIdStep5@( G, H, hom1, hom2, a, A )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      a:          element of A
##      A:          abelian normal subgroup of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom1)^-1 * a * h^hom2 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Assumes that:
##        - [A,[G,G]] = 1;
##        - h^hom1 = h^hom2 mod A, for all h in H;
##        - G = A Im(hom1) = A Im(hom2);
##        - [H,H] is a subgroup of Coin(hom1,hom2);
##        - Z(G) = 1.
##
RepTwistConjToIdStep5@ := function( G, H, hom1, hom2, a, A )
    local  hi, n, tc, ai, bi, g, p, q, pg;
    hi := SmallGeneratingSet( H );
    n := Length( hi );
    tc := TwistedConjugation( hom1, hom2 );
    ai := List( [ 1 .. n ], i -> tc( One( G ), hi[i] ) );
    bi := List(
        [ 1 .. n ],
        i -> Comm( a, ImagesRepresentative( hom1, hi[i] ) ) * ai[i]
    );
    g := MultipleConjugacySolver@( G, bi, ai );
    if g = fail then
        return fail;
    fi;
    p := NaturalHomomorphismByNormalSubgroupNC( G, A );
    q := IdentityMapping( H );
    pg := ImagesRepresentative( p, g );
    return PreImagesRepresentativeNC( InducedHomomorphism( q, p, hom1 ), pg );
end;

###############################################################################
##
## RepTwistConjToIdStep4@( G, H, hom1, hom2, a, A )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      a:          element of A
##      A:          abelian normal subgroup of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom1)^-1 * a * h^hom2 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Assumes that:
##        - [A,[G,G]] = 1;
##        - h^hom1 = h^hom2 mod A, for all h in H;
##        - G = A Im(hom1) = A Im(hom2);
##        - [H,H] is a subgroup of Coin(hom1,hom2).
##
RepTwistConjToIdStep4@ := function( G, H, hom1, hom2, a, A )
    if IsNilpotentByFinite( G ) then
        return RepresentativeTwistedConjugationOp( hom1, hom2, a );
    elif IsTrivial( Center( G ) ) then
        return RepTwistConjToIdStep5@( G, H, hom1, hom2, a, A );
    fi;
    return RepTwistConjToIdByCentre@( G, H, hom1, hom2, a );
end;

###############################################################################
##
## RepTwistConjToIdStep3@( G, H, hom1, hom2, a, A )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      a:          element of A
##      A:          abelian normal subgroup of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom1)^-1 * a * h^hom2 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Assumes that:
##        - [A,[G,G]] = 1;
##        - h^hom1 = h^hom2 mod A, for all h in H;
##        - G = A Im(hom1) = A Im(hom2).
##
RepTwistConjToIdStep3@ := function( G, H, hom1, hom2, a, A )
    local HH, delta, dHH, p, q, hom1p, hom2p, pa, pA, pG, h1, tc, c, h2;
    if IsNilpotentByFinite( G ) then
        return RepresentativeTwistedConjugationOp( hom1, hom2, a );
    fi;
    HH := DerivedSubgroup( H );
    delta := DifferenceGroupHomomorphisms( hom1, hom2, HH, G );
    dHH := ImagesSource( delta );
    p := NaturalHomomorphismByNormalSubgroupNC( G, dHH );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    pa := ImagesRepresentative( p, a );
    pA := ImagesSet( p, A );
    pG := ImagesSource( p );
    h1 := RepTwistConjToIdStep4@( pG, H, hom1p, hom2p, pa, pA );
    if h1 = fail then
        return fail;
    fi;
    tc := TwistedConjugation( hom1, hom2 );
    c := tc( a, h1 );
    h2 := PreImagesRepresentativeNC( delta, c );
    return h1 * h2;
end;

###############################################################################
##
## RepTwistConjToIdStep2@( G, H, hom1, hom2, a, A )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      a:          element of A
##      A:          abelian normal subgroup of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom1)^-1 * a * h^hom2 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Assumes that:
##        - [A,[G,G]] = 1;
##        - h^hom1 = h^hom2 mod A, for all h in H.
##
RepTwistConjToIdStep2@ := function( G, H, hom1, hom2, a, A )
    local K, hom1r, hom2r;
    K := ClosureGroup( ImagesSource( hom1 ), A );
    hom1r := RestrictedHomomorphism( hom1, H, K );
    hom2r := RestrictedHomomorphism( hom2, H, K );
    return RepTwistConjToIdStep3@( K, H, hom1r, hom2r, a, A );
end;

###############################################################################
##
## RepTwistConjToIdStep1@( G, H, hom1, hom2, g )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      g:          element of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom1)^-1 * g * h^hom2 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Assumes G is nilpotent-by-abelian, and uses induction on the upper
##      central series of [G,G].
##
RepTwistConjToIdStep1@ := function( G, H, hom1, hom2, g )
    local A, p, q, hom1p, hom2p, pg, h1, tc, a, Coin, hom1r, hom2r, h2;
    A := Center( DerivedSubgroup( G ) );
    p := NaturalHomomorphismByNormalSubgroupNC( G, A );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    pg := ImagesRepresentative( p, g );
    h1 := RepresentativeTwistedConjugationOp( hom1p, hom2p, pg );
    if h1 = fail then
        return fail;
    fi;
    tc := TwistedConjugation( hom1, hom2 );
    a := tc( g, h1 );
    Coin := CoincidenceGroup2( hom1p, hom2p );
    hom1r := RestrictedHomomorphism( hom1, Coin, G );
    hom2r := RestrictedHomomorphism( hom2, Coin, G );
    h2 := RepTwistConjToIdStep2@( G, Coin, hom1r, hom2r, a, A );
    if h2 = fail then
        return fail;
    fi;
    return h1 * h2;
end;

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
        return RepTwistConjToIdByTrivialSubgroup@( G, H, hom1, hom2, g );
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
        return RepTwistConjToIdByCentre@( G, H, hom1, hom2, g );
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
        return RepTwistConjToIdByFiniteQuotient@( G, H, hom1, hom2, g, F );
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
        return RepTwistConjToIdStep1@( G, H, hom1, hom2, g );
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
        return RepTwistConjToIdByFiniteQuotient@( G, H, hom1, hom2, g, K );
    end
);
