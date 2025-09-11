###############################################################################
##
## TWC_CoincidenceGroupByTrivialSubgroup( G, H, hom1, hom2 )
##
##  INPUT:
##      G:          finite group
##      H:          infinite PcpGroup
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
BindGlobal(
    "TWC_CoincidenceGroupByTrivialSubgroup",
    function( G, H, hom1, hom2 )
        local N, p, q, Coin;
        N := TWC_IntersectionOfKernels( hom1, hom2 );
        p := IdentityMapping( G );
        q := NaturalHomomorphismByNormalSubgroupNC( H, N );
        Coin := TWC_InducedCoincidenceGroup( q, p, hom1, hom2 );
        return PreImagesSetNC( q, Coin );
    end
);

###############################################################################
##
## TWC_CoincidenceGroupByFiniteQuotient( G, H, hom1, hom2, K )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      K:          finite index normal subgroup of G
##
##  OUTPUT:
##      coin:       subgroup of H consisting of h for which h^hom1 = h^hom2
##
##  REMARKS:
##      Calculates Coin(hom1,hom2) by first calculating Coin(hom1N,hom2N) and
##      Coin(hom1HN,hom2HN), where hom1N, hom2N: N -> K (with N normal in H)
##      and hom1HN, hom2HN: H/N -> G/K.
##
BindGlobal(
    "TWC_CoincidenceGroupByFiniteQuotient",
    function( G, H, hom1, hom2, K )
        local N, p, q, CoinHN, hom1N, hom2N, tc, qh, gens, dict, func, C;
        N := TWC_IntersectionOfPreImages( hom1, hom2, K );
        p := NaturalHomomorphismByNormalSubgroupNC( G, K );
        q := NaturalHomomorphismByNormalSubgroupNC( H, N );
        CoinHN := TWC_InducedCoincidenceGroup( q, p, hom1, hom2 );
        hom1N := RestrictedHomomorphism( hom1, N, K );
        hom2N := RestrictedHomomorphism( hom2, N, K );
        tc := TwistedConjugation( hom1, hom2 );
        gens := List( GeneratorsOfGroup( CoincidenceGroup2( hom1N, hom2N ) ) );
        dict := NewDictionary( false, true, CoinHN );
        func := function( qh, dict )
            local h, n, hn;
            hn := LookupDictionary( dict, qh );
            if hn = fail then
                h := PreImagesRepresentativeNC( q, qh );
                n := RepresentativeTwistedConjugationOp(
                    hom1N, hom2N,
                    tc( One( G ), h )
                );
                if n <> fail then
                    hn := h * n;
                    AddDictionary( dict, qh, hn );
                fi;
            fi;
            return hn;
        end;
        C := SubgroupByProperty( CoinHN, qh -> func( qh, dict ) <> fail );
        for qh in SmallGeneratingSet( C ) do
            Add( gens, func( qh, dict ) );
        od;
        return SubgroupNC( H, gens );
    end
);

###############################################################################
##
## TWC_CoincidenceGroupByCentre( G, H, hom1, hom2 )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
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
BindGlobal(
    "TWC_CoincidenceGroupByCentre",
    function( G, H, hom1, hom2 )
        local C, p, q, Coin, diff;
        C := Center( G );
        p := NaturalHomomorphismByNormalSubgroupNC( G, C );
        q := IdentityMapping( H );
        Coin := TWC_InducedCoincidenceGroup( q, p, hom1, hom2 );
        diff := TWC_DifferenceGroupHomomorphisms( hom1, hom2, Coin, G );
        return KernelOfMultiplicativeGeneralMapping( diff );
    end
);

###############################################################################
##
## TWC_CoincidenceGroupStep5( G, H, hom1, hom2 )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
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
BindGlobal(
    "TWC_CoincidenceGroupStep5",
    function( G, H, hom1, hom2 )
        local hi, n, tc, ai, C, i;
        hi := SmallGeneratingSet( H );
        n := Length( hi );
        tc := TwistedConjugation( hom1, hom2 );
        ai := List( [ 1 .. n ], i -> tc( One( G ), hi[i] ^ -1 ) );
        C := G;
        for i in [ 1 .. n ] do
            C := Centraliser( C, ai[i] );
        od;
        # TODO: Replace this by PreImagesSet (without NC) eventually
        C := NormalIntersection( C, ImagesSource( hom2 ) );
        return PreImagesSetNC( hom2, C );
    end
);

###############################################################################
##
## TWC_CoincidenceGroupStep4( G, H, hom1, hom2 )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
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
BindGlobal(
    "TWC_CoincidenceGroupStep4",
    function( G, H, hom1, hom2 )
        local recfun;
        if IsNilpotentByFinite( G ) then
            return CoincidenceGroup2( hom1, hom2 );
        fi;
        recfun := function( G, H, hom1, hom2 )
            local C, p, q, Coin, d;
            C := Center( G );
            if IsTrivial( C ) then
                return TWC_CoincidenceGroupStep5( G, H, hom1, hom2 );
            fi;
            p := NaturalHomomorphismByNormalSubgroupNC( G, C );
            q := IdentityMapping( H );
            Coin := recfun(
                ImagesSource( p ), H,
                InducedHomomorphism( q, p, hom1 ),
                InducedHomomorphism( q, p, hom2 )
            );
            d := TWC_DifferenceGroupHomomorphisms( hom1, hom2, Coin, G );
            return KernelOfMultiplicativeGeneralMapping( d );
        end;
        return recfun( G, H, hom1, hom2 );
    end
);

###############################################################################
##
## TWC_CoincidenceGroupStep3( G, H, hom1, hom2 )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
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
BindGlobal(
    "TWC_CoincidenceGroupStep3",
    function( G, H, hom1, hom2 )
        local HH, d, p, q, Coin, ci, n, tc, bi, di, gens1, gens2;
        if IsNilpotentByFinite( G ) then
            return CoincidenceGroup2( hom1, hom2 );
        fi;
        HH := DerivedSubgroup( H );
        d := TWC_DifferenceGroupHomomorphisms( hom1, hom2, HH, G );
        p := NaturalHomomorphismByNormalSubgroupNC( G, ImagesSource( d ) );
        q := IdentityMapping( H );
        Coin := TWC_CoincidenceGroupStep4(
            ImagesSource( p ), H,
            InducedHomomorphism( q, p, hom1 ),
            InducedHomomorphism( q, p, hom2 )
        );
        ci := SmallGeneratingSet( Coin );
        n := Length( ci );
        tc := TwistedConjugation( hom1, hom2 );
        bi := List( [ 1 .. n ], i -> tc( One( G ), ci[i] ^ -1 ) );
        di := List( [ 1 .. n ], i -> PreImagesRepresentativeNC( d, bi[i] ) );
        gens1 := List( [ 1 .. n ], i -> di[i] ^ -1 * ci[i] );
        gens2 := SmallGeneratingSet(
            KernelOfMultiplicativeGeneralMapping( d )
        );
        return Subgroup( H, Concatenation( gens1, gens2 ) );
    end
);

###############################################################################
##
## TWC_CoincidenceGroupStep2( G, H, hom1, hom2 )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
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
BindGlobal(
    "TWC_CoincidenceGroupStep2",
    function( G, H, hom1, hom2 )
        local A, Gr;
        A := Center( DerivedSubgroup( G ) );
        Gr := ClosureGroup( ImagesSource( hom1 ), A );
        return TWC_CoincidenceGroupStep3(
            Gr, H,
            RestrictedHomomorphism( hom1, H, Gr ),
            RestrictedHomomorphism( hom2, H, Gr )
        );
    end
);

###############################################################################
##
## TWC_CoincidenceGroupStep1( G, H, hom1, hom2 )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
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
BindGlobal(
    "TWC_CoincidenceGroupStep1",
        function( G, H, hom1, hom2 )
        local A, p, q, Coin, hom1r, hom2r;
        A := Center( DerivedSubgroup( G ) );
        p := NaturalHomomorphismByNormalSubgroupNC( G, A );
        q := IdentityMapping( H );
        Coin := TWC_InducedCoincidenceGroup( q, p, hom1, hom2 );
        hom1r := RestrictedHomomorphism( hom1, Coin, G );
        hom2r := RestrictedHomomorphism( hom2, Coin, G );
        return TWC_CoincidenceGroupStep2( G, Coin, hom1r, hom2r );
    end
);
