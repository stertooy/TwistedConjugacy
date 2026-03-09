#! @Chapter twistedconjugacyclasses

#! @Section tcc_calc

#! @BeginExample
tcc := TwistedConjugacyClass( phi, psi, g1 );
#! (4,6,5)^G
Representative( tcc );
#! (4,6,5)
ActingDomain( tcc ) = H;
#! true
FunctionAction( tcc )( g1, h );
#! (1,6,4,2)(3,5)
List( tcc );
#! [ (4,6,5), (1,6,4,2)(3,5) ]
Size( tcc );
#! 2
StabiliserOfExternalSet( tcc );
#! Group([ (1,2,3,4,5), (1,3,4,5,2) ])
TwistedConjugacyClasses( phi, psi ){ [ 1 .. 7 ] };
#! [ ()^G, (4,5,6)^G, (4,6,5)^G, (3,4)(5,6)^G, (3,4,5)^G, (3,4,6)^G, (3,5,4)^G ]
RepresentativesTwistedConjugacyClasses( phi, psi ){ [ 1 .. 7 ] };
#! [ (), (4,5,6), (4,6,5), (3,4)(5,6), (3,4,5), (3,4,6), (3,5,4) ]
NrTwistedConjugacyClasses( phi, psi );
#! 184
#! @EndExample
