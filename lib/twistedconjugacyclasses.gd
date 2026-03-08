DeclareGlobalFunction( "TwistedConjugacyClass" );
DeclareSynonym( "ReidemeisterClass", TwistedConjugacyClass );

DeclareGlobalFunction( "TwistedConjugacyClasses" );
DeclareSynonym( "ReidemeisterClasses", TwistedConjugacyClasses );

DeclareGlobalFunction( "RepresentativesTwistedConjugacyClasses" );
DeclareSynonym( "RepresentativesReidemeisterClasses", RepresentativesTwistedConjugacyClasses );

DeclareOperation(
    "RepresentativesTwistedConjugacyClassesOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism, IsGroup, IsBool ]
);
