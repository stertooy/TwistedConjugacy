gap> START_TEST( "Testing TwistedConjugacy for PermGroups: homomorphisms" );

#
gap> filt := IsPermGroup;;
gap> G := Group( [ (11,16)(12,15)(13,14), (2,4)(3,6)(5,9)(7,8), (1,2,4)(3,5,7)(6,8,9), (1,3,6)(2,5,8)(4,7,9), (10,11,12,13,14,15,16) ] );;
gap> T := TrivialGroup( filt );;
gap> C := CyclicGroup( filt, 2 );;

#
gap> AutsG := RepresentativesAutomorphismClasses( G );;
gap> Size( AutsG );
72
gap> HomsG := RepresentativesEndomorphismClasses( G );;
gap> Size( HomsG );
308
gap> AutsT := RepresentativesAutomorphismClasses( T );;
gap> Size( AutsT );
1
gap> HomsT := RepresentativesEndomorphismClasses( T );;
gap> Size( HomsT );
1
gap> AutsC := RepresentativesAutomorphismClasses( C );;
gap> Size( AutsC );
1
gap> HomsC := RepresentativesEndomorphismClasses( C );;
gap> Size( HomsC );
2

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
gap> STOP_TEST( "homomorphisms.tst" );
