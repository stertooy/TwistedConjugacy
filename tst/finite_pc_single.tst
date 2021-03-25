gap> START_TEST( "Testing Twisted Conjugacy for finite pc groups" );

#
gap> F := FreeGroup( 5 );;
gap> Q := F / [ F.1^2, F.2^-1*F.1^-1*F.2*F.1, F.3^-1*F.1^-1*F.3*F.1, F.4^-1*F.1^-1*F.4*F.1, F.5^-1*F.1^-1*F.5*F.1*F.5^-5, F.2^2, F.3^-1*F.2^-1*F.3*F.2*F.3^-1, F.4^-1*F.2^-1*F.4*F.2*F.4^-1, F.5^-1*F.2^-1*F.5*F.2, F.3^3, F.4^-1*F.3^-1*F.4*F.3, F.5^-1*F.3^-1*F.5*F.3, F.4^3, F.5^-1*F.4^-1*F.5*F.4, F.5^7 ];;
gap> i := IsomorphismPcGroup( Q );;
gap> G := Image( i );;
gap> imgs := [ G.1*G.5^6, G.1*G.2*G.3^2*G.4^2*G.5^6, G.3^2, G.3*G.4^2, Identity(G) ];;
gap> phi := GroupHomomorphismByImages( G, G, GeneratorsOfGroup( G ), imgs );;
gap> FixedPointGroup( phi ) = Subgroup( G, [ G.1*G.5^6 ] );
true
gap> tc := TwistedConjugation( phi );;
gap> IsTwistedConjugate( phi, G.2, G.3 );
false
gap> g := RepresentativeTwistedConjugation( phi, G.1, G.3 );;
gap> tc( G.1, g ) = G.3;   
true
gap> tcc := ReidemeisterClass( phi, G.3 );;
gap> Print( tcc, "\n" );
ReidemeisterClass( [ [ f2, f1, f3, f4, f5 ] -> [ f2*f5^6, f1*f2*f3^2*f4^2*f5^6\
, f3^2, f3*f4^2, <identity> of ... ], [ f2, f1, f3, f4, f5 ] -> [ f2, f1, f3, \
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
gap> ReidemeisterSpectrum( G );
[ 4, 6, 8, 10, 12, 15, 20, 30 ]
gap> HasRationalReidemeisterZeta( phi );
true
gap> zeta1 := ReidemeisterZeta( phi );;
gap> zeta1( 10/3 );
-531441/206851765939
gap> PrintReidemeisterZeta( phi );
"(1-s)^(-4)*(1-s^2)^(-1)*(1-s^3)^(-2)"
gap> ReidemeisterZetaCoefficients( phi );
[ [  ], [ 4, 6, 10, 6, 4, 12 ] ]
gap> p := NaturalHomomorphismByNormalSubgroup( G, DerivedSubgroup( G ) );;
gap> H := Image( p );;
gap> psi := InducedHomomorphism( p, p, phi );;
gap> ReidemeisterNumber( psi );
2
gap> i := IsomorphismPcpGroup( G );;
gap> khi := InverseGeneralMapping(i)*phi*i;;
gap> ReidemeisterNumber( khi );
4

#
gap> STOP_TEST( "finite_pc_single.tst" );
