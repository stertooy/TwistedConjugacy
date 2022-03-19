gap> START_TEST( "Testing TwistedConjugacy for PcGroups: extra tests" );

#
gap> filt := IsPcGroup;;
gap> ProductCyclicGroups := function ( L ) return DirectProduct( List( L, CyclicGroup ) ); end;;

#
gap> T := TrivialGroup( filt );;
gap> idT := IdentityMapping( T );;
gap> Print( ReidemeisterClass( idT, One( T ) ), "\n" );
ReidemeisterClass( [ [ ] -> [ ], [ ] -> [ ] ], <identity> of ... )

#
gap> C2 := CyclicGroup( filt, 2 );;
gap> endo := GroupHomomorphismByImagesNC( C2, C2, [ C2.1 ], [ C2.1^2 ] );;
gap> Print( ReidemeisterClass( endo, C2.1 ) , "\n" );
ReidemeisterClass( [ [ f1 ] -> [ <identity> of ... ], [ f1 ] -> [ f1 ] ], f1 )

#
gap> T := TrivialGroup( IsPcGroup );;
gap> Homs := RepresentativesEndomorphismClasses( T );;
gap> Size( Homs );
1
gap> Homs := RepresentativesHomomorphismClasses( G, T );;
gap> Size( Homs );
1
gap> IsTrivial( ImagesSource( Homs[1] ) );
true
gap> Homs := RepresentativesHomomorphismClasses( T, G );;
gap> Size( Homs );
1
gap> IsTrivial( ImagesSource( Homs[1] ) );
true
gap> C2 := CyclicGroup( 2 );;
gap> Homs := RepresentativesEndomorphismClasses( C2 );;
gap> Size( Homs );
2

#
gap> G := DirectProduct( SmallGroup( 8, 3 ), SmallGroup( 261, 1 ) );;
gap> Fingerprint@TwistedConjugacy(G)[1];
[ [ 1, 1 ], 1 ]
gap> G := DirectProduct( SmallGroup( 8, 1 ), SmallGroup( 261, 1 ) );;
gap> Fingerprint@TwistedConjugacy(G)[1];
[ 8, 1 ]

#
gap> STOP_TEST( "extra.tst" );
