gap> START_TEST( "Testing Double Twisted Conjugacy for infinite pc groups" );

#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> gens := GeneratorsOfGroup( G );;
gap> imgs1 := [ G.1*G.4^-1, G.3, G.2*G.3^2*G.4^2, G.4^-1  ];;
gap> phi := GroupHomomorphismByImagesNC( G, G, gens, imgs1 );;
gap> imgs2 := [ G.1, G.2^2*G.3*G.4^2, G.2*G.3*G.4, G.4  ];;
gap> psi := GroupHomomorphismByImagesNC( G, G, gens, imgs2 );;
gap> tc := TwistedConjugation( phi, psi );;
gap> IsTwistedConjugate( phi, G.2, G.3^2 );
false
gap> g := RepresentativeTwistedConjugation( phi, psi, G.2, G.2*G.3^2 );;
gap> tc( G.2, g ) = G.2*G.3^2;
true
gap> tcc := ReidemeisterClass( phi, psi, G.3 );;
gap> Print( tcc, "\n" );
ReidemeisterClass( [ [ g1, g2, g3, g4 ] -> [ g1*g4^-1, g3, g2*g3^2*g4^2, g4^-1\
 ], [ g1, g2, g3, g4 ] -> [ g1, g2^2*g3*g4^2, g2*g3*g4, g4 ] ], g3 )
gap> Size( tcc );
infinity
gap> List( tcc );
fail
gap> Representative( tcc );
g3
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = G;
true
gap> R := TwistedConjugacyClasses( phi, psi );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
4
gap> NrTwistedConjugacyClasses( phi, psi );
4
gap> IsTrivial( CoincidenceGroup( phi, psi ) );
true
gap> F := FittingSubgroup( G );;
gap> f := GeneratorsOfGroup( F );;
gap> i := GroupHomomorphismByImagesNC( F, G, f, f );;
gap> ReidemeisterClasses( i, i );
fail
gap> tcc := ReidemeisterClass( i, i, One( G ) );;
gap> Size( tcc );
1
gap> List( tcc );
[ id ]
gap> CoincidenceGroup( i, i ) = F;
true
gap> xi := GroupHomomorphismByImagesNC( F, F, [ F.1, F.2, F.3 ], [ F.1^2*F.2, F.1^3*F.2^2, F.3 ] );;
gap> ReidemeisterNumber( xi );
infinity
gap> FixedPointGroup( xi );
Pcp-group with orders [ 0 ]
gap> N := Subgroup( G, [ G.1^2, G.2 ] );;
gap> phiN := RestrictedHomomorphism( phi, N, N );;
gap> psiN := RestrictedHomomorphism( psi, N, N );;
gap> ReidemeisterNumber( phiN, psiN );
4
gap> i := GroupHomomorphismByImages( N, G, GeneratorsOfGroup( N ), GeneratorsOfGroup( N ) );;
gap> ReidemeisterClasses( i, i );
fail
gap> Q := G/FittingSubgroup(G);;
gap> j := GroupHomomorphismByImages( Q, G, [Q.1], [One(G)] );;
gap> ReidemeisterClasses( j, j );
fail
gap> ReidemeisterNumber( j, j );
infinity

#
gap> STOP_TEST( "infinite_pc_double.tst" );
