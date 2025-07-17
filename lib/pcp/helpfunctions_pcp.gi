###############################################################################
##
## IntersectionOfKernels( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      N:          intersection of Ker(hom1) and Ker(hom2)
##
InstallGlobalFunction(
    IntersectionOfKernels,
    { hom1, hom2 } -> NormalIntersection(
        KernelOfMultiplicativeGeneralMapping( hom1 ),
        KernelOfMultiplicativeGeneralMapping( hom2 )
    )
);

###############################################################################
##
## IntersectionOfPreImages( hom1, hom2, M )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      M:          normal subgroup of G
##
##  OUTPUT:
##      N:          intersection of hom1^-1(M) and hom2^-1(M)
##
InstallGlobalFunction(
    IntersectionOfPreImages,
    { hom1, hom2, M } -> NormalIntersection(
        # TODO: replace by PreImagesSet eventually
        PreImagesSetNC( hom1, NormalIntersection( M, ImagesSource( hom1 ) ) ),
        PreImagesSetNC( hom2, NormalIntersection( M, ImagesSource( hom2 ) ) )
    )
);

###############################################################################
##
## IsNilpotentByAbelian( G )
##
##  INPUT:
##      G:          group
##
##  OUTPUT:
##      bool:       true iff G is nilpotent-by-abelian
##
InstallMethod(
    IsNilpotentByAbelian,
    [ IsGroup ],
    G -> IsNilpotentGroup( DerivedSubgroup( G ) )
);

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
        local auts, groups, S, f, info;

        auts := List( Igs( G ), g -> ImagesRepresentative( alpha, g ) );
        groups := [ G, N ];

        S := SplitExtensionByAutomorphisms( N, G, auts );

        f := [ 1, Length( Igs( G ) ) + 1, Length( Igs( S ) ) + 1 ];
        info := rec(
            groups := groups,
            first := f,
            embeddings := [],
            projections := false
        );
        SetSemidirectProductInfo( S, info );

        if ForAny( groups, H -> HasIsFinite( H ) and not IsFinite( H ) ) then
            SetSize( S, infinity );
        elif ForAll( groups, HasSize ) then
            SetSize( S, Product( List( groups, Size ) ) );
        fi;

        return S;
    end
);

###############################################################################
##
## Embedding( S, i )
##
##  INPUT:
##      S:          semidirect product N : G
##      i:          positive integer (1 or 2)
##
##  OUTPUT:
##      hom:        embedding of G or N into S, corresponding to i = 1 or 2
##
InstallMethod(
    Embedding,
    [ IsPcpGroup and HasSemidirectProductInfo, IsPosInt ],
    function( S, i )
        local info, G, imgs, hom, gens;

        info := SemidirectProductInfo( S );
        if IsBound( info.embeddings[i] ) then
            return info.embeddings[i];
        fi;

        G := info.groups[i];
        gens := Igs( G );
        imgs := Igs( S ){ [ info.first[i] .. info.first[ i + 1 ] - 1 ] };
        hom  := GroupHomomorphismByImagesNC( G, S, gens, imgs );
        SetIsInjective( hom, true );

        info.embeddings[i] := hom;
        return hom;
    end
);

###############################################################################
##
## Projection( S )
##
##  INPUT:
##      S:          semidirect product N : G
##
##  OUTPUT:
##      hom:        projection from S to G
##
InstallOtherMethod(
    Projection,
    [ IsPcpGroup and HasSemidirectProductInfo ],
    function( S )
        local info, G, imgs, hom, N, gens;

        info := SemidirectProductInfo( S );
        if not IsBool( info.projections ) then
            return info.projections;
        fi;

        G := info.groups[1];
        gens := Igs( S );
        imgs := Concatenation(
            Igs( G ),
            List( [ info.first[2] .. Length( gens ) ], x -> One( G ) )
        );
        hom := GroupHomomorphismByImagesNC( S, G, gens, imgs );
        SetIsSurjective( hom, true );

        N := SubgroupNC( S, gens{ [ info.first[2] .. Length( gens ) ] } );
        SetKernelOfMultiplicativeGeneralMapping( hom, N );

        info.projections := hom;
        return hom;
    end
);
