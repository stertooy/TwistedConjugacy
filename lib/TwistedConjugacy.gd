###############################################################################
##
## Declarations
##
DeclareOperation(
	"TwistedConjugation",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareOperation(
	"IsTwistedConjugate",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ]
);
DeclareOperation(
	"RepresentativeTwistedConjugation",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ]
);


DeclareGlobalFunction( "ReidemeisterClass" );
DeclareSynonym( "TwistedConjugacyClass", ReidemeisterClass );
DeclareGlobalFunction( "ReidemeisterClasses" );
DeclareSynonym(	"TwistedConjugacyClasses", ReidemeisterClasses );
DeclareOperation(
	"RepresentativesReidemeisterClasses",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareSynonym(
	"RepresentativesTwistedConjugacyClasses",
	RepresentativesReidemeisterClasses
);
DeclareOperation(
	"ReidemeisterNumber",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareSynonym(
	"NrTwistedConjugacyClasses",
	ReidemeisterNumber
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


DeclareOperation(
	"CoincidenceGroup2",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareGlobalFunction( "CoincidenceGroup" );
DeclareGlobalFunction( "FixedPointGroup" );

DeclareGlobalFunction( "InducedHomomorphism" );
DeclareGlobalFunction( "RestrictedHomomorphism" );


DeclareOperation(
	"RepTwistConjToId",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ]
);


DeclareRepresentation(
	"IsReidemeisterClassGroupRep",
	IsExternalOrbit,
	[]
);
DeclareAttribute(
	"GroupHomomorphismsOfReidemeisterClass",
	IsReidemeisterClassGroupRep
);
