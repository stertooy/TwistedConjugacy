#! @Chapter derivations

#! @Section gd_creating

#! @BeginExample
H := PcGroupCode( 149167619499417164, 72 );;
G := PcGroupCode( 5551210572, 72 );;
inn := InnerAutomorphism( G, G.2 );;
hom := GroupHomomorphismByImages(
     G, G,
     [ G.1*G.2, G.5 ], [ G.1*G.2^2*G.3^2*G.4, G.5 ]
   );;
act := GroupHomomorphismByImages(
     H, AutomorphismGroup( G ),
     [ H.2, H.1*H.4 ], [ inn, hom ]
   );;
gens := [ H.2, H.1*H.4 ];;
imgs := [ G.5, G.2 ];;
der := GroupDerivationByImages( H, G, gens, imgs, act );
#! Group derivation [ f2, f1*f4 ] -> [ f5, f2 ]
#! @EndExample

#! @Section gd_operations

#! @BeginExample
IsInjective( der ) or IsSurjective( der );
#! false
K := Kernel( der );;
Size( K );
#! 9
ImH := Image( der );
#! Group derivation image in Group( [ f1, f2, f3, f4, f5 ] )
h1 := H.1*H.3;;
g := Image( der, h1 );
#! f2*f4
ImK := Image( der, K );
#! Group derivation image in Group( [ f1, f2, f3, f4, f5 ] )
h2 := PreImagesRepresentative( der, g );;
Image( der, h2 ) = g;
#! true
PreIm := PreImages( der, g );
#! RightCoset(<group of size 9 with 2 generators>,<object>)
PreIm = RightCoset( K, h2 );
#! true
#! @EndExample

#! @Section gd_images

#! @BeginExample
Size( ImH );
#! 8
Size( ImK );
#! 1
g in ImH;
#! true
g in ImK;
#! false
List( ImK );
#! [ <identity> of ... ]
#! @EndExample
