gap> START_TEST( "Testing TwistedConjugacy for PermGroups: fixed point groups and coincidence groups" );

# Preparation
gap> filt := IsPermGroup;;
gap> G := Group( [ (11,16)(12,15)(13,14), (2,4)(3,6)(5,9)(7,8), (1,2,4)(3,5,7)(6,8,9), (1,3,6)(2,5,8)(4,7,9), (10,11,12,13,14,15,16) ] );;
gap> H := Group( [ (2,7)(3,6)(4,5)(8,9,10,12)(11,17,14,19)(13,18,16,15), (8,10)(9,12)(11,14)(13,16)(15,18)(17,19), (8,11,15)(9,13,17)(10,14,18)(12,16,19), (1,2,3,4,5,6,7) ] );;
gap> T := TrivialGroup( filt );;
gap> gensG := GeneratorsOfGroup( G );;
gap> gensH := [ H.1, H.3*H.4 ];;
gap> imgs1 := [ G.1*G.5^6, G.1*G.2*G.3^2*G.4^2*G.5^6, G.3^2, G.3*G.4^2, One( G ) ];;
gap> imgs2 := [ One( G ), G.2*G.3*G.4, G.3, G.3^2*G.4, One( G ) ];;
gap> imgs3 := [ G.1*G.5^6, G.2*G.3*G.4^2, G.3, G.3*G.4^2, G.5^2 ];;
gap> imgs4 := [ G.1*G.5^3, G.2*G.4^2, G.3^2*G.4, G.3*G.4, G.5^5 ];;
gap> imgs5 := [ G.1, G.2, G.3*G.4^2, G.3^2*G.4^2, G.5 ];;
gap> imgs6 := [ G.2*G.4^2, One( G ) ];;
gap> imgs7 := [ G.1*G.2*G.3*G.5, G.3*G.4^2*G.5^3 ];;
gap> endo1 := GroupHomomorphismByImages( G, G, gensG, imgs1 );;
gap> endo2 := GroupHomomorphismByImages( G, G, gensG, imgs2 );;
gap> endo3 := GroupHomomorphismByImages( G, G, gensG, imgs3 );;
gap> endo4 := GroupHomomorphismByImages( G, G, gensG, imgs4 );;
gap> endo5 := GroupHomomorphismByImages( G, G, gensG, imgs5 );;
gap> hom1 := GroupHomomorphismByImages( H, G, gensH, imgs6 );;
gap> hom2 := GroupHomomorphismByImages( H, G, gensH, imgs7 );;
gap> idT := IdentityMapping( T );;
gap> triv := GroupHomomorphismByFunction( G, TrivialSubgroup( G ), g -> One( G ) );;

# Fixed point group of an endomorphism
gap> Fixd := FixedPointGroup( endo2 );;
gap> Size( Fixd );
3
gap> ForAll( Fixd, g -> g = g^endo2 );
true
gap> ForAny( G, g -> not g in Fixd and g = g^endo2 );
false

# Coincidence group of two endomorphisms
gap> Coin := CoincidenceGroup( endo1, endo2 );;
gap> Size( Coin );
14
gap> ForAll( Coin, g -> g^endo1 = g^endo2 );
true
gap> ForAny( G, g -> not g in Coin and g^endo1 = g^endo2 );
false

# Coincidence group of three endomorphisms
gap> Coin := CoincidenceGroup( IdentityMapping( G ), endo1, endo2 );;
gap> IsTrivial( Coin );
true
gap> ForAny( G, g -> not g in Coin and g^endo1 = g^endo2 and g = g^endo2 );
false
gap> CoincidenceGroup( endo3, endo4, endo4 ) = Subgroup( G, [ G.1*G.5, G.2*G.3*G.4 ] );
true

# Coincidence group of two homomorphisms
gap> Coin := CoincidenceGroup( hom1, hom2 );;
gap> Size( Coin );
2
gap> ForAll( Coin, h -> h^hom1 = h^hom2 );
true
gap> ForAny( H, h -> not h in Coin and h^hom1 = h^hom2 );
false

#
gap> IsTrivial( FixedPointGroup( idT ) );
true
gap> CoincidenceGroup( triv, triv, triv, triv ) = G;
true

#
gap> STOP_TEST( "fixed_points_and_coincidences.tst" );
