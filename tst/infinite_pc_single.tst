gap> START_TEST( "Testing Twisted Conjugacy for infinite pc groups" );

#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> gens := GeneratorsOfGroup( G );;
gap> i := 2;; # The Reidemeister number of phi should be 2*i if i <> 0, and infinity if i = 0
gap> imgs := [ G.1*G.4^-1, G.3, G.2*(G.3*G.4)^i, G.4^-1  ];;
gap> phi := GroupHomomorphismByImages( G, G, gens, imgs );;
gap> tc := TwistedConjugation( phi );;
gap> IsTwistedConjugate( phi, G.2, G.3^2 );
false
gap> g := RepresentativeTwistedConjugation( phi, G.2, G.2*G.3^2 );
g2*g3*g4
gap> tc( G.2, g ) = G.2*G.3^2;
true
gap> tcc := ReidemeisterClass( phi, G.3 );;
gap> Representative( tcc );
g3
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = G;
true
gap> NrTwistedConjugacyClasses( phi );
4
gap> ReidemeisterZetaCoefficients( phi );
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 3rd choice method found for `ReidemeisterZetaCoefficients' on 1 argu\
ments
gap> ReidemeisterZeta( phi );
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 3rd choice method found for `ReidemeisterZeta' on 1 arguments
gap> PrintReidemeisterZeta( phi );
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 3rd choice method found for `PrintReidemeisterZeta' on 1 arguments
gap> id := IdentityMapping( G );;
gap> ReidemeisterNumber( id ); # quotient gives infinity
infinity
gap> IsTwistedConjugate( id, G.2, G.3^2 );
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 3rd choice method found for `RepTwistConjToIdByNormal' on 4 argument\
s
gap> i := 0;;
gap> imgs := [ G.4^-1*G.1, G.3, G.4^i*G.2*G.3^i, G.4^-1  ];;
gap> psi := GroupHomomorphismByImages( G, G, GeneratorsOfGroup( G ), imgs );;
gap> ReidemeisterNumber( psi ); # derived subgroup gives infinity
infinity
gap> triv := GroupHomomorphismByFunction( G, G, g -> One( G ) );;
gap> ReidemeisterClasses( triv );
[ id^G ]

#
gap> STOP_TEST( "infinite_pc_single.tst" );
