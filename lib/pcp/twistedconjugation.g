###############################################################################
##
## MultipleConjugacySolver( G, r, s )
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
TWC.MultipleConjugacySolver := function( G, r, s )
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
## RepTwistConjToIdByTrivSub( G, H, hom1, hom2, g )
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
TWC.RepTwistConjToIdByTrivSub := function( G, H, hom1, hom2, g )
    local N, id, q, hom1HN, hom2HN, qh;
    N := TWC.IntersectionOfKernels( hom1, hom2 );
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
## RepTwistConjToIdByFinQuo( G, H, hom1, hom2, g, M )
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
TWC.RepTwistConjToIdByFinQuo := function( G, H, hom1, hom2, g, M )
    local N, p, q, hom1HN, hom2HN, pg, qh1, Coin, h1, tc, m1, hom1N, hom2N,
          qh2, h2, m2, n;
    N := TWC.IntersectionOfPreImages( hom1, hom2, M );
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
## RepTwistConjToIdByCentre( G, H, hom1, hom2, g, N )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      g:          element of G
##      N:          normal subgroup of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * g * h^hom1 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Used for factoring the calculation of h through H -> G -> G/C, with C
##      the centre of G.
##
TWC.RepTwistConjToIdByCentre := function( G, H, hom1, hom2, g, N )
    local C, p, q, hom1p, hom2p, pg, pG, pN, h1, tc, c, Coin, d, h2;
    C := Centre( G );
    p := NaturalHomomorphismByNormalSubgroupNC( G, C );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    pg := ImagesRepresentative( p, g );
    if IsBool( N ) then
        h1 := RepresentativeTwistedConjugationOp( hom1p, hom2p, pg );
    else
        pG := ImagesSource( p );
        pN := ImagesSet( p, N );
        h1 := TWC.RepTwistConjToIdStep4( pG, H, hom1p, hom2p, pg, pN );
    fi;
    if h1 = fail then
        return fail;
    fi;
    tc := TwistedConjugation( hom1, hom2 );
    c := tc( g, h1 );
    Coin := CoincidenceGroup2( hom1p, hom2p );
    d := TWC.DifferenceGroupHomomorphisms( hom1, hom2, Coin, G );
    if not c in ImagesSource( d ) then
        return fail;
    fi;
    # TODO: Replace by PreImagesRepresentative eventually
    h2 := PreImagesRepresentativeNC( d, c );
    return h1 * h2;
end;

###############################################################################
##
## RepTwistConjToIdStep5( G, H, hom1, hom2, a, A )
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
TWC.RepTwistConjToIdStep5 := function( G, H, hom1, hom2, a, A )
    local  hi, n, tc, ai, bi, g, p, q, pg, ind;
    hi := SmallGeneratingSet( H );
    n := Length( hi );
    tc := TwistedConjugation( hom1, hom2 );
    ai := List( [ 1 .. n ], i -> tc( One( G ), hi[i] ) );
    bi := List(
        [ 1 .. n ],
        i -> Comm( a, ImagesRepresentative( hom1, hi[i] ) ) * ai[i]
    );
    g := TWC.MultipleConjugacySolver( G, bi, ai );
    if g = fail then
        return fail;
    fi;
    p := NaturalHomomorphismByNormalSubgroupNC( G, A );
    q := IdentityMapping( H );
    pg := ImagesRepresentative( p, g );
    ind := InducedHomomorphism( q, p, hom1 );
    return PreImagesRepresentativeNC( ind, pg );
end;

###############################################################################
##
## RepTwistConjToIdStep4( G, H, hom1, hom2, a, A )
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
TWC.RepTwistConjToIdStep4 := function( G, H, hom1, hom2, a, A )
    if IsTrivial( Center( G ) ) then
        return TWC.RepTwistConjToIdStep5( G, H, hom1, hom2, a, A );
    fi;
    return TWC.RepTwistConjToIdByCentre( G, H, hom1, hom2, a, A );
end;

###############################################################################
##
## RepTwistConjToIdStep3( G, H, hom1, hom2, a, A )
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
TWC.RepTwistConjToIdStep3 := function( G, H, hom1, hom2, a, A )
    local HH, delta, dHH, p, q, hom1p, hom2p, pa, pA, pG, h1, tc, c, h2;
    if IsNilpotentByFinite( G ) then
        return RepresentativeTwistedConjugationOp( hom1, hom2, a );
    fi;
    HH := DerivedSubgroup( H );
    delta := TWC.DifferenceGroupHomomorphisms( hom1, hom2, HH, G );
    dHH := ImagesSource( delta );
    p := NaturalHomomorphismByNormalSubgroupNC( G, dHH );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    pa := ImagesRepresentative( p, a );
    pA := ImagesSet( p, A );
    pG := ImagesSource( p );
    if IsNilpotentByFinite( pG ) then
        h1 := RepresentativeTwistedConjugationOp( hom1p, hom2p, pa );
    else
        h1 := TWC.RepTwistConjToIdStep4( pG, H, hom1p, hom2p, pa, pA );
    fi;
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
## RepTwistConjToIdStep2( H, hom1, hom2, a, A )
##
##  INPUT:
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
TWC.RepTwistConjToIdStep2 := function( H, hom1, hom2, a, A )
    local K, hom1r, hom2r;
    K := ClosureGroup( ImagesSource( hom1 ), A );
    hom1r := RestrictedHomomorphism( hom1, H, K );
    hom2r := RestrictedHomomorphism( hom2, H, K );
    return TWC.RepTwistConjToIdStep3( K, H, hom1r, hom2r, a, A );
end;

###############################################################################
##
## RepTwistConjToIdStep1( G, H, hom1, hom2, g )
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
TWC.RepTwistConjToIdStep1 := function( G, H, hom1, hom2, g )
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
    h2 := TWC.RepTwistConjToIdStep2( Coin, hom1r, hom2r, a, A );
    if h2 = fail then
        return fail;
    fi;
    return h1 * h2;
end;
