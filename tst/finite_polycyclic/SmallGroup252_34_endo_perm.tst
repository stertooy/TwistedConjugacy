gap> START_TEST( "Testing Twisted Conjugacy for finite pc groups" );

#
# Polyclic group with endomorphism
#
gap> G := Image( SmallerDegreePermutationRepresentation ( Image( IsomorphismPermGroup( SmallGroup( 252, 34 ) ) ) ) );;
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
ReidemeisterClass( [ [ (11,16)(12,15)(13,14), (2,4)(3,6)(5,9)(7,8), (1,2,4)(3,\
5,7)(6,8,9), (1,3,6)(2,5,8)(4,7,9), (10,11,12,13,14,15,16) ] -> [ (10,16)(11,1\
5)(12,14), (1,9)(2,8)(3,7)(4,6)(10,16)(11,15)(12,14), (1,4,2)(3,7,5)(6,9,8), (\
1,8,7)(2,9,3)(4,6,5), () ], [ (11,16)(12,15)(13,14), (2,4)(3,6)(5,9)(7,8), (1,\
2,4)(3,5,7)(6,8,9), (1,3,6)(2,5,8)(4,7,9), (10,11,12,13,14,15,16) ] -> [ (11,1\
6)(12,15)(13,14), (2,4)(3,6)(5,9)(7,8), (1,2,4)(3,5,7)(6,8,9), (1,3,6)(2,5,8)(\
4,7,9), (10,11,12,13,14,15,16) ] ], (1,2,4)(3,5,7)(6,8,9) )
gap> Representative( tcc );
(1,2,4)(3,5,7)(6,8,9)
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
ReidemeisterClass( [ <object>, [ (10,15,13,11,16,14,12), (1,8,7)(2,9,3)(4,6,5)\
, (1,2,4)(3,5,7)(6,8,9) ] -> [ (10,15,13,11,16,14,12), (1,8,7)(2,9,3)(4,6,5), \
(1,2,4)(3,5,7)(6,8,9) ] ], (1,2,4)(3,5,7)(6,8,9) )
gap> Representative( tccD );
(1,2,4)(3,5,7)(6,8,9)
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
gap> FixedPointGroup( phiH ) = Subgroup( H, [ H.2 ] );
true

# Twisted Conjugacy
gap> tcH := TwistedConjugation( phiH );;
gap> IsTwistedConjugate( phiH, H.1, H.2 );
false
gap> h := RepresentativeTwistedConjugation( phiH, H.1, H.1*H.2 );;
gap> tcH( H.1, h ) = H.1*H.2;   
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
