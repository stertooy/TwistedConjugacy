gap> START_TEST( "Testing Double Twisted Conjugacy for infinite non-nilpotent-by-finite groups" );

#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> id := IdentityMapping( G );;
gap> ReidemeisterNumber( id ); # quotient gives infinity
infinity
gap> FixedPointGroup( id ) = G;
true
gap> triv := GroupHomomorphismByFunction( G, G, g -> One( G ) );;
gap> ReidemeisterClasses( triv );
[ id^G ]
gap> G := ExamplesOfSomePcpGroups( 2 );;
gap> ReidemeisterNumber( IdentityMapping( G ) );
infinity
gap> IsTwistedConjugate( IdentityMapping( G ), G.1, G.2 );
false
gap> G := ExamplesOfSomePcpGroups( 11 );;
gap> IsTwistedConjugate( IdentityMapping( G ), G.4, G.5 );
false


#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> imgs1 := [ G.1*G.4^-1, G.3, G.2*G.3^2*G.4^2, G.4^-1 ];;
gap> imgs2 := [ G.1, G.2^2*G.3*G.4^2, G.2*G.3*G.4, G.4 ];;
gap> phi := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs1 );;
gap> psi := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs2 );;
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
gap> p := NaturalHomomorphismByNormalSubgroup( G, FittingSubgroup( G ) );;
gap> Q := Image( p );;
gap> j := GroupHomomorphismByImages( Q, G, [Q.1], [One(G)] );;
gap> ReidemeisterClasses( j, j );
fail
gap> ReidemeisterNumber( j, j );
infinity
gap> IsTwistedConjugate( p, p, Q.1, One( Q ) );
false


#
gap> H := DirectProduct( ExamplesOfSomePcpGroups( 4 ), AbelianPcpGroup( 1 ) );;
gap> G := ExamplesOfSomePcpGroups( 4 );;
gap> phi := GroupHomomorphismByImagesNC( H, G, [ H.1, H.2, H.4 ],[ G.1^2, One( G ), One( G ) ] );;
gap> psi := GroupHomomorphismByImagesNC( H, G, [ H.1, H.2, H.4 ],[ G.3, One( G ), One( G ) ] );;
gap> khi := GroupHomomorphismByImagesNC( H ,G, [ H.1, H.2, H.4 ],[ G.1, G.2^2, One( G ) ] );;
gap> ReidemeisterNumber( phi, psi );
infinity
gap> IsTwistedConjugate( phi, psi, G.1, G.2 );
false
gap> CoincidenceGroup( phi, psi ) = FittingSubgroup( H );
true
gap> R := TwistedConjugacyClasses( phi, khi );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
4
gap> NrTwistedConjugacyClasses( phi, khi );
4
gap> IsTwistedConjugate( phi, khi, G.2, G.3 );
false
gap> IsTwistedConjugate( phi, khi, G.2, G.2*G.3^2 );
true
gap> CoincidenceGroup( phi, khi ) = Centre( H );
true

#
#@if TestPackageAvailability("polenta",">=1.3.8") = true 
gap> M := Group( [
>   [ [ 1, 0, 0, 0, 1 ], [ 0, 1, 0, 0, 0 ], [ 0, 0, 1, 0, 0 ], [ 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 1 ] ],
>   [ [ 1, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 1 ], [ 0, 0, 1, 0, 0 ], [ 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 1 ] ],
>   [ [ 1, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0 ], [ 0, 0, 1, 0, 1 ], [ 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 1 ] ],
>   [ [ 1, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0 ], [ 0, 0, 1, 0, 0 ], [ 0, 0, 0, 1, 1 ], [ 0, 0, 0, 0, 1 ] ],
>   [ [ 0, 1, 0, 0, 0 ], [ 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0 ], [ 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 1 ] ],
>   [ [ 0, 1, 0, 0, 0 ], [ 0, 0, 1, 0, 0 ], [ 0, 0, 0, 1, 0 ], [ 1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1 ] ]
> ] );;
gap> iso := IsomorphismPcpGroup( M );;
gap> G := Image( iso );;
gap> p := NaturalHomomorphismByNormalSubgroup( G, FittingSubgroup( G ) );;
gap> CoincidenceGroup( p, p ) = G;
true
gap> S5 := SymmetricGroup( 5 );;
gap> S4 := SymmetricGroup( 4 );;
gap> iso2 := IsomorphismGroups( Image( p ), S4 );;
gap> gens := GeneratorsOfGroup( S4 );;
gap> inc := GroupHomomorphismByImages( S4, S5, gens, gens );;
gap> q := p*iso2*inc;;
gap> CoincidenceGroup( q, q ) = G;
true
gap> ReidemeisterNumber( q, q );
12
gap> hom3 := GroupHomomorphismByImagesNC( G, S5, GeneratorsOfGroup( G ), List( GeneratorsOfGroup( G ), i -> One( S5 ) ) );;
gap> ReidemeisterNumber( q, hom3 );
5
gap> inc2 := GroupHomomorphismByImages( S4, G, [(1,2),(1,2,3,4)] , List( [M.5,M.6], i -> i^iso ) );;
gap> ReidemeisterClasses( inc2, inc2 );
fail
gap> ReidemeisterNumber( inc2, inc2 );
infinity
#@fi

#
gap> STOP_TEST( "infinite_non_nbf.tst" );
