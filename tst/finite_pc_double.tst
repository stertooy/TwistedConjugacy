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
gap> phi := GroupHomomorphismByImages( H, G, gens, imgs1 );;
gap> psi := GroupHomomorphismByImages( H, G, gens, imgs2 );;
gap> CoincidenceGroup( phi, psi ) = Subgroup( H, [H.2] );
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
gap> phiK := GroupHomomorphismByImages( K, K, [ K.1 ], [ K.1^2 ] );;
gap> psiK := GroupHomomorphismByImages( K, K, [ K.1 ], [ One( K ) ] );;
gap> ReidemeisterZetaCoefficients( phiK, psiK );
[ [ 2 ], [ 4 ] ]
gap> PrintReidemeisterZeta( phiK , psiK );
"exp(-2*s)*(1-s)^(-4)"
gap> F := FreeGroup( 2 );;
gap> L := F/[F.1^24, F.2^5, F.2*F.1*(F.1*F.2^4)^-1 ];;
gap> M := Image( IsomorphismPcGroup( L ) );;
gap> phiM := GroupHomomorphismByImages( M, M, [ M.1, M.2 ], [ M.1^6, One( M ) ] );;
gap> psiM := GroupHomomorphismByImages( M, M, [ M.1, M.2 ], [ One( M ), One( M ) ] );;
gap> PrintReidemeisterZeta(phiM,psiM);
"exp(-90*s-30*s^2)*(1-s)^(-120)"
gap> N := DirectProduct( CyclicGroup( 4 ), CyclicGroup( 2 ), CyclicGroup( 2 ) );;
gap> phiN := GroupHomomorphismByImages( N, N, [ N.1, N.3, N.4 ], [ N.1^2, N.3*N.4, One( N ) ] );;
gap> psiN := GroupHomomorphismByImages( N, N, [ N.1, N.3, N.4 ], [ One( N ), N.3*N.4, N.3 ] );;
gap> HasRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 4 ], [ 4, 8, 8 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"exp(-4*s)*(1-s)^(-20/3)*(1-E(3)^2*s)^(4/3*E(3)^2)*(1-E(3)*s)^(4/3*E(3))"
gap> N := DirectProduct( CyclicGroup( 2 ), CyclicGroup( 2 ), CyclicGroup( 2 ) );;
gap> phiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ One( N ), N.2, N.1*N.2*N.3 ] );;
gap> psiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ One( N ), N.1*N.3, N.1*N.2*N.3 ] );;
gap> HasRationalReidemeisterZeta( phiN, psiN );
true
gap> zeta := ReidemeisterZeta( phiN, psiN );;
gap> s := Indeterminate( Rationals, "s" );;
gap> Value( DenominatorOfRationalFunction( zeta( s ) ), E(3) );
0
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [  ], [ 4, 2, 4, 2, 4, 8 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"(1-s)^(-4)*(1-s^2)*(1-s^6)^(-1)"
gap> phiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ One( N ), N.1, N.2 ] );;
gap> psiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ N.1*N.3, N.2*N.3, N.1*N.2 ] );;
gap> HasRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 1, 1 ], [ 2 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"exp(-s-1/2*s^2)*(1-s)^(-2)"
gap> phiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ One( N ), N.1, N.2 ] );;
gap> psiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ N.1*N.2*N.3, N.1, N.2 ] );;
gap> HasRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 4, 2 ], [ 1 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"exp(3*s+1/2*s^2)*(1-s)^(-1)"
gap> phiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ One( N ), One( N ), N.3 ] );;
gap> psiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ One( N), N.1*N.3, N.1 ] );;
gap> HasRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [ 4, 2 ], [ 4 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"exp(-s^2)*(1-s)^(-4)"
gap> phiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ One( N ), One( N ), N.3 ] );;
gap> psiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ N.3, N.1*N.3, N.2*N.3 ] );;
gap> HasRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [  ], [ 1, 1, 2, 2 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"(1-s)^(-3/2)*(1+E(4)*s)^(-1/4+1/4*E(4))*(1-E(4)*s)^(-1/4-1/4*E(4))"
gap> phiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ One( N ), One( N ), N.3 ] );;
gap> psiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3 ], [ N.1, N.3, N.2 ] );;
gap> HasRationalReidemeisterZeta( phiN, psiN );
false
gap> zeta := ReidemeisterZeta( phiN, psiN );
fail
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [  ], [ 1, 2 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"(1-s)^(-3/2)*(1+s)^(-1/2)"
gap> N := DirectProduct( CyclicGroup( 2 ), CyclicGroup( 2 ), CyclicGroup( 2 ), CyclicGroup( 2 ) );;
gap> phiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3, N.4 ], [ One( N ), N.2, N.1*N.2*N.3, One( N ) ] );;
gap> psiN := GroupHomomorphismByImages( N, N, [ N.1, N.2, N.3, N.4 ], [ One( N ), N.1*N.3, N.1*N.2*N.3, One( N ) ] );;
gap> HasRationalReidemeisterZeta( phiN, psiN );
true
gap> zeta := ReidemeisterZeta( phiN, psiN );;
gap> zeta( 1+E(6) );
-3/784*E(3)-1/98*E(3)^2
gap> ReidemeisterZetaCoefficients( phiN, psiN );
[ [  ], [ 8, 4, 8, 4, 8, 16 ] ]
gap> PrintReidemeisterZeta( phiN, psiN );
"(1-s)^(-8)*(1-s^2)^2*(1-s^6)^(-2)"

#
gap> STOP_TEST( "finite_pc_double.tst" );
