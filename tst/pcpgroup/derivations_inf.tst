gap> START_TEST( "Testing TwistedConjugacy for infinite PcpGroups: derivations" );

# Preparation
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> H := ExamplesOfSomePcpGroups( 5 );;
gap> gens := GeneratorsOfGroup( H );;
gap> imgs1 := [ G.1*G.4^-1, G.3, G.2*G.3^2*G.4^2, G.4^-1  ];;
gap> imgs2 := [ G.1, G.2^2*G.3*G.4^2, G.2*G.3*G.4, G.4  ];;
gap> hom1 := GroupHomomorphismByImages( H, G, gens, imgs1 );;
gap> hom2 := GroupHomomorphismByImages( H, G, gens, imgs2 );;
gap> imgs3 := List( gens, h -> ConjugatorAutomorphismNC( G, h^hom1 ) );;
gap> imgs4 := [ G.4, G.2^2*G.4^-2, G.3^-1*G.4^-1, G.4^2 ];;
gap> imgs5 := [ G.1, G.2^2*G.4^-2, G.3^-1*G.4^-1, G.4^2 ];;
gap> act := GroupHomomorphismByImages( H, Group( imgs3 ), gens, imgs3 );;

# Group derivation by images
gap> derv := GroupDerivationByImagesNC( H, G, gens, imgs4, act );
Group derivation [ g1, g2, g3, g4 ] -> [ g4, g2^2*g4^-2, g3^-1*g4^-1, g4^2 ]
gap> GroupDerivationInfo( derv );
rec(
    lhs := [ g1, g2, g3, g4 ] -> [ g1, g2, g3, g4 ],
    rhs := [ g1, g2, g3, g4 ] -> [ g1*g8, g2*g6^2*g8^-2, g3*g7^-1*g8^-1, g4*g8^2 ],
    sdp := Pcp-group with orders [ 2, 0, 0, 0, 2, 0, 0, 0 ]
)
gap> Print( derv );
<group derivation: Pcp-group with orders [ 2, 0, 0, 0 ] -> Pcp-group with orders [ 2, 0, 0, 0 ] >
gap> K := Kernel( derv );
Pcp-group with orders [  ]
gap> h :=  H.1*H.2^-2*H.3^3*H.4^-4;;
gap> g := ImagesRepresentative( derv, h );
g2^-4*g3^-3*g4^24
gap> ImagesElm( derv, h );
[ g2^-4*g3^-3*g4^24 ]
gap> x := PreImagesRepresentative( derv, g );;
gap> g = ImagesRepresentative( derv, x );
true
gap> PreImagesElm( derv, g ) = RightCoset( K, x );
true
gap> imgH := ImagesSource( derv );
Group derivation image in Pcp-group with orders [ 2, 0, 0, 0 ]
gap> K = StabilizerOfExternalSet( imgH );
true
gap> Print( imgH );
<group derivation image: Pcp-group with orders [ 2, 0, 0, 0 ] -> Pcp-group with orders [ 2, 0, 0, 0 ] >
gap> g in imgH;
true
gap> G.1 in imgH;
false
gap> PreImagesRepresentative( derv, G.1 );
fail
gap> PreImagesElm( derv, G.1 );
[  ]
gap> Random( imgH ) in imgH;
true
gap> Size( imgH );
infinity
gap> imgK := ImagesSet( derv, K );
Group derivation image in Pcp-group with orders [ 2, 0, 0, 0 ]
gap> Print( imgK );
<group derivation image: Pcp-group with orders [  ] -> Pcp-group with orders [ 2, 0, 0, 0 ] >
gap> Size( imgK );
1
gap> List( imgK );
[ id ]
gap> IsInjective( derv );
true
gap> IsSurjective( derv );
false

# Group derivation by function
gap> derv := GroupDerivationByFunction( H, G, h -> (h^hom1)^-1*h^hom2, act );
Group derivation via function( h ) ... end
gap> GroupDerivationInfo( derv );
rec(
    lhs := [ g1, g2, g3, g4 ] -> [ g1, g2, g3, g4 ],
    rhs := MappingByFunction(
        Pcp-group with orders [ 2, 0, 0, 0 ],
        Pcp-group with orders [ 2, 0, 0, 0, 2, 0, 0, 0 ],
        function( h ) ... end
    ),
    sdp := Pcp-group with orders [ 2, 0, 0, 0, 2, 0, 0, 0 ]
)
gap> Print( derv );
<group derivation: Pcp-group with orders [ 2, 0, 0, 0 ] -> Pcp-group with orders [ 2, 0, 0, 0 ] >
gap> K := Kernel( derv );
Pcp-group with orders [  ]
gap> h :=  H.1*H.2^-2*H.3^3*H.4^-4;;
gap> g := ImagesRepresentative( derv, h );
g2^-4*g3^-3*g4^24
gap> ImagesElm( derv, h );
[ g2^-4*g3^-3*g4^24 ]
gap> x := PreImagesRepresentative( derv, g );;
gap> g = ImagesRepresentative( derv, x );
true
gap> PreImagesElm( derv, g ) = RightCoset( K, x );
true
gap> imgH := ImagesSource( derv );
Group derivation image in Pcp-group with orders [ 2, 0, 0, 0 ]
gap> Print( imgH );
<group derivation image: Pcp-group with orders [ 2, 0, 0, 0 ] -> Pcp-group with orders [ 2, 0, 0, 0 ] >
gap> g in imgH;
true
gap> G.1 in imgH;
false
gap> Random( imgH ) in imgH;
true
gap> Size( imgH );
infinity
gap> imgK := ImagesSet( derv, K );
Group derivation image in Pcp-group with orders [ 2, 0, 0, 0 ]
gap> Print( imgK );
<group derivation image: Pcp-group with orders [  ] -> Pcp-group with orders [ 2, 0, 0, 0 ] >
gap> Size( imgK );
1
gap> List( imgK );
[ id ]
gap> IsInjective( derv );
true
gap> IsSurjective( derv );
false

# Faulty group derivation
gap> derv := GroupDerivationByImagesNC( H, G, gens, imgs5, act );
Group derivation [ g1, g2, g3, g4 ] -> [ g1, g2^2*g4^-2, g3^-1*g4^-1, g4^2 ]
gap> derv := GroupDerivationByImages( H, G, gens, imgs5, act );
fail

# Trivial group derivations
gap> act := GroupHomomorphismByFunction( G, InnerAutomorphismGroup( G ), g -> IdentityMapping( G ) );;
gap> derv := GroupDerivationByImages( G, G, act );
Group derivation [ g1, g2, g3, g4 ] -> [ g1, g2, g3, g4 ]
gap> derv := GroupDerivationByImages( G, G, ListWithIdenticalEntries( 4, One( G ) ), act );
Group derivation [ g1, g2, g3, g4 ] -> [ id, id, id, id ]

# Coset-inspired example
gap> G := ExamplesOfSomePcpGroups( 10 );;
gap> H := DirectProduct( Subgroup( G, [ G.1 ] ), Subgroup( G, [ G.2^2, G.3 ] ) );;
gap> gens := [ H.1, H.2, H.3 ];;
gap> imgs1 := [ G.1, One( G ), One( G ) ];;
gap> imgs2 := [ One( G ), G.2^2, G.3 ];;
gap> hom1 := GroupHomomorphismByImages( H, G, gens, imgs1 );;
gap> hom2 := GroupHomomorphismByImages( H, G, gens, imgs2 );;
gap> inn := InnerAutomorphismNC( G, G.1 );;
gap> idG := IdentityMapping( G );;
gap> imgs3 := [ inn, idG, idG ];;
gap> imgs4 := [ G.1^-1, G.2^2, G.3 ];;
gap> act := GroupHomomorphismByImages( H, Group( [ inn ] ), gens, imgs3 );;
gap> derv := GroupDerivationByImages( H, G, gens, imgs4, act );
Group derivation [ g1, g2, g3 ] -> [ g1^-1, g2^2, g3 ]
gap> IsInjective( derv );
true
gap> IsSurjective( derv );
false

#
gap> STOP_TEST( "derivations_inf.tst" );

