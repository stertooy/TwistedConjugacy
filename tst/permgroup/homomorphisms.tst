gap> START_TEST( "Testing TwistedConjugacy for PermGroups: homomorphisms" );

#
gap> filt := IsPermGroup;;
gap> G := Group( [ (1,4,2)(3,7,5)(6,9,8)(11,16)(12,15)(13,14), (1,6,3)(2,8,5)(4,9,7)(10,11,12,13,14,15,16) ] );;
gap> T := TrivialGroup( filt );;
gap> C := CyclicGroup( filt, 2 );;

#
gap> AutsG := RepresentativesAutomorphismClasses( G );;
gap> Size( AutsG );
144
gap> HomsG := RepresentativesEndomorphismClasses( G );;
gap> Size( HomsG );
405
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
