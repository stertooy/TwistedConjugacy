###############################################################################
##
## TWC_CreateGroupDerivationInfo( derv, bool )
##
##  INPUT:
##      derv:       group derivation
##      bool:       true if the function should check this is indeed a
##                  derivation
##
##  OUTPUT:
##      info:       record containing useful information
##
BindGlobal(
    "TWC_CreateGroupDerivationInfo",
    function( derv, check )
        local H, G, act, S, embH, embG, gens, imgs, embsH, embsG, rhs;

        H := Source( derv );
        G := Range( derv );
        act := derv!.act;
        S := SemidirectProduct( H, act, G );

        embH := Embedding( S, 1 );
        embG := Embedding( S, 2 );

        if IsBound( derv!.fun ) then
            rhs := GroupHomomorphismByFunction(
                H, S,
                h -> ImagesRepresentative( embH, h ) *
                    ImagesRepresentative( embG, derv!.fun( h ) )
            );
        else
            gens := MappingGeneratorsImages( derv )[1];

            embsH := List( gens, h -> ImagesRepresentative( embH, h ) );
            embsG := List(
                MappingGeneratorsImages( derv )[2],
                g -> ImagesRepresentative( embG, g )
            );

            imgs := List( [ 1 .. Length( gens ) ], i -> embsH[i] * embsG[i] );

            if check then
                rhs := GroupHomomorphismByImages( H, S, gens, imgs );
            else
                rhs := GroupHomomorphismByImagesNC( H, S, gens, imgs );
            fi;
        fi;
        return rec( lhs := embH, rhs := rhs, sdp := S );
    end
);
