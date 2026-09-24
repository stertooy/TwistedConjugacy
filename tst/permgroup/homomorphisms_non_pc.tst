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
gap> Size( RepresentativesEndomorphismClasses( G ) );
3
gap> Size( RepresentativesEndomorphismClasses( H ) );
3
gap> Size( RepresentativesEndomorphismClasses( K ) );
3
gap> Size( RepresentativesEndomorphismClasses( L ) );
5

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
gap> Size( RepresentativesHomomorphismClasses( K, K ) );
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
gap> P := Group( [ (1,15,6,16,9,13,5,2)(3,22,10,28,20,19,12,8)(4,24,17,7,21,25,14,11)(18,46,36,47,38,44,35,27)(23,42,32,34,26,41,33,31)(29,43,48,37,30,40,45,39),
> (1,20,9,3)(2,5,16,6)(4,10,21,12)(7,17,11,14)(8,38,28,18)(13,26,15,23)(19,29,22,30)(24,32,25,33)(27,35,47,36)(31,43,34,40)(37,48,39,45)(41,44,42,46),
> (1,21,9,4)(2,11,16,7)(3,12,20,10)(5,17,6,14)(8,22,28,19)(13,25,15,24)(18,30,38,29)(23,33,26,32)(27,39,47,37)(31,42,34,41)(35,48,36,45)(40,46,43,44) ] );;
gap> Length( RepresentativesEndomorphismClasses( P ) );
14

#
gap> D1 := Group( [ (9,12)(10,16)(11,17)(13,19)(14,22)(15,23)(18,20)(21,24),
> (9,17)(10,23)(11,22)(12,21)(13,18)(14,24)(15,20)(16,19),
> (1,2,5,4)(3,7,8,6)(9,10,14,18)(11,19,21,15)(12,20,22,16)(13,17,23,24),
> (1,3,5,8)(2,6,4,7)(9,11,14,21)(10,15,18,19)(12,17,22,24)(13,16,23,20) ] );;
gap> Length( DirectFactorsOfGroup( D1 ) );
2
gap> D2 := Group( [ (1,5,3,2,4)(6,9,7,10,8), (1,3,5,2,4)(6,9,7,10,8) ] );;
gap> Length( RepresentativesHomomorphismClasses( D1, D2 ) );
86
gap> Length( RepresentativesHomomorphismClasses( D2, D1 ) );
1
gap> Length( RepresentativesHomomorphismClasses( D2, DirectProduct( D1, D2 ) ) );
25

#
gap> STOP_TEST( "homomorphisms_non_pc.tst" );
