###############################################################################
##
## ReidemeisterNumberOp( hom1, hom2 )
##
##  INPUT:
##      hom1:       group homomorphism H -> G
##      hom2:       group homomorphism H -> G (optional)
##
##  OUTPUT:
##      R:          Reidemeister number R(hom1,hom2)
##
InstallMethod(
    ReidemeisterNumberOp,
    "for nilpotent-by-finite range",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    2,
    function( hom1, _hom2 )
        local G, H;
        G := Range( hom1 );
        H := Source( hom1 );
        if not (
            IsPcpGroup( H ) and
            IsPcpGroup( G ) and
            IsNilpotentByFinite( G ) and
            HirschLength( H ) < HirschLength( G )
        ) then TryNextMethod(); fi;
        return infinity;
    end
);
