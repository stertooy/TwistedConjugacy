gap> START_TEST( "Testing Double Twisted Conjugacy for finite non-pc groups" );

#
# Non-polyclic groups with two homomorphisms
#
gap> G := AlternatingGroup( 6 );;
gap> H := SymmetricGroup( 5 );;
gap> hom1 := GroupHomomorphismByImagesNC( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ], [ (1,2)(3,4), () ] );;
gap> hom2 := GroupHomomorphismByImagesNC( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ], [ (1,4)(3,6), () ] );; 

# Coincidence Group
gap> IndexNC( H, CoincidenceGroup( hom1, hom2 ) );
2

# Reidemeister Classes
gap> tcc := ReidemeisterClass( hom1, hom2, (4,6,5) );;
gap> Representative( tcc ) = (4,6,5);
true
gap> Size( tcc );
2
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
184
gap> ReidemeisterNumber( hom1, hom2 );
184

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
[ 120 ]
gap> CoincidenceReidemeisterSpectrum( H, G );
[ 180, 184, 360 ]

#
gap> STOP_TEST( "finite_npc_double.tst" );
