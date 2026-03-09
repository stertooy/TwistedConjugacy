#! @Chapter reidemeisterzeta

#! @Section decomposingreidnr

#! @Returns two lists of integers: the first list contains one period of the
#! sequence $(P_n)_{n \in \mathbb{N}}$, the second list contains
#! $(Q_n)_{n \in \mathbb{N}}$ up to the part where it becomes the constant zero
#! sequence.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "IteratedReidemeisterNumberDecomposition" );

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

#! @Returns <K>true</K> if the Reidemeister zeta function of <A>endo1</A> and
#! <A>endo2</A> is rational, otherwise <K>false</K>.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "IsRationalReidemeisterZetaFunction" );

#! @Returns the Reidemeister zeta function of <A>endo1</A> and <A>endo2</A> if
#! it is rational, otherwise <K>fail</K>.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "ReidemeisterZetaFunction" );

#! @Returns a string describing the Reidemeister zeta function of <A>endo1</A>
#! and <A>endo2</A>.
#! @Description
#! This is often more readable than evaluating
#! <Ref Func="ReidemeisterZetaFunction" Style="Number"/> in an indeterminate, and does
#! not require rationality.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "PrintReidemeisterZetaFunction" );

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

#! @Returns <K>true</K> if the Reidemeister generating function of <A>endo1</A> and
#! <A>endo2</A> is rational, otherwise <K>false</K>.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "IsRationalReidemeisterGeneratingFunction" );

#! @Returns the Reidemeister generating function of <A>endo1</A> and <A>endo2</A> if
#! it is rational, otherwise <K>fail</K>.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "ReidemeisterGeneratingFunction" );

#! @Returns a string describing the Reidemeister generating function of <A>endo1</A>
#! and <A>endo2</A>.
#! @Description
#! This is often more readable than evaluating
#! <Ref Func="ReidemeisterGeneratingFunction" Style="Number"/> in an indeterminate, and does
#! not require rationality.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "PrintReidemeisterGeneratingFunction" );

#! @BeginExample
IsRationalReidemeisterGeneratingFunction( phi, psi );
#! true
ReidemeisterGeneratingFunction( phi, psi )( 2 );
#! -36
PrintReidemeisterGeneratingFunction( phi, psi );
#! "(6*s^2+6*s)/(-s+1)"
#! @EndExample
