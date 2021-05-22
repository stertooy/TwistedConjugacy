gap> START_TEST( "Testing TwistedConjugacy for finite PcpGroups: endomorphisms" );

#
gap> G := PcGroupToPcpGroup( SmallGroup( 252, 34 ) );;
gap> imgs1 := [ G.1*G.5^6, G.1*G.2*G.3^2*G.4^2*G.5^6, G.3^2, G.3*G.4^2, One( G ) ];;
gap> imgs2 := [ One( G ), G.2*G.3*G.4, G.3, G.3^2*G.4, One( G ) ];;
gap> endo1 := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs1 );;
gap> endo2 := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs2 );;

#
gap> Size( CoincidenceGroup( endo1, endo2 ) );
14
gap> Size( FixedPointGroup( endo1 ) );
2
gap> Size( FixedPointGroup( endo2 ) );
3

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
gap> G := DerivedSubgroup( G );;
gap> endo1 := RestrictedHomomorphism( endo1, G, G );;
gap> endo2 := RestrictedHomomorphism( endo2, G, G );;

#
gap> Size( CoincidenceGroup( endo1, endo2 ) );
7
gap> Size( FixedPointGroup( endo1 ) );
1
gap> Size( FixedPointGroup( endo2 ) );
3

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
gap> STOP_TEST( "endomorphisms_finite.tst" );
