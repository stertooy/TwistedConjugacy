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
