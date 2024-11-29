# TwistedConjugacy, chapter 5
#
# DO NOT EDIT THIS FILE - EDIT EXAMPLES IN THE SOURCE INSTEAD!
#
# This file has been generated by AutoDoc. It contains examples extracted from
# the package documentation. Each example is preceded by a comment which gives
# the name of a GAPDoc XML file and a line range from which the example were
# taken. Note that the XML file in turn may have been generated by AutoDoc
# from some other input.
#
gap> START_TEST("twistedconjugacy04.tst");

# doc/_Chapter_csts.xml:22-32
gap> G := ExamplesOfSomePcpGroups( 5 );;
gap> H := Subgroup( G, [ G.1*G.2^-1*G.3^-1*G.4^-1, G.2^-1*G.3*G.4^-2 ] );;
gap> K := Subgroup( G, [ G.1*G.3^-2*G.4^2, G.1*G.4^4 ] );;
gap> x := G.1*G.3^-1;;
gap> y := G.1*G.2^-1*G.3^-2*G.4^-1;;
gap> Hx := RightCoset( H, x );;
gap> Ky := RightCoset( K, y );;
gap> Intersection( Hx, Ky );
RightCoset(<group with 2 generators>,<object>)

# doc/_Chapter_csts.xml:49-55
gap> HxK := DoubleCoset( H, x, K );;
gap> G.1 in HxK;
false
gap> G.2 in HxK;
true

#
gap> STOP_TEST("twistedconjugacy04.tst", 1);
