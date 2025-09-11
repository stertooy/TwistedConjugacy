###############################################################################
##
## IsNilpotentByAbelian( G )
##
##  INPUT:
##      G:          group
##
##  OUTPUT:
##      bool:       true iff G is nilpotent-by-abelian
##
InstallMethod(
    IsNilpotentByAbelian,
    [ IsGroup ],
    G -> IsNilpotentGroup( DerivedSubgroup( G ) )
);
