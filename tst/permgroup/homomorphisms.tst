gap> START_TEST( "Testing TwistedConjugacy for PermGroups: homomorphisms" );

#
gap> filt := IsPermGroup;;
gap> G := Group( [ (11,16)(12,15)(13,14), (2,4)(3,6)(5,9)(7,8), (1,2,4)(3,5,7)(6,8,9), (1,3,6)(2,5,8)(4,7,9), (10,11,12,13,14,15,16) ] );;
gap> H := DirectProduct( Group([ (1,2,5,8)(3,12,10,16)(4,14,11,7)(6,15,13,9), (1,3,5,10)(2,6,8,13)(4,15,11,9)(7,16,14,12), (1,4,5,11)(2,7,8,14)(3,9,10,15)(6,12,13,16), (1,5)(2,8)(3,10)(4,11)(6,13)(7,14)(9,15)(12,16) ]), Group([ (1,2,3,4,5,6,7,8,9), (10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38) ]) );;
gap> T := TrivialGroup( filt );;
gap> C := CyclicGroup( filt, 2 );;

#
gap> HomsG := RepresentativesEndomorphismClasses( G );;
gap> Size( HomsG );
308
gap> HomsT := RepresentativesEndomorphismClasses( T );;
gap> Size( HomsT );
1
gap> HomsC := RepresentativesEndomorphismClasses( C );;
gap> Size( HomsC );
2
gap> HomsH := RepresentativesEndomorphismClasses( H );;
gap> Size( HomsH );
2088

#
gap> HomsGT := RepresentativesHomomorphismClasses( G, T );;
gap> Size( HomsGT );
1
gap> IsTrivial( ImagesSource( HomsGT[1] ) );
true
gap> HomsTG := RepresentativesHomomorphismClasses( T, G );;
gap> Size( HomsTG );
1
gap> IsTrivial( ImagesSource( HomsTG[1] ) );
true

#
gap> HomsGH := RepresentativesHomomorphismClasses( G, H );;
gap> Size(last);
4
gap> HomsHG := RepresentativesHomomorphismClasses( H, G );;
gap> Size(last);
32

#
gap> STOP_TEST( "homomorphisms.tst" );
