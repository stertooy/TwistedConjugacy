DeclareCategory( "IsOrbitAffineAction", IsExternalSet );

#! @BeginGroup
#! @ChapterInfo affineactions, affact_creating
#! @Returns the affine action of <A>K</A> associated to the derivation
#! <A>der</A>.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, der
DeclareGlobalFunction( "AffineActionByGroupDerivation" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_operations
#! @GroupTitle OrbitAffineAction
#! @Returns the orbit of <A>g</A> under the affine action of <A>K</A>
#! associated to <A>der</A>.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, g, der
DeclareGlobalFunction( "OrbitAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_operations
#! @GroupTitle OrbitsAffineAction
#! @Returns a list containing the orbits under the affine action of <A>K</A>
#! associated to  <A>der</A> if there are finitely many, or <K>fail</K> if
#! there are infinitely many.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, der
DeclareGlobalFunction( "OrbitsAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_operations
#! @GroupTitle NrOrbitsAffineAction
#! @Returns the number of orbits under the affine action of <A>K</A>
#! associated to <A>der</A>.
#! @Arguments K, der
DeclareGlobalFunction( "NrOrbitsAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_operations
#! @GroupTitle StabiliserAffineAction
#! @Returns the stabiliser of <A>g</A> under the affine action of <A>K</A>
#! associated to <A>der</A>.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, g, der
DeclareGlobalFunction( "StabiliserAffineAction" );
#! @Arguments K, g, der
DeclareSynonym( "StabilizerAffineAction", StabiliserAffineAction );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_operations
#! @GroupTitle RepresentativeAffineAction
#! @Returns an element of <A>K</A> that maps <A>g1</A> to <A>g2</A> under the
#! affine action of <A>K</A> associated to <A>der</A>, or <K>fail</K> if no
#! such element exists.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, g1, g2, der
DeclareGlobalFunction( "RepresentativeAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_orbits
#! @GroupTitle Representative
#! @Returns the group element that was used to construct <A>orb</A>.
#! @Label of an orbit of an affine action
#! @ItemType Attr
#! @Arguments orb
DeclareGlobalName( "Representative" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_orbits
#! @GroupTitle ActingDomain
#! @Returns the group whose affine action <A>orb</A> is an orbit of.
#! @Label of an orbit of an affine action
#! @ItemType Attr
#! @Arguments orb
DeclareGlobalName( "ActingDomain" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_orbits
#! @GroupTitle FunctionAction
#! @Returns the affine action that <A>orb</A> is an orbit of.
#! @Label of an orbit of an affine action
#! @ItemType Attr
#! @Arguments orb
DeclareGlobalName( "FunctionAction" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_orbits
#! @GroupTitle \in
#! @Returns <K>true</K> if <A>elm</A> is an element of <A>orb</A>, otherwise
#! <K>false</K>.
#! @Label for an element and an orbit of an affine action
#! @ItemType Oper
#! @Arguments elm, orb
DeclareGlobalName( "\in" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_orbits
#! @GroupTitle IsFinite
#! @Returns <K>true</K> if <A>orb</A> is finite, otherwise <K>false</K>.
#! @Label for an orbit of an affine action
#! @ItemType Prop
#! @Arguments orb
DeclareGlobalName( "IsFinite" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_orbits
#! @GroupTitle Size
#! @Returns the number of elements in <A>orb</A>.
#! @Label of an orbit of an affine action
#! @ItemType Attr
#! @Arguments orb
DeclareGlobalName( "Size" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_orbits
#! @GroupTitle StabiliserOfExternalSet
#! @Returns the stabiliser of <C>Representative(<A>orb</A>)</C> under the
#! action <C>FunctionAction(<A>orb</A>)</C>.
#! @Label of an orbit of an affine action
#! @ItemType Attr
#! @Arguments orb
DeclareGlobalName( "StabiliserOfExternalSet" );
#! @Label of an orbit of an affine action
#! @ItemType Attr
#! @Arguments orb
DeclareGlobalName( "StabilizerOfExternalSet" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_orbits
#! @GroupTitle List
#! @Returns a list containing the elements of <A>orb</A>.
#! @Description
###############################################################################
#! If <A>orb</A> is infinite, this will run forever or cause an error. It is
#! recommended to first test the finiteness of <A>orb</A> using
#! <Ref Prop="IsFinite" Label="for an orbit of an affine action" Style="Number"/>.
#! @Label of an orbit of an affine action
#! @ItemType Func
#! @Arguments orb
DeclareGlobalName( "List" );
#! @Label for an orbit of an affine action
#! @ItemType Attr
#! @Arguments orb
DeclareGlobalName( "AsList" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_orbits
#! @GroupTitle Random
#! @Returns a random element in <A>orb</A>.
#! @Label in an orbit of an affine action
#! @ItemType Oper
#! @Arguments orb
DeclareGlobalName( "Random" );
#! @EndGroup

#! @BeginGroup
#! @ChapterInfo affineactions, affact_orbits
#! @GroupTitle \=
#! @Returns <K>true</K> if <A>orb1</A> is equal to <A>orb2</A>, otherwise
#! <K>false</K>.
#! @Label for orbits of an affine action
#! @ItemType Oper
#! @Arguments orb1, orb2
DeclareGlobalName( "\=" );
#! @EndGroup
