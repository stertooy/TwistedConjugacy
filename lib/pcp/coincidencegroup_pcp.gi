###############################################################################
##
## CoincidenceGroupByTrivialSubgroup@( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which h^hom1 = h^hom2
##
##  REMARKS:
##      Used for factoring the calculation of Coin(hom1,hom2) through
##      H -> H/N -> G, with N the intersection of Ker(hom1) and Ker(hom2).
##
CoincidenceGroupByTrivialSubgroup@ := function( hom1, hom2 )
    local G, H, N, p, q, Coin;
    G := Range( hom1 );
    H := Source( hom1 );
    N := IntersectionKernels@( hom1, hom2 );
    p := IdentityMapping( G );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    Coin := CoincidenceGroup2(
        InducedHomomorphism( q, p, hom1 ),
        InducedHomomorphism( q, p, hom2 )
    );
    return PreImagesSetNC( q, Coin );
end;


###############################################################################
##
## CoincidenceGroupByFiniteQuotient@( hom1, hom2, M )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      M:          normal subgroup of G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which h^hom1 = h^hom2
##
##  REMARKS:
##      Calculates Coin(hom1,hom2) by first calculating Coin(hom1N,hom2N) and
##      Coin(hom1HN,hom2HN), where hom1N, hom2N: N -> M (with N normal in H)
##      and hom1HN, hom2HN: H/N -> G/M. Only works if Coin(hom1HN,hom2HN) is
##      finite.
##
CoincidenceGroupByFiniteQuotient@ := function( hom1, hom2, M )
    local G, H, N, p, q, CoinHN, hom1N, hom2N, tc, qh, gens, func, C;
    G := Range( hom1 );
    H := Source( hom1 );
    N := IntersectionPreImage@( hom1, hom2, M );
    p := NaturalHomomorphismByNormalSubgroupNC( G, M );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    CoinHN := CoincidenceGroup2(
        InducedHomomorphism( q, p, hom1 ),
        InducedHomomorphism( q, p, hom2 )
    );
    if not IsFinite( CoinHN ) then TryNextMethod(); fi;
    hom1N := RestrictedHomomorphism( hom1, N, M );
    hom2N := RestrictedHomomorphism( hom2, N, M );
    tc := TwistedConjugation( hom1, hom2 );
    gens := List( GeneratorsOfGroup( CoincidenceGroup2( hom1N, hom2N ) ) );
    func := function( qh )
        local h, n;
        h := PreImagesRepresentativeNC( q, qh );
        n := RepresentativeTwistedConjugationOp(
            hom1N, hom2N,
            tc( One( G ), h )
        );
        if n = fail then
            return fail;
        fi;
        return [h,n];
    end;
    C := SubgroupByProperty( CoinHN, qh -> func( qh ) <> fail );
    for qh in SmallGeneratingSet( C ) do
        Add( gens, Product( func( qh ) ) );
    od;
    return Subgroup( H, gens );
end;


###############################################################################
##
## CoincidenceGroupByCentre@( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which h^hom1 = h^hom2
##
##  REMARKS:
##      Used for factoring the calculation of Coin(hom1,hom2) through
##      H -> G -> G/C, with C the centre of G.
##
CoincidenceGroupByCentre@ := function( hom1, hom2 )
    local G, H, C, p, q, Coin, diff;
    G := Range( hom1 );
    H := Source( hom1 );
    C := Center( G );
    p := NaturalHomomorphismByNormalSubgroupNC( G, C );
    q := IdentityMapping( H );
    Coin := CoincidenceGroup2(
        InducedHomomorphism( q, p, hom1 ),
        InducedHomomorphism( q, p, hom2 )
    );
    diff := DifferenceGroupHomomorphisms@( hom1, hom2, Coin, G );
    return Kernel( diff );
end;


###############################################################################
##
## CoincidenceGroupStep5@( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which h^hom1 = h^hom2
##
##  REMARKS:
##      Assumes the existence of a normal abelian subgroup A of G such that:
##        - [A,[G,G]] = 1;
##        - h^hom1 = h^hom2 mod A, for all h in H;
##        - G = A Im(hom1) = A Im(hom2);
##        - [H,H] is a subgroup of Coin(hom1,hom2);
##        - Z(G) = 1.
##
CoincidenceGroupStep5@ := function( hom1, hom2 )
    local H, G, hi, n, tc, ai, C, i;
    G := Range( hom1 );
    H := Source( hom1 );
    hi := SmallGeneratingSet( H );
    n := Length( hi );
    tc := TwistedConjugation( hom1, hom2 );
    ai := List( [1..n], i -> tc( One( G ), hi[i]^-1 ) );
    C := G;
    for i in [1..n] do
        C := Centraliser( C, ai[i] );
    od;
    return PreImagesSet( hom2, C );
end;


###############################################################################
##
## CoincidenceGroupStep4@( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which h^hom1 = h^hom2
##
##  REMARKS:
##      Assumes the existence of a normal abelian subgroup A of G such that:
##        - [A,[G,G]] = 1;
##        - h^hom1 = h^hom2 mod A, for all h in H;
##        - G = A Im(hom1) = A Im(hom2);
##        - [H,H] is a subgroup of Coin(hom1,hom2).
##
CoincidenceGroupStep4@ := function( hom1, hom2 )
    local G, H, C, p, q, Coin, d;
    G := Range( hom1 );
    H := Source( hom1 );
    if IsNilpotentByFinite( G ) then
        return CoincidenceGroup2( hom1, hom2 );
    fi;
    C := Center( G );
    if IsTrivial( C ) then
        return CoincidenceGroupStep5@( hom1, hom2 );
    fi;
    p := NaturalHomomorphismByNormalSubgroupNC( G, C );
    q := IdentityMapping( H );
    Coin := CoincidenceGroupStep4@(
        InducedHomomorphism( q, p, hom1 ),
        InducedHomomorphism( q, p, hom2 )
    );
    d := DifferenceGroupHomomorphisms@( hom1, hom2, Coin, G );
    return Kernel( d );
end;


###############################################################################
##
## CoincidenceGroupStep3@( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which h^hom1 = h^hom2
##
##  REMARKS:
##      Assumes the existence of a normal abelian subgroup A of G such that:
##        - [A,[G,G]] = 1;
##        - h^hom1 = h^hom2 mod A, for all h in H;
##        - G = A Im(hom1) = A Im(hom2).
##
CoincidenceGroupStep3@ := function( hom1, hom2 )
    local G, H, HH, d, p, q, Coin, ci, n, tc, bi, di, gens1, gens2;
    G := Range( hom1 );
    H := Source( hom1 );
    if IsNilpotentByFinite( G ) then
        return CoincidenceGroup2( hom1, hom2 );
    fi;
    HH := DerivedSubgroup( H );
    d := DifferenceGroupHomomorphisms@( hom1, hom2, HH, G );
    p := NaturalHomomorphismByNormalSubgroupNC( G, ImagesSource( d ) );
    q := IdentityMapping( H );
    Coin := CoincidenceGroupStep4@(
        InducedHomomorphism( q, p, hom1 ),
        InducedHomomorphism( q, p, hom2 )
    );
    ci := SmallGeneratingSet( Coin );
    n := Length( ci );
    tc := TwistedConjugation( hom1, hom2 );
    bi := List( [1..n], i -> tc( One( G ), ci[i]^-1 ) );
    di := List( [1..n], i -> PreImagesRepresentativeNC( d, bi[i] ) );
    gens1 := List( [1..n], i -> di[i]^-1*ci[i] );
    gens2 := SmallGeneratingSet( Kernel( d ) );
    return Subgroup( H, Concatenation( gens1, gens2 ) );
end;


###############################################################################
##
## CoincidenceGroupStep2@( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which h^hom1 = h^hom2
##
##  REMARKS:
##      Assumes the existence of a normal abelian subgroup A of G such that:
##        - [A,[G,G]] = 1;
##        - h^hom1 = h^hom2 mod A, for all h in H.
##
CoincidenceGroupStep2@ := function( hom1, hom2 )
    local H, G, A, Gr;
    H := Source( hom1 );
    G := Range( hom1 );
    A := Center( DerivedSubgroup( G ) );
    Gr := ClosureGroup( ImagesSource( hom1 ), A );
    return CoincidenceGroupStep3@(
        RestrictedHomomorphism( hom1, H, Gr ),
        RestrictedHomomorphism( hom2, H, Gr )
    );
end;


###############################################################################
##
## CoincidenceGroupStep1@( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which h^hom1 = h^hom2
##
##  REMARKS:
##      Assumes G is nilpotent-by-abelian, and uses induction on the upper
##      central series of [G,G].
##
CoincidenceGroupStep1@ := function( hom1, hom2 )
    local H, G, A, p, q, Coin, hom1r, hom2r;
    H := Source( hom1 );
    G := Range( hom1 );
    A := Center( DerivedSubgroup( G ) );
    p := NaturalHomomorphismByNormalSubgroupNC( G, A );
    q := IdentityMapping( H );
    Coin:= CoincidenceGroup2(
        InducedHomomorphism( q, p, hom1 ),
        InducedHomomorphism( q, p, hom2 )
    );
    hom1r := RestrictedHomomorphism( hom1, Coin, G );
    hom2r := RestrictedHomomorphism( hom2, Coin, G );
    return CoincidenceGroupStep2@( hom1r, hom2r );
end;


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
    "for infinite pcp source and finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    6,
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
        return CoincidenceGroupByTrivialSubgroup@( hom1, hom2 );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for infinite pcp source and infinite nilpotent pcp range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    3,
    function( hom1, hom2 )
        local G, H, M, N;
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
        return CoincidenceGroupByCentre@( hom1, hom2 );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for infinite pcp source and infinite nilpotent-by-finite pcp range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    2,
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
        return CoincidenceGroupByFiniteQuotient@( hom1, hom2, M );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for infinite pcp source and infinite nilpotent-by-abelian pcp range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    1,
    function( hom1, hom2 )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            not IsFinite( H ) and
            IsPcpGroup( G ) and
            IsNilpotentByAbelian( G ) and
            not IsNilpotentByFinite( G )
        ) then TryNextMethod(); fi;
        return CoincidenceGroupStep1@( hom1, hom2 );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for infinite pcp source and range",
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
            not IsNilpotentByAbelian( G ) and
            not IsNilpotentByFinite( G )
        ) then TryNextMethod(); fi;
        M := NilpotentByAbelianByFiniteSeries( G )[2];
        return CoincidenceGroupByFiniteQuotient@( hom1, hom2, M );
    end
);
