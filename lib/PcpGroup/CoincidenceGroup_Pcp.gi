###############################################################################
##
## CoincidenceGroupByTrivialSubgroup@( hom1, hom2 )
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
    return PreImagesSet( q, Coin );
end;


###############################################################################
##
## CoincidenceGroupByFiniteQuotient@( hom1, hom2, N, M )
##
CoincidenceGroupByFiniteQuotient@ := function( hom1, hom2, N, M )
    local G, H, p, q, CoinHN, hom1N, hom2N, tc, igs, pcgs, orbit, l, i, qh,
        pos, j, h, stab, n;
    G := Range( hom1 );
    H := Source( hom1 );
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
    igs := Igs( CoincidenceGroup2( hom1N, hom2N ) );
    q := RestrictedHomomorphism( q, Source( q ), ImagesSource( q ) );
    q := q * IsomorphismPcGroup( CoinHN );
    CoinHN := Range( q );
    pcgs := Pcgs( CoinHN );
    orbit := [ One( CoinHN ) ];
    l := ListWithIdenticalEntries( Length( pcgs ), 0 );
    Add( l, 1 );
    for i in Reversed( [1..Length( pcgs )] ) do
        qh := pcgs[i];
        pos := fail;
        for j in [1..Length( orbit )] do
            h := PreImagesRepresentative( q, orbit[j] / qh );
            if RepTwistConjToId( hom1N, hom2N, tc( One( G ), h ) ) <> fail then
                pos := j-1;
                break;
            fi;
        od;
        if IsInt( pos ) then
            stab := ListWithIdenticalEntries( Length( pcgs ), 0 );
            stab[i] := 1;
            while pos > 0 do
                j := First( [i..Length( pcgs )] + 2, j -> l[j] <= pos );
                stab[j-1] := - QuoInt( pos, l[j] );
                pos := RemInt( pos, l[j] );
            od;
            qh := LinearCombinationPcgs( pcgs, stab );
            h := PreImagesRepresentative( q, qh );
            n := RepTwistConjToId( hom1N, hom2N, tc( One( G ), h ) );
            igs := AddToIgs( igs, [ h*n ] );
        else
            for j in [2..RelativeOrders( pcgs )[i]] do
                Append( orbit, orbit{ [1-l[i+1]..0] + Length( orbit ) } * qh );
            od;
        fi;
        l[i] := Length( orbit );
    od;
    return SubgroupByIgs( H, igs );
end;


###############################################################################
##
## CoincidenceGroupByCentre@( hom1, hom2 )
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
CoincidenceGroupStep5@ := function( hom1, hom2 )
    local H, G, h, n, tc, r, C, i;
    G := Range( hom1 );
    H := Source( hom1 );
    h := SmallGeneratingSet( H );
    n := Length( h );
    tc := TwistedConjugation( hom1, hom2 );
    r := List( [1..n], i -> tc( One( G ), h[i]^-1 ) );
    C := G;
    for i in [1..n] do
        C := Centraliser( C, r[i] );
    od;
    return PreImagesSet( hom2, C );
end;


###############################################################################
##
## CoincidenceGroupStep4@( hom1, hom2 )
##
CoincidenceGroupStep4@ := function( hom1, hom2 ) 
    local G, H, C, p, q, Coin, diff;
    G := Range( hom1 );
    H := Source( hom1 );
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
    diff := DifferenceGroupHomomorphisms@( hom1, hom2, Coin, G );
    return Kernel( diff );
end;


###############################################################################
##
## CoincidenceGroupStep3@( hom1, hom2 )
##
CoincidenceGroupStep3@ := function( hom1, hom2 )
    local G, H, HH, GG, d, dHH, p, q, CoinModC, CoinHH, h, n, tc, c, x, gens1, gens2;
    G := Range( hom1 );
    H := Source( hom1 );
    HH := DerivedSubgroup( H );
    GG := DerivedSubgroup( G );
    d := DifferenceGroupHomomorphisms@( hom1, hom2, HH, G );
    dHH := ImagesSource( d );
    p := NaturalHomomorphismByNormalSubgroupNC( G, dHH );
    q := IdentityMapping( H );
    CoinModC := CoincidenceGroupStep4@( 
        InducedHomomorphism( q, p, hom1 ),
        InducedHomomorphism( q, p, hom2 )
    );
    CoinHH := CoincidenceGroup2( 
        RestrictedHomomorphism( hom1, HH, GG ),
        RestrictedHomomorphism( hom2, HH, GG )
    );
    h := SmallGeneratingSet( CoinModC );
    n := Length( h );
    tc := TwistedConjugation( hom1, hom2 );
    c := List( [1..n], i -> tc( One( G ), h[i]^-1 ) );
    x := List( [1..n], i -> PreImagesRepresentative( d, c[i] ) );
    gens1 := List( [1..n], i -> x[i]^-1*h[i] );
    gens2 := SmallGeneratingSet( CoinHH );
    return Subgroup( H, Concatenation( gens1, gens2 ) );
end;


###############################################################################
##
## CoincidenceGroupStep2@( hom1, hom2 )
##
CoincidenceGroupStep2@ := function( hom1, hom2 )
    local H, G, img1, img2, Gr, hom1r, hom2r;
    H := Source( hom1 );
    G := Range( hom2 );
    img1 := ImagesSource( hom1 );
    img2 := ImagesSource( hom2 );
    Gr := ClosureGroup( img1, img2 ); 
    hom1r := RestrictedHomomorphism( hom1, H, Gr );
    hom2r := RestrictedHomomorphism( hom2, H, Gr );
    return CoincidenceGroupStep3@( hom1r, hom2r );
end;


###############################################################################
##
## CoincidenceGroupStep1@( hom1, hom2 )
##
CoincidenceGroupStep1@ := function( hom1, hom2 )
    local H, G, LCS, C, p, q, Coin, hom1r, hom2r;
    H := Source( hom1 );
    G := Range( hom2 );
    LCS := LowerCentralSeries( DerivedSubgroup( G ) );
    C := LCS[Length(LCS)-1];
    p := NaturalHomomorphismByNormalSubgroupNC( G, C );
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
InstallMethod(
    CoincidenceGroup2,
    "for infinite polycyclic source and finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    6,
    function( hom1, hom2 )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsFinite( G ) and
            not IsTrivial( G )
        ) then TryNextMethod(); fi;
        return CoincidenceGroupByTrivialSubgroup@( hom1, hom2 );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for infinite polycyclic source and infinite nilpotent range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    3,
    function( hom1, hom2 )
        local G, H, M, N;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            IsNilpotentGroup( G ) and
            not IsAbelian( G )
        ) then TryNextMethod(); fi;
        return CoincidenceGroupByCentre@( hom1, hom2 );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for infinite polycyclic source and infinite nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    2,
    function( hom1, hom2 )
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
        return CoincidenceGroupByFiniteQuotient@( hom1, hom2, N, M );
    end
);



InstallMethod(
    CoincidenceGroup2,
    "for infinite polycyclic source and infinite nilpotent-by-abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    1,
    function( hom1, hom2 )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            IsNilpotentByAbelian( G ) and
            not IsNilpotentByFinite( G )
        ) then TryNextMethod(); fi;
        return CoincidenceGroupStep1@( hom1, hom2 );
    end
);

InstallMethod(
    CoincidenceGroup2,
    "for infinite polycyclic source and range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    0,
    function( hom1, hom2 )
        local G, H, M, N;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            not IsNilpotentByAbelian( G )
        ) then TryNextMethod(); fi;
        M := NilpotentByAbelianNormalSubgroup( G );
        N := IntersectionPreImage@( hom1, hom2, M );
        return CoincidenceGroupByFiniteQuotient@( hom1, hom2, N, M );
    end
);
