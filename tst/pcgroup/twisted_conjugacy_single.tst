gap> START_TEST( "Testing TwistedConjugacy for PcGroups: twisted conjugation by endomorphisms" );

#
gap> G := PcGroupCode( 57308604420143, 252 );;
gap> gens := GeneratorsOfGroup( G );;
gap> imgs1 := [ G.1*G.5^6, G.1*G.2*G.3^2*G.4^2*G.5^6, G.3^2, G.3*G.4^2, One( G ) ];;
gap> imgs2 := [ One( G ), G.2*G.3*G.4, G.3, G.3^2*G.4, One( G ) ];;
gap> endo1 := GroupHomomorphismByImages( G, G, gens, imgs1 );;
gap> endo2 := GroupHomomorphismByImages( G, G, gens, imgs2 );;

#
gap> tcc := ReidemeisterClass( endo1, endo2, One( G ) );;
gap> Print( tcc );
ReidemeisterClass( [ [ f1, f2, f3, f4, f5 ] -> [ f1*f5^6, f1*f2*f3^2*f4^2*f5^6, f3^2, f3*f4^2, <identity> of ... ], [ f1, f2, f3, f4, f5 ] -> [ <identity> of ..., f2*f3*f4, f3, f3^2*f4, <identity> of ... ] ], <identity> of ... )
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

#
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
gap> R1 = R2;
false
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
gap> ReidemeisterClass( endo1, endo2, g1 ) = ReidemeisterClass( endo1, endo2, g2 );
true

#
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

#
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
gap> IsTwistedConjugate( endoL, [ G.1, G.1, G.2 ], [ G.1, G.2, G.1 ] );
false

#
gap> D := DerivedSubgroup( G );;
gap> endo1D := RestrictedHomomorphism( endo1, D, D );;
gap> endo2D := RestrictedHomomorphism( endo2, D, D );;

#
gap> tccD := ReidemeisterClass( endo1D, endo2D, One( D ) );;
gap> Representative( tccD ) = One( D );
true
gap> Size( tccD );
9
gap> Length( List( tccD ) );
9
gap> Random( tccD ) in tccD;
true
gap> ActingDomain( tccD ) = D;
true

#
gap> RD := TwistedConjugacyClasses( endo1D, endo2D );;
gap> Representative( RD[1] ) = One( D );
true
gap> Size( RD );
7
gap> NrTwistedConjugacyClasses( endo1D, endo2D ) = ReidemeisterNumber( endo2D, endo1D );
true
gap> NrTwistedConjugacyClasses( endo1D );
1
gap> ReidemeisterNumber( endo2D );
3
gap> RD1 := ReidemeisterClasses( endo1D );;
gap> RD2 := ReidemeisterClasses( endo2D );;
gap> Representative( RD1[1] ) = Representative( RD2[1] );
true
gap> ReidemeisterClass( endo1D, One( D ) ) = ReidemeisterClass( endo2D, One( D ) );
false

#
gap> tcD := TwistedConjugation( endo1D, endo2D );;
gap> IsTwistedConjugate( endo1D, endo2D, Random( RD[1] ), Random( RD[2] ) );
false
gap> RepresentativeTwistedConjugation( endo1D, endo2D, Random( RD[1] ), Random( RD[2] ) );
fail
gap> g1D := Random( RD[5] );;
gap> g2D := Random( RD[5] );;
gap> gcD := RepresentativeTwistedConjugation( endo1D, endo2D, g1D, g2D );;
gap> tcD( g1D, gcD ) = g2D;
true

#
gap> tc1D := TwistedConjugation( endo1D );;
gap> g11D := Random( D );;
gap> g12D := Random( D );;
gap> g1cD := RepresentativeTwistedConjugation( endo1D, g11D, g12D );;
gap> tc1D( g11D, g1cD ) = g12D;
true

#
gap> tc2D := TwistedConjugation( endo2D );;
gap> IsTwistedConjugate( endo2D, Random( RD2[1] ), Random( RD2[2] ) );
false
gap> RepresentativeTwistedConjugation( endo2D, Random( RD2[1] ), Random( RD2[2] ) );
fail
gap> g21D := Random( RD2[3] );;
gap> g22D := Random( RD2[3] );;
gap> g2cD := RepresentativeTwistedConjugation( endo2D, g21D, g22D );;
gap> tc2D( g21D, g2cD ) = g22D;
true

#
gap> T := TrivialSubgroup( G );;
gap> endoT := GroupHomomorphismByImages( T, T, [ One( T ) ], [ One( T ) ] );;
gap> Size( ReidemeisterClasses( endoT ) );
1
gap> RepresentativesReidemeisterClasses( endoT ) = [ One( T ) ];
true

#
gap> STOP_TEST( "twisted_conjugacy_single.tst" );
