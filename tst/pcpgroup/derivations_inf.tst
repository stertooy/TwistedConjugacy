gap> START_TEST( "Testing TwistedConjugacy for infinite PcpGroups: derivations" );

# Preparation
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> H := DirectProduct( ExamplesOfSomePcpGroups( 5 ), AbelianPcpGroup( 1 ) );;
gap> gens := GeneratorsOfGroup( H );;
gap> imgs1 := [ G.1*G.4^-1, G.3, G.2*G.3^2*G.4^2, G.4^-1, One( G )  ];;
gap> imgs2 := [ G.1, G.2^2*G.3*G.4^2, G.2*G.3*G.4, G.4, One( G )  ];;
gap> hom1 := GroupHomomorphismByImages( H, G, gens, imgs1 );;
gap> hom2 := GroupHomomorphismByImages( H, G, gens, imgs2 );;
gap> imgs3 := List( gens, h -> ConjugatorAutomorphismNC( G, h^hom1 ) );;
gap> imgs4 := [ G.4, G.2^2*G.4^-2, G.3^-1*G.4^-1, G.4^2, One( G ) ];;
gap> imgs5 := [ G.1, G.2^2*G.4^-2, G.3^-1*G.4^-1, G.4^2, One( G ) ];;
gap> act := GroupHomomorphismByImages( H, Group( imgs3 ), gens, imgs3 );;

# Group derivation by images
gap> derv := GroupDerivationByImages( H, G, gens, imgs4, act );
Group derivation [ g1, g2, g3, g4, g5 ] -> [ g4, g2^2*g4^-2, g3^-1*g4^-1, g4^2, id ]
gap> Print( derv );
<group derivation: Pcp-group with orders [ 2, 0, 0, 0, 0 ] -> Pcp-group with orders [ 2, 0, 0, 0 ] >
gap> K := Kernel( derv );
Pcp-group with orders [ 0 ]
gap> h :=  H.1*H.2^-2*H.3^3*H.4^-4*H.5^5;;
gap> g := ImagesRepresentative( derv, h );
g2^-4*g3^-3*g4^24
gap> ImagesElm( derv, h );
[ g2^-4*g3^-3*g4^24 ]
gap> x := PreImagesRepresentative( derv, g );
gap> g = ImagesRepresentative( derv, x );
true
gap> PreImagesElm( derv, g ) = RightCoset( K, x );
true
gap> imgH := ImagesSource( derv );;
gap> g in imgH;
true
gap> G.1 in imgH;
false
gap> Random( imgH ) in imgH;
true
gap> Size( imgH );
infinity
gap> List( imgH );
fail
gap> imgK := ImagesSet( derv K );;
gap> Size( imgK );
1
gap> List( imgK );
[ id ]
gap> L := Subgroup( H, [ H.1, H.2^3, H.4^2, H.5^5 ] );;

#
gap> STOP_TEST( "derivations_inf.tst" );
