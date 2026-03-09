#! @ChapterInfo twistedconjugation, twistedconjugationinfo
#! @Returns a function that maps the pair <C>(g,h)</C> to
#! <A>hom1</A><C>(h)⁻¹</C> <C>g</C> <A>hom2</A><C>(h)</C>.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "TwistedConjugation" );

#! @ChapterInfo twistedconjugation, tcp
#! @Returns <K>true</K> if <A>g1</A> and <A>g2</A> are
#! <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugate, otherwise <K>false</K>.
#! @Arguments hom1[, hom2], g1[, g2]
DeclareGlobalFunction( "IsTwistedConjugate" );

#! @ChapterInfo twistedconjugation, tcp
#! @Returns an element that maps <A>g1</A> to <A>g2</A> under the
#! <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugacy action, or <K>fail</K> if
#! no such element exists.
#! @Description
#! If the source group is finite, this function relies on orbit-stabiliser
#! algorithms provided by &GAP;. Otherwise, it relies on a mixture of the
#! algorithms described in <Cite Key='roma16-a' Where='Thm. 3'/>,
#! <Cite Key='bkl20-a' Where='Sec. 5.4'/>,
#! <Cite Key='roma21-a' Where='Sec. 7'/> and <Cite Key='dt21-a'/>.
#! @Arguments hom1[, hom2], g1[, g2]
DeclareGlobalFunction( "RepresentativeTwistedConjugation" );

DeclareOperation(
    "RepresentativeTwistedConjugationOp",
    [ IsGroupHomomorphism, IsGroupHomomorphism,
      IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ]
);
