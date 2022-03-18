gap> START_TEST( "Testing TwistedConjugacy for PcGroups: Fixed Point Groups and Coincidence Groups" );

# Preparation
gap> gensG :=  [ (11,16)(12,15)(13,14), (2,4)(3,6)(5,9)(7,8), (1,2,4)(3,5,7)(6,8,9), (1,3,6)(2,5,8)(4,7,9), (10,11,12,13,14,15,16) ];;
gap> gensH := [ (2,7)(3,6)(4,5)(8,9,10,12)(11,17,14,19)(13,18,16,15), (1,2,3,4,5,6,7)(8,11,15)(9,13,17)(10,14,18)(12,16,19) ];;
gap> G := Group( gensG );;
gap> H := Group( gensH );;
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
