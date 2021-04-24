gap> START_TEST( "Testing Double Twisted Conjugacy for finite pc groups" );

#
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
