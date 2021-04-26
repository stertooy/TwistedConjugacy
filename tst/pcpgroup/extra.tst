gap> START_TEST( "Testing Double Twisted Conjugacy for infinite non-nilpotent-by-finite groups" );

#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> idG := IdentityMapping( G );;
gap> ReidemeisterNumber( idG ); # quotient gives infinity
infinity
gap> FixedPointGroup( idG ) = G;
true
gap> trivG := GroupHomomorphismByFunction( G, G, g -> One( G ) );;
gap> Size( ReidemeisterClasses( trivG ) );
1

#
gap> F := FittingSubgroup( G );;
gap> incF := GroupHomomorphismByImagesNC( F, G, GeneratorsOfGroup( F ), GeneratorsOfGroup( F ) );;
gap> homF := GroupHomomorphismByImagesNC( F, F, [ F.1, F.2, F.3 ], [ F.1^2*F.2, F.1^3*F.2^2, F.3 ] );;
gap> ReidemeisterClasses( incF, incF );
fail
gap> tcc := ReidemeisterClass( incF, incF, One( G ) );;
gap> Size( tcc );
1
gap> List( tcc );
[ id ]
gap> CoincidenceGroup( incF, incF ) = F;
true
gap> ReidemeisterNumber( homF );
infinity
gap> FixedPointGroup( homF );
Pcp-group with orders [ 0 ]

#
gap> N := Subgroup( G, [ G.1^2, G.2 ] );;
gap> imgs1 := [ G.1*G.4^-1, G.3, G.2*G.3^2*G.4^2, G.4^-1 ];;
gap> imgs2 := [ G.1, G.2^2*G.3*G.4^2, G.2*G.3*G.4, G.4 ];;
gap> hom1 := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs1 );;
gap> hom2 := GroupHomomorphismByImagesNC( G, G, GeneratorsOfGroup( G ), imgs2 );;
gap> hom1N := RestrictedHomomorphism( hom1, N, N );;
gap> hom2N := RestrictedHomomorphism( hom2, N, N );;
gap> ReidemeisterNumber( hom1N, hom2N );
4
gap> incN := GroupHomomorphismByImages( N, G, GeneratorsOfGroup( N ), GeneratorsOfGroup( N ) );;
gap> ReidemeisterClasses( incN, incN );
fail

#
gap> p := NaturalHomomorphismByNormalSubgroup( G, FittingSubgroup( G ) );;
gap> Q := Image( p );;
gap> trivQG := GroupHomomorphismByImages( Q, G, [ Q.1 ], [ One( G ) ] );;
gap> ReidemeisterClasses( trivQG, trivQG );
fail
gap> ReidemeisterNumber( trivQG, trivQG );
infinity
gap> IsTwistedConjugate( p, p, Q.1, One( Q ) );
false

#
gap> G2 := ExamplesOfSomePcpGroups( 2 );;
gap> idG2 := IdentityMapping( G2 );;
gap> ReidemeisterNumber( idG2 );
infinity
gap> IsTwistedConjugate( idG2, G2.1, G2.2 );
false

#
gap> G3 := ExamplesOfSomePcpGroups( 11 );;
gap> idG3 := IdentityMapping( G3 );;
gap> IsTwistedConjugate( idG3, G3.4, G3.5 );
false

#
gap> H := DirectProduct( ExamplesOfSomePcpGroups( 4 ), AbelianPcpGroup( 1 ) );;
gap> G4 := ExamplesOfSomePcpGroups( 4 );;
gap> hom1H := GroupHomomorphismByImagesNC( H, G4, [ H.1, H.2, H.4 ],[ G4.1^2, One( G4 ), One( G4 ) ] );;
gap> hom2H := GroupHomomorphismByImagesNC( H, G4, [ H.1, H.2, H.4 ],[ G4.3, One( G4 ), One( G4 ) ] );;
gap> hom3H := GroupHomomorphismByImagesNC( H ,G4, [ H.1, H.2, H.4 ],[ G4.1, G4.2^2, One( G4 ) ] );;
gap> ReidemeisterNumber( hom1H, hom2H );
infinity
gap> IsTwistedConjugate( hom1H, hom2H, G4.1, G4.2 );
false
gap> CoincidenceGroup( hom1H, hom2H ) = FittingSubgroup( H );
true
gap> R := TwistedConjugacyClasses( hom1H, hom3H );;
gap> Representative( R[1] ) = One( G4 );
true
gap> Size( R );
4
gap> NrTwistedConjugacyClasses( hom1H, hom3H );
4
gap> IsTwistedConjugate( hom1H, hom3H, G4.2, G4.3 );
false
gap> IsTwistedConjugate( hom1H, hom3H, G4.2, G4.2*G4.3^2 );
true
gap> CoincidenceGroup( hom1H, hom3H ) = Centre( H );
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
gap> ReidemeisterNumber( hom1G5, hom1G5 );
208
gap> ReidemeisterNumber( hom2G5, hom2G5 );
368
gap> ReidemeisterNumber( hom1G5, hom2G5 );
180
gap> CoincidenceGroup( hom1G5, hom2G5 ) = FittingSubgroup( G5 );
true
gap> inc1S6 := GroupHomomorphismByImages( S6, G5, [ (1,2,3,4,5,6), (1,2) ] , [ G5.1, G5.1 ] );;
gap> inc2S6 := GroupHomomorphismByImages( S6, G5, [ (1,2,3,4,5,6), (1,2) ] , [ G5.1*G5.4, G5.1*G5.4 ] );;
gap> CoincidenceGroup( inc1S6, inc2S6 );
Group([ (2,6,5,4,3), (1,3,5)(2,4,6) ])
gap> ReidemeisterClasses( inc1S6, inc2S6 );
fail
gap> ReidemeisterNumber( inc2S6, inc2S6 );
infinity

#
gap> STOP_TEST( "infinite_non_nbf.tst" );
