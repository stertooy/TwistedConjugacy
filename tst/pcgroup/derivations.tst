gap> START_TEST( "Testing TwistedConjugacy for PcGroups: derivations" );

# Preparation
gap> H := PcGroupCode( 149167619499417164, 72 );;
gap> G := PcGroupCode( 5551210572, 72 );;
gap> gensG := [ G.4, G.1*G.2 ];;
gap> imgsG := [ G.4*G.5, G.1*G.2^2*G.3^2*G.4 ];;
gap> auts := [ InnerAutomorphismNC( G, G.2 ), GroupHomomorphismByImagesNC( G, G, gensG, imgsG ) ];;
gap> gensH := [ H.2, H.1*H.4 ];;
gap> act := GroupHomomorphismByImagesNC( H, Group( auts ), gensH, auts );;

# Group derivation 1
gap> imgs := [ G.2^2, G.1*G.2 ];;
gap> derv := GroupDerivationByImages( H, G, gensH, imgs, act );
Group derivation [ f2, f1*f4 ] -> [ f2^2, f1*f2 ]
gap> GroupDerivationInfo( derv );
rec(
    lhs := [ f1, f2, f3, f4, f5 ] -> [ f1, f2, f3, f4, f5 ],
    rhs := [ f2, f1*f4 ] -> [ f2*f7^2, f1*f4*f6*f7 ],
    sdp := <pc group of size 5184 with 10 generators>
)
gap> Print( derv );
<group derivation: Group( [ f1, f2, f3, f4, f5 ] ) -> Group( [ f1, f2, f3, f4, f5 ] ) >
gap> K := Kernel( derv );
Group([  ])
gap> h := H.1*H.3^2*H.5;;
gap> g := ImagesRepresentative( derv, h );
f1*f2*f3^2*f4*f5
gap> ImagesElm( derv, h );
[ f1*f2*f3^2*f4*f5 ]
gap> x := PreImagesRepresentative( derv, g );;
gap> g = ImagesRepresentative( derv, x );
true
gap> PreImagesElm( derv, g ) = RightCoset( K, x );
true
gap> imgH := ImagesSource( derv );
Group derivation image in Group( [ f1, f2, f3, f4, f5 ] )
gap> Print( imgH );
<group derivation image: Group( [ f1, f2, f3, f4, f5 ] ) -> Group( [ f1, f2, f3, f4, f5 ] ) >
gap> g in imgH;
true
gap> Random( imgH ) in imgH;
true
gap> Size( imgH ) = Length( List( imgH ) );
true
gap> imgK := ImagesSet( derv, K );
Group derivation image in Group( [ f1, f2, f3, f4, f5 ] )
gap> Print( imgK );
<group derivation image: Group( <identity> of ... ) -> Group( [ f1, f2, f3, f4, f5 ] ) >
gap> Size( imgK );
1
gap> List( imgK );
[ <identity> of ... ]
gap> IsInjective( derv ) or IsSurjective( derv );
true
gap> IsBijective( derv );
true

# Group derivation 2
gap> imgs := [ G.5, G.2 ];;
gap> derv := GroupDerivationByImages( H, G, gensH, imgs, act );
Group derivation [ f2, f1*f4 ] -> [ f5, f2 ]
gap> GroupDerivationInfo( derv );
rec(
    lhs := [ f1, f2, f3, f4, f5 ] -> [ f1, f2, f3, f4, f5 ],
    rhs := [ f2, f1*f4 ] -> [ f2*f10, f1*f4*f7 ],
    sdp := <pc group of size 5184 with 10 generators>
)
gap> Print( derv );
<group derivation: Group( [ f1, f2, f3, f4, f5 ] ) -> Group( [ f1, f2, f3, f4, f5 ] ) >
gap> K := Kernel( derv );
Group([ f2*f4*f5, f3 ])
gap> h := H.1*H.3^2*H.5;;
gap> g := ImagesRepresentative( derv, h );
f2*f4*f5
gap> ImagesElm( derv, h );
[ f2*f4*f5 ]
gap> x := PreImagesRepresentative( derv, g );;
gap> g = ImagesRepresentative( derv, x );
true
gap> PreImagesElm( derv, g ) = RightCoset( K, x );
true
gap> imgH := ImagesSource( derv );
Group derivation image in Group( [ f1, f2, f3, f4, f5 ] )
gap> Print( imgH );
<group derivation image: Group( [ f1, f2, f3, f4, f5 ] ) -> Group( [ f1, f2, f3, f4, f5 ] ) >
gap> g in imgH;
true
gap> G.1 in imgH;
false
gap> Random( imgH ) in imgH;
true
gap> Size( imgH ) = Length( List( imgH ) );
true
gap> imgK := ImagesSet( derv, K );
Group derivation image in Group( [ f1, f2, f3, f4, f5 ] )
gap> Print( imgK );
<group derivation image: Group( [ f2*f4*f5, f3 ] ) -> Group( [ f1, f2, f3, f4, f5 ] ) >
gap> Size( imgK );
1
gap> List( imgK );
[ <identity> of ... ]
gap> IsInjective( derv ) or IsSurjective( derv );
false
gap> IsBijective( derv );
false

#
gap> STOP_TEST( "derivations.tst" );
