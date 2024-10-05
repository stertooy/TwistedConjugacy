gap> START_TEST( "Testing TwistedConjugacy for PcpGroups: twisted conjugation by endomorphisms" );

#
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> H := Subgroup( G, [ G.1*G.2^-1*G.3^-1*G.4^-1, G.2^-1*G.3*G.4^-2 ] );;
gap> K := Subgroup( G, [ G.1*G.3^-2*G.4^2, G.1*G.4^4 ] );;
gap> x := G.1*G.3^-1;;
gap> y := G.1*G.2^-1*G.3^-2*G.4^-1;;
gap> I := Intersection( H, K );;
gap> IsSubgroup( H, I ) and IsSubgroup( K, I );
true
gap> Intersection( H, I ) = I and Intersection( I, K ) = I;
true

#
gap> Hx := RightCoset( H, x );;
gap> Ky := RightCoset( K, y );;
gap> Iz := Intersection( Hx, Ky );;
gap> I := ActingDomain( Iz );;
gap> IsSubgroup( H, I ) and IsSubgroup( K, I );
true
gap> z := Representative( Iz );;
gap> z in Hx and z in Ky;
true

#
gap> HxK := DoubleCoset( H, x, K );;
gap> y in HxK;
true
gap> One( G ) in HxK;
false

#
gap> STOP_TEST( "twisted_conjugacy_single.tst" );
