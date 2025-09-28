DeclareCategory( "IsGroupDerivation", IsSPGeneralMapping );
InstallTrueMethod( IsMapping, IsGroupDerivation );
InstallTrueMethod( RespectsOne, IsGroupDerivation );

DeclareAttribute( "GroupDerivationInfo", IsGroupDerivation );
DeclareAttribute( "KernelOfGroupDerivation", IsGroupDerivation );

DeclareGlobalFunction( "GroupDerivationByImagesNC" );
DeclareGlobalFunction( "GroupDerivationByImages" );
DeclareGlobalFunction( "GroupDerivationByFunction" );

DeclareGlobalFunction( "GroupDerivationByAffineAction" );

DeclareProperty( "IsGroupDerivationImage", IsOrbitAffineAction );
