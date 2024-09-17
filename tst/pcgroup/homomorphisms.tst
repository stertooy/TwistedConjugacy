gap> START_TEST( "Testing TwistedConjugacy for PcGroups: homomorphisms" );

#
gap> filt := IsPcGroup;;
gap> G := PcGroupCode( 57308604420143, 252 );;
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
