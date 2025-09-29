DeclareGlobalName( "ReidemeisterClass" );
DeclareGlobalName( "TwistedConjugacyClass" );

DeclareGlobalName( "ReidemeisterClasses" );
DeclareGlobalName( "TwistedConjugacyClasses" );

DeclareGlobalName( "RepresentativesReidemeisterClasses" );
DeclareGlobalName( "RepresentativesTwistedConjugacyClasses" );

DeclareOperation(
    "RepresentativesReidemeisterClassesOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ]
);
