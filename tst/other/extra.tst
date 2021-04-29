gap> START_TEST( "Testing TwistedConjugacy: extra tests" );

#
gap> G := AbelianGroup([0,3,3]);;
gap> H := CyclicGroup( 6 );;
gap> imgs1 := [ G.2  ];;
gap> imgs2 := [ G.3^2 ];;
gap> hom1 := GroupHomomorphismByImagesNC( H, G, [ H.1 ], imgs1 );;
gap> hom2 := GroupHomomorphismByImagesNC( H, G, [ H.1 ], imgs2 );;
gap> ReidemeisterClasses( hom1, hom2 );
fail
gap> ReidemeisterNumber( hom1, hom2 );
infinity

#
gap> STOP_TEST( "extra.tst" );
