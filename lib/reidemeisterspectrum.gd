#! @Returns the Reidemeister spectrum of <A>G</A>.
#! @ChapterInfo reidemeisternumbers, reidemeisterspectra
#! @Description
#! If <A>G</A> is abelian, this function relies on the results from
#! <Cite Key='send23-a'/>.
#! Otherwise, it relies on <Cite Key='ree59-a' Where='Thm. 1'/>.
#! @Arguments G
DeclareGlobalFunction( "ReidemeisterSpectrum" );

DeclareOperation( "ReidemeisterSpectrumOp", [ IsGroup ] );

#! @Returns the extended Reidemeister spectrum of <A>G</A>.
#! @ChapterInfo reidemeisternumbers, reidemeisterspectra
#! @Description
#! If <A>G</A> is simple, this is the union of its Reidemeister spectrum with
#! the element $1$.
#! If <A>G</A> is abelian, this is just the set of all divisors its order.
#! Otherwise, this function relies on <Cite Key='ree59-a' Where='Thm. 1'/>.
#! @Arguments G
DeclareGlobalFunction( "ExtendedReidemeisterSpectrum" );

DeclareOperation( "ExtendedReidemeisterSpectrumOp", [ IsGroup ] );

#! @Returns the coincidence Reidemeister spectrum of <A>H</A> and <A>G</A>.
#! @ChapterInfo reidemeisternumbers, reidemeisterspectra
#! @Description
#! If <A>G</A> = <A>H</A> is simple, this is the union of its Reidemeister
#! spectrum with $1$ and the order of the group. 
#! If <A>G</A> = <A>H</A> is abelian, this is just the set of all divisors its
#! order.
#! Otherwise, this function relies on <Cite Key='st26-a' Where='Cor. 3.2'/>.
#! @Arguments [H, ]G
DeclareGlobalFunction( "CoincidenceReidemeisterSpectrum" );

DeclareOperation( "CoincidenceReidemeisterSpectrumOp", [ IsGroup, IsGroup ] );

#! @Returns the total Reidemeister spectrum of <A>H</A> and <A>G</A>.
#! @ChapterInfo reidemeisternumbers, reidemeisterspectra
#! @Arguments G
DeclareGlobalFunction( "TotalReidemeisterSpectrum" );

DeclareOperation( "TotalReidemeisterSpectrumOp", [ IsGroup ] );
