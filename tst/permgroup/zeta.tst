gap> START_TEST( "Testing TwistedConjugacy for PcGroups: endomorphisms" );

#
gap> G := Group( [ (11,16)(12,15)(13,14), (2,4)(3,6)(5,9)(7,8), (1,2,4)(3,5,7)(6,8,9), (1,3,6)(2,5,8)(4,7,9), (10,11,12,13,14,15,16) ] );;
gap> gens := GeneratorsOfGroup( G );;
gap> imgs1 := [ G.1*G.5^6, G.1*G.2*G.3^2*G.4^2*G.5^6, G.3^2, G.3*G.4^2, One( G ) ];;
gap> imgs2 := [ One( G ), G.2*G.3*G.4, G.3, G.3^2*G.4, One( G ) ];;
gap> endo1 := GroupHomomorphismByImagesNC( G, G, gens, imgs1 );;
gap> endo2 := GroupHomomorphismByImagesNC( G, G, gens, imgs2 );;

#
gap> IsRationalReidemeisterZeta( endo1, endo2 );
true
gap> zeta := ReidemeisterZeta( endo1, endo2 );;
gap> zeta( 10/3 );
109418989131512359209/311973482284542371301330321821976049
gap> PrintReidemeisterZeta( endo1, endo2 );
"(1-s)^(-42)"
gap> ReidemeisterZetaCoefficients( endo1, endo2 );
[ [ 42 ], [  ] ]

#
gap> IsRationalReidemeisterZeta( endo1 );
true
gap> zeta1 := ReidemeisterZeta( endo1 );;
gap> zeta1( 10/3 );
-531441/206851765939
gap> PrintReidemeisterZeta( endo1 );
"(1-s)^(-4)*(1-s^2)^(-1)*(1-s^3)^(-2)"
gap> ReidemeisterZetaCoefficients( endo1 );
[ [ 4, 6, 10, 6, 4, 12 ], [  ] ]

#
gap> IsRationalReidemeisterZeta( endo2 );
true
gap> zeta2 := ReidemeisterZeta( endo2 );;
gap> zeta2( 10/3 );
729/333739
gap> PrintReidemeisterZeta( endo2 );
"(1-s)^(-3)*(1-s^3)^(-1)"
gap> ReidemeisterZetaCoefficients( endo2 );
[ [ 3, 3, 6 ], [  ] ]

#
gap> D := DerivedSubgroup( G );;
gap> endo1D := RestrictedHomomorphism( endo1, D, D );;
gap> endo2D := RestrictedHomomorphism( endo2, D, D );;

#
gap> IsRationalReidemeisterZeta( endo1D, endo2D );
true
gap> zeta := ReidemeisterZeta( endo1D, endo2D );;
gap> zeta( 10/3 );
-1144561273430837494885949696427/
5872800730587046310315302901773887552120493728995593112131303
gap> PrintReidemeisterZeta( endo1D, endo2D );
"(1-s)^(-7)*(1-s^2)^(-28)"
gap> ReidemeisterZetaCoefficients( endo1D, endo2D );
[ [ 7, 63 ], [  ] ]

#
gap> IsRationalReidemeisterZeta( endo1D );
true
gap> zeta1 := ReidemeisterZeta( endo1D );;
gap> zeta1( 10/3 );
-19683/636535627
gap> PrintReidemeisterZeta( endo1D );
"(1-s)^(-1)*(1-s^2)^(-1)*(1-s^6)^(-1)"
gap> ReidemeisterZetaCoefficients( endo1D );
[ [ 1, 3, 1, 3, 1, 9 ], [  ] ]

#
gap> IsRationalReidemeisterZeta( endo2D );
true
gap> zeta2 := ReidemeisterZeta( endo2D );;
gap> zeta2( 10/3 );
-19683/324728047
gap> PrintReidemeisterZeta( endo2D );
"(1-s)^(-3)*(1-s^3)^(-2)"
gap> ReidemeisterZetaCoefficients( endo2D );
[ [ 3, 3, 9 ], [  ] ]

#
gap> STOP_TEST( "endomorphisms.tst" );