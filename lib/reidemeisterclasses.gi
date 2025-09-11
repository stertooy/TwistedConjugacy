###############################################################################
##
## ReidemeisterClass( hom1, hom2, g )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##      g:          element of G
##
##  OUTPUT:
##      tcc:        (hom1,hom2)-twisted conjugacy class of g
##
InstallGlobalFunction(
    ReidemeisterClass,
    function( hom1, arg... )
        local G, H, hom2, g, tc, tcc;
        G := Range( hom1 );
        H := Source( hom1 );
        if Length( arg ) = 1 then
            hom2 := IdentityMapping( G );
            g := First( arg );
        else
            hom2 := First( arg );
            g := Last( arg );
        fi;
        tc := TwistedConjugation( hom1, hom2 );
        tcc := rec( lhs := hom1, rhs := hom2 );
        ObjectifyWithAttributes(
            tcc, NewType(
                FamilyObj( G ),
                IsReidemeisterClassGroupRep and
                HasActingDomain and
                HasRepresentative and
                HasFunctionAction
            ),
            ActingDomain, H,
            Representative, g,
            FunctionAction, tc
        );
        return tcc;
    end
);

###############################################################################
##
## \in( g, tcc )
##
##  INPUT:
##      g:          element of a group
##      tcc:        twisted conjugacy class
##
##  OUTPUT:
##      bool:       true if g belongs to tcc, false otherwise
##
InstallMethod(
    \in,
    "for Reidemeister classes",
    [ IsMultiplicativeElementWithInverse, IsReidemeisterClassGroupRep ],
    { g, tcc } -> IsTwistedConjugate(
        tcc!.lhs, tcc!.rhs,
        g, Representative( tcc )
    )
);

###############################################################################
##
## PrintObj( tcc )
##
##  INPUT:
##      tcc:        twisted conjugacy class
##
InstallMethod(
    PrintObj,
    "for Reidemeister classes",
    [ IsReidemeisterClassGroupRep ],
    function( tcc )
        local homStrings, g, hom, homGensImgs;
        homStrings := [];
        g := Representative( tcc );
        for hom in [ tcc!.lhs, tcc!.rhs ] do
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

###############################################################################
##
## Size( tcc )
##
##  INPUT:
##      tcc:        twisted conjugacy class
##
##  OUTPUT:
##      n:          number of elements in tcc (or infinity)
##
InstallMethod(
    Size,
    "for Reidemeister classes",
    [ IsReidemeisterClassGroupRep ],
    tcc -> IndexNC( ActingDomain( tcc ), StabilizerOfExternalSet( tcc ) )
);

###############################################################################
##
## StabilizerOfExternalSet( tcc )
##
##  INPUT:
##      tcc:        twisted conjugacy class
##
##  OUTPUT:
##      Coin:       stabiliser of the representative of tcc, under the twisted
##                  conjugacy action
##
InstallMethod(
    StabilizerOfExternalSet,
    "for Reidemeister classes",
    [ IsReidemeisterClassGroupRep ],
    function( tcc )
        local g, hom1, hom2, G, inn;
        g := Representative( tcc );
        hom1 := tcc!.lhs;
        hom2 := tcc!.rhs;
        G := Range( hom1 );
        inn := InnerAutomorphismNC( G, g );
        return CoincidenceGroup2( hom1 * inn, hom2 );
    end
);

###############################################################################
##
## \=( tcc1, tcc2 )
##
##  INPUT:
##      tcc1:       twisted conjugacy class
##      tcc2:       twisted conjugacy class
##
##  OUTPUT:
##      bool:       true if tcc1 is equal to tcc2, false otherwise
##
InstallMethod(
    \=,
    "for Reidemeister classes",
    [ IsReidemeisterClassGroupRep, IsReidemeisterClassGroupRep ],
    function( tcc1, tcc2 )
        if tcc1!.lhs <> tcc2!.lhs or tcc1!.rhs <> tcc2!.rhs then
            return false;
        fi;
        return IsTwistedConjugate(
            tcc1!.lhs, tcc1!.rhs,
            Representative( tcc1 ), Representative( tcc2 )
        );
    end
);

###############################################################################
##
## ReidemeisterClasses( hom1, hom2, N )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##      N:          normal subgroup of G (optional)
##
##  OUTPUT:
##      L:          list containing the (hom1,hom2)-twisted conjugacy classes,
##                  or fail if there are infinitely many
##
InstallGlobalFunction(
    ReidemeisterClasses,
    function( hom1, arg... )
        local G, hom2, N, Rcl;
        G := Range( hom1 );
        if IsGroupHomomorphism( First( arg ) ) then
            hom2 := First( arg );
        else
            hom2 := IdentityMapping( G );
        fi;
        if IsGroup( Last( arg ) ) then
            N := Last( arg );
        else
            N := G;
        fi;
        Rcl := RepresentativesReidemeisterClasses( hom1, hom2, N );
        if Rcl = fail then
            return fail;
        fi;
        return List( Rcl, g -> ReidemeisterClass( hom1, hom2, g ) );
    end
);

###############################################################################
##
## RepresentativesReidemeisterClasses( hom1, hom2, N )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##      N:          normal subgroup of G (optional)
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class, or fail if there are infinitely
##                  many
##
InstallGlobalFunction(
    RepresentativesReidemeisterClasses,
    function( hom1, arg... )
        local G, H, hom2, N, gens, tc, q, p, Rcl, copy, g, h, pos, i;
        G := Range( hom1 );
        H := Source( hom1 );
        if IsGroupHomomorphism( First( arg ) ) then
            hom2 := First( arg );
        else
            hom2 := IdentityMapping( G );
        fi;
        if IsGroup( Last( arg ) ) then
            N := Last( arg );
        else
            N := G;
        fi;
        gens := GeneratorsOfGroup( H );
        tc := TwistedConjugation( hom1, hom2 );
        if N <> G and not ForAll( gens, h -> tc( One( G ), h ) in N ) then
            q := IdentityMapping( H );
            p := NaturalHomomorphismByNormalSubgroupNC( G, N );
            H := TWC_InducedCoincidenceGroup( q, p, hom1, hom2 );
            hom1 := RestrictedHomomorphism( hom1, H, G );
            hom2 := RestrictedHomomorphism( hom2, H, G );
        fi;
        Rcl := RepresentativesReidemeisterClassesOp( hom1, hom2, N, false );
        if Rcl = fail then
            return fail;
        elif TWC_ASSERT then
            copy := ShallowCopy( Rcl );
            g := Remove( copy );
            while not IsEmpty( copy ) do
                if ForAny( copy, h -> IsTwistedConjugate( hom1, hom2, g, h ) )
                then Error( "Assertion failure" ); fi;
                g := Remove( copy );
            od;
        fi;
        pos := Position( Rcl, One( G ) );
        if pos = fail then
            pos := First(
                [ 1 .. Length( Rcl ) ],
                i -> IsTwistedConjugate( hom1, hom2, Rcl[i] )
            );
        fi;
        if pos > 1 then
            Remove( Rcl, pos );
            Add( Rcl, One( G ), 1 );
        fi;
        return Rcl;
    end
);

###############################################################################
##
## RepresentativesReidemeisterClassesOp( hom1, hom2, N )
##
##  INPUT:
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
InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for trivial subgroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ],
    8,
    function( _hom1, _hom2, N, _one )
        if not IsTrivial( N ) then TryNextMethod(); fi;
        return [ One( N ) ];
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for central subgroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ],
    6,
    function( hom1, hom2, N, one )
        local G, H, diff, D, p;
        G := Range( hom1 );
        if not IsCentral( G, N ) then TryNextMethod(); fi;
        H := Source( hom1 );
        diff := TWC_DifferenceGroupHomomorphisms( hom1, hom2, H, N );
        D := ImagesSource( diff );
        if ( one and N <> D ) or IndexNC( N, D ) = infinity then
            return fail;
        fi;
        p := NaturalHomomorphismByNormalSubgroupNC( N, D );
        return List(
            ImagesSource( p ),
            pn -> PreImagesRepresentativeNC( p, pn )
        );
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for finite source",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ],
    5,
    function( hom1, hom2, N, one )
        local H, tc, N_List, gens, orb;
        H := Source( hom1 );
        if not IsFinite( H ) then TryNextMethod(); fi;
        if not IsFinite( N ) then
            return fail;
        fi;
        tc := TwistedConjugation( hom1, hom2 );
        N_List := AsSSortedListNonstored( N );
        if CanEasilyComputePcgs( H ) then
            gens := Pcgs( H );
        else
            gens := SmallGeneratingSet( H );
        fi;
        if one then
            orb := ExternalOrbit( H, N_List, One( N ), gens, gens, tc );
            if Size( orb ) < Length( N_List ) then
                return fail;
            fi;
            return [ One( N ) ];
        fi;
        return List( ExternalOrbits( H, N_List, gens, gens, tc ), First );
    end
);
