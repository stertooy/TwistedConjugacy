gap> START_TEST( "Testing TwistedConjugacy for PcpGroups: representatives in a normal subgroup" );

# Finite quotient: lifts must belong to N.
gap> G := ExamplesOfSomePcpGroups( 3 );;
gap> N := Subgroup( G, [ G.1 * G.2, G.2 ^ 2 ] );;
gap> H := Subgroup( G, [ G.1 ^ 2, G.2 ^ 4 ] );;
gap> gens := GeneratorsOfGroup( H );;
gap> hom1 := GroupHomomorphismByImages( H, G, gens, List( gens, h -> One( G ) ) );;
gap> hom2 := GroupHomomorphismByImages( H, G, gens, gens );;
gap> IsNormal( G, N ) and IsSubgroup( N, H );
true
gap> R := RepresentativesTwistedConjugacyClasses( hom1, hom2, N );;
gap> ForAll( R, r -> r in N );
true
gap> Length( R ) = Index( N, H );
true
gap> R[ 1 ] = One( G );
true

# The action sends r to r*h, so test distinctness using r^-1*s in H.
gap> ForAll( R, r -> Number( R, s -> r ^ -1 * s in H ) = 1 );
true

# Central quotient: lifts must belong to N.
gap> coll := FromTheLeftCollector( 3 );;
gap> SetConjugate( coll, 2, 1, [ 2, 1, 3, 1 ] );;
gap> G := PcpGroupByCollector( coll );;
gap> N := Subgroup( G, [ G.1 ^ 2 * G.3, G.2 ^ 2, G.3 ^ 2 ] );;
gap> H := Subgroup( G, [ G.1 ^ 4 * G.3 ^ 2, G.2 ^ 4, G.3 ^ 4 ] );;
gap> gens := GeneratorsOfGroup( H );;
gap> hom1 := GroupHomomorphismByImages( H, G, gens, List( gens, h -> One( G ) ) );;
gap> hom2 := GroupHomomorphismByImages( H, G, gens, gens );;
gap> IsNormal( G, N ) and IsSubgroup( N, H );
true
gap> R := RepresentativesTwistedConjugacyClasses( hom1, hom2, N );;
gap> ForAll( R, r -> r in N );
true
gap> Length( R ) = Index( N, H );
true
gap> R[ 1 ] = One( G );
true
gap> ForAll( R, r -> Number( R, s -> r ^ -1 * s in H ) = 1 );
true

#
gap> STOP_TEST( "twisted_conjugacy_subgroup.tst" );
