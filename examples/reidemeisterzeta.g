#! @Chapter reidemeisterzeta

#! @Section decomposingreidnr

#! @BeginExample
G := PcGroupCode( 3913, 12 );;
phi := GroupHomomorphismByImages( G, G, [ G.1, G.3 ], [ One(G), One(G) ] );;
psi := GroupHomomorphismByImages( G, G, [ G.1, G.3 ], [ G.2, One(G) ] );;
IteratedReidemeisterNumberDecomposition( phi );
#! [ [ 1 ], [  ] ]
IteratedReidemeisterNumberDecomposition( phi, psi );
#! [ [ 12 ], [ -6 ] ]
#! @EndExample

#! @Section reidemeisterzeta

#! @BeginExample
IsRationalReidemeisterZetaFunction( phi );
#! true
IsRationalReidemeisterZetaFunction( phi, psi );
#! false
s := Indeterminate( Rationals, "s" );;
ReidemeisterZetaFunction( phi )(s);
#! (1)/(-s+1)
PrintReidemeisterZetaFunction( phi, psi );
#! "exp(-6*s)*(1-s)^(-12)"
#! @EndExample

#! @Section reidemeistergen

#! @BeginExample
IsRationalReidemeisterGeneratingFunction( phi, psi );
#! true
ReidemeisterGeneratingFunction( phi, psi )( 2 );
#! -36
PrintReidemeisterGeneratingFunction( phi, psi );
#! "(6*s^2+6*s)/(-s+1)"
#! @EndExample
