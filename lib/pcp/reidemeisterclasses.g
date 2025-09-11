###############################################################################
##
## TWC_ReidemeisterClassesByTrivialSubgroup( G, H, hom1, hom2, N, one )
##
##  INPUT:
##      G:          finite group
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          normal subgroup of G with hom1 = hom2 mod N
##      one:        boolean to toggle returning fail as soon as there is more
##                  than one Reidemeister class
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
BindGlobal(
    "TWC_ReidemeisterClassesByTrivialSubgroup",
    function( G, H, hom1, hom2, N, one )
        local L, id, q, hom1HL, hom2HL;
        L := TWC_IntersectionOfKernels( hom1, hom2 );
        id := IdentityMapping( G );
        q := NaturalHomomorphismByNormalSubgroupNC( H, L );
        hom1HL := InducedHomomorphism( q, id, hom1 );
        hom2HL := InducedHomomorphism( q, id, hom2 );
        return RepresentativesReidemeisterClassesOp( hom1HL, hom2HL, N, one );
    end
);

###############################################################################
##
## TWC_ReidemeisterClassesByFiniteQuotient( G, H, hom1, hom2, N, K, one )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          normal subgroup of G with hom1 = hom2 mod N
##      K:          finite index normal subgroup of G
##      one:        boolean to toggle returning fail as soon as there is more
##                  than one Reidemeister class
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class in N, or fail if there are
##                  infinitely many
##
##  REMARKS:
##      Calculates the representatives of (hom1,hom2) by first calculating the
##      representatives of (hom1p,hom2p), with hom1p, hom2p: H/L -> G/K,
##      where L is normal in H.
##
BindGlobal(
    "TWC_ReidemeisterClassesByFiniteQuotient",
        function( G, H, hom1, hom2, N, K, one )
        local L, p, q, GK, pN, hom1p, hom2p, RclGK, Rcl, hom1K, hom2K, M, pn,
              inn_pn, Coin, n, conj_n, inn_n_hom1K, RclM, inRclM, inn_n, tc,
              m1, isNew, h, m2, inn_nm2_hom1K;
        L := TWC_IntersectionOfPreImages( hom1, hom2, K );
        p := NaturalHomomorphismByNormalSubgroupNC( G, K );
        q := NaturalHomomorphismByNormalSubgroupNC( H, L );
        hom1p := InducedHomomorphism( q, p, hom1 );
        hom2p := InducedHomomorphism( q, p, hom2 );
        pN := ImagesSet( p, N );
        RclGK := RepresentativesReidemeisterClassesOp( hom1p, hom2p, pN, one );
        if RclGK = fail then
            return fail;
        fi;
        GK := ImagesSource( p );
        Rcl := [];
        hom1K := RestrictedHomomorphism( hom1, L, K );
        hom2K := RestrictedHomomorphism( hom2, L, K );
        M := NormalIntersection( N, K );
        for pn in RclGK do
            n := PreImagesRepresentativeNC( p, pn );
            conj_n := ConjugatorAutomorphismNC( K, n );
            inn_n_hom1K := hom1K * conj_n;
            RclM := RepresentativesReidemeisterClassesOp(
                inn_n_hom1K, hom2K, M, false
            );
            if RclM = fail then
                return fail;
            fi;
            inRclM := [ Remove( RclM, 1 ) ];
            if not IsEmpty( RclM ) then
                inn_pn := InnerAutomorphismNC( GK, pn );
                inn_n := InnerAutomorphismNC( G, n );
                tc := TwistedConjugation( hom1 * inn_n, hom2 );
                Coin := List(
                    CoincidenceGroup2( hom1p * inn_pn, hom2p ),
                    qh -> PreImagesRepresentativeNC( q, qh )
                );
                for m1 in RclM do
                    isNew := true;
                    for h in Coin do
                        m2 := tc( m1, h );
                        inn_nm2_hom1K := inn_n_hom1K *
                            InnerAutomorphismNC( K, m2 );
                        if ForAny(
                            inRclM,
                            k -> RepresentativeTwistedConjugationOp(
                                inn_nm2_hom1K,
                                hom2K,
                                m2 ^ -1 * k
                            ) <> fail
                        ) then
                            isNew := false;
                            break;
                        fi;
                    od;
                    if isNew then
                        if one then
                            return fail;
                        fi;
                        Add( inRclM, m1 );
                    fi;
                od;
            fi;
            Append( Rcl, List( inRclM, m -> n * m ) );
        od;
        return Rcl;
    end
);

###############################################################################
##
## TWC_ReidemeisterClassesByNormalSubgroup( G, H, hom1, hom2, N, K, one )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          normal subgroup of G with hom1 = hom2 mod N
##      M:          normal subgroup of G
##      one:        boolean to toggle returning fail as soon as there is more
##                  than one Reidemeister class
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
BindGlobal(
    "TWC_ReidemeisterClassesByNormalSubgroup",
    function( G, H, hom1, hom2, N, K, one )
        local p, idH, pN, hom1p, hom2p, RclGK, Rcl, M, pn, n, inn_n, C_n,
              hom1_n, hom2_n, RclM, inn_pn, GK;
        p := NaturalHomomorphismByNormalSubgroupNC( G, K );
        idH := IdentityMapping( H );
        pN := ImagesSet( p, N );
        hom1p := InducedHomomorphism( idH, p, hom1 );
        hom2p := InducedHomomorphism( idH, p, hom2 );
        RclGK := RepresentativesReidemeisterClassesOp( hom1p, hom2p, pN, one );
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
            C_n := CoincidenceGroup2( hom1p * inn_pn, hom2p );
            hom1_n := RestrictedHomomorphism( hom1 * inn_n, C_n, G );
            hom2_n := RestrictedHomomorphism( hom2, C_n, G );
            RclM := RepresentativesReidemeisterClassesOp(
                hom1_n, hom2_n, M, one
            );
            if RclM = fail then
                return fail;
            fi;
            Append( Rcl, List( RclM, m -> n * m ) );
        od;
        return Rcl;
    end
);

###############################################################################
##
## TWC_RepsReidClassesStep3( G, H, hom1, hom2, A, one )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      A:          abelian normal subgroup of G with hom1 = hom2 mod A
##      one:        boolean to toggle returning fail as soon as there is more
##                  than one Reidemeister class
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class in A, or fail if there are
##                  infinitely many
##
##  REMARKS:
##      Assumes that:
##        - [A,[G,G]] = 1;
##        - G = A Im(hom1) = A Im(hom2);
##        - [H,H] is a subgroup of Coin(hom1,hom2);
##
BindGlobal(
    "TWC_RepsReidClassesStep3",
    function( _, H, hom1, hom2, A, one )
        local q, Hab, igs, prei, imgs1, auts, Aut, alpha, S, imgs2, n, diff,
              iHab, iA, embsHab, embsA, l, r, N, Rcl;
        q := NaturalHomomorphismByNormalSubgroupNC( H, DerivedSubgroup( H ) );
        Hab := ImagesSource( q );
        igs := Igs( Hab );
        prei := List( igs, qh -> PreImagesRepresentativeNC( q, qh ) );
        imgs1 := List( prei, h -> ImagesRepresentative( hom1, h ) );
        auts := List( imgs1, h -> ConjugatorAutomorphismNC( A, h ) );
        Aut := Group( auts );

        alpha := GroupHomomorphismByImagesNC( Hab, Aut, igs, auts );
        S := SemidirectProduct( Hab, alpha, A );
        if not IsNilpotentByFinite( S ) then
            return fail;
        fi;

        imgs2 := List( prei, h -> ImagesRepresentative( hom2, h ) );
        n := Length( igs );
        diff := List( [ 1 .. n ], i -> imgs1[i] ^ -1 * imgs2[i] );
        iHab := Embedding( S, 1 );
        iA := Embedding( S, 2 );
        embsHab := List( igs, qh -> ImagesRepresentative( iHab, qh ) );
        embsA := List( diff, a -> ImagesRepresentative( iA, a ) );
        l := GroupHomomorphismByImagesNC( Hab, S, igs, embsHab );
        r := GroupHomomorphismByImagesNC(
            Hab, S,
            igs, List( [ 1 .. n ], i -> embsHab[i] * embsA[i] )
        );
        N := ImagesSource( iA );
        Rcl := RepresentativesReidemeisterClassesOp( l, r, N, one );
        if Rcl = fail then
            return fail;
        fi;
        return List( Rcl, a -> PreImagesRepresentativeNC( iA, a ) );
    end
);

###############################################################################
##
## TWC_RepsReidClassesStep2( G, H, hom1, hom2, A, one )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      A:          abelian normal subgroup of G with hom1 = hom2 mod A
##      one:        boolean to toggle returning fail as soon as there is more
##                  than one Reidemeister class
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class in A, or fail if there are
##                  infinitely many
##
##  REMARKS:
##      Assumes that:
##        - [A,[G,G]] = 1;
##        - G = A Im(hom1) = A Im(hom2);
##
BindGlobal(
    "TWC_RepsReidClassesStep2",
    function( G, H, hom1, hom2, A, one )
        local HH, delta, dHH, p, q, hom1p, hom2p, pG, pA, Rcl;
        HH := DerivedSubgroup( H );
        delta := TWC_DifferenceGroupHomomorphisms( hom1, hom2, HH, A );
        dHH := ImagesSource( delta );
        p := NaturalHomomorphismByNormalSubgroupNC( G, dHH );
        q := IdentityMapping( H );
        hom1p := InducedHomomorphism( q, p, hom1 );
        hom2p := InducedHomomorphism( q, p, hom2 );
        pG := ImagesSource( p );
        pA := ImagesSet( p, A );
        Rcl := TWC_RepsReidClassesStep3( pG, H, hom1p, hom2p, pA, one );
        if Rcl = fail then
            return fail;
        fi;
        return List( Rcl, pa -> PreImagesRepresentativeNC( p, pa ) );
    end
);

###############################################################################
##
## TWC_RepsReidClassesStep1( G, H, hom1, hom2, A )
##
##  INPUT:
##      G:          infinite PcpGroup
##      H:          infinite PcpGroup
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      A:          abelian normal subgroup of G with hom1 = hom2 mod A
##      one:        boolean to toggle returning fail as soon as there is more
##                  than one Reidemeister class
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class in A, or fail if there are
##                  infinitely many
##
##  REMARKS:
##      Assumes that [A,[G,G]] = 1
##
BindGlobal(
"TWC_RepsReidClassesStep1",
    function( _G, H, hom1, hom2, A, one )
        local K, l, r;
        K := ClosureGroup( ImagesSource( hom1 ), A );
        l := RestrictedHomomorphism( hom1, H, K );
        r := RestrictedHomomorphism( hom2, H, K );
        return TWC_RepsReidClassesStep2( K, H, l, r, A, one );
    end
);
