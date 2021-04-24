gap> START_TEST( "Testing Twisted Conjugacy for finite pc groups" );

#
# Polyclic group with endomorphism
#
gap> G := SmallGroup( 252, 34 );;
gap> imgs := [ G.1*G.5^6, G.1*G.2*G.3^2*G.4^2*G.5^6, G.3^2, G.3*G.4^2, Identity(G) ];;
gap> phi := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs );;

# Fixed Point Group
gap> FixedPointGroup( phi ) = SubgroupNC( G, [ G.1*G.5^6 ] );
true

# Twisted Conjugacy
gap> tc := TwistedConjugation( phi );;
gap> IsTwistedConjugate( phi, G.2, G.3 );
false
gap> g := RepresentativeTwistedConjugation( phi, G.1, G.3 );;
gap> tc( G.1, g ) = G.3;   
true

# Reidemeister Classes
gap> tcc := ReidemeisterClass( phi, G.3 );;
gap> Print( tcc, "\n" );
ReidemeisterClass( [ [ f1, f2, f3, f4, f5 ] -> [ f1*f5^6, f1*f2*f3^2*f4^2*f5^6\
, f3^2, f3*f4^2, <identity> of ... ], [ f1, f2, f3, f4, f5 ] -> [ f1, f2, f3, \
f4, f5 ] ], f3 )
gap> Representative( tcc );
f3
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

# Twisted Conjugacy
gap> tcD := TwistedConjugation( phiD );;
gap> d := RepresentativeTwistedConjugation( phi, D.2, D.3 );;
gap> tcD( D.2, d ) = D.3;   
true

# Reidemeister Classes
gap> tccD := ReidemeisterClass( phiD, D.3 );;
gap> Print( tccD, "\n" );
ReidemeisterClass( [ <object>, [ f3, f4, f5 ] -> [ f3, f4, f5 ] ], f5 )
gap> Representative( tccD );
f5
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
gap> FixedPointGroup( phiH ) = Subgroup( H, [ H.1 ] );
true

# Twisted Conjugacy
gap> tcH := TwistedConjugation( phiH );;
gap> IsTwistedConjugate( phiH, H.1, H.2 );
false
gap> h := RepresentativeTwistedConjugation( phiH, H.2, H.1*H.2 );;
gap> tcH( H.2, h ) = H.1*H.2;   
true

# Reidemeister Classes
gap> tccH := ReidemeisterClass( phiH, H.2 );;
gap> Print( tccH, "\n" );
ReidemeisterClass( [ <object>, [ f1, f2 ] -> [ f1, f2 ] ], f2 )
gap> Representative( tccH );
f2
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
