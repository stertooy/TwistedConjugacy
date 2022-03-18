gap> START_TEST( "Testing TwistedConjugacy for PermGroups: extra tests" );

#
# gap> K := Group([ (1,2,3,4,5)(6,9)(7,8), (2,3)(4,5)(6,7)(8,9) ]);;
# gap> imgs1 := [ (1,4,5,2,3)(6,8)(7,9), (2,3)(4,5)(6,9)(7,8) ];;
# gap> imgs2 := [ (), (1,3)(2,4)(6,7)(8,9) ];;
# gap> endo1K := GroupHomomorphismByImagesNC( K, K, [ (1,2,3,4,5)(6,9)(7,8), (2,3)(4,5)(6,7)(8,9) ], imgs1 );;
# gap> endo2K := GroupHomomorphismByImagesNC( K, K, [ (1,2,3,4,5)(6,9)(7,8), (2,3)(4,5)(6,7)(8,9) ], imgs2 );;
# gap> IsRationalReidemeisterZeta( endo1K, endo2K );
# false
# gap> zetaK := ReidemeisterZeta( endo1K, endo2K );
# fail
# gap> PrintReidemeisterZeta( endo1K, endo2K );
# "(1-s)^(-5/3)*(1-E(3)*s)^(1/3*E(3))*(1-E(3)^2*s)^(1/3*E(3)^2)"
# gap> ReidemeisterZetaCoefficients( endo1K, endo2K );
# [ [ 2, 1, 2 ], [  ] ]

#
gap> STOP_TEST( "extra.tst" );
