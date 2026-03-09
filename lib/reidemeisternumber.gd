#! @BeginGroup ReidemeisterNumberGroup
#! @ChapterInfo reidemeisternumbers, reidemeisternumbers
#! @Returns the Reidemeister number of ( <A>hom1</A>, <A>hom2</A> ).
#! @Description
#! If $G$ is abelian, this function relies on (a generalisation of)
#! <Cite Key='jian83-a' Where='Thm. 2.5'/>.
#! If $G = H$, $G$ is finite non-abelian and $\psi = \operatorname{id}_G$, it
#! relies on <Cite Key='fh94-a' Where='Thm. 5'/>.
#! Otherwise, it simply calculates the twisted conjugacy classes and then
#! counts them.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "ReidemeisterNumber" );
#! @Arguments hom1[, hom2]
# DeclareGlobalFunction( "NrTwistedConjugacyClasses" );
#
DeclareSynonym( "NrTwistedConjugacyClasses", ReidemeisterNumber );
#! @EndGroup

DeclareOperation(
    "ReidemeisterNumberOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);
