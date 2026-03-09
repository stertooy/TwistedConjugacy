#! @Returns the Reidemeister spectrum of <A>G</A>.
#! @ChapterInfo reidemeisternumbers, reidemeisterspectra
#! @Description
#! If $G$ is abelian, this function relies on the results from
#! <Cite Key='send23-a'/>.
#! Otherwise, it relies on <Cite Key='fh94-a' Where='Thm. 5'/>.
#! @Arguments G
DeclareGlobalFunction( "ReidemeisterSpectrum" );

DeclareOperation( "ReidemeisterSpectrumOp", [ IsGroup ] );

#! @Returns the extended Reidemeister spectrum of <A>G</A>.
#! @ChapterInfo reidemeisternumbers, reidemeisterspectra
#! @Description
#! If $G$ is abelian, this is just the set of all divisors of the order of
#! <A>G</A>.
#! Otherwise, this function relies on <Cite Key='fh94-a' Where='Thm. 5'/>.
#! @Arguments G
DeclareGlobalFunction( "ExtendedReidemeisterSpectrum" );

DeclareOperation( "ExtendedReidemeisterSpectrumOp", [ IsGroup ] );

#! @Returns the coincidence Reidemeister spectrum of <A>H</A> and <A>G</A>.
#! @ChapterInfo reidemeisternumbers, reidemeisterspectra
#! @Arguments [H, ]G
DeclareGlobalFunction( "CoincidenceReidemeisterSpectrum" );

DeclareOperation( "CoincidenceReidemeisterSpectrumOp", [ IsGroup, IsGroup ] );

#! @Returns the total Reidemeister spectrum of <A>H</A> and <A>G</A>.
#! @ChapterInfo reidemeisternumbers, reidemeisterspectra
#! @Arguments G
DeclareGlobalFunction( "TotalReidemeisterSpectrum" );

DeclareOperation( "TotalReidemeisterSpectrumOp", [ IsGroup ] );
