###############################################################################
##
## TWC_FourMapsForAffineAction( K, derv )
##
##  INPUT:
##      K:          subgroup of H
##      derv:       group derivation H -> G
##
##  OUTPUT:
##      lhs:        group homomorphism H -> S
##      rhs:        group homomorphism H -> S
##      emb:        group homomorphism G -> S
##      fnc:        affine action of H on G
##
BindGlobal(
    "TWC_FourMapsForAffineAction",
    function( K, derv )
        local info, S, lhs, rhs, emb, fnc;
        info := GroupDerivationInfo( derv );
        S := info!.sdp;
        lhs := info!.lhs;
        rhs := info!.rhs;
        if K <> Source( derv ) then
            lhs := RestrictedHomomorphism( lhs, K, S );
            rhs := RestrictedHomomorphism( rhs, K, S );
        fi;
        emb := Embedding( S, 2 );
        fnc := function( g, k )
            local tc, inv, s, t;
            tc := TwistedConjugation( lhs, rhs );
            inv := RestrictedInverseGeneralMapping( emb );
            s := ImagesRepresentative( emb, g );
            t := tc( s, k );
            return ImagesRepresentative( inv, t );
        end;
        return [ lhs, rhs, emb, fnc ];
    end
);
