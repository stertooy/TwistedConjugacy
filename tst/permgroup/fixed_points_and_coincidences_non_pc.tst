gap> START_TEST( "Testing TwistedConjugacy for PermGroups: fixed point groups and coincidence groups for non-polycyclic groups" );

# Preparation
gap> filt := IsPermGroup;;
gap> G := Group( [ (3,4)(5,6), (1,2,3)(4,5,7) ] );;
gap> A := AlternatingGroup( filt, 6 );;
gap> S := SymmetricGroup( filt, 5 );;
gap> imgs1 := [ (1,3,4,6,7,5,2), (3,4)(5,6) ];;
gap> imgs2 := [ (1,2,3,7,4,6,5), (3,4)(5,6) ];;
gap> endo1 := GroupHomomorphismByImages( G, G, [ (1,6,7,4,3,5,2), (3,5)(4,6) ], imgs1 );;
gap> endo2 := GroupHomomorphismByImages( G, G, [ (1,6,7,4,3,5,2), (3,5)(4,6) ], imgs2 );;
gap> hom1 := GroupHomomorphismByImages( S, A, [ (1,2)(3,5,4), (2,3)(4,5) ], [ (1,2)(3,4), () ] );;
gap> hom2 := GroupHomomorphismByImages( S, A, [ (1,2)(3,5,4), (2,3)(4,5) ], [ (1,4)(3,6), () ] );;

# Fixed point group of an endomorphism
gap> Fixd := FixedPointGroup( endo2 );;
gap> Size( Fixd );
8
gap> ForAll( Fixd, g -> g = g^endo2 );
true
gap> ForAny( G, g -> not g in Fixd and g = g^endo2 );
false

# Coincidence group of two endomorphisms
gap> Coin := CoincidenceGroup( endo1, endo2 );;
gap> Size( Coin );
4
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
60
gap> ForAll( Coin, s -> s^hom1 = s^hom2 );
true
gap> ForAny( S, s -> not s in Coin and s^hom1 = s^hom2 );
false

#
gap> STOP_TEST( "fixed_points_and_coincidences_non_pc.tst" );
