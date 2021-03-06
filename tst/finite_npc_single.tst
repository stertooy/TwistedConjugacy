gap> START_TEST( "Testing Twisted Conjugacy for finite non-pc groups" );

#
gap> G := Group([ (3,4)(5,6), (1,2,3)(4,5,7) ]);;
gap> phi := GroupHomomorphismByImages( G, G, [ (2,7)(4,6), (1,4,5,6,7,2,3) ], [ (2,4)(6,7), (1,2,4,6,5,7,3) ] );;
gap> FixedPointGroup( phi ) = Subgroup( G, [ (1,3,6)(4,5,7) ] );
true
gap> tc := TwistedConjugation( phi );;
gap> IsTwistedConjugate( phi, G.1, G.1^2 );
false
gap> g := RepresentativeTwistedConjugation( phi, G.1, G.2 );;
gap> tc( G.1, g ) = G.2;
true
gap> tcc := ReidemeisterClass( phi, G.1 );
(3,4)(5,6)^G
gap> Print( tcc, "\n" );
ReidemeisterClass( [ [ (2,7)(4,6), (1,4,5,6,7,2,3) ] -> [ (2,4)(6,7), (1,2,4,6\
,5,7,3) ], [ (3,4)(5,6), (1,2,3)(4,5,7) ] -> [ (3,4)(5,6), (1,2,3)(4,5,7) ] ],\
 (3,4)(5,6) )
gap> Representative( tcc );
(3,4)(5,6)
gap> Size( tcc );
42
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
[ 4, 6 ]
gap> ExtendedReidemeisterSpectrum( G );
[ 1, 4, 6 ]
gap> zeta1 := ReidemeisterZeta( phi );;
gap> zeta1( 10/3 );
-729/218491
gap> PrintReidemeisterZeta( phi );
"(1-z)^-4 * (1-z^2)^-1"
gap> ReidemeisterZetaCoefficients( phi );
[ [  ], [ 4, 6 ] ]

#
gap> STOP_TEST( "finite_npc_single.tst" );
