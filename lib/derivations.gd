DeclareCategory( "IsGroupDerivation", IsSPGeneralMapping );
InstallTrueMethod( IsMapping, IsGroupDerivation );
InstallTrueMethod( RespectsOne, IsGroupDerivation );

DeclareAttribute( "GroupDerivationInfo", IsGroupDerivation );
DeclareAttribute( "KernelOfGroupDerivation", IsGroupDerivation );

DeclareGlobalName( "GroupDerivationByImagesNC" );
DeclareGlobalName( "GroupDerivationByImages" );
DeclareGlobalName( "GroupDerivationByFunction" );
DeclareGlobalName( "GroupDerivationByAffineAction" );

DeclareProperty( "IsGroupDerivationImage", IsOrbitAffineAction );
