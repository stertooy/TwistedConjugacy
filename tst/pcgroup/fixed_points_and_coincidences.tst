gap> START_TEST( "Testing TwistedConjugacy for PcGroups: Fixed Point Groups and Coincidence Groups" );

# Preparation
gap> G := SmallGroup( 252, 34 );;
gap> H := SmallGroup( 84, 5 );;
gap> gensG := GeneratorsOfGroup( G );;
gap> gensH := [ H.1, H.3*H.4 ];;
gap> imgs1 := [ G.1*G.5^6, G.1*G.2*G.3^2*G.4^2*G.5^6, G.3^2, G.3*G.4^2, One( G ) ];;
gap> imgs2 := [ One( G ), G.2*G.3*G.4, G.3, G.3^2*G.4, One( G ) ];;
gap> imgs3 := [ G.2*G.4^2, One( G ) ];;
gap> imgs4 := [ G.1*G.2*G.3*G.5, G.3*G.4^2*G.5^3 ];;
gap> endo1 := GroupHomomorphismByImagesNC( G, G, gensG, imgs1 );;
gap> endo2 := GroupHomomorphismByImagesNC( G, G, gensG, imgs2 );;
gap> hom1 := GroupHomomorphismByImages( H, G, gensH, imgs3 );;
gap> hom2 := GroupHomomorphismByImages( H, G, gensH, imgs4 );;

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

# Coincidence group of two homomorphisms
gap> Coin := CoincidenceGroup( hom1, hom2 );;
gap> Size( Coin );
2
gap> ForAll( Coin, h -> h^hom1 = h^hom2 );
true
gap> ForAny( H, h -> not h in Coin and h^hom1 = h^hom2 );
false

#
gap> STOP_TEST( "endomorphisms.tst" );
