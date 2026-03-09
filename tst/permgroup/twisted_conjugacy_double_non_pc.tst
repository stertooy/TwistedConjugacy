gap> START_TEST( "Testing TwistedConjugacy for PermGroups: homomorphisms of non-polycyclic groups" );

#
gap> G := AlternatingGroup( 6 );;
gap> H := SymmetricGroup( 5 );;
gap> hom1 := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ], [ (1,2)(3,4), () ] );;
gap> hom2 := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ], [ (1,4)(3,6), () ] );;

#
gap> tcc := ReidemeisterClass( hom1, hom2, (4,6,5) );;
gap> Representative( tcc ) = (4,6,5);
true
gap> Size( tcc );
2
gap> Length( List( tcc ) );
2
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = H;
true
gap> R := TwistedConjugacyClasses( hom1, hom2 );;
gap> Representative( R[1] ) = One( G );
true
gap> Size( R );
184
gap> ReidemeisterNumber( hom1, hom2 );
184

#
gap> tc := TwistedConjugation( hom1, hom2 );;
gap> IsTwistedConjugate( hom1, hom2, Random( R[1] ), Random( R[2] ) );
false
gap> RepresentativeTwistedConjugation( hom1, hom2, Random( R[1] ), Random( R[2] ) );
fail
gap> g1 := Random( R[3] );;
gap> g2 := Random( R[3] );;
gap> g := RepresentativeTwistedConjugation( hom1, hom2, g1, g2 );;
gap> tc( g1, g ) = g2;
true

#
gap> h := Random( H );;
gap> tc2 := TwistedConjugation( hom2, hom1 );;
gap> g1L := [ g1, g2 ];;
gap> g2L := [ tc( g1, h ), tc2( g2, h ) ];;
gap> hom1L := [ hom1, hom2 ];;
gap> hom2L := [ hom2, hom1 ];;
gap> IsTwistedConjugate( hom1L, hom2L, g1L, g2L );
true
gap> h2 := RepresentativeTwistedConjugation( hom1L, hom2L, g1L, g2L );;
gap> g2L = [ tc( g1, h2 ), tc2( g2, h2 ) ];
true
gap> IsTwistedConjugate( hom1L, hom2L, [ G.1, G.2 ], [ G.2, G.1 ] );
false

#
gap> STOP_TEST( "twisted_conjugacy_double_non_pc.tst" );
