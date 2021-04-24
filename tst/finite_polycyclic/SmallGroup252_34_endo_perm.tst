gap> START_TEST( "Testing Twisted Conjugacy for finite pc groups" );

#
# Polyclic group with endomorphism
#
gap> G := Image( SmallerDegreePermutationRepresentation ( Image( IsomorphismPermGroup( SmallGroup( 252, 34 ) ) ) ) );;
gap> imgs := [ G.1*G.5^6, G.1*G.2*G.3^2*G.4^2*G.5^6, G.3^2, G.3*G.4^2, Identity(G) ];;
gap> phi := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs );;

# Fixed Point Group
gap> Size( FixedPointGroup( phi ) );
2

# Reidemeister Classes
gap> tcc := ReidemeisterClass( phi, One( G ) );;
gap> Representative( tcc ) = One( G );
true
gap> Size( tcc );
126
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = G;
true
gap> R := TwistedConjugacyClasses( phi );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
4
gap> NrTwistedConjugacyClasses( phi );
4

# Twisted Conjugacy
gap> tc := TwistedConjugation( phi );;
gap> IsTwistedConjugate( phi, Random( R[1] ), Random( R[2] ) );
false
gap> g1 := Random( R[3] );;
gap> g2 := Random( R[3] );;
gap> g := RepresentativeTwistedConjugation( phi, g1, g2 );;
gap> tc( g1, g ) = g2;   
true

# Reidemeister Spectrum
gap> ReidemeisterSpectrum( G );
[ 4, 6, 8, 10, 12, 15, 20, 30 ]

# Reidemeister Zeta
gap> IsRationalReidemeisterZeta( phi );
true
gap> zeta := ReidemeisterZeta( phi );;
gap> zeta( 10/3 );
-531441/206851765939
gap> PrintReidemeisterZeta( phi );
"(1-s)^(-4)*(1-s^2)^(-1)*(1-s^3)^(-2)"
gap> ReidemeisterZetaCoefficients( phi );
[ [ 4, 6, 10, 6, 4, 12 ], [  ] ]

#
# Derived Subgroup (abelian)
#
gap> D := DerivedSubgroup( G );;
gap> phiD := RestrictedHomomorphism( phi, D, D );;

# Fixed Point Group
gap> IsTrivial( FixedPointGroup( phiD ) );
true

# Reidemeister Classes
gap> tccD := ReidemeisterClass( phiD, D.1 );;
gap> Representative( tccD ) = D.1;
true
gap> Size( tccD ) = Size( D );
true
gap> Random( tccD ) in tccD;
true
gap> ActingDomain( tccD ) = D;
true
gap> RD := TwistedConjugacyClasses( phiD );;
gap> Representative( RD[1] ) = One( D );
true
gap> Size( RD );
1
gap> NrTwistedConjugacyClasses( phiD );
1

# Twisted Conjugacy
gap> tcD := TwistedConjugation( phiD );;
gap> d1 := Random( D );;
gap> d2 := Random( D );;
gap> d := RepresentativeTwistedConjugation( phi, d1, d2 );;
gap> tcD( d1, d ) = d2;   
true

# Reidemeister Spectrum
gap> ReidemeisterSpectrum( D );
[ 1, 3, 7, 9, 21, 63 ]
gap> ExtendedReidemeisterSpectrum(D);
[ 1, 3, 7, 9, 21, 63 ]
gap> CoincidenceReidemeisterSpectrum(D);
[ 1, 3, 7, 9, 21, 63 ]

# Reidemeister Zeta
gap> IsRationalReidemeisterZeta( phiD );
true
gap> zetaD := ReidemeisterZeta( phiD );;
gap> zetaD( 10/3 );
-19683/636535627
gap> PrintReidemeisterZeta( phiD );
"(1-s)^(-1)*(1-s^2)^(-1)*(1-s^6)^(-1)"
gap> ReidemeisterZetaCoefficients( phiD );
[ [ 1, 3, 1, 3, 1, 9 ], [  ] ]

#
# Abelianisation (abelian)
#
gap> p := NaturalHomomorphismByNormalSubgroupNC( G, D );;
gap> H := Image( p );;
gap> phiH := InducedHomomorphism( p, p, phi );;

# Fixed Point Group
gap> FixH := FixedPointGroup( phiH );;
gap> FixH = Image( p, FixedPointGroup( phi ) );
true
gap> h1 := MinimalGeneratingSet( FixH )[1];;

# Reidemeister Classes
gap> tccH := ReidemeisterClass( phiH, h1 );;
gap> Representative( tccH ) = h1;
true
gap> 2*Size( tccH ) = Size( H );
true
gap> Random( tccH ) in tccH;
true
gap> ActingDomain( tccH ) = H;
true
gap> RH := TwistedConjugacyClasses( phiH );;
gap> Representative( RH[1] ) = One( H );
true
gap> Size( RH );
2
gap> NrTwistedConjugacyClasses( phiH );
2

# Twisted Conjugacy
gap> tcH := TwistedConjugation( phiH );;
gap> h2 := Random( RH[2] );;
gap> IsTwistedConjugate( phiH, h1, h2 );
false
gap> h := RepresentativeTwistedConjugation( phiH, h2, h1*h2 );;
gap> tcH( h2, h ) = h1*h2;   
true

# Reidemeister Spectrum
gap> ReidemeisterSpectrum(H);
[ 1, 2, 4 ]
gap> ExtendedReidemeisterSpectrum(H);
[ 1, 2, 4 ]
gap> CoincidenceReidemeisterSpectrum(H);
[ 1, 2, 4 ]

# Reidemeister Zeta
gap> IsRationalReidemeisterZeta( phiH );
true
gap> zetaH := ReidemeisterZeta( phiH );;
gap> zetaH( 10/3 );
-81/4459
gap> PrintReidemeisterZeta( phiH );
"(1-s)^(-2)*(1-s^2)^(-1)"
gap> ReidemeisterZetaCoefficients( phiH );
[ [ 2, 4 ], [  ] ]

#
gap> STOP_TEST( "finite_pc_single.tst" );
