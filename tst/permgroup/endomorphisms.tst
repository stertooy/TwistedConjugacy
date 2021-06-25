gap> START_TEST( "Testing TwistedConjugacy for PermGroups: endomorphisms" );

#
gap> G := Group( [ (3,4)(5,6), (1,2,3)(4,5,7) ] );;
gap> imgs1 := [ (1,3,4,6,7,5,2), (3,4)(5,6) ];;
gap> imgs2 := [ (1,2,3,7,4,6,5), (3,4)(5,6) ];;
gap> endo1 := GroupHomomorphismByImagesNC( G, G, [ (1,6,7,4,3,5,2), (3,5)(4,6) ], imgs1 );;
gap> endo2 := GroupHomomorphismByImagesNC( G, G, [ (1,6,7,4,3,5,2), (3,5)(4,6) ], imgs2 );;

#
gap> Size( CoincidenceGroup( endo1, endo2 ) );
4
gap> Size( FixedPointGroup( endo1 ) );
4
gap> Size( FixedPointGroup( endo2 ) );
8
gap> CoincidenceGroup( IdentityMapping( G ), endo1, endo2 );
Group(())

#
gap> tcc := ReidemeisterClass( endo1, endo2, One( G ) );;
gap> Representative( tcc ) = One( G );
true
gap> Size( tcc );
42
gap> Length( List( tcc ) );
42
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = G;
true
gap> R := TwistedConjugacyClasses( endo1, endo2 );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
4
gap> NrTwistedConjugacyClasses( endo1, endo2 ) = ReidemeisterNumber( endo2, endo1 );
true
gap> NrTwistedConjugacyClasses( endo1 );
4
gap> ReidemeisterNumber( endo2 );
6
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
gap> g1 := Random( R[3] );;
gap> g2 := Random( R[3] );;
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
[ 4, 6 ]
gap> ExtendedReidemeisterSpectrum( G );
[ 1, 4, 6 ]
gap> CoincidenceReidemeisterSpectrum( G );
[ 1, 4, 6, 168 ]

#
gap> IsRationalReidemeisterZeta( endo1, endo2 );
true
gap> zeta := ReidemeisterZeta( endo1, endo2 );;
gap> zeta( 10/3 );
-729/218491
gap> PrintReidemeisterZeta( endo1, endo2 );
"(1-s)^(-4)*(1-s^2)^(-1)"
gap> ReidemeisterZetaCoefficients( endo1, endo2 );
[ [ 4, 6 ], [  ] ]
gap> IsRationalReidemeisterZeta( endo1 );
true
gap> zeta1 := ReidemeisterZeta( endo1 );;
gap> zeta1( 10/3 );
-729/218491
gap> PrintReidemeisterZeta( endo1 );
"(1-s)^(-4)*(1-s^2)^(-1)"
gap> ReidemeisterZetaCoefficients( endo1 );
[ [ 4, 6 ], [  ] ]
gap> IsRationalReidemeisterZeta( endo2 );
true
gap> zeta2 := ReidemeisterZeta( endo2 );;
gap> zeta2( 10/3 );
729/117649
gap> PrintReidemeisterZeta( endo2 );
"(1-s)^(-6)"
gap> ReidemeisterZetaCoefficients( endo2 );
[ [ 6 ], [  ] ]

#
gap> STOP_TEST( "endomorphisms.tst" );
