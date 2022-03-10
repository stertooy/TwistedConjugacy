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
DeclareRepresentation(
	"IsReidemeisterClassGroupRep",
	IsExternalOrbit,
	[]
);
DeclareAttribute(
	"GroupHomomorphismsOfReidemeisterClass",
	IsReidemeisterClassGroupRep
);


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


DeclareGlobalFunction( "ReidemeisterNumber" );
DeclareSynonym(
	"NrTwistedConjugacyClasses",
	ReidemeisterNumber
);
DeclareOperation(
	"ReidemeisterNumberOp",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);


DeclareGlobalFunction( "ReidemeisterSpectrum" );
DeclareOperation(
	"ReidemeisterSpectrumOp",
	[ IsGroup ]
);
DeclareGlobalFunction( "ExtendedReidemeisterSpectrum" );
DeclareOperation(
	"ExtendedReidemeisterSpectrumOp",
	[ IsGroup ]
);
DeclareGlobalFunction( "CoincidenceReidemeisterSpectrum" );
DeclareOperation(
	"CoincidenceReidemeisterSpectrumOp",
	[ IsGroup, IsGroup ]
);


DeclareGlobalFunction( "ReidemeisterZetaCoefficients" );
DeclareOperation(
	"ReidemeisterZetaCoefficientsOp",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareGlobalFunction( "IsRationalReidemeisterZeta" );
DeclareOperation(
	"IsRationalReidemeisterZetaOp",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareGlobalFunction( "ReidemeisterZeta" );
DeclareOperation(
	"ReidemeisterZetaOp",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);
DeclareGlobalFunction( "PrintReidemeisterZeta" );
DeclareOperation(
	"PrintReidemeisterZetaOp",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);

DeclareOperation(
	"RepresentativesHomomorphismClasses",
	[ IsGroup, IsGroup ]
);


DeclareGlobalFunction( "FixedPointGroup" );
DeclareGlobalFunction( "CoincidenceGroup" );
DeclareOperation(
	"CoincidenceGroup2",
	[ IsGroupHomomorphism, IsGroupHomomorphism ]
);


DeclareGlobalFunction( "InducedHomomorphism" );
DeclareGlobalFunction( "RestrictedHomomorphism" );
