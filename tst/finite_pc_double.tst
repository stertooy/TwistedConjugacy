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
"e^(-2z) * (1-z)^-4"
gap> ZetaK := ReidemeisterZeta( phiK, psiK );;
gap> ZetaK( 10 );
3.14152e-13
gap> L := CyclicGroup( 4 );;
gap> phiK := GroupHomomorphismByImages( K, K, [ K.1 ], [ K.1^2 ] );;
gap> psiK := GroupHomomorphismByImages( K, K, [ K.1 ], [ One( K ) ] );;
gap> ReidemeisterZetaCoefficients( phiK, psiK );
[ [ 2 ], [ 4 ] ]
gap> PrintReidemeisterZeta( phiK , psiK );
"e^(-2z) * (1-z)^-4"
gap> ZetaK := ReidemeisterZeta( phiK, psiK );;
gap> 10^13*ZetaK( 10 );
3.14152

#
gap> STOP_TEST( "finite_pc_double.tst" );
