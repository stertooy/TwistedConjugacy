gap> START_TEST( "Testing TwistedConjugacy for PcGroups: endomorphisms" );

#
gap> G := SmallGroup( 252, 34 );;
gap> gens := GeneratorsOfGroup( G );;
gap> imgs1 := [ G.1*G.5^6, G.1*G.2*G.3^2*G.4^2*G.5^6, G.3^2, G.3*G.4^2, One( G ) ];;
gap> imgs2 := [ One( G ), G.2*G.3*G.4, G.3, G.3^2*G.4, One( G ) ];;
gap> endo1 := GroupHomomorphismByImagesNC( G, G, gens, imgs1 );;
gap> endo2 := GroupHomomorphismByImagesNC( G, G, gens, imgs2 );;

#
gap> tcc := ReidemeisterClass( endo1, endo2, One( G ) );;
gap> Representative( tcc ) = One( G );
true
gap> Size( tcc );
18
gap> Length( List( tcc ) );
18
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = G;
true
gap> R := TwistedConjugacyClasses( endo1, endo2 );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
42
gap> NrTwistedConjugacyClasses( endo1, endo2 ) = ReidemeisterNumber( endo2, endo1 );
true
gap> NrTwistedConjugacyClasses( endo1 );
4
gap> ReidemeisterNumber( endo2 );
3
gap> R1 := ReidemeisterClasses( endo1 );;
gap> R2 := ReidemeisterClasses( endo2 );;
gap> Representative( R1[1] ) = Representative( R2[1] );
true
gap> ReidemeisterClass( endo1, One( G ) ) = ReidemeisterClass( endo2, One( G ) );
false

#
gap> tc := TwistedConjugation( endo1, endo2 );;
gap> IsTwistedConjugate( endo1, endo2, Random( R[1] ), Random( R[2] ) );
false
gap> RepresentativeTwistedConjugation( endo1, endo2, Random( R[1] ), Random( R[2] ) );
fail
gap> g1 := Random( R[10] );;
gap> g2 := Random( R[10] );;
gap> gc := RepresentativeTwistedConjugation( endo1, endo2, g1, g2 );;
gap> tc( g1, gc ) = g2;
true
gap> tc1 := TwistedConjugation( endo1 );;
gap> IsTwistedConjugate( endo1, Random( R1[1] ), Random( R1[2] ) );
false
gap> RepresentativeTwistedConjugation( endo1, Random( R1[1] ), Random( R1[2] ) );
fail
gap> g11 := Random( R1[3] );;
gap> g12 := Random( R1[3] );;
gap> g1c := RepresentativeTwistedConjugation( endo1, g11, g12 );;
gap> tc1( g11, g1c ) = g12;
true
gap> tc2 := TwistedConjugation( endo2 );;
gap> IsTwistedConjugate( endo2, Random( R2[1] ), Random( R2[2] ) );
false
gap> RepresentativeTwistedConjugation( endo2, Random( R2[1] ), Random( R2[2] ) );
fail
gap> g21 := Random( R2[3] );;
gap> g22 := Random( R2[3] );;
gap> g2c := RepresentativeTwistedConjugation( endo2, g21, g22 );;
gap> tc2( g21, g2c ) = g22;
true

#
gap> h := Random( G );;
gap> g1L := [ g11, g21 ];;
gap> g2L := [ tc1( g11, h ), tc2( g21, h ) ];;
gap> endoL := [ endo1, endo2 ];;
gap> IsTwistedConjugate( endoL, g1L, g2L );
true
gap> h2 := RepresentativeTwistedConjugation( endoL, g1L, g2L );;
gap> g2L = [ tc1( g11, h2 ), tc2( g21, h2 ) ];
true
gap> IsTwistedConjugate( endoL, [ G.1, G.2 ], [ G.2, G.1 ] );
false

#
gap> ReidemeisterSpectrum( G );
[ 4, 6, 8, 10, 12, 15, 20, 30 ]
gap> H := SubgroupNC( G, [ G.1, G.2, G.3 ] );;
gap> ReidemeisterSpectrum( H );
[ 4, 6 ]
gap> ExtendedReidemeisterSpectrum( H );
[ 1, 2, 3, 4, 6 ]
gap> CoincidenceReidemeisterSpectrum( H );
[ 1, 2, 3, 4, 6, 8, 12 ]
gap> Q := FactorGroupNC( G, SubgroupNC( G, [ G.3, G.4 ] ) );;
gap> ReidemeisterSpectrum( Q );
[ 2, 4, 8, 10 ]
gap> ExtendedReidemeisterSpectrum( Q );
[ 1, 2, 4, 5, 8, 10 ]
gap> CoincidenceReidemeisterSpectrum( Q );
[ 1, 2, 4, 5, 7, 8, 10, 14, 16, 28 ]

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
gap> IsRationalReidemeisterZeta( endo1 );
true
gap> zeta1 := ReidemeisterZeta( endo1 );;
gap> zeta1( 10/3 );
-531441/206851765939
gap> PrintReidemeisterZeta( endo1 );
"(1-s)^(-4)*(1-s^2)^(-1)*(1-s^3)^(-2)"
gap> ReidemeisterZetaCoefficients( endo1 );
[ [ 4, 6, 10, 6, 4, 12 ], [  ] ]
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
gap> G := DerivedSubgroup( G );;
gap> endo1 := RestrictedHomomorphism( endo1, G, G );;
gap> endo2 := RestrictedHomomorphism( endo2, G, G );;

#
gap> tcc := ReidemeisterClass( endo1, endo2, One( G ) );;
gap> Representative( tcc ) = One( G );
true
gap> Size( tcc );
9
gap> Length( List( tcc ) );
9
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = G;
true
gap> R := TwistedConjugacyClasses( endo1, endo2 );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
7
gap> NrTwistedConjugacyClasses( endo1, endo2 ) = ReidemeisterNumber( endo2, endo1 );
true
gap> NrTwistedConjugacyClasses( endo1 );
1
gap> ReidemeisterNumber( endo2 );
3
gap> R1 := ReidemeisterClasses( endo1 );;
gap> R2 := ReidemeisterClasses( endo2 );;
gap> Representative( R1[1] ) = Representative( R2[1] );
true
gap> ReidemeisterClass( endo1, One( G ) ) = ReidemeisterClass( endo2, One( G ) );
false

#
gap> tc := TwistedConjugation( endo1, endo2 );;
gap> IsTwistedConjugate( endo1, endo2, Random( R[1] ), Random( R[2] ) );
false
gap> RepresentativeTwistedConjugation( endo1, endo2, Random( R[1] ), Random( R[2] ) );
fail
gap> g1 := Random( R[5] );;
gap> g2 := Random( R[5] );;
gap> gc := RepresentativeTwistedConjugation( endo1, endo2, g1, g2 );;
gap> tc( g1, gc ) = g2;
true
gap> tc1 := TwistedConjugation( endo1 );;
gap> g11 := Random( G );;
gap> g12 := Random( G );;
gap> g1c := RepresentativeTwistedConjugation( endo1, g11, g12 );;
gap> tc1( g11, g1c ) = g12;
true
gap> tc2 := TwistedConjugation( endo2 );;
gap> IsTwistedConjugate( endo2, Random( R2[1] ), Random( R2[2] ) );
false
gap> RepresentativeTwistedConjugation( endo2, Random( R2[1] ), Random( R2[2] ) );
fail
gap> g21 := Random( R2[3] );;
gap> g22 := Random( R2[3] );;
gap> g2c := RepresentativeTwistedConjugation( endo2, g21, g22 );;
gap> tc2( g21, g2c ) = g22;
true

#
gap> ReidemeisterSpectrum( G );
[ 1, 3, 7, 9, 21, 63 ]
gap> ExtendedReidemeisterSpectrum( G );
[ 1, 3, 7, 9, 21, 63 ]

#
gap> IsRationalReidemeisterZeta( endo1, endo2 );
true
gap> zeta := ReidemeisterZeta( endo1, endo2 );;
gap> zeta( 10/3 );
-1144561273430837494885949696427/
5872800730587046310315302901773887552120493728995593112131303
gap> PrintReidemeisterZeta( endo1, endo2 );
"(1-s)^(-7)*(1-s^2)^(-28)"
gap> ReidemeisterZetaCoefficients( endo1, endo2 );
[ [ 7, 63 ], [  ] ]
gap> IsRationalReidemeisterZeta( endo1 );
true
gap> zeta1 := ReidemeisterZeta( endo1 );;
gap> zeta1( 10/3 );
-19683/636535627
gap> PrintReidemeisterZeta( endo1 );
"(1-s)^(-1)*(1-s^2)^(-1)*(1-s^6)^(-1)"
gap> ReidemeisterZetaCoefficients( endo1 );
[ [ 1, 3, 1, 3, 1, 9 ], [  ] ]
gap> IsRationalReidemeisterZeta( endo2 );
true
gap> zeta2 := ReidemeisterZeta( endo2 );;
gap> zeta2( 10/3 );
-19683/324728047
gap> PrintReidemeisterZeta( endo2 );
"(1-s)^(-3)*(1-s^3)^(-2)"
gap> ReidemeisterZetaCoefficients( endo2 );
[ [ 3, 3, 9 ], [  ] ]

#
gap> STOP_TEST( "endomorphisms.tst" );
