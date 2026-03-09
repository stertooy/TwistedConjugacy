#! @BeginGroup
#! @ChapterInfo cosets, rightcosets
#! @GroupTitle Intersection
#! @Returns the intersection of the right cosets <A>C1</A>, <A>C2</A>, ...
#! @Description
#! Alternatively, this function also accepts a single list of right cosets
#! <A>L</A> as argument.
#!
#! This intersection is always a right coset, or the empty list.
#! @Label of right cosets of a PcpGroup
#! @Arguments C1, C2, ...
# DeclareGlobalFunction( "Intersection" );
#! @Label of a list of right cosets of a PcpGroup
#! @Arguments L
# DeclareGlobalFunction( "Intersection" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo cosets, doublecosets
#! @GroupTitle \in
#! @Returns <K>true</K> if <A>g</A> is an element of <A>D</A>, otherwise
#! <K>false</K>.
#! @Label for an element and a double coset of a PcpGroup
#! @Arguments g, D
# DeclareOperation( "\in",
#   [ IsMultiplicativeElementWithInverse, IsDoubleCoset ] );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo cosets, doublecosets
#! @GroupTitle Size
#! @Returns the number of elements in <A>D</A>.
#! @Label of a double coset of a PcpGroup
#! @Arguments D
# DeclareOperation( "Size", [ IsDoubleCoset ] );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo cosets, doublecosets
#! @GroupTitle List
#! @Returns a list containing the elements of <A>D</A>.
#! @Description
#! If <A>D</A> is infinite, this will run forever. It is recommended to first
#! test the finiteness of <A>D</A> using
#! <Ref Attr="Size" Label="of a double coset of a PcpGroup" Style="Number"/>.
#! @Label of a double coset of a PcpGroup
#! @Arguments D
# DeclareGlobalFunction( "List" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo cosets, doublecosets
#! @GroupTitle \=
#! @Returns <K>true</K> if <A>C</A> and <A>D</A> are the same double coset,
#! otherwise <K>false</K>.
#! @Label for double cosets of a PcpGroup
#! @Arguments C, D
# DeclareOperation( "\=", [ IsDoubleCoset, IsDoubleCoset ] );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo cosets, doublecosets
#! @GroupTitle DoubleCosets
#! @Returns a duplicate-free list of all <C>(<A>H</A>,<A>K</A>)</C>-double
#! cosets in <A>G</A> if there are finitely many, otherwise <K>fail</K>.
#! @Description
#! The groups <A>H</A> and <A>K</A> must be subgroups of the group <A>G</A>.
#! The <C>NC</C> version does not check whether this is the case.
#! @Label for PcpGroups
#! @Arguments G, H, K
# DeclareGlobalFunction( "DoubleCosets" );
#! @Label for PcpGroups
#! @Arguments G, H, K
# DeclareOperation( "DoubleCosetsNC", [ IsPcpGroup, IsPcPGroup, IsPcPGroup ] );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo cosets, doublecosets
#! @GroupTitle DoubleCosetRepsAndSizes
#! @Returns a list containing pairs of the form <C>[ r, n ]</C>, where <C>r</C>
#! is a representative and <C>n</C> is the size of a double coset.
#! @Description
#! While for finite groups this function is supposed to be faster than
#! <Ref Oper="DoubleCosetsNC" Label="for PcpGroups" Style="Number"/>, for
#! PcpGroups it is usually **slower**.
#! @Label for PcpGroups
#! @Arguments G, H, K
# DeclareOperation( "DoubleCosetRepsAndSizes",
#   [ IsPcpGroup, IsPcPGroup, IsPcPGroup ] );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo cosets, doublecosets
#! @GroupTitle DoubleCosetIndex
#! @Returns the double coset index of the pair (<A>H</A>,<A>K</A>).
#! @Description
#! The groups <A>H</A> and <A>K</A> must be subgroups of the group <A>G</A>.
#! The <C>NC</C> version does not check whether this is the case.
#! @Arguments G, H, K
DeclareGlobalFunction( "DoubleCosetIndex" );
#! @Label
#! @Arguments G, H, K
DeclareOperation( "DoubleCosetIndexNC", [ IsGroup, IsGroup, IsGroup ] );
#! @EndGroup
