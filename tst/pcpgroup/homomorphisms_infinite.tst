gap> START_TEST( "Testing TwistedConjugacy for infinite PcpGroups: homomorphisms" );

#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> H := DirectProduct( ExamplesOfSomePcpGroups( 5 ), AbelianPcpGroup( 1 ) );;
gap> imgs1 := [ G.1*G.4^-1, G.3, G.2*G.3^2*G.4^2, G.4^-1, One( G )  ];;
gap> imgs2 := [ G.1, G.2^2*G.3*G.4^2, G.2*G.3*G.4, G.4, One( G )  ];;
gap> hom1 := GroupHomomorphismByImagesNC( H, G, GeneratorsOfGroup( H ), imgs1 );;
gap> hom2 := GroupHomomorphismByImagesNC( H, G, GeneratorsOfGroup( H ), imgs2 );;

#
gap> CoincidenceGroup( hom1, hom2 ) = SubgroupNC( H, [ H.5 ] );
true

#
gap> tcc := ReidemeisterClass( hom1, hom2, One( G ) );;
gap> Representative( tcc ) = One( G );
true
gap> Size( tcc );
infinity
gap> List( tcc );
fail
gap> ActingDomain( tcc ) = H;
true
gap> R := TwistedConjugacyClasses( hom1, hom2 );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
4
gap> ReidemeisterNumber( hom1, hom2 );
4

#
gap> tc := TwistedConjugation( hom1, hom2 );;
gap> IsTwistedConjugate( hom1, hom2, Random( R[1] ), Random( R[2] ) );
false
gap> RepresentativeTwistedConjugation( hom1, hom2, Random( R[1] ), Random( R[2] ) );
fail
gap> g1 := Random( R[3] );;
gap> g2 := Random( R[3] );;
gap> g := RepresentativeTwistedConjugation( hom1, hom2, g1, g2 );;
gap> tc( g1, g ) = g2;   
true

#
gap> STOP_TEST( "homomorphisms_infinite.tst" );
