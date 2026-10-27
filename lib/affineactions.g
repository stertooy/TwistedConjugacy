###############################################################################
##
## IsOrbitAffineActionRep
##
DeclareRepresentation(
    "IsOrbitAffineActionRep",
    IsExternalOrbit and IsOrbitAffineAction
);

###############################################################################
##
## FourMapsForAffineAction( K, derv )
##
##  INPUT:
##      K:          subgroup of H
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      lhs:        group homomorphism K -> S
##      rhs:        group homomorphism K -> S
##      emb:        group homomorphism G -> S
##      fnc:        affine action of K on G
##
TWC.FourMapsForAffineAction := function( K, derv )
    local info, S, lhs, rhs, emb, tc, inv, fnc;
    info := GroupDerivationInfo( derv );
    S := info!.sdp;
    lhs := info!.lhs;
    rhs := info!.rhs;
    if K <> Source( derv ) then
        lhs := RestrictedHomomorphism( lhs, K, S );
        rhs := RestrictedHomomorphism( rhs, K, S );
    fi;
    emb := Embedding( S, 2 );
    tc := TwistedConjugation( lhs, rhs );
    inv := RestrictedInverseGeneralMapping( emb );
    fnc := function( g, k )
        local s, t;
        s := ImagesRepresentative( emb, g );
        t := tc( s, k );
        return ImagesRepresentative( inv, t );
    end;
    return [ lhs, rhs, emb, fnc ];
end;

###############################################################################
##
## AffineOrbitData( K, derv )
##
##  INPUT:
##      K:          subgroup of H
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      data:       record
##
TWC.AffineOrbitData := function( K, derv )
    local G, map, iG, R;
    G := Range( derv );
    map := TWC.FourMapsForAffineAction( K, derv );
    iG := ImagesSet( map[ 3 ], G );
    R := RepresentativesTwistedConjugacyClasses( map[ 1 ], map[ 2 ], iG );
    return rec( maps := map, reps := R );
end;

###############################################################################
##
## OrbitAffineActionByMaps( K, g, map )
##
##  INPUT:
##      K:          subgroup of H
##      g:          element of G
##      map:        maps from FourMapsForAffineAction
##
##  OUTPUT:
##      orb:        affine orbit of g
##
TWC.OrbitAffineActionByMaps := function( K, g, map )
    local emb, s, tcc, orb;
    emb := map[ 3 ];
    s := ImagesRepresentative( emb, g );
    tcc := TwistedConjugacyClass( map[ 1 ], map[ 2 ], s );
    orb := rec(
        tcc := tcc,
        emb := emb
    );
    ObjectifyWithAttributes(
        orb, NewType(
            FamilyObj( Source( emb ) ),
            IsOrbitAffineActionRep and
            HasRepresentative and
            HasActingDomain and
            HasFunctionAction
        ),
        Representative, g,
        ActingDomain, K,
        FunctionAction, map[ 4 ]
    );
    return orb;
end;
