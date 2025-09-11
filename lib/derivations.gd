DeclareCategory( "IsGroupDerivation", IsSPGeneralMapping );
InstallTrueMethod( IsMapping, IsGroupDerivation );
InstallTrueMethod( RespectsOne, IsGroupDerivation );

DeclareAttribute( "GroupDerivationInfo", IsGroupDerivation );
DeclareAttribute( "KernelOfGroupDerivation", IsGroupDerivation );

DeclareGlobalFunction( "GroupDerivationByImagesNC" );
DeclareGlobalFunction( "GroupDerivationByImages" );
DeclareRepresentation( "IsGroupDerivationByImages", IsAttributeStoringRep );
InstallTrueMethod( IsGroupDerivation, IsGroupDerivationByImages );

DeclareGlobalFunction( "GroupDerivationByFunction" );
DeclareRepresentation( "IsGroupDerivationByFunction", IsAttributeStoringRep );
InstallTrueMethod( IsGroupDerivation, IsGroupDerivationByFunction );

DeclareGlobalFunction( "GroupDerivationByAffineAction" );

DeclareProperty( "IsGroupDerivationImage", IsOrbitAffineActionRep );
