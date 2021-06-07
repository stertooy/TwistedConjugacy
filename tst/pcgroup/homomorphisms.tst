gap> START_TEST( "Testing TwistedConjugacy for PcGroups: homomorphisms" );

#
gap> G := SmallGroup( 252, 34 );;
gap> H := SmallGroup( 84, 5 );;
gap> imgs1 := [ G.2*G.4^2, One( G ) ];;
gap> imgs2 := [ G.1*G.2*G.3*G.5, G.3*G.4^2*G.5^3 ];;
gap> hom1 := GroupHomomorphismByImagesNC( H, G, [ H.1, H.3*H.4 ], imgs1 );;
gap> hom2 := GroupHomomorphismByImagesNC( H, G, [ H.1, H.3*H.4 ], imgs2 );;

#
gap> Coin := CoincidenceGroup( hom1, hom2 );;
gap> h := Random( H );;
gap> Coin.1 * h = h*Coin.1;
true

#
gap> tcc := ReidemeisterClass( hom1, hom2, One( G ) );;
gap> Representative( tcc ) = One( G );
true
gap> Size( tcc );
42
gap> Length( List( tcc ) );
42
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = H;
true
gap> R := TwistedConjugacyClasses( hom1, hom2 );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
6
gap> ReidemeisterNumber( hom1, hom2 );
6

#
gap> tc := TwistedConjugation( hom1, hom2 );;
gap> IsTwistedConjugate( hom1, hom2, Random( R[1] ), Random( R[2] ) );
false
gap> RepresentativeTwistedConjugation( hom1, hom2, Random( R[1] ), Random( R[2] ) );
fail
gap> g1 := Random( R[3] );;
gap> g2 := Random( R[3] );;
gap> g := RepresentativeTwistedConjugation( hom1, hom2, g1, g2 );;
gap> tc( g1, g ) = g2;
true

#
gap> h := Random( H );;
gap> tc2 := TwistedConjugation( hom2, hom1 );;
gap> g1L := [ g1, g2 ];;
gap> g2L := [ tc( g1, h ), tc2( g2, h ) ];;
gap> hom1L := [ hom1, hom2 ];;
gap> hom2L := [ hom2, hom1 ];;
gap> IsTwistedConjugate( hom1L, hom2L, g1L, g2L );
true
gap> h2 := RepresentativeTwistedConjugation( hom1L, hom2L, g1L, g2L );;
gap> g2L = [ tc( g1, h2 ), tc2( g2, h2 ) ];
true
gap> IsTwistedConjugate( hom1L, hom2L, [ G.1, G.2 ], [ G.2, G.1 ] );
false

#
gap> CoincidenceReidemeisterSpectrum( G, H );
[ 42, 84 ]

#
gap> M := DerivedSubgroup( G );;
gap> N := Subgroup( H, [ H.2, H.3, H.4 ] );;
gap> homN1 := RestrictedHomomorphism( hom1, N, M );;
gap> homN2 := RestrictedHomomorphism( hom2, N, M );;

#
gap> CoincidenceGroup( homN1, homN2 ) = SubgroupNC( N, [ MinimalGeneratingSet( N )[1]^21 ] ) ;
true

#
gap> tccM := ReidemeisterClass( homN1, homN2, One( M ) );;
gap> Representative( tccM ) = One( M );
true
gap> Size( tccM );
21
gap> Length( List( tccM ) );
21
gap> Random( tccM ) in tccM;
true
gap> ActingDomain( tccM ) = N;
true
gap> RM := TwistedConjugacyClasses( homN1, homN2 );;
gap> Representative( RM[1] ) = One( M );
true
gap> Size( RM );
3
gap> ReidemeisterNumber( homN1, homN2 );
3

#
gap> tcM := TwistedConjugation( homN1, homN2 );;
gap> IsTwistedConjugate( homN1, homN2, Random( RM[1] ), Random( RM[2] ) );
false
gap> RepresentativeTwistedConjugation( homN1, homN2, Random( RM[1] ), Random( RM[2] ) );
fail
gap> m1 := Random( RM[3] );;
gap> m2 := Random( RM[3] );;
gap> mc := RepresentativeTwistedConjugation( homN1, homN2, m1, m2 );;
gap> tcM( m1, mc ) = m2;
true

#
gap> CoincidenceReidemeisterSpectrum( M, N );
[ 2, 6, 14, 42 ]
gap> CoincidenceReidemeisterSpectrum( N, M );
[ 3, 9, 21, 63 ]

#
gap> STOP_TEST( "homomorphisms.tst" );
