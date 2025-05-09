gap> START_TEST( "Testing TwistedConjugacy for PcpGroups: twisted conjugation by endomorphisms" );

#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> H := Subgroup( G, [ G.1*G.2^-1*G.3^-1*G.4^-1, G.2^-1*G.3*G.4^-2 ] );;
gap> K := Subgroup( G, [ G.1*G.3^-2*G.4^2, G.1*G.4^4 ] );;
gap> x := G.1*G.3^-1;;
gap> y := G.1*G.2^-1*G.3^-2*G.4^-1;;
gap> z := G.1*G.2*G.3*G.4^2;;
gap> I := Intersection( H, K );;
gap> IsSubgroup( H, I ) and IsSubgroup( K, I );
true
gap> Intersection( H, I ) = I and Intersection( I, K ) = I;
true

#
gap> Hx := RightCoset( H, x );;
gap> Hy := RightCoset( H, y );;
gap> Ky := RightCoset( K, y );;
gap> Intersection( Hx, Hy );
[  ]
gap> Iw := Intersection( Hx, Ky );
RightCoset(<group with 2 generators>,<object>)
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
gap> y in HxK;
true
gap> z in HxK;
false
gap> HxK = HyK;
true
gap> HxK = HzK;
false
gap> DoubleCosets( G, H, H );
fail
gap> DCS := DoubleCosets( G, H, K );;
gap> DCS = [ HzK, HxK ];
true

#
gap> G := ExamplesOfSomePcpGroups(10);;
gap> H := Subgroup( G, [G.1^3, G.4]);;
gap> K := Subgroup( G, [G.2^2, G.3^3]);;
gap> Length( DoubleCosets( G, H, K ) );
27

#
gap> STOP_TEST( "twisted_conjugacy_single.tst" );
