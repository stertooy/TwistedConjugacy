gap> START_TEST( "Testing TwistedConjugacy for infinite PcpGroups: twisted conjugation by endomorphisms" );

#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> imgs1 := [ G.1*G.4^-1, G.3, G.2*(G.3*G.4)^3, G.4^-1  ];;
gap> imgs2 := [ G.4^-1*G.1, G.3, G.2, G.4^-1  ];;
gap> endo1 := GroupHomomorphismByImages( G, G, GeneratorsOfGroup( G ), imgs1 );;
gap> endo2 := GroupHomomorphismByImages( G, G, GeneratorsOfGroup( G ), imgs2 );;

#
gap> tcc := ReidemeisterClass( endo1, endo2, One( G ) );;
gap> Representative( tcc ) = One( G );
true
gap> Size( tcc );
infinity
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = G;
true
gap> R := TwistedConjugacyClasses( endo1, endo2 );
fail
gap> NrTwistedConjugacyClasses( endo1, endo2 ) = ReidemeisterNumber( endo2, endo1 );
true
gap> NrTwistedConjugacyClasses( endo1 );
6
gap> ReidemeisterNumber( endo2 );
infinity
gap> R1 := ReidemeisterClasses( endo1 );;
gap> Size( R1 );
6
gap> R2 := ReidemeisterClasses( endo1, FittingSubgroup( G ) );;
gap> Size( R2 );
3
gap> R3 := ReidemeisterClasses( endo1, DerivedSubgroup( G ) );;
gap> Size( R3 );
3

#
gap> tc := TwistedConjugation( endo1, endo2 );;
gap> IsTwistedConjugate( endo1, endo2, G.1, G.2 );
false
gap> RepresentativeTwistedConjugation( endo1, endo2, G.1, G.2 );
fail
gap> gc := RepresentativeTwistedConjugation( endo1, endo2, G.1, G.1*G.3^2 );;
gap> tc( G.1, gc ) = G.1*G.3^2;
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
gap> IsTwistedConjugate( endo2, G.1, G.2 );
false
gap> RepresentativeTwistedConjugation( endo2, G.1, G.2 );
fail
gap> g21 := G.1;;
gap> g22 := G.1*G.2*G.3;;
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
gap> STOP_TEST( "twisted_conjugacy_single_inf.tst" );
