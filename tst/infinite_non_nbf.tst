gap> START_TEST( "Testing Double Twisted Conjugacy for infinite non-nilpotent-by-finite groups" );

#
gap> H := DirectProduct(ExamplesOfSomePcpGroups( 4 ),AbelianPcpGroup(2));;
gap> G := DirectProduct(ExamplesOfSomePcpGroups( 4 ),AbelianPcpGroup(1));;
gap> hom1 := GroupHomomorphismByImages(H,G,[H.1,H.2,H.4,H.5],[G.1^2,One(G),G.4,One(G)]);;
gap> hom2 := GroupHomomorphismByImages(H,G,[H.1,H.2,H.4,H.5],[G.3,One(G),One(G),G.4]);;
gap> ReidemeisterNumber( hom1, hom2 );
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 6th choice method found for `ReidemeisterClasses' on 2 arguments
gap> IsTwistedConjugate( hom1, hom2, G.4, G.4^2 );
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 6th choice method found for `RepTwistConjToId' on 3 arguments

#
gap> STOP_TEST( "infinite_non_nbf.tst" );
