###############################################################################
##
## SemidirectProduct( G, alpha, N )
##
##  INPUT:
##      G:          acting group
##      alpha:      homomorphism from G into Aut(N)
##      N:          normal subgroup
##
##  OUTPUT:
##      S:          the semidirect product N : G
##
InstallMethod(
    SemidirectProduct,
    "for pcp groups",
    [ IsPcpGroup, IsGroupHomomorphism, IsPcpGroup ],
    function( G, alpha, N )
        local auts, S, groups, n, k, emb1, acts, emb2, imgs, proj, ker, info;

        auts := List( Igs( G ), g -> ImagesRepresentative( alpha, g ) );
        S := SplitExtensionByAutomorphisms( N, G, auts );
        groups := [ G, N ];

        n := Length( Igs( G ) );
        k := Length( Igs( N ) );

        emb1 := GroupHomomorphismByImagesNC(
            G, S, Igs( G ), Igs( S ){ [ 1 .. n ] }
        );
        SetIsInjective( emb1, true );
        acts := Igs( S ){ [ n + 1 .. n + k ] };
        emb2 := GroupHomomorphismByImagesNC(
            N, S, Igs( N ), acts
        );
        SetIsInjective( emb2, true );

        imgs := Concatenation(
            Igs( G ),
            ListWithIdenticalEntries( k, One( G ) )
        );
        proj := GroupHomomorphismByImagesNC( S, G, Igs( S ), imgs );
        SetIsSurjective( proj, true );
        ker := SubgroupNC( S, acts );
        SetKernelOfMultiplicativeGeneralMapping( proj, ker );

        info := rec(
            groups := groups,
            embeddings := [ emb1, emb2],
            projections := proj
        );
        SetSemidirectProductInfo( S, info );

        if ForAny( groups, H -> HasIsFinite( H ) and not IsFinite( H ) ) then
            SetSize( S, infinity );
        elif ForAll( groups, HasSize ) then
            SetSize( S, Product( groups, Size ) );
        fi;

        return S;
    end
);
