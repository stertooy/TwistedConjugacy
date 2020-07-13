gap> START_TEST( "Testing Double Twisted Conjugacy for nilpotent groups" );

#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> gens := GeneratorsOfGroup( G );;
gap> imgs1 := [ G.1*G.4^-1, G.3, G.2*G.3^2*G.4^2, G.4^-1  ];;
gap> phi := GroupHomomorphismByImages( G, G, gens, imgs1 );;
gap> imgs2 := [ G.1, G.2^2*G.3*G.4^2, G.2*G.3*G.4, G.4  ];;
gap> psi := GroupHomomorphismByImages( G, G, gens, imgs2 );;
gap> F := FittingSubgroup( G );;
gap> phiF := RestrictedEndomorphism( phi, F );;
gap> psiF := RestrictedEndomorphism( psi, F );;
gap> CoincidenceGroup( phiF, psiF );
Pcp-group with orders [  ]
gap> CoincidenceGroup( IdentityMapping( F ), psiF );
Pcp-group with orders [ 0 ]
gap> ReidemeisterNumber( phiF, psiF );
4
gap> p := NaturalHomomorphismByNormalSubgroup( F, Subgroup( F, [ G.4^4 ] ) );;
gap> H := Image( p );;
gap> phiH := InducedEndomorphism( p, phiF );;
gap> psiH := InducedEndomorphism( p, psiF );;
gap> ReidemeisterNumber( phiH, psiH );
4
gap> ReidemeisterClasses( phiH, psiH );
[ id^G, g3^3^G, g1^G, g1*g3^3^G ]
gap> ReidemeisterClasses( IdentityMapping( H ) );
fail
gap> K := ExamplesOfSomePcpGroups( 14 );;
gap> ReidemeisterClasses( IdentityMapping( K ) );
fail
gap> ReidemeisterNumber( IdentityMapping( K ) );
infinity

#
gap> STOP_TEST( "infinite_nilpotent.tst" );
