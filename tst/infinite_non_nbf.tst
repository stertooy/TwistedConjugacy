gap> START_TEST( "Testing Double Twisted Conjugacy for infinite non-nilpotent-by-finite groups" );

#
gap> H := DirectProduct( ExamplesOfSomePcpGroups( 4 ),AbelianPcpGroup( 1 ) );;
gap> G := ExamplesOfSomePcpGroups( 4 );;
gap> hom1 := GroupHomomorphismByImages( H, G, [ H.1, H.2, H.4 ],[ G.1^2, One( G ), One( G ) ] );;
gap> hom2 := GroupHomomorphismByImages( H, G, [ H.1, H.2, H.4 ],[ G.3, One( G ), One( G ) ] );;
gap> hom3 := GroupHomomorphismByImages( H ,G, [ H.1, H.2, H.4 ],[ G.1, G.2^2, One( G ) ] );;
gap> ReidemeisterNumber( hom1, hom2 );
infinity
gap> IsTwistedConjugate( hom1, hom2, G.1, G.2 );
false
gap> ReidemeisterNumber( hom1, hom3 );
4
gap> IsTwistedConjugate( hom1, hom3, G.2, G.3 );
false
gap> IsTwistedConjugate( hom1, hom3, G.2, G.2*G.3^2 );
true

#
gap> STOP_TEST( "infinite_non_nbf.tst" );
