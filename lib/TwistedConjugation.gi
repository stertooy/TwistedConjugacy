###############################################################################
##
## TwistedConjugation( hom1, arg... )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##
##  OUTPUT:
##      tc:         function (g,h) -> (h^hom2)^-1 * g * (h^hom1)
##
InstallGlobalFunction(
    TwistedConjugation,
    function( hom1, arg... )
        local hom2;
        if Length( arg ) = 0 then
            return function( g, h )
                return OnLeftInverse( g, h ) *
                    ImagesRepresentative( hom1, h );
            end;
        else
            hom2 := arg[1];
            return function( g, h )
                return OnLeftInverse( g, ImagesRepresentative( hom2, h ) ) *
                    ImagesRepresentative( hom1, h );
            end;
        fi;
    end
);


###############################################################################
##
## IsTwistedConjugate( hom1, hom2, g1, g2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##      g1:         element of G
##      g2:         element of G (optional)
##
##  OUTPUT:
##      bool:       true if there exists an element h of H such that
##                  (h^hom2)^-1 * g_1 * h^hom1 = g_2, or false otherwise.
##
##  REMARKS:
##      If no hom2 is given, it is assumed that hom1 is an endomorphism G -> G
##      and hom2 is assumed to be the identity mapping of G. If no g2 is given,
##      it is assumed to be 1.
##
InstallGlobalFunction(
    IsTwistedConjugate,
    function( arg... )
        return CallFuncList( RepresentativeTwistedConjugation, arg ) <> fail;
    end
);


###############################################################################
##
## RepresentativeTwistedConjugation( hom1, hom2, g1, g2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##      g1:         element of G
##      g2:         element of G (optional)
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * g_1 * h^hom1 = g_2, or
##                  fail if no such element exists
##
##  REMARKS:
##      If no hom2 is given, it is assumed that hom1 is an endomorphism G -> G
##      and hom2 is assumed to be the identity mapping of G. If no g2 is given,
##      it is assumed to be 1.
##
InstallGlobalFunction(
    RepresentativeTwistedConjugation,
    function( arg... )
        local G;
        if Length( arg ) < 4 then
            G := Range( arg[1] );
            if arg[2] in G then
                Add( arg, IdentityMapping( G ), 2 );
            fi;
        fi;
        return CallFuncList( RepresentativeTwistedConjugationOp, arg );
    end
);


###############################################################################
##
## RepTwistConjToIdByTrivialSubgroup@( hom1, hom2, g )
##
##  INPUT:
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
RepTwistConjToIdByTrivialSubgroup@ := function( hom1, hom2, g )
    local G, H, N, id, q, hom1HN, hom2HN, qh;
    G := Range( hom1 );
    H := Source( hom1 );
    N := IntersectionKernels@( hom1, hom2 );
    id := IdentityMapping( G );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    hom1HN := InducedHomomorphism( q, id, hom1 );
    hom2HN := InducedHomomorphism( q, id, hom2 );
    qh := RepresentativeTwistedConjugationOp( hom1HN, hom2HN, g );
    if qh = fail then
        return fail;
    fi;
    return PreImagesRepresentative( q, qh );
end;


###############################################################################
##
## RepTwistConjToIdByFiniteQuotient@( hom1, hom2, g, M )
##
##  INPUT:
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
    qh1 := RepresentativeTwistedConjugationOp( hom1HN, hom2HN, pg );
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
        n := RepresentativeTwistedConjugationOp( hom1N, hom2N, m2 );
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
##  INPUT:
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
    h1 := RepresentativeTwistedConjugationOp( hom1p, hom2p, pg );
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
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      a:          element of A
##      A:          abelian normal subgroup of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * a * h^hom1 = 1, or
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
RepTwistConjToIdStep5@ := function( hom1, hom2, a, A )
    local H, G, hi, n, tc, ai, bi, g, p, q, pg;
    H := Source( hom1 );
    G := Range( hom1 );
    hi := SmallGeneratingSet( H );
    n := Length( hi );
    tc := TwistedConjugation( hom1, hom2 );
    ai := List( [1..n], i -> tc( One( G ), hi[i]^-1 ) );
    bi := List(
        [1..n],
        i -> Comm( a, ImagesRepresentative( hom2, hi[i] )^-1 )*ai[i]
    );
    g := RepresentativeAction( G, bi, ai, OnTuples );
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
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      a:          element of A
##      A:          abelian normal subgroup of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * a * h^hom1 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Assumes that:
##        - [A,[G,G]] = 1;
##        - h^hom1 = h^hom2 mod A, for all h in H;
##        - G = A Im(hom1) = A Im(hom2);
##        - [H,H] is a subgroup of Coin(hom1,hom2).
##
RepTwistConjToIdStep4@ := function( hom1, hom2, a, A )
    local G, H, C, p, q, hom1p, hom2p, pa, A2, h1, tc, c, Coin, delta, h2;
    G := Range( hom1 );
    H := Source( hom1 );
    if IsNilpotentByFinite( G ) then
        return RepresentativeTwistedConjugationOp( hom1, hom2, a );
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
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      a:          element of A
##      A:          abelian normal subgroup of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * a * h^hom1 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Assumes that:
##        - [A,[G,G]] = 1;
##        - h^hom1 = h^hom2 mod A, for all h in H;
##        - G = A Im(hom1) = A Im(hom2).
##
RepTwistConjToIdStep3@ := function( hom1, hom2, a, A )
    local H, G, HH, delta, dHH, p, q, hom1p,hom2p, A2, pa, h1, tc, c, h2;
    H := Source( hom1 );
    G := Range( hom1 );
    if IsNilpotentByFinite( G ) then
        return RepresentativeTwistedConjugationOp( hom1, hom2, a );
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
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      a:          element of A
##      A:          abelian normal subgroup of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * a * h^hom1 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Assumes that:
##        - [A,[G,G]] = 1;
##        - h^hom1 = h^hom2 mod A, for all h in H.
##
RepTwistConjToIdStep2@ := function( hom1, hom2, a, A )
    local H, G, hom1r, hom2r;
    H := Source( hom1 );
    G := ClosureGroup( ImagesSource( hom1 ), A );
    hom1r := RestrictedHomomorphism( hom1, H, G );
    hom2r := RestrictedHomomorphism( hom2, H, G );
    return RepTwistConjToIdStep3@( hom1r, hom2r, a, A );
end;


###############################################################################
##
## RepTwistConjToIdStep1@( hom1, hom2, g )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      g:          element of G
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * g * h^hom1 = 1, or
##                  fail if no such element exists
##
##  REMARKS:
##      Assumes G is nilpotent-by-abelian, and uses induction on the upper
##      central series of [G,G].
##
RepTwistConjToIdStep1@ := function( hom1, hom2, g )
    local H, G, A, p, q, hom1p, hom2p, pg, h1, tc, a, Coin, hom1r, hom2r, h2;
    H := Source( hom1 );
    G := Range( hom2 );
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
## RepresentativeTwistedConjugationOp( hom1, hom2, g1, g2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      g1:         element of G
##      g2:         element of G (optional)
##
##  OUTPUT:
##      h:          element of H such that (h^hom2)^-1 * g_1 * h^hom1 = g_2, or
##                  fail if no such element exists
##
##  REMARKS:
##      If no g2 is given, it is assumed to be 1.
##
InstallMethod(
    RepresentativeTwistedConjugationOp,
    "for two homomorphisms and two elements",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ],
    function( hom1, hom2, g1, g2 )
        local G, g2inv, i_hom1, g;
        G := Range( hom1 );
        g2inv := g2^-1;
        i_hom1 := hom1*InnerAutomorphismNC( G, g2inv );
        g := g1*g2inv;
        return RepresentativeTwistedConjugationOp( i_hom1, hom2, g );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for trivial element",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    7,
    function( hom1, hom2, g )
        local H;
        H := Source( hom1 );
        if not IsOne( g ) then TryNextMethod(); fi;
        return One( H );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for infinite source and finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    6,
    function( hom1, hom2, g )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            not IsFinite( H ) and
            IsPolycyclicByFinite( H ) and
            IsFinite( G )
        ) then TryNextMethod(); fi;
        return RepTwistConjToIdByTrivialSubgroup@( hom1, hom2, g );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    5,
    function( hom1, hom2, g )
        local G, H, diff;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPolycyclicByFinite( H ) and
            IsPolycyclicByFinite( G ) and
            IsAbelian( G )
        ) then TryNextMethod(); fi;
        diff := DifferenceGroupHomomorphisms@( hom1, hom2, H, G );
        if not g in ImagesSource( diff ) then
            return fail;
        fi;
        return PreImagesRepresentative( diff, g );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for finite source",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    4,
    function( hom1, hom2, g )
        local G, H, tc, d, todo, conj, trail, h, i, k, gens, l;
        G := Range( hom1 );
        H := Source( hom1 );
        if not IsFinite( H ) then TryNextMethod(); fi;
        tc := TwistedConjugation( hom1, hom2 );
        g := Immutable( g );
        d := NewDictionary( g, true );
        AddDictionary( d, g, 0 );
        todo := [ g ];
        conj := [];
        trail := [];
        while not IsEmpty( todo ) do
            k := Remove( todo );
            if CanEasilyComputePcgs( H ) then
                gens := Pcgs( H );
            else
                gens := SmallGeneratingSet( H );
            fi;
            for h in gens do
                l := Immutable( tc( k, h ) );
                if IsOne( l ) then
                    while k <> g do
                        i := LookupDictionary( d, k );
                        k := trail[i];
                        h := conj[i]*h;
                    od;
                    return h;
                elif not KnowsDictionary( d, l ) then
                    Add( trail, k );
                    Add( todo, l );
                    Add( conj, h );
                    AddDictionary( d, l, Length( trail ) );
                fi;
            od;
        od;
        return fail;
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for nilpotent range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    3,
    function( hom1, hom2, g )
        local G, H, M;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPolycyclicByFinite( H ) and
            IsPolycyclicByFinite( G ) and
            IsNilpotentGroup( G ) and
            not IsAbelian( G )
        ) then TryNextMethod(); fi;
        return RepTwistConjToIdByCentre@( hom1, hom2, g );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    2,
    function( hom1, hom2, g )
        local G, H, M;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPolycyclicByFinite( H ) and
            IsPolycyclicByFinite( G ) and
            IsNilpotentByFinite( G ) and
            not IsNilpotentGroup( G )
        ) then TryNextMethod(); fi;
        M := FittingSubgroup( G );
        return RepTwistConjToIdByFiniteQuotient@( hom1, hom2, g, M );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for nilpotent-by-abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    1,
    function( hom1, hom2, g )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPolycyclicByFinite( H ) and
            IsPolycyclicByFinite( G ) and
            IsNilpotentByAbelian( G )
        ) then TryNextMethod(); fi;
        return RepTwistConjToIdStep1@( hom1, hom2, g );
    end
);

InstallOtherMethod(
    RepresentativeTwistedConjugationOp,
    "for polycyclic-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse ],
    0,
    function( hom1, hom2, g )
        local G, H, M;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPolycyclicByFinite( H ) and
            IsPolycyclicByFinite( G ) and
            not IsNilpotentByAbelian( G )
        ) then TryNextMethod(); fi;
        M := NilpotentByAbelianNormalSubgroup@( G );
        return RepTwistConjToIdByFiniteQuotient@( hom1, hom2, g, M );
    end
);
