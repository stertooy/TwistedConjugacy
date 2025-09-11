DeclareGlobalFunction( "ReidemeisterNumber" );
DeclareSynonym( "NrTwistedConjugacyClasses", ReidemeisterNumber );
DeclareOperation(
    "ReidemeisterNumberOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);
