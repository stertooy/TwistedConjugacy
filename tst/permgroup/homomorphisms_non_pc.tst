gap> START_TEST( "Testing TwistedConjugacy for PermGroups: homomorphisms of non-polycyclic groups" );

#
gap> G := Group( [ (3,11,9,7,5)(4,12,10,8,6), (1,2,8)(3,7,9)(4,10,5)(6,12,11) ] );;
gap> IsSimpleGroup( G );
true
gap> H := Group( [ (1,2,3,4,5,6,7,8,9), (8,9,10) ] );;
gap> IsSimpleGroup( H );
true
gap> K := Group( [ (1,2,3)(4,5,6)(7,8,9)(10,11,12), (1,5,9)(4,12,7)(6,13,14)(8,15,16) ] );;
gap> IsQuasisimpleGroup( K );
true
gap> L := Group( [ (1,2)(3,4)(5,6)(7,8)(9,10)(11,12), (1,9,13,14,4)(2,7,12,15,16)(3,6,17,18,8) ] );;
gap> IsQuasisimpleGroup( L );
true

#
gap> Size( RepresentativesAutomorphismClasses( G ) );
2
gap> Size( RepresentativesEndomorphismClasses( G ) );
3
gap> Size( RepresentativesEndomorphismClasses( G, false ) );
1

#
gap> Size( RepresentativesAutomorphismClasses( H ) );
2
gap> Size( RepresentativesEndomorphismClasses( H ) );
3
gap> Size( RepresentativesEndomorphismClasses( H, false ) );
1

#
gap> Size( RepresentativesAutomorphismClasses( K ) );
2
gap> Size( RepresentativesEndomorphismClasses( K ) );
3
gap> Size( RepresentativesEndomorphismClasses( K, false ) );
1

#
gap> Size( RepresentativesAutomorphismClasses( L ) );
4
gap> Size( RepresentativesEndomorphismClasses( L ) );
5
gap> Size( RepresentativesEndomorphismClasses( L, false ) );
1

#
gap> Size( RepresentativesHomomorphismClasses( G, H ) );
1
gap> Size( RepresentativesHomomorphismClasses( K, H ) );
4
gap> Size( RepresentativesHomomorphismClasses( L, H ) );
5

#
gap> STOP_TEST( "homomorphisms_non_pc.tst" );
