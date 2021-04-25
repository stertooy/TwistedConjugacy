gap> START_TEST( "Testing Twisted Conjugacy for finite pc groups" );

#
# PermGroup
#
gap> G := Image( SmallerDegreePermutationRepresentation( Image( IsomorphismPermGroup( SmallGroup( 252, 34 ) ) ) ) );;
gap> imgs1 := [ G.1*G.5^6, G.1*G.2*G.3^2*G.4^2*G.5^6, G.3^2, G.3*G.4^2, One( G ) ];;
gap> imgs2 := [ One( G ), G.2*G.3*G.4, G.3, G.3^2*G.4, Identity(G) ];;
gap> endo1 := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs1 );;
gap> endo2 := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs2 );;

# Fixed Point Group
gap> Size( CoincidenceGroup( endo1, endo2 ) );
14
gap> Size( FixedPointGroup( endo1 ) );
2
gap> Size( FixedPointGroup( endo2 ) );
3

# Reidemeister Classes
gap> tcc := ReidemeisterClass( endo1, endo2, One( G ) );;
gap> Representative( tcc ) = One( G );
true
gap> Size( tcc );
18
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = G;
true
gap> ActingCodomain( tcc ) = G;
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

# Twisted Conjugacy
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

# Reidemeister Spectrum
gap> ReidemeisterSpectrum( G );
[ 4, 6, 8, 10, 12, 15, 20, 30 ]
gap> Q := FactorGroupNC( G, SubgroupNC( G, [ G.3, G.4 ] ) );;
gap> ReidemeisterSpectrum( Q );
[ 2, 4, 8, 10 ]
gap> ExtendedReidemeisterSpectrum( Q );
[ 1, 2, 4, 5, 8, 10 ]
gap> CoincidenceReidemeisterSpectrum( Q );
[ 1, 2, 4, 5, 7, 8, 10, 14, 16, 28 ]

# Reidemeister Zeta
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
gap> STOP_TEST( "finite_pc_single.tst" );
