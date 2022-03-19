gap> START_TEST( "Testing TwistedConjugacy for PcGroups: extra tests" );

#
gap> filt := IsPcGroup;;
gap> G := SmallGroup( 252, 34 );;
gap> H := DirectProduct( SmallGroup( 16, 9 ), SmallGroup( 261, 1 ) );;
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
gap> STOP_TEST( "extra.tst" );
