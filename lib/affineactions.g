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
