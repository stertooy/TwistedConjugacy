###############################################################################
##
## Declarations
##
DeclareGlobalFunction( "TwistedConjugation" );
DeclareGlobalFunction( "IsTwistedConjugate" );
DeclareGlobalFunction( "RepresentativeTwistedConjugation" );
DeclareOperation(
    "RepresentativeTwistedConjugationOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ]
);
DeclareGlobalFunction( "IsTwistedConjugateMultiple" );
DeclareGlobalFunction( "RepresentativeTwistedConjugationMultiple" );
DeclareOperation(
    "RepresentativeTwistedConjugationMultOp",
    [ IsList, IsList, IsList, IsList ]
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
DeclareSynonym( "TwistedConjugacyClasses", ReidemeisterClasses );
DeclareGlobalFunction( "RepresentativesReidemeisterClasses" );
DeclareSynonym(
    "RepresentativesTwistedConjugacyClasses",
    RepresentativesReidemeisterClasses
);
DeclareOperation(
    "RepresentativesReidemeisterClassesOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
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
DeclareGlobalFunction( "FullReidemeisterSpectrum" );
DeclareOperation(
    "FullReidemeisterSpectrumOp",
    [ IsGroup ]
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


DeclareGlobalFunction( "RepresentativesHomomorphismClasses" );
DeclareOperation(
    "RepresentativesHomomorphismClassesOp",
    [ IsGroup, IsGroup ]
);
DeclareGlobalFunction( "RepresentativesEndomorphismClasses" );
DeclareOperation(
    "RepresentativesEndomorphismClassesOp",
    [ IsGroup ]
);
DeclareGlobalFunction( "RepresentativesAutomorphismClasses" );
DeclareOperation(
    "RepresentativesAutomorphismClassesOp",
    [ IsGroup ]
);


DeclareGlobalFunction( "FixedPointGroup" );
DeclareGlobalFunction( "CoincidenceGroup" );
DeclareOperation(
    "CoincidenceGroup2",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);


DeclareGlobalFunction( "InducedHomomorphism" );
DeclareGlobalFunction( "RestrictedHomomorphism" );


DeclareProperty( "IsNilpotentByFinite", IsGroup );
InstallTrueMethod( IsNilpotentByFinite, IsNilpotentGroup );
InstallTrueMethod( IsNilpotentByFinite, IsGroup and IsFinite );
DeclareProperty( "IsPolycyclicByFinite", IsGroup );
InstallTrueMethod( IsPolycyclicByFinite, IsPolycyclicGroup );
InstallTrueMethod( IsPolycyclicByFinite, IsGroup and IsFinite );
DeclareProperty( "IsNilpotentByAbelian", IsGroup );
InstallTrueMethod( IsNilpotentByAbelian, IsNilpotentGroup );
