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

# Affine action 1
gap> aff := AffineActionByGroupDerivation( H, derv );
function( g, k ) ... end
gap> orb := OrbitAffineAction( H, G.1, derv );
f1^G
gap> Print( orb );
OrbitAffineAction( f1 )
gap> stab := StabilizerAffineAction( H, G.1, derv );
Group([  ])
gap> NrOrbitsAffineAction( H, derv );
1
gap> OrbitsAffineAction( H, derv );
[ <identity> of ...^G ]
gap> h := RepresentativeAffineAction( H, G.1, G.2, derv );;
gap> aff( G.1, h ) = G.2;
true
gap> G.1*G.2 in orb;
true
gap> Size( orb ) = Size( G );
true
gap> dervA := GroupDerivationByAffineAction( H, G, aff );
Group derivation [ f1, f2, f3, f4, f5 ] -> [ f1*f2*f4, f2^2, f3, f4*f5, f4 ]
gap> ForAll( H, h -> h^derv = h^dervA );
true
gap> aff := AffineActionByGroupDerivation( K, derv );
function( g, k ) ... end
gap> orb := OrbitAffineAction( K, G.1, derv );
f1^G
gap> stab := StabilizerAffineAction( K, G.1, derv );
Group([  ])
gap> NrOrbitsAffineAction( K, derv );
72
gap> h := RepresentativeAffineAction( K, G.1, G.2, derv );
fail
gap> G.1*G.2 in orb;
false
gap> Size( orb );
1
gap> dervB := GroupDerivationByAffineAction( K, G, aff );
Group derivation [  ] -> [  ]
gap> ForAll( K, k -> k^derv = k^dervA );
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

# Affine action 2
gap> aff := AffineActionByGroupDerivation( H, derv );
function( g, k ) ... end
gap> orb := OrbitAffineAction( H, G.1, derv );
f1^G
gap> stab := StabilizerAffineAction( H, G.1, derv );;
gap> ForAll( GeneratorsOfGroup( stab ), h -> aff( G.1, h ) = G.1 );
true
gap> NrOrbitsAffineAction( H, derv );
10
gap> Length( OrbitsAffineAction( H, derv ) );
10
gap> h := RepresentativeAffineAction( H, G.1, G.1*G.2, derv );;
gap> aff( G.1, h ) = G.1*G.2;
true
gap> G.1*G.5 in orb;
true
gap> Size( orb );
8
gap> dervA := GroupDerivationByAffineAction( H, G, aff );
Group derivation [ f1, f2, f3, f4, f5 ] -> [ f2*f4, f5, <identity> of ..., f4*f5, f4 ]
gap> ForAll( H, h -> h^derv = h^dervA );
true
gap> aff := AffineActionByGroupDerivation( K, derv );
function( g, k ) ... end
gap> orb := OrbitAffineAction( K, G.1, derv );
f1^G
gap> stab := StabilizerAffineAction( K, G.1, derv );;
gap> Size( stab );
9
gap> NrOrbitsAffineAction( K, derv );
36
gap> h := RepresentativeAffineAction( K, G.1, G.2, derv );
fail
gap> ForAll( stab, k -> aff( G.1, k ) = G.1 );
true
gap> G.1*G.2 in orb;
false
gap> Size( orb );
1
gap> dervB := GroupDerivationByAffineAction( K, G, aff );
Group derivation [ f2*f4*f5, f3 ] -> [ <identity> of ..., <identity> of ... ]
gap> ForAll( K, k -> k^derv = k^dervA );
true

#
gap> STOP_TEST( "derivations.tst" );
