gap> START_TEST( "Testing TwistedConjugacy for PcGroups: extra tests" );

#
gap> ProductCyclicGroups := function ( L ) return DirectProduct( List( L, CyclicGroup ) ); end;;

#
gap> T := TrivialGroup();;
gap> idT := IdentityMapping( T );;
gap> IsTrivial( FixedPointGroup( idT ) );
true
gap> ReidemeisterClasses( idT );
[ <identity> of ...^G ]
gap> IsTwistedConjugate( idT, One( T ), One( T ) );
true
gap> Print( ReidemeisterClass( idT, One( T ) ), "\n" );
ReidemeisterClass( [ IdentityMapping( Group( <identity> of ... ) ), IdentityMapping( Group( <identity> of ... ) ) ], <identity> of ... )

#
gap> C2 := CyclicGroup( 2 );;
gap> triv := GroupHomomorphismByFunction( C2, T, x -> One( T ) );;
gap> C2 = CoincidenceGroup( triv, triv );
true
gap> endo := GroupHomomorphismByImagesNC( C2, C2, [ C2.1 ], [ C2.1^2 ] );;
gap> Print( ReidemeisterClass( endo, C2.1 ) , "\n" );
ReidemeisterClass( [ [ f1 ] -> [ <identity> of ... ], IdentityMapping( Group( [ f1 ] ) ) ], f1 )

#
gap> L1 := [ 2, 3, 5, 6, 24, 30 ];;
gap> G1 := ProductCyclicGroups( L1 );;
gap> ReidemeisterSpectrum( G1 ) = 2*DivisorsInt( Size( G1 ) / 2 );
true
gap> ExtendedReidemeisterSpectrum( G1 ) = DivisorsInt( Product( L1 ) );
true

#
gap> L2 := [ 2, 3, 5, 17, 24 ];;
gap> G2 := ProductCyclicGroups( L2 );;
gap> ReidemeisterSpectrum( G2 ) = 4*DivisorsInt( Size( G2 ) / 4 );
true
gap> ExtendedReidemeisterSpectrum( G2 ) = DivisorsInt( Product( L2 ) );
true

#
gap> L3 := [ 512, 512 ];;
gap> G3 := ProductCyclicGroups( L3 );;
gap> ReidemeisterSpectrum( G3 ) = DivisorsInt( 2^18 );
true
gap> ExtendedReidemeisterSpectrum( G3 ) = DivisorsInt( 2^18 );
true

#
gap> C3 := CyclicGroup( 3 );;
gap> CoincidenceReidemeisterSpectrum( C3 );
[ 1, 3 ]

#
gap> D6 := DihedralGroup( 6 );;
gap> CoincidenceReidemeisterSpectrum( D6 );
[ 1, 2, 3, 4, 6 ]

#
gap> C4 := CyclicGroup( 4 );;
gap> CoincidenceReidemeisterSpectrum( C4 );
[ 1, 2, 4 ]

#
gap> Q8 := QuaternionGroup( 8 );;
gap> ReidemeisterSpectrum( Q8 );
[ 2, 3, 5 ]
gap> ExtendedReidemeisterSpectrum( Q8 );
[ 1, 2, 3, 5 ]
gap> CoincidenceReidemeisterSpectrum( Q8 );
[ 1, 2, 3, 4, 5, 8 ]

#
gap> A4 := SmallGroup( 12, 3 );;
gap> ReidemeisterSpectrum( A4 );
[ 2, 4 ]
gap> ExtendedReidemeisterSpectrum( A4 );
[ 1, 2, 3, 4 ]
gap> CoincidenceReidemeisterSpectrum( A4 );
[ 1, 2, 3, 4, 6, 12 ]

#
gap> CoincidenceReidemeisterSpectrum( Q8, C4 );
[ 2, 4 ]
gap> CoincidenceReidemeisterSpectrum( C4, Q8 );
[ 2, 4, 6, 8 ]
gap> CoincidenceReidemeisterSpectrum( Q8, A4 );
[ 3, 4, 5, 6, 8, 12 ]
gap> CoincidenceReidemeisterSpectrum( A4, Q8 );
[ 8 ]

#
gap> s := Indeterminate( Rationals, "s" );;

#
gap> hom1C4 := GroupHomomorphismByImagesNC( C4, C4, [ C4.1 ], [ C4.1^2 ] );;
gap> hom2C4 := GroupHomomorphismByImagesNC( C4, C4, [ C4.1 ], [ One( C4 ) ] );;
gap> ReidemeisterZetaCoefficients( hom1C4, hom2C4 );
[ [ 4 ], [ -2 ] ]
gap> PrintReidemeisterZeta( hom1C4, hom2C4 );
"exp(-2*s)*(1-s)^(-4)"

#
gap> M := SmallGroup( 120, 2 );;
gap> hom1M := GroupHomomorphismByImagesNC( M, M, [ M.1, M.2 ], [ M.1^6, One( M ) ] );;
gap> hom2M := GroupHomomorphismByImagesNC( M, M, [ M.1, M.2 ], [ One( M ), One( M ) ] );;
gap> ReidemeisterZetaCoefficients( hom1M, hom2M );
[ [ 120 ], [ -90, -60 ] ]
gap> zeta12M := ReidemeisterZeta( hom1M, hom2M );
fail
gap> IsRationalReidemeisterZeta( hom1M, hom2M );
false
gap> PrintReidemeisterZeta( hom1M, hom2M );
"exp(-90*s-30*s^2)*(1-s)^(-120)"

#
gap> L4 := [ 2, 2, 4 ];;
gap> G4 := ProductCyclicGroups( L4 );;
gap> hom1G4 := GroupHomomorphismByImagesNC( G4, G4, [ G4.1, G4.2, G4.3 ], [ G4.1*G4.2, One( G4 ), G4.3^2 ] );;
gap> hom2G4 := GroupHomomorphismByImagesNC( G4, G4, [ G4.1, G4.2, G4.3 ], [ G4.1*G4.2, G4.1, One( G4 ) ] );;
gap> ReidemeisterZetaCoefficients( hom1G4, hom2G4 );
[ [ 8, 4, 8 ], [ -4 ] ]
gap> IsRationalReidemeisterZeta( hom1G4, hom2G4 );
false
gap> zeta12G4 := ReidemeisterZeta( hom1G4, hom2G4 );
fail
gap> PrintReidemeisterZeta( hom1G4, hom2G4 );
"exp(-4*s)*(1-s)^(-20/3)*(1-E(3)*s)^(4/3*E(3))*(1-E(3)^2*s)^(4/3*E(3)^2)"

#
gap> L5 := [ 2, 2, 2 ];;
gap> G5 := ProductCyclicGroups( L5 );;
gap> hom1G5 := GroupHomomorphismByImagesNC( G5, G5, [ G5.1, G5.2, G5.3 ], [ One( G5 ), G5.2, G5.1*G5.2*G5.3 ] );;
gap> hom2G5 := GroupHomomorphismByImagesNC( G5, G5, [ G5.1, G5.2, G5.3 ], [ One( G5 ), G5.1*G5.3, G5.1*G5.2*G5.3 ] );;
gap> ReidemeisterZetaCoefficients( hom1G5, hom2G5 );
[ [ 4, 2, 4, 2, 4, 8 ], [  ] ]
gap> IsRationalReidemeisterZeta( hom1G5, hom2G5 );
true
gap> zeta12G5 := ReidemeisterZeta( hom1G5, hom2G5 );;
gap> Value( DenominatorOfRationalFunction( zeta12G5( s ) ), E(3) );
0
gap> zeta12G5( s );
(-1)/(-s^8+4*s^7-7*s^6+8*s^5-8*s^4+8*s^3-7*s^2+4*s-1)
gap> PrintReidemeisterZeta( hom1G5, hom2G5 );
"(1-s)^(-4)*(1-s^2)*(1-s^6)^(-1)"
gap> hom3G5 := GroupHomomorphismByImagesNC( G5, G5, [ G5.1, G5.2, G5.3 ], [ One( G5 ), G5.1, G5.2 ] );;
gap> hom4G5 := GroupHomomorphismByImagesNC( G5, G5, [ G5.1, G5.2, G5.3 ], [ G5.1*G5.3, G5.2*G5.3, G5.1*G5.2 ] );;
gap> ReidemeisterZetaCoefficients( hom3G5, hom4G5 );
[ [ 2 ], [ -1, -1 ] ]
gap> IsRationalReidemeisterZeta( hom3G5, hom4G5 );
false
gap> zeta34G5 := ReidemeisterZeta( hom3G5, hom4G5 );
fail
gap> PrintReidemeisterZeta( hom3G5, hom4G5 );
"exp(-s-1/2*s^2)*(1-s)^(-2)"
gap> hom5G5 := GroupHomomorphismByImagesNC( G5, G5, [ G5.1, G5.2, G5.3 ], [ G5.1*G5.2*G5.3, G5.1, G5.2 ] );;
gap> ReidemeisterZetaCoefficients( hom3G5, hom5G5 );
[ [ 1 ], [ 3, 1 ] ]
gap> IsRationalReidemeisterZeta( hom3G5, hom5G5 );
false
gap> zeta35G5 := ReidemeisterZeta( hom3G5, hom5G5 );
fail
gap> PrintReidemeisterZeta( hom3G5, hom5G5 );
"exp(3*s+1/2*s^2)*(1-s)^(-1)"
gap> hom6G5 := GroupHomomorphismByImagesNC( G5, G5, [ G5.1, G5.2, G5.3 ], [ One( G5 ), One( G5 ), G5.3 ] );;
gap> hom7G5 := GroupHomomorphismByImagesNC( G5, G5, [ G5.1, G5.2, G5.3 ], [ One( G5 ), G5.1*G5.3, G5.1 ] );;
gap> ReidemeisterZetaCoefficients( hom6G5, hom7G5 );
[ [ 4 ], [ 0, -2 ] ]
gap> IsRationalReidemeisterZeta( hom6G5, hom7G5 );
false
gap> zeta67G5 := ReidemeisterZeta( hom6G5, hom7G5 );
fail
gap> PrintReidemeisterZeta( hom6G5, hom7G5 );
"exp(-s^2)*(1-s)^(-4)"
gap> hom8G5 := GroupHomomorphismByImagesNC( G5, G5, [ G5.1, G5.2, G5.3 ], [ G5.3, G5.1*G5.3, G5.2*G5.3 ] );;
gap> ReidemeisterZetaCoefficients( hom6G5, hom8G5 );
[ [ 1, 1, 2, 2 ], [  ] ]
gap> IsRationalReidemeisterZeta( hom6G5, hom8G5 );
false
gap> zeta68G5 := ReidemeisterZeta( hom6G5, hom8G5 );
fail
gap> PrintReidemeisterZeta( hom6G5, hom8G5 );
"(1-s)^(-3/2)*(1-E(4)*s)^(-1/4-1/4*E(4))*(1+E(4)*s)^(-1/4+1/4*E(4))"
gap> hom9G5 := GroupHomomorphismByImagesNC( G5, G5, [ G5.1, G5.2, G5.3 ], [ G5.1, G5.3, G5.2 ] );;
gap> ReidemeisterZetaCoefficients( hom6G5, hom9G5 );
[ [ 1, 2 ], [  ] ]
gap> IsRationalReidemeisterZeta( hom6G5, hom9G5 );
false
gap> zeta69G5 := ReidemeisterZeta( hom6G5, hom9G5 );
fail
gap> PrintReidemeisterZeta( hom6G5, hom9G5 );
"(1-s)^(-3/2)*(1+s)^(-1/2)"

#
gap> L6 := [ 2, 2, 2, 2 ];;
gap> G6 := ProductCyclicGroups( L6 );;
gap> hom1G6 := GroupHomomorphismByImagesNC( G6, G6, [ G6.1, G6.2, G6.3, G6.4 ], [ One( G6 ), G6.2, G6.1*G6.2*G6.3, One( G6 ) ] );;
gap> hom2G6 := GroupHomomorphismByImagesNC( G6, G6, [ G6.1, G6.2, G6.3, G6.4 ], [ One( G6 ), G6.1*G6.3, G6.1*G6.2*G6.3, One( G6 ) ] );;
gap> ReidemeisterZetaCoefficients( hom1G6, hom2G6 );
[ [ 8, 4, 8, 4, 8, 16 ], [  ] ]
gap> IsRationalReidemeisterZeta( hom1G6, hom2G6 );
true
gap> zeta12G6 := ReidemeisterZeta( hom1G6, hom2G6 );;
gap> zeta12G6( 1+E(6) );
-3/784*E(3)-1/98*E(3)^2
gap> zeta12G6( s );
(1)/(s^16-8*s^15+30*s^14-72*s^13+129*s^12-192*s^11+254*s^10-304*s^9+324*s^8-30\
4*s^7+254*s^6-192*s^5+129*s^4-72*s^3+30*s^2-8*s+1)
gap> PrintReidemeisterZeta( hom1G6, hom2G6 );
"(1-s)^(-8)*(1-s^2)^2*(1-s^6)^(-2)"

#
gap> hom1Q8 := GroupHomomorphismByImagesNC( Q8, Q8, [ Q8.1, Q8.2 ],[ Q8.1, Q8.1*Q8.2 ] );;
gap> hom2Q8 := GroupHomomorphismByImagesNC( Q8, Q8, [ Q8.1, Q8.2 ],[ Q8.2, Q8.1*Q8.2 ] );;
gap> ReidemeisterZetaCoefficients( hom1Q8, hom2Q8 );
[ [ 3, 2, 3, 2, 3, 5 ], [  ] ]
gap> IsRationalReidemeisterZeta( hom1Q8, hom2Q8 );
false
gap> zeta12Q8 := ReidemeisterZeta( hom6G5, hom9G5 );
fail
gap> PrintReidemeisterZeta( hom1Q8, hom2Q8 );
"(1-s)^(-3)*(1-E(6)*s)^(-1/2)*(1-E(6)^2*s)^(-1/2)*(1+E(6)*s)^(-1/2)*(1+E(6)^2*\
s)^(-1/2)"

#
gap> G := SmallGroup( 252, 34 );;
gap> hom1 := GroupHomomorphismByImagesNC( G, G, [ G.1, G.2, G.3, G.4, G.5 ], [ G.1*G.5^6, G.2*G.3*G.4^2, G.3, G.3*G.4^2, G.5^2 ] );;
gap> hom2 := GroupHomomorphismByImagesNC( G, G, [ G.1, G.2, G.3, G.4, G.5 ], [ G.1*G.5^3, G.2*G.4^2, G.3^2*G.4, G.3*G.4, G.5^5 ] );;
gap> hom3 := GroupHomomorphismByImagesNC( G, G, [ G.1, G.2, G.3, G.4, G.5 ], [ G.1, G.2, G.3*G.4^2, G.3^2*G.4^2, G.5 ] );;
gap> CoincidenceGroup( hom1, hom2, hom3 ) = Subgroup( G, [ G.1*G.5, G.2*G.3*G.4 ] );
true
gap> triv :=GroupHomomorphismByFunction( G, TrivialSubgroup( G ), g -> One( G ) );;
gap> CoincidenceGroup( triv, triv, triv, triv ) = G;
true

#
gap> STOP_TEST( "extra.tst" );
