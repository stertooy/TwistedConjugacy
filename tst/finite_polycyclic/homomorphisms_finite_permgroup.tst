gap> START_TEST( "Testing Double Twisted Conjugacy for finite pc groups" );

#
# Polyclic groups with two homomorphisms
#
gap> G := Image( SmallerDegreePermutationRepresentation( Image( IsomorphismPermGroup( SmallGroup( 252, 34 ) ) ) ) );;
gap> H := Image( SmallerDegreePermutationRepresentation( Image( IsomorphismPermGroup( SmallGroup( 84, 5 ) ) ) ) );;
gap> gens := [ H.1, H.3*H.4 ];;
gap> imgs1 := [ G.2*G.4^2, One( G ) ];;
gap> imgs2 := [ G.1*G.2*G.3*G.5, G.3*G.4^2*G.5^3 ];; 
gap> hom1 := GroupHomomorphismByImagesNC( H, G, gens, imgs1 );;
gap> hom2 := GroupHomomorphismByImagesNC( H, G, gens, imgs2 );;

# Coincidence Group
gap> CoincidenceGroup( hom1, hom2 ) = Centre ( H );
true

# Reidemeister Classes
gap> tcc := ReidemeisterClass( hom1, hom2, One( G ) );;
gap> Representative( tcc ) = One( G );
true
gap> Size( tcc );
42
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = H;
true
gap> ActingCodomain( tcc ) = G;
true
gap> R := TwistedConjugacyClasses( hom1, hom2 );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
6
gap> ReidemeisterNumber( hom1, hom2 );
6

# Twisted Conjugacy
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

# Reidemeister Spectrum
gap> CoincidenceReidemeisterSpectrum( G, H );
[ 42, 84 ]

#
# Derived Subgroup (abelian)
#
gap> M := DerivedSubgroup( G );;
gap> N := IntersectionPreImage@TwistedConjugacy( hom1, hom2, M );;
gap> homN1 := RestrictedHomomorphism( hom1, N, M );;
gap> homN2 := RestrictedHomomorphism( hom2, N, M );;

# Coincidence Group
gap> CoincidenceGroup( homN1, homN2 ) = SubgroupNC( N, [ MinimalGeneratingSet( N )[1]^21 ] ) ;
true

# Reidemeister Classes
gap> tccM := ReidemeisterClass( homN1, homN2, One( M ) );;
gap> Representative( tccM ) = One( M );
true
gap> Size( tccM );
21
gap> Random( tccM ) in tccM;
true
gap> ActingDomain( tccM ) = N;
true
gap> ActingCodomain( tccM ) = M;
true
gap> RM := TwistedConjugacyClasses( homN1, homN2 );;
gap> Representative( RM[1] ) = One( M );
true
gap> Size( RM );
3
gap> ReidemeisterNumber( homN1, homN2 );
3

# Twisted Conjugacy
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

# Reidemeister Spectrum
gap> CoincidenceReidemeisterSpectrum( M, N );
[ 2, 6, 14, 42 ]
gap> CoincidenceReidemeisterSpectrum( N, M );
[ 3, 9, 21, 63 ]

#
gap> STOP_TEST( "finite_pc_double.tst" );
