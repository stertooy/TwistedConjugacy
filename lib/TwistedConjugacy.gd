###############################################################################
##
## Declarations
##
DeclareGlobalFunction( "TwistedConjugation" );
DeclareOperation(
	"RepTwistConjToId",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ]
);
DeclareGlobalFunction( "RepresentativeTwistedConjugation" );
DeclareGlobalFunction( "IsTwistedConjugate" );


DeclareGlobalFunction( "ReidemeisterClass" );
DeclareSynonym( "TwistedConjugacyClass", ReidemeisterClass );


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


DeclareGlobalFunction( "ReidemeisterClasses" );
DeclareSynonym(	"TwistedConjugacyClasses", ReidemeisterClasses );


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
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareOperation(
	"IsRationalReidemeisterZeta",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareOperation(
	"ReidemeisterZeta",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareOperation(
	"PrintReidemeisterZeta",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);


DeclareGlobalFunction( "FixedPointGroup" );
DeclareGlobalFunction( "CoincidenceGroup" );
DeclareOperation(
	"CoincidenceGroup2",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);


DeclareGlobalFunction( "InducedHomomorphism" );
DeclareGlobalFunction( "RestrictedHomomorphism" );
