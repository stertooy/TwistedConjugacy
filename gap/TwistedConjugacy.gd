###############################################################################
##
## Declarations
##
DeclareOperation( "TwistedConjugation",
	[IsGroupHomomorphism, IsGroupHomomorphism] );
DeclareOperation( "IsTwistedConjugate",
	[IsGroupHomomorphism, IsGroupHomomorphism, IsObject, IsObject] );
DeclareOperation( "RepresentativeTwistedConjugation",
	[IsGroupHomomorphism, IsGroupHomomorphism, IsObject, IsObject] );


DeclareOperation( "ReidemeisterClass",
	[IsGroupHomomorphism, IsGroupHomomorphism, IsObject] );
DeclareSynonym( "TwistedConjugacyClass", ReidemeisterClass );
DeclareOperation( "ReidemeisterClasses",
	[IsGroupHomomorphism, IsGroupHomomorphism] );
DeclareSynonym( "TwistedConjugacyClasses", ReidemeisterClasses );
DeclareOperation( "ReidemeisterNumber",
	[IsGroupHomomorphism, IsGroupHomomorphism] );
DeclareSynonym( "NrTwistedConjugacyClasses", ReidemeisterNumber );


DeclareAttribute( "ReidemeisterSpectrum", IsGroup );
DeclareAttribute( "ExtendedReidemeisterSpectrum", IsGroup );


DeclareOperation( "ReidemeisterZeta",
	[IsGroupHomomorphism and IsEndoGeneralMapping] );
DeclareOperation( "PrintReidemeisterZeta",
	[IsGroupHomomorphism and IsEndoGeneralMapping] );
DeclareOperation( "ReidemeisterZetaCoefficients",
	[IsGroupHomomorphism and IsEndoGeneralMapping] );


DeclareOperation( "TwistedConjugacyClassZeta",
	[IsGroupHomomorphism and IsEndoGeneralMapping] );
DeclareOperation( "ConjugacyClassZeta", [IsGroup] );
DeclareOperation( "PrintTwistedConjugacyClassZeta",
	[IsGroupHomomorphism and IsEndoGeneralMapping] );
DeclareOperation( "PrintConjugacyClassZeta", [IsGroup] );
DeclareOperation( "TwistedConjugacyClassZetaCoefficients",
	[IsGroupHomomorphism and IsEndoGeneralMapping] );
DeclareOperation( "ConjugacyClassZetaCoefficients", [IsGroup] );


DeclareOperation( "FixedPointGroup",
	[IsGroupHomomorphism and IsEndoGeneralMapping] );
DeclareOperation( "CoincidenceGroup",
	[IsGroupHomomorphism, IsGroupHomomorphism] );


DeclareGlobalFunction( "InducedEndomorphism" ); 
DeclareGlobalFunction( "RestrictedEndomorphism" );

DeclareOperation( "RepTwistConjToId",
	[IsGroupHomomorphism, IsGroupHomomorphism, IsObject] );


DeclareRepresentation( "IsReidemeisterClassGroupRep", IsExternalOrbit, [] );
DeclareAttribute( "GroupHomomorphismsOfReidemeisterClass",
	IsReidemeisterClassGroupRep );
