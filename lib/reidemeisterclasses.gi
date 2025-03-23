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
    function( g, tcc )
        local hom;
        hom := GroupHomomorphismsOfReidemeisterClass( tcc );
        return IsTwistedConjugate(
            hom[1], hom[2],
            g, Representative( tcc )
        );
    end
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


###############################################################################
##
## Random( rs, tcc )
##
##  INPUT:
##      rs:         random generator
##      tcc:        twisted conjugacy class
##
##  OUTPUT:
##      g:          random element of tcc
##
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
    function( tcc )
        local H, Coin;
        H := ActingDomain( tcc );
        Coin := StabilizerOfExternalSet( tcc );
        return IndexNC( H, Coin );
    end
);


###############################################################################
##
## ListOp( tcc )
##
##  INPUT:
##      tcc:        twisted conjugacy class
##
##  OUTPUT:
##      L:          list containing the elements of tcc, or fail if tcc has
##                  infinitely many elements
##
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
## ReidemeisterClasses( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##
##  OUTPUT:
##      L:          list containing the (hom1,hom2)-twisted conjugacy classes,
##                  or fail if there are infinitely many
##
InstallGlobalFunction(
    ReidemeisterClasses,
    function( hom1, arg... )
        local G, hom2, Rcl, copy, g, h;
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
## RepresentativesReidemeisterClasses( hom1, hom2, N )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G
##      N:          normal subgroup of G with hom1(h)^-1*hom2(h) in N
##                  for all h in H
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class, or fail if there are infinitely
##                  many
##
InstallGlobalFunction(
    RepresentativesReidemeisterClasses,
    function( hom1, arg... )
        local G, hom2, Rcl, copy, g, h, pos, i;
        G := Range( hom1 );
        if Length( arg ) = 0 then
            hom2 := IdentityMapping( G );
        else
            hom2 := arg[1];
        fi;
        Rcl := RepresentativesReidemeisterClassesOp( hom1, hom2, G );
        if Rcl = fail then
            return fail;
        elif ASSERT@ then
            copy := ShallowCopy( Rcl );
            g := Remove( copy );
            while not IsEmpty( copy ) do
                if ForAny( copy, h -> IsTwistedConjugate( hom1, hom2, g, h ) )
                then Error("Assertion failure"); fi;
                g := Remove( copy );
            od;
        fi;
        pos := Position( Rcl, One( G ) );
        if pos = fail then
            pos := First(
                [1..Length( Rcl )],
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
##      N:          normal subgroup of G with hom1(h)^-1*hom2(h) in N
##                  for all h in H
##
##  OUTPUT:
##      L:          list containing a representative of each (hom1,hom2)-
##                  twisted conjugacy class, or fail if there are infinitely
##                  many
##
InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for trivial subgroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    6,
    function( hom1, hom2, N )
        if not IsTrivial( N ) then TryNextMethod(); fi;
        return [ One( N ) ];
    end
);

InstallMethod(
    RepresentativesReidemeisterClassesOp,
    "for central subgroup",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    4,
    function( hom1, hom2, N )
        local G, H, diff, D, p, pn;
        G := Range( hom1 );
        H := Source( hom1 );
        if not IsCentral( G, N ) then TryNextMethod(); fi;
        diff := DifferenceGroupHomomorphisms@( hom1, hom2, H, N );
        D := ImagesSource( diff );
        if IndexNC( N, D ) = infinity then return fail; fi;
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
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup ],
    3,
    function( hom1, hom2, N )
        local G, H, Rcl, tc, N_List, gens, orbits;
        G := Range( hom1 );
        H := Source( hom1 );
        if not IsFinite( H ) then TryNextMethod(); fi;
        if not IsFinite( N ) then return fail; fi;
        Rcl := [];
        tc := TwistedConjugation( hom1, hom2 );
        N_List := AsSSortedListNonstored( N );
        if CanEasilyComputePcgs( H ) then
            gens := Pcgs( H );
        else
            gens := SmallGeneratingSet( H );
        fi;
        orbits := OrbitsDomain( H, N_List, gens, gens, tc );
        return ListX( orbits, First );
    end
);
