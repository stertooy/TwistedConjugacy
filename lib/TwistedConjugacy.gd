###############################################################################
##
## Declarations
##
DeclareGlobalFunction( "TwistedConjugation" );
DeclareGlobalFunction( "IsTwistedConjugate" );
DeclareGlobalFunction( "RepresentativeTwistedConjugation" );
DeclareOperation(
	"RepTwistConjToId",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ]
);


DeclareGlobalFunction( "ReidemeisterClass" );
DeclareSynonym( "TwistedConjugacyClass", ReidemeisterClass );
DeclareGlobalFunction( "ReidemeisterClasses" );
DeclareSynonym(	"TwistedConjugacyClasses", ReidemeisterClasses );
DeclareRepresentation(
	"IsReidemeisterClassGroupRep",
	IsExternalOrbit,
	[]
);
DeclareAttribute(
	"GroupHomomorphismsOfReidemeisterClass",
	IsReidemeisterClassGroupRep
);


DeclareOperation(
	"RepresentativesReidemeisterClasses",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareSynonym(
	"RepresentativesTwistedConjugacyClasses",
	RepresentativesReidemeisterClasses
);


DeclareGlobalFunction( "ReidemeisterNumber" );
DeclareSynonym(
	"NrTwistedConjugacyClasses",
	ReidemeisterNumber
);
DeclareOperation(
	"ReidemeisterNumberOp",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);


DeclareAttribute(
	"ReidemeisterSpectrum",
	IsGroup
);
DeclareAttribute(
	"ExtendedReidemeisterSpectrum",
	IsGroup
);
DeclareAttribute(
	"CoincidenceReidemeisterSpectrum",
	IsGroup
);
DeclareOperation(
	"CoincidenceReidemeisterSpectrum",
	[ IsGroup, IsGroup ]
);


DeclareOperation(
	"ReidemeisterZetaCoefficients",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ]
);
DeclareOperation(
	"IsRationalReidemeisterZeta",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ]
);
DeclareOperation(
	"ReidemeisterZeta",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ]
);
DeclareOperation(
	"PrintReidemeisterZeta",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ]
);


DeclareGlobalFunction( "CoincidenceGroup" );
DeclareGlobalFunction( "FixedPointGroup" );
DeclareOperation(
	"CoincidenceGroup2",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);


DeclareGlobalFunction( "InducedHomomorphism" );
DeclareGlobalFunction( "RestrictedHomomorphism" );
