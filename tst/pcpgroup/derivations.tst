gap> START_TEST( "Testing TwistedConjugacy for PcpGroups: derivations between finite groups" );

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

# Affine action 1
gap> aff := AffineActionByGroupDerivation( H, derv );
function( g, k ) ... end
gap> orb := OrbitAffineAction( H, G.1, derv );
g1^G
gap> Print( orb );
OrbitAffineAction( g1 )
gap> stab := StabilizerAffineAction( H, G.1, derv );
Pcp-group with orders [  ]
gap> NrOrbitsAffineAction( H, derv );
1
gap> OrbitsAffineAction( H, derv );
[ id^G ]
gap> h := RepresentativeAffineAction( H, G.1, G.2, derv );;
gap> aff( G.1, h ) = G.2;
true
gap> G.1*G.2 in orb;
true
gap> Size( orb ) = Size( G );
true
gap> dervA := GroupDerivationByAffineAction( H, G, aff );
Group derivation [ g1, g2, g3, g4, g5 ] -> [ g1*g2*g4, g2^2, g3, g4*g5, g4 ]
gap> ForAll( H, h -> h^derv = h^dervA );
true
gap> aff := AffineActionByGroupDerivation( K, derv );
function( g, k ) ... end
gap> orb := OrbitAffineAction( K, G.1, derv );
g1^G
gap> stab := StabilizerAffineAction( K, G.1, derv );
Pcp-group with orders [  ]
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

# Affine action 2
gap> aff := AffineActionByGroupDerivation( H, derv );
function( g, k ) ... end
gap> orb := OrbitAffineAction( H, G.1, derv );
g1^G
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
Group derivation [ g1, g2, g3, g4, g5 ] -> [ g2*g4, g5, id, g4*g5, g4 ]
gap> ForAll( H, h -> h^derv = h^dervA );
true
gap> aff := AffineActionByGroupDerivation( K, derv );
function( g, k ) ... end
gap> orb := OrbitAffineAction( K, G.1, derv );
g1^G
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
Group derivation [ g2*g4*g5, g3 ] -> [ id, id ]
gap> ForAll( K, k -> k^derv = k^dervA );
true

#
gap> STOP_TEST( "derivations.tst" );
