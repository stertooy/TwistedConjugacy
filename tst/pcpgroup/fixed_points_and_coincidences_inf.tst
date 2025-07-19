gap> START_TEST( "Testing TwistedConjugacy for infinite PcpGroups: fixed point groups and coincidence groups" );

# Preparation
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> H := DirectProduct( ExamplesOfSomePcpGroups( 5 ), AbelianPcpGroup( 1 ) );;
gap> F := FittingSubgroup( G );;
gap> G2 := ExamplesOfSomePcpGroups( 4 );;
gap> H2 := DirectProduct( G2, AbelianPcpGroup( 1 ) );;
gap> gensG := GeneratorsOfGroup( G );;
gap> gensH := GeneratorsOfGroup( H );;
gap> gensF := GeneratorsOfGroup( F );;
gap> imgs1 := [ G.1*G.4^-1, G.3, G.2*(G.3*G.4)^3, G.4^-1  ];;
gap> imgs2 := [ G.4^-1*G.1, G.3, G.2, G.4^-1  ];;
gap> imgs3 := [ G.1*G.4^-1, G.3, G.2*G.3^2*G.4^2, G.4^-1, One( G )  ];;
gap> imgs4 := [ G.1, G.2^2*G.3*G.4^2, G.2*G.3*G.4, G.4, One( G )  ];;
gap> imgs5 := [ G.1, G.2, G.3, G.4, One( G ) ];;
gap> imgsF := [ F.1^2*F.2, F.1^3*F.2^2, F.3 ];;
gap> endo1 := GroupHomomorphismByImages( G, G, gensG, imgs1 );;
gap> endo2 := GroupHomomorphismByImages( G, G, gensG, imgs2 );;
gap> hom1 := GroupHomomorphismByImages( H, G, gensH, imgs3 );;
gap> hom2 := GroupHomomorphismByImages( H, G, gensH, imgs4 );;
gap> hom3 := GroupHomomorphismByImages( H, G, gensH, imgs5 );;
gap> idG := IdentityMapping( G );;
gap> incF := GroupHomomorphismByImages( F, G, gensF, gensF );;
gap> homF := GroupHomomorphismByImages( F, F, gensF, imgsF );;
gap> hom4 := GroupHomomorphismByImages( H2, G2, [ H2.1, H2.2, H2.4 ],[ G2.1^2, One( G2 ), One( G2 ) ] );;
gap> hom5 := GroupHomomorphismByImages( H2, G2, [ H2.1, H2.2, H2.4 ],[ G2.3, One( G2 ), One( G2 ) ] );;
gap> hom6 := GroupHomomorphismByImages( H2, G2, [ H2.1, H2.2, H2.4 ],[ G2.1, G2.2^2, One( G2 ) ] );;

# Fixed point group of an endomorphism
gap> Fixd := FixedPointGroup( endo1 );
Pcp-group with orders [  ]
gap> IsTrivial( Fixd );
true

# Fixed point group of an endomorphism
gap> Fixd := FixedPointGroup( endo2 );
Pcp-group with orders [ 0 ]
gap> ForAll( GeneratorsOfGroup( Fixd ), g -> g = g^endo2 );
true
gap> Fixd = Subgroup( G, [ G.2*G.3*G.4 ] );
true

# Fixed point group of an endomorphism
gap> Fixd := FixedPointGroup( idG );
Pcp-group with orders [ 2, 0, 0, 0 ]
gap> Fixd = G;
true

# Coincidence group of two endomorphisms
gap> Coin := CoincidenceGroup( endo1, endo2 );
Pcp-group with orders [ 2, 0, 0 ]
gap> ForAll( GeneratorsOfGroup( Coin ), g -> g^endo1 = g^endo2 );
true
gap> Coin = Subgroup( G, [ G.1, G.2, G.4 ] );
true

# Coincidence group of three endomorphisms
gap> Coin := CoincidenceGroup( idG, endo1, endo2 );;
gap> IsTrivial( Coin );
true

# Coincidence group of two homomorphisms
gap> Coin := CoincidenceGroup( hom1, hom2 );
Pcp-group with orders [ 0 ]
gap> ForAll( GeneratorsOfGroup( Coin ), h -> h^hom1 = h^hom2 );
true
gap> Coin = Subgroup( H, [ H.5 ] );
true

# Coincidence group of three endomorphisms
gap> Coin := CoincidenceGroup( hom1, hom2, hom3 );
Pcp-group with orders [ 0 ]
gap> ForAll( GeneratorsOfGroup( Coin ), h -> h^hom1 = h^hom2 and h^hom1 = h^hom3 );
true
gap> Coin = Subgroup( H, [ H.5 ] );
true

# Fitting subgroup
gap> CoincidenceGroup( incF, incF ) = F;
true
gap> FixedPointGroup( homF );
Pcp-group with orders [ 0 ]

#
gap> CoincidenceGroup( hom4, hom5 ) = FittingSubgroup( H2 );
true
gap> CoincidenceGroup( hom4, hom6 ) = Centre( H2 );
true
gap> CoincidenceGroup( hom4, hom5, hom6 ) = Centre( H2 );
true

#
gap> DG := DirectProduct( G, G );;
gap> G5 := DG / Centre( DG );;
gap> p5 := NaturalHomomorphismByNormalSubgroup( G5, FittingSubgroup( G5 ) );;
gap> S6 := SymmetricGroup( 6 );;
gap> K4 := Image( p5 );;
gap> inc1K4 := GroupHomomorphismByImages( K4, S6, [ K4.1, K4.2 ], [ (5,6), (1,2)(3,4) ] );;
gap> inc2K4 := GroupHomomorphismByImages( K4, S6, [ K4.1, K4.2 ], [ (1,3)(4,5), () ] );;
gap> hom1G5 := p5*inc1K4;;
gap> hom2G5 := p5*inc2K4;;
gap> CoincidenceGroup( hom1G5, hom2G5 ) = FittingSubgroup( G5 );
true
gap> inc1S6 := GroupHomomorphismByImages( S6, G5, [ (1,2,3,4,5,6), (1,2) ] , [ G5.1, G5.1 ] );;
gap> inc2S6 := GroupHomomorphismByImages( S6, G5, [ (1,2,3,4,5,6), (1,2) ] , [ G5.1*G5.4, G5.1*G5.4 ] );;
gap> CoincidenceGroup( inc1S6, inc2S6 );
Group([ (2,6,5,4,3), (1,3,5)(2,4,6) ])

#
gap> G6 := DirectProduct( ExamplesOfSomePcpGroups( 5 ), ExamplesOfSomePcpGroups( 1 ) );;
gap> imgs1G6 := [ G6.1*G6.4^-1, G6.3, G6.2*(G6.3*G6.4)^3, G6.4^-1, G6.5, G6.6, G6.7, G6.8  ];;
gap> imgs2G6 := [ G6.4^-1*G6.1, G6.3, G6.2, G6.4^-1, G6.5, G6.6, G6.7, G6.8  ];;
gap> aut1G6 := GroupHomomorphismByImages( G6, G6, GeneratorsOfGroup( G6 ), imgs2G6 );;
gap> aut2G6 := GroupHomomorphismByImages( G6, G6, GeneratorsOfGroup( G6 ), imgs1G6 );;
gap> FixedPointGroup( aut1G6 );
Pcp-group with orders [ 0, 0, 0, 0, 0 ]
gap> FixedPointGroup( aut2G6 );
Pcp-group with orders [ 0, 0, 0, 0 ]
gap> CoincidenceGroup( aut1G6, aut2G6 );
Pcp-group with orders [ 2, 0, 0, 0, 0, 0, 0 ]

#
gap> G8 := ExamplesOfSomePcpGroups( 10 );;
gap> hom1G8 := InnerAutomorphism( G8, G8.1^-1*G8.3^2*G8.4 );;
gap> hom2G8 := InnerAutomorphism( G8, G8.1^-3*G8.3^-1 );;
#@if CHECK_INTSTAB@Polycyclic
gap> CoinG8 := CoincidenceGroup( hom1G8, hom2G8 );
#I  Stabilizer not increasing: exiting.
#I  Stabilizer not increasing: exiting.
#I  Stabilizer not increasing: exiting.
#I  Stabilizer not increasing: exiting.
Pcp-group with orders [ 0, 0, 0 ]
#@else
gap> CoinG8 := CoincidenceGroup( hom1G8, hom2G8 );
Pcp-group with orders [ 0, 0, 0 ]
#@fi
gap> ForAll( GeneratorsOfGroup( CoinG8 ), h -> h^hom1G8 = h^hom2G8 );
true
gap> IsNilpotentByFinite( CoinG8 ) and not IsNilpotent( CoinG8 );
true
gap> FittingSubgroup( CoinG8 ) = FittingSubgroup( G8 );
true
gap> hom3G8 := InnerAutomorphism( G8, G8.1^-2*G8.2^-3*G8.3^-2 );;
gap> hom4G8 := InnerAutomorphism( G8, G8.2^-4*G8.3^-1*G8.4^-2 );;
gap> Coin2G8 := CoincidenceGroup( hom3G8, hom4G8 );
Pcp-group with orders [ 0, 0 ]
gap> ForAll( GeneratorsOfGroup( Coin2G8 ), h -> h^hom3G8 = h^hom4G8 );
true

#
gap> STOP_TEST( "fixed_points_and_coincidences_inf.tst" );
