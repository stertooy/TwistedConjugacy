gap> START_TEST( "Testing TwistedConjugacy for PcpGroups: cosets" );

#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> H := Subgroup( G, [ G.1*G.2^-1*G.3^-1*G.4^-1, G.2^-1*G.3*G.4^-2 ] );;
gap> K := Subgroup( G, [ G.1*G.3^-2*G.4^2, G.1*G.4^4 ] );;
gap> x := G.1*G.3^-1;;
gap> y := G.1*G.2^-1*G.3^-2*G.4^-1;;
gap> z := G.1*G.2*G.3*G.4^2;;

#
gap> Hx := RightCoset( H, x );;
gap> Hy := RightCoset( H, y );;
gap> Ky := RightCoset( K, y );;
gap> Intersection( Hx, Hy );
[  ]
gap> Iw := Intersection( Hx, Ky );
RightCoset(<group with 2 generators>,<object>)
gap> Intersection( Hx, Iw ) = Iw;
true
gap> Intersection( Iw, Ky ) = Iw;
true
gap> I := ActingDomain( Iw );;
gap> IsSubgroup( H, I ) and IsSubgroup( K, I );
true
gap> w := Representative( Iw );;
gap> w in Hx and w in Ky;
true

#
gap> HxK := DoubleCoset( H, x, K );;
gap> HyK := DoubleCoset( H, y, K );;
gap> HzK := DoubleCoset( H, z, K );;
gap> HxH := DoubleCoset( H, x, H );;
gap> y in HxK;
true
gap> z in HxK;
false
gap> HxK = HyK;
true
gap> HxK = HzK;
false
gap> HxK = HxH;
false
gap> DoubleCosets( G, H, H );
fail
gap> DCS := DoubleCosets( G, H, K );;
gap> DCS = [ HzK, HxK ];
true
gap> DoubleCosetRepsAndSizes( G, H, K );
[ [ id, infinity ], [ g3, infinity ] ]
gap> DoubleCosetIndex( G, H, K );
2
gap> DoubleCosetIndex( H, K, K );
Error, not contained

#
gap> G := ExamplesOfSomePcpGroups( 10 );;
gap> H := Subgroup( G, [ G.1^2, G.4 ] );;
gap> K := Subgroup( G, [ G.2^2, G.3^2 ] );;
gap> L := Subgroup( G, [ G.2 ] );;
gap> Length( DoubleCosets( G, H, K ) );
12
gap> DCRS := DoubleCosetRepsAndSizes( G, H, K );;
gap> List( DCRS, Last ) = ListWithIdenticalEntries( 12, infinity );
true
gap> DoubleCosetIndex( G, H, L );
infinity

#
gap> G := ExamplesOfSomePcpGroups( 4 );;
gap> H := Subgroup( G, [ G.1 ] );;
gap> DoubleCosets( G, H, H );
fail
gap> DoubleCosetRepsAndSizes( G, H, H );
fail
gap> DoubleCosetIndex( G, H, H );
infinity

#
gap> G := ExamplesOfSomePcpGroups( 14 );;
gap> H := Subgroup( G,[ G.14, G.15 ] );;
gap> K := Subgroup( G,[ G.18, G.19 ] );;
gap> g := G.1;;
gap> DC := DoubleCoset( H, g, K );;
gap> Size( DC );
7500
gap> N := NormalTorsionSubgroup(G);;
gap> DoubleCosetIndex( N, H, K );
300

#
gap> STOP_TEST( "cosets.tst" );
