gap> START_TEST( "Testing Double Twisted Conjugacy for finite non-pc groups" );

#
gap> G := AlternatingGroup( 6 );;
gap> H := SymmetricGroup( 5 );;
gap> phi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ], [ (1,2)(3,4), () ] );;
gap> psi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ], [ (1,4)(3,6), () ] );; 
gap> CoincidenceGroup(phi,psi);
<permutation group with 60 generators>
gap> tc := TwistedConjugation( phi, psi );;
gap> g1 := (4,6,5);;
gap> g2 := (1,6,4,2)(3,5);;
gap> IsTwistedConjugate( psi, phi, g1, g2 );
false
gap> h := RepresentativeTwistedConjugation( phi, psi, g1, g2 );
(1,2)
gap> tc( g1, h ) = g2;
true
gap> tcc := ReidemeisterClass( phi, psi, g1 );
(4,6,5)^G
gap> List(tcc);
[ (4,6,5), (1,6,4,2)(3,5) ]
gap> ActingDomain( tcc ) = H;
true
gap> NrTwistedConjugacyClasses( phi, psi );
184

#
gap> STOP_TEST( "finite_npc_double.tst" );
