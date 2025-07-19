###############################################################################
##
## DoubleCosetIndex( G, U, V )
##
##  INPUT:
##      G:          group
##      U:          subgroup of G
##      V:          subgroup of G
##
##  OUTPUT:
##      ind:        double coset index of (U,V)
##
InstallGlobalFunction(
    DoubleCosetIndex,
    function( G, U, V )
        if not ( IsSubset( G, U ) and IsSubset( G, V ) ) then
            Error( "not contained" );
        fi;
        return DoubleCosetIndexNC( G, U, V );
    end
);

###############################################################################
##
## DoubleCosetIndexNC( G, U, V )
##
##  INPUT:
##      G:          group
##      U:          subgroup of G
##      V:          subgroup of G
##
##  OUTPUT:
##      ind:        double coset index of (U,V)
##
InstallMethod(
    DoubleCosetIndexNC,
    "for two subgroups",
    [ IsGroup, IsGroup, IsGroup ],
    function( G, U, V )
        local DCS;
        if IsNormal( U, V ) or IsNormal( V, U ) then
            return IndexNC( G, ClosureGroup( U, V ) );
        fi;
        DCS := DoubleCosetsNC( G, U, V );
        if DCS = fail then
            return infinity;
        fi;
        return Length( DCS );
    end
);
