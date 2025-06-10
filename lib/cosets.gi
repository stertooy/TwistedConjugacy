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
        if IsNormal( G, U ) or IsNormal( G, V ) then
            return IndexNC( G, ClosureGroup( U, V ) );
        fi;
        return Length( DoubleCosetsNC( G, U, V ) );
    end
);

