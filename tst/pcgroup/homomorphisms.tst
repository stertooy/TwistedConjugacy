gap> START_TEST( "Testing TwistedConjugacy for PcGroups: homomorphisms" );

#
gap> filt := IsPcGroup;;
gap> G := PcGroupCode( 57308604420143, 252 );;
gap> T := TrivialGroup( filt );;
gap> C := CyclicGroup( filt, 2 );;
gap> D := DihedralGroup( filt, 8 );;
gap> P := DirectProduct( C, C );;
gap> Q := DirectProduct( C, D );;

#
gap> AutsG := RepresentativesAutomorphismClasses( G );;
gap> Size( AutsG );
72
gap> HomsG := RepresentativesEndomorphismClasses( G );;
gap> Size( HomsG );
308
gap> Size( RepresentativesHomomorphismClasses( G, G ) );
308
gap> NonbijectiveG := RepresentativesEndomorphismClasses( G, false );;
gap> Size( NonbijectiveG );
236
gap> ForAll( NonbijectiveG, hom -> not IsBijective( hom ) );
true
gap> AutsT := RepresentativesAutomorphismClasses( T );;
gap> Size( AutsT );
1
gap> HomsT := RepresentativesEndomorphismClasses( T );;
gap> Size( HomsT );
1
gap> RepresentativesEndomorphismClasses( T, false );
[  ]
gap> AutsC := RepresentativesAutomorphismClasses( C );;
gap> Size( AutsC );
1
gap> HomsC := RepresentativesEndomorphismClasses( C );;
gap> Size( HomsC );
2
gap> Size( RepresentativesEndomorphismClasses( C, false ) );
1

#
gap> HomsGT := RepresentativesHomomorphismClasses( G, T );;
gap> Size( HomsGT );
1
gap> IsTrivial( ImagesSource( HomsGT[ 1 ] ) );
true
gap> HomsTG := RepresentativesHomomorphismClasses( T, G );;
gap> Size( HomsTG );
1
gap> IsTrivial( ImagesSource( HomsTG[ 1 ] ) );
true
gap> Size( RepresentativesHomomorphismClasses( D, C ) );
4

#
gap> Length( RepresentativesHomomorphismClasses( P, Q ) );
64
gap> Length( RepresentativesHomomorphismClasses( D, P ) );
16
gap> Length( RepresentativesHomomorphismClasses( Q, D ) );
68
gap> Length( RepresentativesHomomorphismClasses( P, D ) );
16

#
gap> STOP_TEST( "homomorphisms.tst" );
