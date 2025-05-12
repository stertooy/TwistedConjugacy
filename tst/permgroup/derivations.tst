gap> START_TEST( "Testing TwistedConjugacy for PermGroups: derivations" );

# Preparation
gap> H := Group( [ (2,4,3)(5,11,9,7,13,12,10,8,6), (1,2,4,3)(6,11)(7,10)(8,9)(12,13) ] );;
gap> G := Group( [ (10,12)(13,15), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ] );;
gap> gensG := [ (10,12)(11,14), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ];;
gap> imgsG := [ (10,12)(13,15), (1,5,9,4,8,3,7,2,6)(10,15,14,12,13,11) ];;
gap> auts := [ InnerAutomorphismNC( G, (1,6,2,7,3,8,4,9,5)(10,11,13)(12,14,15) ), GroupHomomorphismByImagesNC( G, G, gensG, imgsG ) ];;
gap> gensH := [ (2,3,4)(5,6,8,10,12,13,7,9,11), (1,2,4,3)(6,11)(7,10)(8,9)(12,13) ];;
gap> act := GroupHomomorphismByImagesNC( H, Group( auts ), gensH, auts );;

# Group derivation 1
gap> imgs := [ (1,2,3,4,5,6,7,8,9)(10,13,11)(12,15,14), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ];;
gap> derv := GroupDerivationByImages( H, G, gensH, imgs, act );
Group derivation [ (2,3,4)(5,6,8,10,12,13,7,9,11), (1,2,4,3)(6,11)(7,10)(8,9)(12,13) ] -> 
                 [ (1,2,3,4,5,6,7,8,9)(10,13,11)(12,15,14), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ]
gap> GroupDerivationInfo( derv );
rec( 
    lhs := [ (2,4,3)(5,11,9,7,13,12,10,8,6), (1,2,4,3)(6,11)(7,10)(8,9)(12,13) ] -> 
           [ (2,4,3)(5,11,9,7,13,12,10,8,6)(14,18,22,17,21,16,20,15,19)(23,26,24)(25,28,27), (1,2,4,3)(6,11)(7,10)(8,9)(12,13)(15,22)(16,21)(17,20)(18,19)(24,26,27,28) ], 
    rhs := [ (2,3,4)(5,6,8,10,12,13,7,9,11), (1,2,4,3)(6,11)(7,10)(8,9)(12,13) ] ->
           [ (2,3,4)(5,6,8,10,12,13,7,9,11)(14,20,17)(15,21,18)(16,22,19), (1,2,4,3)(6,11)(7,10)(8,9)(12,13)(14,19)(15,18)(16,17)(20,22)(23,27)(24,25) ],
    sdp := <permutation group with 4 generators>
)
gap> Print( derv );
<group derivation: Group( [ (2,4,3)(5,11,9,7,13,12,10,8,6), (1,2,4,3)(6,11)(7,10)(8,9)(12,13) ] ) ->
                   Group( [ (10,12)(13,15), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ] ) >
gap> K := Kernel( derv );
Group(())
gap> h := (1,3,4,2)(5,10)(6,8)(9,13)(11,12);;
gap> g := ImagesRepresentative( derv, h );
(1,9,8,7,6,5,4,3,2)(10,14,15,12,11,13)
gap> ImagesElm( derv, h );
[ (1,9,8,7,6,5,4,3,2)(10,14,15,12,11,13) ]
gap> x := PreImagesRepresentative( derv, g );;
gap> g = ImagesRepresentative( derv, x );
true
gap> PreImagesElm( derv, g ) = RightCoset( K, x );
true
gap> imgH := ImagesSource( derv );
Group derivation image in Group( [ (10,12)(13,15), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ] )
gap> Print( imgH );
<group derivation image: Group( [ (2,4,3)(5,11,9,7,13,12,10,8,6),(1,2,4,3)(6,11)(7,10)(8,9)(12,13) ] ) ->
                         Group( [ (10,12)(13,15), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ] ) >
gap> g in imgH;
true
gap> Random( imgH ) in imgH;
true
gap> Size( imgH ) = Length( List( imgH ) );
true
gap> imgK := ImagesSet( derv, K );
Group derivation image in Group( [ (10,12)(13,15), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ] )
gap> Print( imgK );
<group derivation image: Group( () ) ->
                         Group( [ (10,12)(13,15), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ] ) >
gap> Size( imgK );
1
gap> List( imgK );
[ () ]
gap> IsInjective( derv ) or IsSurjective( derv );
true
gap> IsBijective( derv );
true

# Group derivation 2
gap> imgs := [ (11,14)(13,15), (1,6,2,7,3,8,4,9,5)(10,11,13)(12,14,15) ];;
gap> derv := GroupDerivationByImages( H, G, gensH, imgs, act );
Group derivation [ (2,3,4)(5,6,8,10,12,13,7,9,11), (1,2,4,3)(6,11)(7,10)(8,9)(12,13) ] -> 
                 [ (11,14)(13,15), (1,6,2,7,3,8,4,9,5)(10,11,13)(12,14,15) ]
gap> GroupDerivationInfo( derv );
rec( 
    lhs := [ (2,4,3)(5,11,9,7,13,12,10,8,6), (1,2,4,3)(6,11)(7,10)(8,9)(12,13) ] ->
           [ (2,4,3)(5,11,9,7,13,12,10,8,6)(14,18,22,17,21,16,20,15,19)(23,26,24)(25,28,27), (1,2,4,3)(6,11)(7,10)(8,9)(12,13)(15,22)(16,21)(17,20)(18,19)(24,26,27,28) ], 
    rhs := [ (2,3,4)(5,6,8,10,12,13,7,9,11), (1,2,4,3)(6,11)(7,10)(8,9)(12,13) ] ->
           [ (2,3,4)(5,6,8,10,12,13,7,9,11)(14,19,15,20,16,21,17,22,18)(23,27,26)(24,28,25), (1,2,4,3)(6,11)(7,10)(8,9)(12,13)(14,19)(15,18)(16,17)(20,22)(23,24)(25,27)(26,28) ], 
    sdp := <permutation group with 4 generators>
)
gap> Print( derv );
<group derivation: Group( [ (2,4,3)(5,11,9,7,13,12,10,8,6), (1,2,4,3)(6,11)(7,10)(8,9)(12,13) ] ) ->
                   Group( [ (10,12)(13,15), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ] ) >
gap> K := Kernel( derv );
Group([ (1,3,4)(5,11,9,7,13,12,10,8,6), (5,7,10)(6,9,12)(8,11,13) ])
gap> h := (1,3,4,2)(5,10)(6,8)(9,13)(11,12);;
gap> g := ImagesRepresentative( derv, h );
(1,6,2,7,3,8,4,9,5)(10,11,15)(12,14,13)
gap> ImagesElm( derv, h );
[ (1,6,2,7,3,8,4,9,5)(10,11,15)(12,14,13) ]
gap> x := PreImagesRepresentative( derv, g );;
gap> g = ImagesRepresentative( derv, x );
true
gap> PreImagesElm( derv, g ) = RightCoset( K, x );
true
gap> imgH := ImagesSource( derv );
Group derivation image in Group( [ (10,12)(13,15), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ] )
gap> Print( imgH );
<group derivation image: Group( [ (2,4,3)(5,11,9,7,13,12,10,8,6),(1,2,4,3)(6,11)(7,10)(8,9)(12,13) ] ) ->
                         Group( [ (10,12)(13,15), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ] ) >
gap> g in imgH;
true
gap> (10,12)(11,14)(13,15) in imgH;
false
gap> Random( imgH ) in imgH;
true
gap> Size( imgH ) = Length( List( imgH ) );
true
gap> imgK := ImagesSet( derv, K );
Group derivation image in Group( [ (10,12)(13,15), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ] )
gap> Print( imgK );
<group derivation image: Group( [ (1,3,4)(5,11,9,7,13,12,10,8,6), (5,7,10)(6,9,12)(8,11,13) ] ) ->
                         Group( [ (10,12)(13,15), (1,6,2,7,3,8,4,9,5)(10,14,13,12,11,15) ] ) >
gap> Size( imgK );
1
gap> List( imgK );
[ () ]
gap> IsInjective( derv ) or IsSurjective( derv );
false
gap> IsBijective( derv );
false

#
gap> STOP_TEST( "derivations.tst" );
