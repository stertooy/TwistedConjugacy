DeclareGlobalFunction( "TwistedConjugation" );
DeclareGlobalFunction( "IsTwistedConjugate" );
DeclareGlobalFunction( "RepresentativeTwistedConjugation" );
DeclareOperation(
    "RepresentativeTwistedConjugationOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ]
);
