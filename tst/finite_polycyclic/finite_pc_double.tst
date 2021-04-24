gap> START_TEST( "Testing Double Twisted Conjugacy for finite pc groups" );

#
gap> F := FreeGroup( 5 );;
gap> Q := F / [ F.1^2, F.2^-1*F.1^-1*F.2*F.1, F.3^-1*F.1^-1*F.3*F.1, F.4^-1*F.1^-1*F.4*F.1, F.5^-1*F.1^-1*F.5*F.1*F.5^-5, F.2^2, F.3^-1*F.2^-1*F.3*F.2*F.3^-1, F.4^-1*F.2^-1*F.4*F.2*F.4^-1, F.5^-1*F.2^-1*F.5*F.2, F.3^3, F.4^-1*F.3^-1*F.4*F.3, F.5^-1*F.3^-1*F.5*F.3, F.4^3, F.5^-1*F.4^-1*F.5*F.4, F.5^7 ];;
gap> i := IsomorphismPcGroup( Q );;
gap> G := Image( i );;
gap> F := FreeGroup( 4 );;
gap> Q := F / [ F.1^2*F.2^-1, F.2^-1*F.1^-1*F.2*F.1, F.3^-1*F.1^-1*F.3*F.1*F.3^-1, F.4^-1*F.1^-1*F.4*F.1*F.4^-5, F.2^2, F.3^-1*F.2^-1*F.3*F.2, F.4^-1*F.2^-1*F.4*F.2, F.3^3, F.4^-1*F.3^-1*F.4*F.3, F.4^7 ];;
gap> i := IsomorphismPcGroup( Q );;
gap> H := Image( i );;
gap> gens := [ H.1, H.3*H.4 ];;
gap> imgs1 := [ G.2*G.4^2, One( G ) ];;
gap> imgs2 := [ G.1*G.2*G.3*G.5, G.3*G.4^2*G.5^3 ];; 
gap> phi := GroupHomomorphismByImagesNC( H, G, gens, imgs1 );;
gap> psi := GroupHomomorphismByImagesNC( H, G, gens, imgs2 );;
gap> CoincidenceGroup( phi, psi ) = SubgroupNC( H, [H.2] );
true
gap> tc := TwistedConjugation( phi, psi );;
gap> IsTwistedConjugate( phi, psi, G.2, G.3 );
false
gap> g := RepresentativeTwistedConjugation( phi, psi, G.1, G.3 );;
gap> tc( G.1, g ) = G.3;   
true
gap> tcc := ReidemeisterClass( phi, psi, G.3 );;
gap> Print( tcc, "\n" );
ReidemeisterClass( [ [ f1, f3*f4 ] -> [ f1*f4^2, <identity> of ... ], [ f1, f3\
*f4 ] -> [ f1*f2*f3*f5, f3*f4^2*f5^3 ] ], f3 )
gap> Representative( tcc );
f3
gap> Size( tcc );
42
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = H;
true
gap> R := TwistedConjugacyClasses( phi, psi );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
6
gap> NrTwistedConjugacyClasses( phi, psi );
6
gap> M := FittingSubgroup( G );;
gap> N := IntersectionPreImage@TwistedConjugacy( phi, psi, M );;
gap> phiN := RestrictedHomomorphism( phi, N, M );;
gap> psiN := RestrictedHomomorphism( psi, N, M );;
gap> ReidemeisterNumber(phiN,psiN);
3
gap> i := IsomorphismPcpGroup( M );;
gap> j := IsomorphismPcpGroup( N );;
gap> M := Image( i );;
gap> N := Image( j );;
gap> phiN := InverseGeneralMapping( j )*phiN*i;;
gap> psiN := InverseGeneralMapping( j )*psiN*i;;
gap> ReidemeisterNumber( phiN, psiN );
3
gap> K := CyclicGroup( 4 );;
gap> phiK := GroupHomomorphismByImagesNC( K, K, [ K.1 ], [ K.1^2 ] );;
gap> psiK := GroupHomomorphismByImagesNC( K, K, [ K.1 ], [ One( K ) ] );;
gap> ReidemeisterZetaCoefficients( phiK, psiK );
[ [ 4 ], [ -2 ] ]
gap> PrintReidemeisterZeta( phiK , psiK );
"exp(-2*s)*(1-s)^(-4)"
gap> F := FreeGroup( 2 );;
gap> L := F/[F.1^24, F.2^5, F.2*F.1*(F.1*F.2^4)^-1 ];;
gap> M := Image( IsomorphismPcGroup( L ) );;
gap> phiM := GroupHomomorphismByImagesNC( M, M, [ M.1, M.2 ], [ M.1^6, One( M ) ] );;
gap> psiM := GroupHomomorphismByImagesNC( M, M, [ M.1, M.2 ], [ One( M ), One( M ) ] );;
gap> PrintReidemeisterZeta(phiM,psiM);
"exp(-90*s-30*s^2)*(1-s)^(-120)"
gap> N := DirectProduct( CyclicGroup( 4 ), CyclicGroup( 2 ), CyclicGroup( 2 ) );;
gap> phiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.3, N.4 ], [ N.1^2, N.3*N.4, One( N ) ] );;
gap> psiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.3, N.4 ], [ One( N ), N.3*N.4, N.3 ] );;
gap> IsRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 8, 4, 8 ], [ -4 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"exp(-4*s)*(1-s)^(-20/3)*(1-E(3)*s)^(4/3*E(3))*(1-E(3)^2*s)^(4/3*E(3)^2)"
gap> N := DirectProduct( CyclicGroup( 2 ), CyclicGroup( 2 ), CyclicGroup( 2 ) );;
gap> phiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ One( N ), N.2, N.1*N.2*N.3 ] );;
gap> psiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ One( N ), N.1*N.3, N.1*N.2*N.3 ] );;
gap> IsRationalReidemeisterZeta( phiN, psiN );
true
gap> zeta := ReidemeisterZeta( phiN, psiN );;
gap> s := Indeterminate( Rationals, "s" );;
gap> Value( DenominatorOfRationalFunction( zeta( s ) ), E(3) );
0
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 4, 2, 4, 2, 4, 8 ], [  ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"(1-s)^(-4)*(1-s^2)*(1-s^6)^(-1)"
gap> phiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ One( N ), N.1, N.2 ] );;
gap> psiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ N.1*N.3, N.2*N.3, N.1*N.2 ] );;
gap> IsRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 2 ], [ -1, -1 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"exp(-s-1/2*s^2)*(1-s)^(-2)"
gap> phiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ One( N ), N.1, N.2 ] );;
gap> psiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ N.1*N.2*N.3, N.1, N.2 ] );;
gap> IsRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 1 ], [ 3, 1 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"exp(3*s+1/2*s^2)*(1-s)^(-1)"
gap> phiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ One( N ), One( N ), N.3 ] );;
gap> psiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ One( N), N.1*N.3, N.1 ] );;
gap> IsRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 4 ], [ 0, -2 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"exp(-s^2)*(1-s)^(-4)"
gap> phiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ One( N ), One( N ), N.3 ] );;
gap> psiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ N.3, N.1*N.3, N.2*N.3 ] );;
gap> IsRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 1, 1, 2, 2 ], [  ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"(1-s)^(-3/2)*(1-E(4)*s)^(-1/4-1/4*E(4))*(1+E(4)*s)^(-1/4+1/4*E(4))"
gap> phiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ One( N ), One( N ), N.3 ] );;
gap> psiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3 ], [ N.1, N.3, N.2 ] );;
gap> IsRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 1, 2 ], [  ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"(1-s)^(-3/2)*(1+s)^(-1/2)"
gap> N := DirectProduct( CyclicGroup( 2 ), CyclicGroup( 2 ), CyclicGroup( 2 ), CyclicGroup( 2 ) );;
gap> phiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3, N.4 ], [ One( N ), N.2, N.1*N.2*N.3, One( N ) ] );;
gap> psiN := GroupHomomorphismByImagesNC( N, N, [ N.1, N.2, N.3, N.4 ], [ One( N ), N.1*N.3, N.1*N.2*N.3, One( N ) ] );;
gap> IsRationalReidemeisterZeta( phiN, psiN );
true
gap> zeta := ReidemeisterZeta( phiN, psiN );;
gap> zeta( 1+E(6) );
-3/784*E(3)-1/98*E(3)^2
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 8, 4, 8, 4, 8, 16 ], [  ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"(1-s)^(-8)*(1-s^2)^2*(1-s^6)^(-2)"
gap> Q := QuaternionGroup( 8 );;
gap> phiQ := GroupHomomorphismByImagesNC( Q, Q, [ Q.1, Q.2 ],[ Q.1, Q.1*Q.2 ] );;
gap> psiQ := GroupHomomorphismByImagesNC( Q, Q, [ Q.1, Q.2 ],[ Q.2, Q.1*Q.2 ] );;
gap> IsRationalReidemeisterZeta( phiQ, psiQ );
false
gap> ReidemeisterZetaCoefficients( phiQ, psiQ );
[ [ 3, 2, 3, 2, 3, 5 ], [  ] ]
gap> PrintReidemeisterZeta( phiQ, psiQ );
"(1-s)^(-3)*(1-E(6)*s)^(-1/2)*(1-E(6)^2*s)^(-1/2)*(1+E(6)*s)^(-1/2)*(1+E(6)^2*\
s)^(-1/2)"
gap> N := CyclicGroup( 3 );;
gap> CoincidenceReidemeisterSpectrum( N );
[ 1, 3 ]
gap> N := DihedralGroup( 6 );;
gap> CoincidenceReidemeisterSpectrum( N );
[ 1, 2, 3, 4, 6 ]
gap> N := CyclicGroup( 4 );;
gap> CoincidenceReidemeisterSpectrum( N );
[ 1, 2, 4 ]
gap> Q := QuaternionGroup( 8 );;
gap> ReidemeisterSpectrum(Q);
[ 2, 3, 5 ]
gap> ExtendedReidemeisterSpectrum(Q);
[ 1, 2, 3, 5 ]
gap> CoincidenceReidemeisterSpectrum( Q );
[ 1, 2, 3, 4, 5, 8 ]
gap> CoincidenceReidemeisterSpectrum( Q, N );
[ 2, 4 ]
gap> CoincidenceReidemeisterSpectrum( N, Q );
[ 2, 4, 6, 8 ]
gap> A := Image( IsomorphismPcpGroup( AlternatingGroup( 4 ) ) );;
gap> ReidemeisterSpectrum(A);
[ 2, 4 ]
gap> ExtendedReidemeisterSpectrum(A);
[ 1, 2, 3, 4 ]
gap> CoincidenceReidemeisterSpectrum(A);
[ 1, 2, 3, 4, 6, 12 ]
gap> CoincidenceReidemeisterSpectrum( Q, A );
[ 3, 4, 5, 6, 8, 12 ]
gap> CoincidenceReidemeisterSpectrum( A, Q );
[ 8 ]

#
gap> STOP_TEST( "finite_pc_double.tst" );