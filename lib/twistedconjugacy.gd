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

DeclareGlobalFunction( "ReidemeisterClass" );
DeclareSynonym( "TwistedConjugacyClass", ReidemeisterClass );
DeclareRepresentation( "IsReidemeisterClassGroupRep", IsExternalOrbit );

DeclareGlobalFunction( "ReidemeisterClasses" );
DeclareSynonym( "TwistedConjugacyClasses", ReidemeisterClasses );
DeclareGlobalFunction( "RepresentativesReidemeisterClasses" );
DeclareSynonym(
    "RepresentativesTwistedConjugacyClasses",
    RepresentativesReidemeisterClasses
);
DeclareOperation(
    "RepresentativesReidemeisterClassesOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ]
);

DeclareGlobalFunction( "ReidemeisterNumber" );
DeclareSynonym( "NrTwistedConjugacyClasses", ReidemeisterNumber );
DeclareOperation(
    "ReidemeisterNumberOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);

DeclareGlobalFunction( "ReidemeisterSpectrum" );
DeclareOperation( "ReidemeisterSpectrumOp", [ IsGroup ] );
DeclareGlobalFunction( "ExtendedReidemeisterSpectrum" );
DeclareOperation( "ExtendedReidemeisterSpectrumOp", [ IsGroup ] );
DeclareGlobalFunction( "CoincidenceReidemeisterSpectrum" );
DeclareOperation( "CoincidenceReidemeisterSpectrumOp", [ IsGroup, IsGroup ] );
DeclareGlobalFunction( "TotalReidemeisterSpectrum" );
DeclareOperation( "TotalReidemeisterSpectrumOp", [ IsGroup ] );

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
DeclareGlobalFunction( "InducedCoincidenceGroup" );

DeclareGlobalFunction( "InducedHomomorphism" );
DeclareGlobalFunction( "RestrictedHomomorphism" );
DeclareGlobalFunction( "InclusionHomomorphism" );
DeclareGlobalFunction( "DifferenceGroupHomomorphisms" );

DeclareProperty( "IsNilpotentByAbelian", IsGroup );
InstallTrueMethod( IsNilpotentByAbelian, IsNilpotentGroup );

DeclareCategory( "IsGroupDerivation", IsSPGeneralMapping );
InstallTrueMethod( IsMapping, IsGroupDerivation );
InstallTrueMethod( RespectsOne, IsGroupDerivation );

DeclareAttribute( "GroupDerivationInfo", IsGroupDerivation );
DeclareAttribute( "KernelOfGroupDerivation", IsGroupDerivation );

DeclareGlobalFunction( "GroupDerivationByImagesNC" );
DeclareGlobalFunction( "GroupDerivationByImages" );
DeclareRepresentation( "IsGroupDerivationByImages", IsAttributeStoringRep );
InstallTrueMethod( IsGroupDerivation, IsGroupDerivationByImages );

DeclareGlobalFunction( "GroupDerivationByFunction" );
DeclareRepresentation( "IsGroupDerivationByFunction", IsAttributeStoringRep );
InstallTrueMethod( IsGroupDerivation, IsGroupDerivationByFunction );

DeclareRepresentation( "IsGroupDerivationImageRep", IsExternalOrbit );

DeclareGlobalFunction( "DoubleCosetIndex" );
DeclareOperation( "DoubleCosetIndexNC", [ IsGroup, IsGroup, IsGroup ] );

DeclareGlobalFunction( "IntersectionOfKernels" );
DeclareGlobalFunction( "IntersectionOfPreImages" );
