#! @Chapter reidemeisternumbers

#! @Section reidemeisternumbers

#! @BeginGroup ReidemeisterNumberGroup
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
DeclareGlobalFunction( "NrTwistedConjugacyClasses" );
#! @EndGroup

#! @Section reidemeisterspectra

#! @Returns the Reidemeister spectrum of <A>G</A>.
#! @Description
#! If $G$ is abelian, this function relies on the results from
#! <Cite Key='send23-a'/>.
#! Otherwise, it relies on <Cite Key='fh94-a' Where='Thm. 5'/>.
#! @Arguments G
DeclareGlobalFunction( "ReidemeisterSpectrum" );

#! @Returns the extended Reidemeister spectrum of <A>G</A>.
#! @Description
#! If $G$ is abelian, this is just the set of all divisors of the order of
#! <A>G</A>.
#! Otherwise, this function relies on <Cite Key='fh94-a' Where='Thm. 5'/>.
#! @Arguments G
DeclareGlobalFunction( "ExtendedReidemeisterSpectrum" );

#! @Returns the coincidence Reidemeister spectrum of <A>H</A> and <A>G</A>.
#! @Arguments [H, ]G
DeclareGlobalFunction( "CoincidenceReidemeisterSpectrum" );

#! @Returns the total Reidemeister spectrum of <A>H</A> and <A>G</A>.
#! @Arguments G
DeclareGlobalFunction( "TotalReidemeisterSpectrum" );

#! @BeginExample
Q := QuaternionGroup( 8 );;
D := DihedralGroup( 8 );;
ReidemeisterSpectrum( Q );
#! [ 2, 3, 5 ]
ExtendedReidemeisterSpectrum( Q );
#! [ 1, 2, 3, 5 ]
CoincidenceReidemeisterSpectrum( Q );
#! [ 1, 2, 3, 4, 5, 8 ]
CoincidenceReidemeisterSpectrum( D, Q );
#! [ 4, 8 ]
CoincidenceReidemeisterSpectrum( Q, D );
#! [ 2, 3, 4, 6, 8 ]
TotalReidemeisterSpectrum( Q );
#! [ 1, 2, 3, 4, 5, 6, 8 ]
#! @EndExample
