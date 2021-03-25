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


DeclareOperation(
	"ReidemeisterClass",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ]
);
DeclareSynonym(
	"TwistedConjugacyClass",
	ReidemeisterClass 
);
DeclareOperation(
	"ReidemeisterClasses",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareSynonym(
	"TwistedConjugacyClasses",
	ReidemeisterClasses
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


DeclareOperation(
	"ReidemeisterZetaCoefficients",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ]
);
DeclareOperation(
	"HasRationalReidemeisterZeta",
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
	"FixedPointGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ]
);
DeclareOperation(
	"CoincidenceGroup",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);


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
DeclareAttribute(
	"ActingCodomain",
	IsReidemeisterClassGroupRep
);
