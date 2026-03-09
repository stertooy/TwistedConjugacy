#! @ChapterInfo reidemeisterzeta, decomposingreidnr
#! @Returns two lists of integers: the first list contains one period of the
#! sequence $(P_n)_{n \in \mathbb{N}}$, the second list contains
#! $(Q_n)_{n \in \mathbb{N}}$ up to the part where it becomes the constant zero
#! sequence.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "IteratedReidemeisterNumberDecomposition" );

DeclareOperation(
    "IteratedReidemeisterNumberDecompositionOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);

#! @ChapterInfo reidemeisterzeta, reidemeisterzeta
#! @Returns <K>true</K> if the Reidemeister zeta function of <A>endo1</A> and
#! <A>endo2</A> is rational, otherwise <K>false</K>.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "IsRationalReidemeisterZetaFunction" );

DeclareOperation(
    "IsRationalReidemeisterZetaFunctionOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);

#! @ChapterInfo reidemeisterzeta, reidemeisterzeta
#! @Returns the Reidemeister zeta function of <A>endo1</A> and <A>endo2</A> if
#! it is rational, otherwise <K>fail</K>.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "ReidemeisterZetaFunction" );

DeclareOperation(
    "ReidemeisterZetaFunctionOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);

#! @ChapterInfo reidemeisterzeta, reidemeisterzeta
#! @Returns a string describing the Reidemeister zeta function of <A>endo1</A>
#! and <A>endo2</A>.
#! @Description
#! This is often more readable than evaluating
#! <Ref Func="ReidemeisterZetaFunction" Style="Number"/> in an indeterminate, and does
#! not require rationality.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "PrintReidemeisterZetaFunction" );

DeclareOperation(
    "PrintReidemeisterZetaFunctionOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);

#! @ChapterInfo reidemeisterzeta, reidemeistergen
#! @Returns <K>true</K> if the Reidemeister generating function of <A>endo1</A> and
#! <A>endo2</A> is rational, otherwise <K>false</K>.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "IsRationalReidemeisterGeneratingFunction" );

DeclareOperation(
    "IsRationalReidemeisterGeneratingFunctionOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);

#! @ChapterInfo reidemeisterzeta, reidemeistergen
#! @Returns the Reidemeister generating function of <A>endo1</A> and <A>endo2</A> if
#! it is rational, otherwise <K>fail</K>.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "ReidemeisterGeneratingFunction" );

DeclareOperation(
    "ReidemeisterGeneratingFunctionOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);

#! @ChapterInfo reidemeisterzeta, reidemeistergen
#! @Returns a string describing the Reidemeister generating function of <A>endo1</A>
#! and <A>endo2</A>.
#! @Description
#! This is often more readable than evaluating
#! <Ref Func="ReidemeisterGeneratingFunction" Style="Number"/> in an indeterminate, and does
#! not require rationality.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "PrintReidemeisterGeneratingFunction" );

DeclareOperation(
    "PrintReidemeisterGeneratingFunctionOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);
