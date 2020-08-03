gap> START_TEST( "Testing Twisted Conjugacy for infinite npc groups" );

#
gap> S := Group( [ [ [ 1, 0, 0 ], [ 0, -1, 0 ], [ 1/2, 0, 1 ] ], [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] ], [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 1, 1 ] ] ] );;
gap> ReidemeisterNumber( IdentityMapping( S ) );
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 6th choice method found for `ReidemeisterClasses' on 2 arguments
gap> IsTwistedConjugate( IdentityMapping( S ), S.1, S.2 );
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 6th choice method found for `RepTwistConjToId' on 3 arguments

#
gap> STOP_TEST( "infinite_npc.tst" );
