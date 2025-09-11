###############################################################################
##
## AffineActionByGroupDerivation( K, derv )
##
##  INPUT:
##      K:          subgroup of H
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      act:        affine action of H on G
##
InstallGlobalFunction(
    AffineActionByGroupDerivation,
    { K, derv } -> TWC_FourMapsForAffineAction( K, derv )[4]
);

###############################################################################
##
## OrbitAffineAction( K, g, derv )
##
##  INPUT:
##      K:          subgroup of H
##      g:          element of G
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      orb:        the orbit of g under the affine action of derv
##
InstallGlobalFunction(
    OrbitAffineAction,
    function( K, g, derv )
        local G, map, emb, s, tcc, orb;
        G := Range( derv );
        map := TWC_FourMapsForAffineAction( K, derv );
        emb := map[3];
        s := ImagesRepresentative( emb, g );
        tcc := ReidemeisterClass( map[1], map[2], s );
        orb := rec(
            tcc := tcc,
            emb := emb
        );
        ObjectifyWithAttributes(
            orb, NewType(
                FamilyObj( G ),
                IsOrbitAffineActionRep and
                HasRepresentative and
                HasActingDomain and
                HasFunctionAction
            ),
            Representative, g,
            ActingDomain, K,
            FunctionAction, map[4]
        );
        return orb;
    end
);

###############################################################################
##
## OrbitsAffineAction( K, derv )
##
##  INPUT:
##      K:          subgroup of H
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      L:          list containing the orbits of the affine action of derv, or
##                  "fail" if there are infinitely many
##
InstallGlobalFunction(
    OrbitsAffineAction,
    function( K, derv )
        local G, map, emb, iG, R, reps;
        G := Range( derv );
        map := TWC_FourMapsForAffineAction( K, derv );
        emb := map[3];
        iG := ImagesSet( emb, G );
        R := RepresentativesReidemeisterClasses( map[1], map[2], iG );
        if IsBool( R ) then
            return fail;
        fi;
        reps := List( R, s -> PreImagesRepresentative( emb, s ) );
        return List( reps, g -> OrbitAffineAction( K, g, derv ) );
    end
);

###############################################################################
##
## NrOrbitsAffineAction( K, derv )
##
##  INPUT:
##      K:          subgroup of H
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      R:          the number of orbits of the affine action of derv
##
InstallGlobalFunction(
    NrOrbitsAffineAction,
    function( K, derv )
        local G, map, emb, iG, R;
        G := Range( derv );
        map := TWC_FourMapsForAffineAction( K, derv );
        emb := map[3];
        iG := ImagesSet( emb, G );
        R := RepresentativesReidemeisterClasses( map[1], map[2], iG );
        if IsBool( R ) then
            return infinity;
        fi;
        return Length( R );
    end
);

###############################################################################
##
## StabilizerAffineAction( K, g, derv )
##
##  INPUT:
##      K:          subgroup of H
##      g:          element of G
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      stab:       stabiliser of g under the affine action of derv
##
InstallGlobalFunction(
    StabilizerAffineAction,
    function( K, g, derv )
        local orb;
        orb := OrbitAffineAction( K, g, derv );
        return StabilizerOfExternalSet( orb );
    end
);

###############################################################################
##
## RepresentativeAffineAction( K, g1, g2, derv )
##
##  INPUT:
##      K:          subgroup of H
##      g1:         element of G
##      g2:         element of G
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      k:          element of K that maps g1 to g2 under the affine action of
##                  derv
##
InstallGlobalFunction(
    RepresentativeAffineAction,
    function( K, g1, g2, derv )
        local map, s1, s2;
        map := TWC_FourMapsForAffineAction( K, derv );
        s1 := ImagesRepresentative( map[3], g1 );
        s2 := ImagesRepresentative( map[3], g2 );
        return RepresentativeTwistedConjugation( map[1], map[2], s1, s2 );
    end
);

###############################################################################
##
## \in( orb, g )
##
##  INPUT:
##      orb:        orbit of an affine action
##      g:          element of G
##
##  OUTPUT:
##      bool:       true if g lies in orb, otherwise false
##
InstallMethod(
    \in,
    "for orbits of affine actions",
    [ IsMultiplicativeElementWithInverse, IsOrbitAffineActionRep ],
    function( g, orb )
        local s;
        s := ImagesRepresentative( orb!.emb, g );
        return s in orb!.tcc;
    end
);

###############################################################################
##
## Size( orb )
##
##  INPUT:
##      orb:        orbit of an affine action
##
##  OUTPUT:
##      n:          number of elements in orb (or infinity)
##
InstallMethod(
    Size,
    "for orbits of affine actions",
    [ IsOrbitAffineActionRep ],
    orb -> Size( orb!.tcc )
);

###############################################################################
##
## StabilizerOfExternalSet( orb )
##
##  INPUT:
##      orb:        orbit of an affine action
##
##  OUTPUT:
##      stab:       stabiliser of the representative of orb
##
InstallMethod(
    StabilizerOfExternalSet,
    "for orbits of affine actions",
    [ IsOrbitAffineActionRep ],
    orb -> StabilizerOfExternalSet( orb!.tcc )
);

###############################################################################
##
## PrintObj( orb )
##
##  INPUT:
##      orb:        orbit of an affine action
##
InstallMethod(
    PrintObj,
    "for orbits of affine actions",
    [ IsOrbitAffineActionRep ],
    function( orb )
        Print( "OrbitAffineAction( ", Representative( orb ), " )" );
    end
);
