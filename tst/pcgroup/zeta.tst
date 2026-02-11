gap> START_TEST( "Testing TwistedConjugacy for PcGroups: zeta functions" );

#
gap> filt := IsPcGroup;;
gap> G := PcGroupCode( 57308604420143, 252 );;
gap> s := Indeterminate( Rationals, "s" );;
gap> gens := GeneratorsOfGroup( G );;
gap> imgs1 := [ G.1*G.5^6, G.1*G.2*G.3^2*G.4^2*G.5^6, G.3^2, G.3*G.4^2, One( G ) ];;
gap> imgs2 := [ One( G ), G.2*G.3*G.4, G.3, G.3^2*G.4, One( G ) ];;
gap> endo1 := GroupHomomorphismByImages( G, G, gens, imgs1 );;
gap> endo2 := GroupHomomorphismByImages( G, G, gens, imgs2 );;

#
gap> IteratedReidemeisterNumberDecomposition( endo1, endo2 );
[ [ 42 ], [  ] ]
gap> IsRationalReidemeisterZetaFunction( endo1, endo2 );
true
gap> zeta := ReidemeisterZetaFunction( endo1, endo2 );;
gap> zeta( 10/3 );
109418989131512359209/311973482284542371301330321821976049
gap> PrintReidemeisterZetaFunction( endo1, endo2 );
"(1-s)^(-42)"
gap> IsRationalReidemeisterGeneratingFunction( endo1, endo2 );
true
gap> genr := ReidemeisterGeneratingFunction( endo1, endo2 );;
gap> genr( 10/3 );
-60
gap> PrintReidemeisterGeneratingFunction( endo1, endo2 );
"(42*s)/(-s+1)"

#
gap> IteratedReidemeisterNumberDecomposition( endo1 );
[ [ 4, 6, 10, 6, 4, 12 ], [  ] ]
gap> IsRationalReidemeisterZetaFunction( endo1 );
true
gap> zeta1 := ReidemeisterZetaFunction( endo1 );;
gap> zeta1( 10/3 );
-531441/206851765939
gap> PrintReidemeisterZetaFunction( endo1 );
"(1-s)^(-4)*(1-s^2)^(-1)*(1-s^3)^(-2)"
gap> IsRationalReidemeisterGeneratingFunction( endo1 );
true
gap> genr := ReidemeisterGeneratingFunction( endo1 );;
gap> genr( 10/3 );
-25440/1807
gap> PrintReidemeisterGeneratingFunction( endo1 );
"(12*s^4+16*s^3+10*s^2+4*s)/(-s^4-s^3+s+1)"

#
gap> IteratedReidemeisterNumberDecomposition( endo2 );
[ [ 3, 3, 6 ], [  ] ]
gap> IsRationalReidemeisterZetaFunction( endo2 );
true
gap> zeta2 := ReidemeisterZetaFunction( endo2 );;
gap> zeta2( 10/3 );
729/333739
gap> PrintReidemeisterZetaFunction( endo2 );
"(1-s)^(-3)*(1-s^3)^(-1)"
gap> IsRationalReidemeisterGeneratingFunction( endo2 );
true
gap> genr := ReidemeisterGeneratingFunction( endo2 );;
gap> genr( 10/3 );
-7170/973
gap> PrintReidemeisterGeneratingFunction( endo2 );
"(6*s^3+3*s^2+3*s)/(-s^3+1)"

#
gap> D := DerivedSubgroup( G );;
gap> endo1D := RestrictedHomomorphism( endo1, D, D );;
gap> endo2D := RestrictedHomomorphism( endo2, D, D );;

#
gap> IsRationalReidemeisterZetaFunction( endo1D, endo2D );
true
gap> zeta := ReidemeisterZetaFunction( endo1D, endo2D );;
gap> zeta( 10/3 );
-1144561273430837494885949696427/
5872800730587046310315302901773887552120493728995593112131303
gap> PrintReidemeisterZetaFunction( endo1D, endo2D );
"(1-s)^(-7)*(1-s^2)^(-28)"
gap> IteratedReidemeisterNumberDecomposition( endo1D, endo2D );
[ [ 7, 63 ], [  ] ]

#
gap> IsRationalReidemeisterZetaFunction( endo1D );
true
gap> zeta1 := ReidemeisterZetaFunction( endo1D );;
gap> zeta1( 10/3 );
-19683/636535627
gap> PrintReidemeisterZetaFunction( endo1D );
"(1-s)^(-1)*(1-s^2)^(-1)*(1-s^6)^(-1)"
gap> IteratedReidemeisterNumberDecomposition( endo1D );
[ [ 1, 3, 1, 3, 1, 9 ], [  ] ]

#
gap> IsRationalReidemeisterZetaFunction( endo2D );
true
gap> zeta2 := ReidemeisterZetaFunction( endo2D );;
gap> zeta2( 10/3 );
-19683/324728047
gap> PrintReidemeisterZetaFunction( endo2D );
"(1-s)^(-3)*(1-s^3)^(-2)"
gap> IteratedReidemeisterNumberDecomposition( endo2D );
[ [ 3, 3, 9 ], [  ] ]

#
gap> C4 := CyclicGroup( filt, 4 );;
gap> hom1C4 := GroupHomomorphismByImages( C4, C4, [ C4.1 ], [ C4.1^2 ] );;
gap> hom2C4 := GroupHomomorphismByImages( C4, C4, [ C4.1 ], [ One( C4 ) ] );;
gap> IteratedReidemeisterNumberDecomposition( hom1C4, hom2C4 );
[ [ 4 ], [ -2 ] ]
gap> PrintReidemeisterZetaFunction( hom1C4, hom2C4 );
"exp(-2*s)*(1-s)^(-4)"

#
gap> G4 := AbelianGroup( filt, [ 2, 2, 4 ] );;
gap> hom1G4 := GroupHomomorphismByImages( G4, G4, [ G4.1, G4.2, G4.3 ], [ G4.1*G4.2, One( G4 ), G4.3^2 ] );;
gap> hom2G4 := GroupHomomorphismByImages( G4, G4, [ G4.1, G4.2, G4.3 ], [ G4.1*G4.2, G4.1, One( G4 ) ] );;
gap> IteratedReidemeisterNumberDecomposition( hom1G4, hom2G4 );
[ [ 8, 4, 8 ], [ -4 ] ]
gap> IsRationalReidemeisterZetaFunction( hom1G4, hom2G4 );
false
gap> zeta12G4 := ReidemeisterZetaFunction( hom1G4, hom2G4 );
fail
gap> PrintReidemeisterZetaFunction( hom1G4, hom2G4 );
"exp(-4*s)*(1-s)^(-20/3)*(1-E(3)*s)^(4/3*E(3))*(1-E(3)^2*s)^(4/3*E(3)^2)"

#
gap> G5 := AbelianGroup( filt, [ 2, 2, 2 ] );;
gap> hom1G5 := GroupHomomorphismByImages( G5, G5, [ G5.1, G5.2, G5.3 ], [ One( G5 ), G5.2, G5.1*G5.2*G5.3 ] );;
gap> hom2G5 := GroupHomomorphismByImages( G5, G5, [ G5.1, G5.2, G5.3 ], [ One( G5 ), G5.1*G5.3, G5.1*G5.2*G5.3 ] );;
gap> IteratedReidemeisterNumberDecomposition( hom1G5, hom2G5 );
[ [ 4, 2, 4, 2, 4, 8 ], [  ] ]
gap> IsRationalReidemeisterZetaFunction( hom1G5, hom2G5 );
true
gap> zeta12G5 := ReidemeisterZetaFunction( hom1G5, hom2G5 );;
gap> Value( DenominatorOfRationalFunction( zeta12G5( s ) ), E(3) );
0
gap> zeta12G5( s );
(-1)/(-s^8+4*s^7-7*s^6+8*s^5-8*s^4+8*s^3-7*s^2+4*s-1)
gap> PrintReidemeisterZetaFunction( hom1G5, hom2G5 );
"(1-s)^(-4)*(1-s^2)*(1-s^6)^(-1)"
gap> hom3G5 := GroupHomomorphismByImages( G5, G5, [ G5.1, G5.2, G5.3 ], [ One( G5 ), G5.1, G5.2 ] );;
gap> hom4G5 := GroupHomomorphismByImages( G5, G5, [ G5.1, G5.2, G5.3 ], [ G5.1*G5.3, G5.2*G5.3, G5.1*G5.2 ] );;
gap> IteratedReidemeisterNumberDecomposition( hom3G5, hom4G5 );
[ [ 2 ], [ -1, -1 ] ]
gap> IsRationalReidemeisterZetaFunction( hom3G5, hom4G5 );
false
gap> zeta34G5 := ReidemeisterZetaFunction( hom3G5, hom4G5 );
fail
gap> PrintReidemeisterZetaFunction( hom3G5, hom4G5 );
"exp(-s-1/2*s^2)*(1-s)^(-2)"
gap> hom5G5 := GroupHomomorphismByImages( G5, G5, [ G5.1, G5.2, G5.3 ], [ G5.1*G5.2*G5.3, G5.1, G5.2 ] );;
gap> IteratedReidemeisterNumberDecomposition( hom3G5, hom5G5 );
[ [ 1 ], [ 3, 1 ] ]
gap> IsRationalReidemeisterZetaFunction( hom3G5, hom5G5 );
false
gap> zeta35G5 := ReidemeisterZetaFunction( hom3G5, hom5G5 );
fail
gap> PrintReidemeisterZetaFunction( hom3G5, hom5G5 );
"exp(3*s+1/2*s^2)*(1-s)^(-1)"
gap> hom6G5 := GroupHomomorphismByImages( G5, G5, [ G5.1, G5.2, G5.3 ], [ One( G5 ), One( G5 ), G5.3 ] );;
gap> hom7G5 := GroupHomomorphismByImages( G5, G5, [ G5.1, G5.2, G5.3 ], [ One( G5 ), G5.1*G5.3, G5.1 ] );;
gap> IteratedReidemeisterNumberDecomposition( hom6G5, hom7G5 );
[ [ 4 ], [ 0, -2 ] ]
gap> IsRationalReidemeisterZetaFunction( hom6G5, hom7G5 );
false
gap> zeta67G5 := ReidemeisterZetaFunction( hom6G5, hom7G5 );
fail
gap> PrintReidemeisterZetaFunction( hom6G5, hom7G5 );
"exp(-s^2)*(1-s)^(-4)"
gap> hom8G5 := GroupHomomorphismByImages( G5, G5, [ G5.1, G5.2, G5.3 ], [ G5.3, G5.1*G5.3, G5.2*G5.3 ] );;
gap> IteratedReidemeisterNumberDecomposition( hom6G5, hom8G5 );
[ [ 1, 1, 2, 2 ], [  ] ]
gap> IsRationalReidemeisterZetaFunction( hom6G5, hom8G5 );
false
gap> zeta68G5 := ReidemeisterZetaFunction( hom6G5, hom8G5 );
fail
gap> PrintReidemeisterZetaFunction( hom6G5, hom8G5 );
"(1-s)^(-3/2)*(1-E(4)*s)^(-1/4-1/4*E(4))*(1+E(4)*s)^(-1/4+1/4*E(4))"
gap> hom9G5 := GroupHomomorphismByImages( G5, G5, [ G5.1, G5.2, G5.3 ], [ G5.1, G5.3, G5.2 ] );;
gap> IteratedReidemeisterNumberDecomposition( hom6G5, hom9G5 );
[ [ 1, 2 ], [  ] ]
gap> IsRationalReidemeisterZetaFunction( hom6G5, hom9G5 );
false
gap> zeta69G5 := ReidemeisterZetaFunction( hom6G5, hom9G5 );
fail
gap> PrintReidemeisterZetaFunction( hom6G5, hom9G5 );
"(1-s)^(-3/2)*(1+s)^(-1/2)"

#
gap> G6 := AbelianGroup( filt, [ 2, 2, 2, 2 ] );;
gap> hom1G6 := GroupHomomorphismByImages( G6, G6, [ G6.1, G6.2, G6.3, G6.4 ], [ One( G6 ), G6.2, G6.1*G6.2*G6.3, One( G6 ) ] );;
gap> hom2G6 := GroupHomomorphismByImages( G6, G6, [ G6.1, G6.2, G6.3, G6.4 ], [ One( G6 ), G6.1*G6.3, G6.1*G6.2*G6.3, One( G6 ) ] );;
gap> IteratedReidemeisterNumberDecomposition( hom1G6, hom2G6 );
[ [ 8, 4, 8, 4, 8, 16 ], [  ] ]
gap> IsRationalReidemeisterZetaFunction( hom1G6, hom2G6 );
true
gap> zeta12G6 := ReidemeisterZetaFunction( hom1G6, hom2G6 );;
gap> zeta12G6( 1+E(6) );
-3/784*E(3)-1/98*E(3)^2
gap> zeta12G6( s );
(1)/(s^16-8*s^15+30*s^14-72*s^13+129*s^12-192*s^11+254*s^10-304*s^9+324*s^8-30\
4*s^7+254*s^6-192*s^5+129*s^4-72*s^3+30*s^2-8*s+1)
gap> PrintReidemeisterZetaFunction( hom1G6, hom2G6 );
"(1-s)^(-8)*(1-s^2)^2*(1-s^6)^(-2)"

#
gap> Q8 := QuaternionGroup( filt, 8 );;
gap> hom1Q8 := GroupHomomorphismByImages( Q8, Q8, [ Q8.1, Q8.2 ],[ Q8.1, Q8.1*Q8.2 ] );;
gap> hom2Q8 := GroupHomomorphismByImages( Q8, Q8, [ Q8.1, Q8.2 ],[ Q8.2, Q8.1*Q8.2 ] );;
gap> IteratedReidemeisterNumberDecomposition( hom1Q8, hom2Q8 );
[ [ 3, 2, 3, 2, 3, 5 ], [  ] ]
gap> IsRationalReidemeisterZetaFunction( hom1Q8, hom2Q8 );
false
gap> zeta12Q8 := ReidemeisterZetaFunction( hom6G5, hom9G5 );
fail
gap> PrintReidemeisterZetaFunction( hom1Q8, hom2Q8 );
"(1-s)^(-3)*(1-E(6)*s)^(-1/2)*(1-E(6)^2*s)^(-1/2)*(1+E(6)*s)^(-1/2)*(1+E(6)^2*s)^(-1/2)"

#
gap> STOP_TEST( "zeta.tst" );
