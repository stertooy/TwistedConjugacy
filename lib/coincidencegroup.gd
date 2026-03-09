#! @ChapterInfo homomorphisms, coincidence
#! @Returns the subgroup of <C>Source(<A>endo</A>)</C> consisting of the
#! elements fixed under the endomorphism <A>endo</A>.
#! @Arguments endo
DeclareGlobalFunction( "FixedPointGroup" );

#! @ChapterInfo homomorphisms, coincidence
#! @Returns the subgroup of <C>Source(<A>hom1</A>)</C> consisting of the
#! elements <C>h</C> for which <C>h^<A>hom1</A></C> = <C>h^<A>hom2</A></C> =
#! ...
#! @Description
#! For infinite non-abelian groups, this function relies on a mixture of the
#! algorithms described in <Cite Key='roma16-a' Where='Thm. 2'/>,
#! <Cite Key='bkl20-a' Where='Sec. 5.4'/> and
#! <Cite Key='roma21-a' Where='Sec. 7'/>.
#! @Arguments hom1, hom2[, ...]
DeclareGlobalFunction( "CoincidenceGroup" );

DeclareOperation(
    "CoincidenceGroup2",
    [ IsGroupHomomorphism, IsGroupHomomorphism ]
);
