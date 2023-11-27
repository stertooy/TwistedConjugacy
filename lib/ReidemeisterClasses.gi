###############################################################################
##
## ReidemeisterClass( hom1, x, arg... )
##
InstallGlobalFunction(
    ReidemeisterClass,
    function( hom1, x, arg... )
        local G, H, hom2, g, tc, tcc;
        G := Range( hom1 );
        H := Source( hom1 );
        if Length( arg ) = 0 then
            hom2 := IdentityMapping( G );
            g := x;
        else
            hom2 := x;
            g := arg[1];
        fi;
        tc := TwistedConjugation( hom1, hom2 );
        tcc := rec();
        ObjectifyWithAttributes(
            tcc, NewType(
                FamilyObj( G ),
                IsReidemeisterClassGroupRep and
                HasActingDomain and
                HasRepresentative and
                HasFunctionAction and
                HasGroupHomomorphismsOfReidemeisterClass
            ),
            ActingDomain, H,
            Representative, g,
            FunctionAction, tc,
            GroupHomomorphismsOfReidemeisterClass, [ hom1, hom2 ]
        );
        return tcc;
    end
);


###############################################################################
##
## Methods for operations/attributes on a ReidemeisterClass
##
InstallMethod(
    \in,
    "for Reidemeister classes",
    [ IsMultiplicativeElementWithInverse, IsReidemeisterClassGroupRep ],
    function( g, tcc )
        local hom;
        hom := GroupHomomorphismsOfReidemeisterClass( tcc );
        return IsTwistedConjugate(
            hom[1], hom[2],
            g, Representative( tcc )
        );
    end
);

InstallMethod(
    PrintObj,
    "for Reidemeister classes",
    [ IsReidemeisterClassGroupRep ],
    function( tcc )
        local homs, homStrings, g, hom, homGensImgs;
        homs := GroupHomomorphismsOfReidemeisterClass( tcc );
        homStrings := [];
        g := Representative( tcc );
        for hom in homs do
            homGensImgs := MappingGeneratorsImages( hom );
            Add( homStrings, Concatenation(
                String( homGensImgs[1] ),
                " -> ",
                String( homGensImgs[2] )
            ));
        od;
        Print(
            "ReidemeisterClass( [ ",
            PrintString( homStrings[1] ),
            ", ",
            PrintString( homStrings[2] ),
            " ], ",
            PrintString( g ),
            " )"
        );
        return;
    end
);

InstallMethodWithRandomSource(
    Random,
    "for a random source and a Reidemeister class",
    [ IsRandomSource, IsReidemeisterClassGroupRep ],
    function( rs, tcc )
        local H, g, h, tc;
        H := ActingDomain( tcc );
        g := Representative( tcc );
        h := Random( rs, H );
        tc := FunctionAction( tcc );
        return tc( g, h );
    end
);

InstallMethod(
    Size,
    "for Reidemeister classes",
    [ IsReidemeisterClassGroupRep ],
    function( tcc )
        local H, Coin;
        H := ActingDomain( tcc );
        Coin := StabilizerOfExternalSet( tcc );
        return IndexNC( H, Coin );
    end
);

InstallMethod(
    ListOp,
    "for Reidemeister classes",
    [ IsReidemeisterClassGroupRep ],
    function( tcc )
        local H, Coin, g, tc;
        if Size( tcc ) = infinity then
            return fail;
        fi;
        H := ActingDomain( tcc );
        Coin := StabilizerOfExternalSet( tcc );
        g := Representative( tcc );
        tc := FunctionAction( tcc );
        return List(
            RightTransversal( H, Coin ),
            h -> tc( g, h )
        );
    end
);

InstallMethod(
    StabilizerOfExternalSet,
    "for Reidemeister classes",
    [ IsReidemeisterClassGroupRep ],
    function( tcc )
        local g, hom, G, inn;
        g := Representative( tcc );
        hom := GroupHomomorphismsOfReidemeisterClass( tcc );
        G := Range( hom[1] );
        inn := InnerAutomorphismNC( G, g^-1 );
        return CoincidenceGroup2( hom[1]*inn, hom[2] );
    end
);


###############################################################################
##
## ReidemeisterClasses( hom1, arg... )
##
InstallGlobalFunction(
    ReidemeisterClasses,
    function( hom1, arg... )
        local G, hom2, Rcl;
        G := Range( hom1 );
        if Length( arg ) = 0 then
            hom2 := IdentityMapping( G );
        else
            hom2 := arg[1];
        fi;
        Rcl := RepresentativesReidemeisterClasses( hom1, hom2 );
        if Rcl = fail then
            return fail;
        fi;
        return List( Rcl, g -> ReidemeisterClass( hom1, hom2, g ) );
    end
);


###############################################################################
##
## ReidemeisterClassesByTrivialSubgroup@( hom1, hom2 )
##
ReidemeisterClassesByTrivialSubgroup@ := function( hom1, hom2 )
    local G, H, N, id, q, hom1HN, hom2HN;
    G := Range( hom1 );
    H := Source( hom1 );
    N := IntersectionKernels@( hom1, hom2 );
    id := IdentityMapping( G );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    hom1HN := InducedHomomorphism( q, id, hom1 );
    hom2HN := InducedHomomorphism( q, id, hom2 );
    return RepresentativesReidemeisterClasses( hom1HN, hom2HN );
end;


###############################################################################
##
## ReidemeisterClassesByFiniteQuotient@( hom1, hom2, M )
##
ReidemeisterClassesByFiniteQuotient@ := function( hom1, hom2, M )
    local G, H, N, p, q, GM, hom1p, hom2p, RclGM, Rcl, hom1N, hom2N, pg,
          inn_pg, Coin, g, conj_g, inn_g_hom1N, RclM, igRclM, inn_g, tc, m1,
          isNew, qh, h, m2;
    G := Range( hom1 );
    H := Source( hom1 );
    N := IntersectionPreImage@( hom1, hom2, M );
    p := NaturalHomomorphismByNormalSubgroupNC( G, M );
    q := NaturalHomomorphismByNormalSubgroupNC( H, N );
    GM := ImagesSource( p );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    RclGM := RepresentativesReidemeisterClasses( hom1p, hom2p );
    if RclGM = fail then
        return fail;
    fi;
    Rcl := [];
    hom1N := RestrictedHomomorphism( hom1, N, M );
    hom2N := RestrictedHomomorphism( hom2, N, M );
    for pg in RclGM do
        inn_pg := InnerAutomorphismNC( GM, pg^-1 );
        Coin := CoincidenceGroup2( hom1p*inn_pg, hom2p );
        if not IsFinite( Coin ) then TryNextMethod(); fi;
        g := PreImagesRepresentative( p, pg );
        conj_g := ConjugatorAutomorphismNC( M, g^-1 );
        inn_g_hom1N := hom1N*conj_g;
        RclM := RepresentativesReidemeisterClasses( inn_g_hom1N, hom2N );
        if RclM = fail then
            return fail;
        fi;
        igRclM := [];
        inn_g := InnerAutomorphismNC( G, g^-1 );
        tc := TwistedConjugation( hom1*inn_g, hom2 );
        for m1 in RclM do
            isNew := true;
            for qh in Coin do
                h := PreImagesRepresentative( q, qh );
                m2 := tc( m1, h );
                if ForAny(
                    igRclM,
                    k -> IsTwistedConjugate(
                        inn_g_hom1N, hom2N,
                        k, m2
                    )
                ) then
                    isNew := false;
                    break;
                fi;
            od;
            if isNew then
                Add( igRclM, m1 );
            fi;
        od;
        Append( Rcl, List( igRclM, m -> m*g ) );
    od;
    return Rcl;
end;


###############################################################################
##
## ReidemeisterClassesByCentre@( hom1, hom2 )
##
ReidemeisterClassesByCentre@ := function( hom1, hom2 )
    local G, H, C, p, q, hom1p, hom2p, RclGM, GM, Rcl, foundOne, pg, inn_pg,
          Coin, g, inn_g, d, r, coker, rm, m;
    G := Range( hom1 );
    H := Source( hom1 );
    C := Center( G );
    p := NaturalHomomorphismByNormalSubgroupNC( G, C );
    q := IdentityMapping( H );
    hom1p := InducedHomomorphism( q, p, hom1 );
    hom2p := InducedHomomorphism( q, p, hom2 );
    RclGM := RepresentativesReidemeisterClasses( hom1p, hom2p );
    if RclGM = fail then
        return fail;
    fi;
    GM := ImagesSource( p );
    Rcl := [];
    foundOne := false;
    for pg in RclGM do
        inn_pg := InnerAutomorphismNC( GM, pg^-1 );
        Coin := CoincidenceGroup2( hom1p*inn_pg, hom2p );
        g := PreImagesRepresentative( p, pg );
        inn_g := InnerAutomorphismNC( G, g^-1 );
        d := DifferenceGroupHomomorphisms@ ( hom1*inn_g, hom2, Coin, G );
        r := NaturalHomomorphismByNormalSubgroupNC( C, ImagesSource( d ) );
        coker := Range( r );
        if not IsFinite( coker ) then
            return fail;
        fi;
        for rm in coker do
            if ( not foundOne ) and IsOne( rm ) and IsOne( pg ) then
                Add( Rcl, One( G ), 1 );
                foundOne := true;
            else
                m := PreImagesRepresentative( r, rm );
                Add( Rcl, m*g );
            fi;
        od;
    od;
    return Rcl;
end;


###############################################################################
##
## RepresentativesReidemeisterClasses( hom1, hom2 )
##
InstallMethod(
    RepresentativesReidemeisterClasses,
    "for trivial range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    6,
    function( hom1, hom2 )
        local G;
        G := Range( hom1 );
        if not IsTrivial( G ) then TryNextMethod(); fi;
        return [ One( G ) ];
    end
);

InstallMethod(
    RepresentativesReidemeisterClasses,
    "for infinite source and finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    5,
    function( hom1, hom2 )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            not IsFinite( H ) and
            IsFinite( G ) and
            not IsTrivial( G )
        ) then TryNextMethod(); fi;
        return ReidemeisterClassesByTrivialSubgroup@( hom1, hom2 );
    end
);

InstallMethod(
    RepresentativesReidemeisterClasses,
    "for abelian range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    4,
    function( hom1, hom2 )
        local G, H, diff, N, Rcl, p, pg, g;
        G := Range( hom1 );
        H := Source( hom1 );
        if not IsAbelian( G ) then TryNextMethod(); fi;
        diff := DifferenceGroupHomomorphisms@( hom1, hom2, H, G );
        N := ImagesSource( diff );
        if IndexNC( G, N ) = infinity then return fail; fi;
        Rcl := [];
        p := NaturalHomomorphismByNormalSubgroupNC( G, N );
        for pg in ImagesSource( p ) do
            if IsOne( pg ) then
                Add( Rcl, One( G ), 1 );
            else
                g := PreImagesRepresentative( p, pg );
                Add( Rcl, g );
            fi;
        od;
        return Rcl;
    end
);

InstallMethod(
    RepresentativesReidemeisterClasses,
    "for finite source",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    3,
    function( hom1, hom2 )
        local G, H, Rcl, tc, G_List, gens, orbits, foundOne, orbit;
        G := Range( hom1 );
        H := Source( hom1 );
        if not IsFinite( H ) then TryNextMethod(); fi;
        if not IsFinite( G ) then return fail; fi;
        Rcl := [];
        tc := TwistedConjugation( hom1, hom2 );
        G_List := AsSSortedListNonstored( G );
        if CanEasilyComputePcgs( H ) then
            gens := Pcgs( H );
        else
            gens := SmallGeneratingSet( H );
        fi;
        orbits := OrbitsDomain( H, G_List, gens, gens, tc );
        foundOne := false;
        for orbit in orbits do
            if ( not foundOne ) and One( G ) in orbit then
                Add( Rcl, One( G ), 1 );
                foundOne := true;
            else
                Add( Rcl, orbit[1] );
            fi;
        od;
        return Rcl;
    end
);

InstallMethod(
    RepresentativesReidemeisterClasses,
    "for finitely generated nilpotent range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    2,
    function( hom1, hom2 )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsFinitelyGeneratedGroup( G ) and
            IsNilpotentGroup( G ) and
            not IsAbelian( G )
        ) then TryNextMethod(); fi;
        return ReidemeisterClassesByCentre@( hom1, hom2 );
    end
);

InstallMethod(
    RepresentativesReidemeisterClasses,
    "for finitely generated nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    1,
    function( hom1, hom2 )
        local G, H, M;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsFinitelyGeneratedGroup( G ) and
            IsNilpotentByFinite( G ) and
            not IsNilpotentGroup( G )
        ) then TryNextMethod(); fi;
        M := FittingSubgroup( G );
        return ReidemeisterClassesByFiniteQuotient@( hom1, hom2, M );
    end
);

InstallMethod(
    RepresentativesReidemeisterClasses,
    "for polycyclic source and range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    0,
    function( hom1, hom2 )
        local G, H, M;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPolycyclicGroup( H ) and
            IsPolycyclicGroup( G )
        ) then TryNextMethod(); fi;
        M := DerivedSubgroup( G );
        return ReidemeisterClassesByFiniteQuotient@( hom1, hom2, M );
    end
);
