gap> START_TEST( "Testing Twisted Conjugacy for finite pc groups" );

#
# Example of "annoying" zeta function
#
gap> K := Group([ (1,2,3,4,5)(6,9)(7,8), (2,3)(4,5)(6,7)(8,9) ]);;
gap> endo1K := GroupHomomorphismByImagesNC( K, K, [ (1,2,3,4,5)(6,9)(7,8), (2,3)(4,5)(6,7)(8,9) ], [ (1,4,5,2,3)(6,8)(7,9), (2,3)(4,5)(6,9)(7,8) ] );;
gap> endo2K := GroupHomomorphismByImagesNC( K, K, [ (1,2,3,4,5)(6,9)(7,8), (2,3)(4,5)(6,7)(8,9) ], [ (), (1,3)(2,4)(6,7)(8,9) ] );;
gap> IsRationalReidemeisterZeta( endo1K, endo2K );
false
gap> zetaK := ReidemeisterZeta( endo1K, endo2K );
fail
gap> PrintReidemeisterZeta( endo1K, endo2K );
"(1-s)^(-5/3)*(1-E(3)*s)^(1/3*E(3))*(1-E(3)^2*s)^(1/3*E(3)^2)"
gap> ReidemeisterZetaCoefficients( endo1K, endo2K );
[ [ 2, 1, 2 ], [  ] ]

#
gap> STOP_TEST( "finite_pc_single.tst" );
