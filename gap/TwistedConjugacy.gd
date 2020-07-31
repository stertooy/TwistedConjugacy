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
	"ReidemeisterZeta",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ]
);
DeclareOperation(
	"PrintReidemeisterZeta",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ]
);
DeclareOperation(
	"ReidemeisterZetaCoefficients",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ]
);


DeclareOperation(
	"TwistedConjugacyClassZeta",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ]
);
DeclareOperation(
	"ConjugacyClassZeta",
	[ IsGroup ]
);
DeclareOperation(
	"PrintTwistedConjugacyClassZeta",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ]
);
DeclareOperation(
	"PrintConjugacyClassZeta",
	[ IsGroup ]
);
DeclareOperation(
	"TwistedConjugacyClassZetaCoefficients",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ]
);
DeclareOperation(
	"ConjugacyClassZetaCoefficients",
	[ IsGroup ]
);


DeclareOperation(
	"FixedPointGroup",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ]
);
DeclareOperation(
	"CoincidenceGroup",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareOperation(
	"PowerSubgroup",
	[ IsGroup, IsPosInt ]
);


DeclareGlobalFunction( "InducedHomomorphism" ); 
DeclareGlobalFunction( "InducedEndomorphism" ); 
DeclareGlobalFunction( "RestrictedHomomorphism" );
DeclareGlobalFunction( "RestrictedEndomorphism" );


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
