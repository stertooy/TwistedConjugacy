gap> START_TEST( "Testing Double Twisted Conjugacy for finite non-pc groups" );

#
gap> G := AlternatingGroup( 6 );;
gap> H := SymmetricGroup( 5 );;
gap> phi := GroupHomomorphismByImagesNC( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ], [ (1,2)(3,4), () ] );;
gap> psi := GroupHomomorphismByImagesNC( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ], [ (1,4)(3,6), () ] );; 
gap> IndexNC( H, CoincidenceGroup( phi, psi ) );
2
gap> tc := TwistedConjugation( phi, psi );;
gap> g1 := (4,6,5);;
gap> g2 := (1,6,4,2)(3,5);;
gap> IsTwistedConjugate( psi, phi, g1, g2 );
false
gap> h := RepresentativeTwistedConjugation( phi, psi, g1, g2 );;
gap> tc( g1, h ) = g2;
true
gap> tcc := ReidemeisterClass( phi, psi, g1 );
(4,6,5)^G
gap> Print( tcc, "\n" );
ReidemeisterClass( [ [ (1,2)(3,5,4), (2,3)(4,5) ] -> [ (1,2)(3,4), () ], [ (1,\
2)(3,5,4), (2,3)(4,5) ] -> [ (1,4)(3,6), () ] ], (4,6,5) )
gap> List( tcc );
[ (4,6,5), (1,6,4,2)(3,5) ]
gap> Size( tcc );
2
gap> ActingDomain( tcc ) = H;
true
gap> ActingCodomain( tcc ) = G;
true
gap> R := TwistedConjugacyClasses( phi, psi );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
184
gap> NrTwistedConjugacyClasses( phi, psi );
184
gap> K := Group([ (1,2,3,4,5)(6,9)(7,8), (2,3)(4,5)(6,7)(8,9) ]);;
gap> phiK := GroupHomomorphismByImagesNC( K, K, [ (1,2,3,4,5)(6,9)(7,8), (2,3)(4,5)(6,7)(8,9) ], [ (1,4,5,2,3)(6,8)(7,9), (2,3)(4,5)(6,9)(7,8) ] );;
gap> psiK := GroupHomomorphismByImagesNC( K, K, [ (1,2,3,4,5)(6,9)(7,8), (2,3)(4,5)(6,7)(8,9) ], [ (), (1,3)(2,4)(6,7)(8,9) ] );;
gap> ReidemeisterZetaCoefficients( phiK, psiK );
[ [  ], [ 2, 1, 2 ] ]

#
gap> STOP_TEST( "finite_npc_double.tst" );
