gap> START_TEST( "Testing Double Twisted Conjugacy for finite pc groups" );

#
gap> F := FreeGroup( 5 );;
gap> Q := F / [ F.1^2, F.2^-1*F.1^-1*F.2*F.1, F.3^-1*F.1^-1*F.3*F.1, F.4^-1*F.1^-1*F.4*F.1, F.5^-1*F.1^-1*F.5*F.1*F.5^-5, F.2^2, F.3^-1*F.2^-1*F.3*F.2*F.3^-1, F.4^-1*F.2^-1*F.4*F.2*F.4^-1, F.5^-1*F.2^-1*F.5*F.2, F.3^3, F.4^-1*F.3^-1*F.4*F.3, F.5^-1*F.3^-1*F.5*F.3, F.4^3, F.5^-1*F.4^-1*F.5*F.4, F.5^7 ];;
gap> i := IsomorphismPcGroup( Q );;
gap> G := Image( i );;
gap> F := FreeGroup( 4 );;
gap> Q := F / [ F.1^2*F.2^-1, F.2^-1*F.1^-1*F.2*F.1, F.3^-1*F.1^-1*F.3*F.1*F.3^-1, F.4^-1*F.1^-1*F.4*F.1*F.4^-5, F.2^2, F.3^-1*F.2^-1*F.3*F.2, F.4^-1*F.2^-1*F.4*F.2, F.3^3, F.4^-1*F.3^-1*F.4*F.3, F.4^7 ];;
gap> i := IsomorphismPcGroup( Q );;
gap> H := Image( i );;
gap> gens := [ H.1, H.3*H.4 ];;
gap> imgs1 := [ G.2*G.4^2, One( G ) ];;
gap> imgs2 := [ G.1*G.2*G.3*G.5, G.3*G.4^2*G.5^3 ];; 
gap> phi := GroupHomomorphismByImages( H, G, gens, imgs1 );;
gap> psi := GroupHomomorphismByImages( H, G, gens, imgs2 );;
gap> tc := TwistedConjugation( phi, psi );;
gap> IsTwistedConjugate( phi, psi, G.2, G.3 );
false
gap> g := RepresentativeTwistedConjugation( phi, psi, G.1, G.3 );
f1*f3*f4^2
gap> tc( G.1, g ) = G.3;   
true
gap> tcc := ReidemeisterClass( phi, psi, G.3 );;
gap> Representative( tcc );
f3
gap> Size( tcc );
42
gap> Random( tcc ) in tcc;
true
gap> ActingDomain( tcc ) = H;
true
gap> NrTwistedConjugacyClasses( phi, psi );
6

#
gap> STOP_TEST( "finite_pc_double.tst" );
