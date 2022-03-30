###############################################################################
##
## Declarations
##
DeclareProperty( "IsCrystallographic", IsGroup );
InstallTrueMethod( IsCrystallographic, IsGroup and IsFreeAbelian );
InstallTrueMethod( IsNilpotentByFinite, IsCrystallographic );
