gap> START_TEST( "Testing TwistedConjugacy for infinite PcpGroups: endomorphisms" );

#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> imgs1 := [ G.1*G.4^-1, G.3, G.2*(G.3*G.4)^3, G.4^-1  ];;
gap> imgs2 := [ G.4^-1*G.1, G.3, G.2, G.4^-1  ];;
gap> endo1 := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs1 );;
gap> endo2 := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs2 );;

#
gap> CoincidenceGroup( endo1, endo2 );
Pcp-group with orders [ 2, 0, 0 ]
gap> FixedPointGroup( endo1 ) ;
Pcp-group with orders [  ]
gap> FixedPointGroup( endo2 );
Pcp-group with orders [ 0 ]

#
gap> tcc := ReidemeisterClass( endo1, endo2, One( G ) );;
gap> Representative( tcc ) = One( G );
true
gap> Size( tcc );
infinity
gap> List( tcc );
fail
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
gap> g2c := RepresentativeTwistedConjugation( endo2, G.1, G.1*G.2*G.3 );;
gap> tc2( G.1, g2c ) = G.1*G.2*G.3;
true

#
gap> STOP_TEST( "endomorphisms_infinite.tst" );
