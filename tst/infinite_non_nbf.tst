gap> START_TEST( "Testing Double Twisted Conjugacy for infinite non-nilpotent-by-finite groups" );

#
gap> H := DirectProduct( ExamplesOfSomePcpGroups( 4 ), AbelianPcpGroup( 1 ) );;
gap> G := ExamplesOfSomePcpGroups( 4 );;
gap> phi := GroupHomomorphismByImagesNC( H, G, [ H.1, H.2, H.4 ],[ G.1^2, One( G ), One( G ) ] );;
gap> psi := GroupHomomorphismByImagesNC( H, G, [ H.1, H.2, H.4 ],[ G.3, One( G ), One( G ) ] );;
gap> khi := GroupHomomorphismByImagesNC( H ,G, [ H.1, H.2, H.4 ],[ G.1, G.2^2, One( G ) ] );;
gap> ReidemeisterNumber( phi, psi );
infinity
gap> IsTwistedConjugate( phi, psi, G.1, G.2 );
false
gap> CoincidenceGroup( phi, psi ) = FittingSubgroup( H );
true
gap> R := TwistedConjugacyClasses( phi, khi );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
4
gap> NrTwistedConjugacyClasses( phi, khi );
4
gap> IsTwistedConjugate( phi, khi, G.2, G.3 );
false
gap> IsTwistedConjugate( phi, khi, G.2, G.2*G.3^2 );
true
gap> CoincidenceGroup( phi, khi ) = Centre( H );
true

#
gap> STOP_TEST( "infinite_non_nbf.tst" );
