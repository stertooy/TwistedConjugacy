gap> START_TEST( "Testing TwistedConjugacy for PcpGroups: derivations" );

# Preparation
gap> H := PcGroupToPcpGroup( PcGroupCode( 149167619499417164, 72 ) );;
gap> G := PcGroupToPcpGroup( PcGroupCode( 5551210572, 72 ) );;
gap> gensG := [ G.4, G.1*G.2 ];;
gap> imgsG := [ G.4*G.5, G.1*G.2^2*G.3^2*G.4 ];;
gap> auts := [ InnerAutomorphism( G, G.2 ), GroupHomomorphismByImages( G, G, gensG, imgsG ) ];;
gap> gensH := [ H.2, H.1*H.4 ];;
gap> act := GroupHomomorphismByImages( H, Group( auts ), gensH, auts );;

# Group derivation 1
gap> imgs := [ G.2^2, G.1*G.2 ];;
gap> derv := GroupDerivationByImages( H, G, gensH, imgs, act );
Group derivation [ g2, g1*g4 ] -> [ g2^2, g1*g2 ]
gap> GroupDerivationInfo( derv );
rec(
    lhs := [ g1, g2, g3, g4, g5 ] -> [ g1, g2, g3, g4, g5 ],
    rhs := [ g2, g1*g4 ] -> [ g2*g7^2, g1*g4*g6*g7 ],
    sdp := Pcp-group with orders [ 2, 3, 3, 2, 2, 2, 3, 3, 2, 2 ]
)
gap> Print( derv );
<group derivation: Pcp-group with orders [ 2, 3, 3, 2, 2 ] -> Pcp-group with orders [ 2, 3, 3, 2, 2 ] >
gap> K := Kernel( derv );
Pcp-group with orders [  ]
gap> h := H.1*H.3^2*H.5;;
gap> g := ImagesRepresentative( derv, h );
g1*g2*g3^2*g4*g5
gap> ImagesElm( derv, h );
[ g1*g2*g3^2*g4*g5 ]
gap> x := PreImagesRepresentative( derv, g );;
gap> g = ImagesRepresentative( derv, x );
true
gap> PreImagesElm( derv, g ) = RightCoset( K, x );
true
gap> imgH := ImagesSource( derv );
Group derivation image in Pcp-group with orders [ 2, 3, 3, 2, 2 ]
gap> Print( imgH );
<group derivation image: Pcp-group with orders [ 2, 3, 3, 2, 2 ] -> Pcp-group with orders [ 2, 3, 3, 2, 2 ] >
gap> g in imgH;
true
gap> Random( imgH ) in imgH;
true
gap> Size( imgH ) = Length( List( imgH ) );
true
gap> imgK := ImagesSet( derv, K );
Group derivation image in Pcp-group with orders [ 2, 3, 3, 2, 2 ]
gap> Print( imgK );
<group derivation image: Pcp-group with orders [  ] -> Pcp-group with orders [ 2, 3, 3, 2, 2 ] >
gap> Size( imgK );
1
gap> List( imgK );
[ id ]
gap> IsInjective( derv ) or IsSurjective( derv );
true
gap> IsBijective( derv );
true

# Group derivation 2
gap> imgs := [ G.5, G.2 ];;
gap> derv := GroupDerivationByImages( H, G, gensH, imgs, act );
Group derivation [ g2, g1*g4 ] -> [ g5, g2 ]
gap> GroupDerivationInfo( derv );
rec(
    lhs := [ g1, g2, g3, g4, g5 ] -> [ g1, g2, g3, g4, g5 ],
    rhs := [ g2, g1*g4 ] -> [ g2*g10, g1*g4*g7 ],
    sdp := Pcp-group with orders [ 2, 3, 3, 2, 2, 2, 3, 3, 2, 2 ]
)
gap> Print( derv );
<group derivation: Pcp-group with orders [ 2, 3, 3, 2, 2 ] -> Pcp-group with orders [ 2, 3, 3, 2, 2 ] >
gap> K := Kernel( derv );
Pcp-group with orders [ 3, 3 ]
gap> h := H.1*H.3^2*H.5;;
gap> g := ImagesRepresentative( derv, h );
g2*g4*g5
gap> ImagesElm( derv, h );
[ g2*g4*g5 ]
gap> x := PreImagesRepresentative( derv, g );;
gap> g = ImagesRepresentative( derv, x );
true
gap> PreImagesElm( derv, g ) = RightCoset( K, x );
true
gap> imgH := ImagesSource( derv );
Group derivation image in Pcp-group with orders [ 2, 3, 3, 2, 2 ]
gap> Print( imgH );
<group derivation image: Pcp-group with orders [ 2, 3, 3, 2, 2 ] -> Pcp-group with orders [ 2, 3, 3, 2, 2 ] >
gap> g in imgH;
true
gap> G.1 in imgH;
false
gap> Random( imgH ) in imgH;
true
gap> Size( imgH ) = Length( List( imgH ) );
true
gap> imgK := ImagesSet( derv, K );
Group derivation image in Pcp-group with orders [ 2, 3, 3, 2, 2 ]
gap> Print( imgK );
<group derivation image: Pcp-group with orders [ 3, 3 ] -> Pcp-group with orders [ 2, 3, 3, 2, 2 ] >
gap> Size( imgK );
1
gap> List( imgK );
[ id ]
gap> IsInjective( derv ) or IsSurjective( derv );
false
gap> IsBijective( derv );
false

#
gap> STOP_TEST( "derivations.tst" );
