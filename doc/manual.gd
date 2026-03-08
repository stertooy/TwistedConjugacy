#! @Chapter Affine actions

#! Let $G$ and $H$ be groups, let $H$ act on $G$ (via automorphisms) by
#! $$\alpha \colon H \to \operatorname{Aut}(G) \colon h \mapsto \alpha_h$$
#! and let $\delta \colon H \to G$ be a group derivation with respect to this
#! action. Then we can construct a new action, called the **affine action**
#! associated to $\delta$, by
#! $$G \times H \to G \colon g^h = \alpha_h(g) \delta(h).$$
#! If $K$ is a subgroup of $H$, then the restriction of the affine action of
#! $H$ on $G$ to $K$ coincides with the affine action of $K$ on $G$ associated
#! to the restriction of $\delta$ to $K$.

#! <P/>

#! Algorithms designed for computing with twisted conjugacy classes can be
#! leveraged to do computations involving affine actions, see
#! <Cite Key='tert25-a' Where='Sec. 10'/> for a description on this.

#! <P/>

#! Please note that the functions in this chapter require $G$ and $H$ to either
#! both be finite, or both be PcpGroups.

#! @Section Creating an affine action

#! @BeginGroup
#! @Returns the affine action of <A>K</A> associated to the derivation <A>der</A>.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, der
DeclareGlobalFunction( "AffineActionByGroupDerivation" );
#! @EndGroup

#! @BeginExample
aff := AffineActionByGroupDerivation( H, der );
#! function( g, k ) ... end
#! @EndExample

#! @Section Operations for affine actions

#! These functions are analogues of existing &GAP; functions for group actions.

#! @BeginGroup
#! @GroupTitle OrbitAffineAction
#! @Returns the orbit of <A>g</A> under the affine action of <A>K</A> associated
#! to <A>der</A>.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, g, der
DeclareGlobalFunction( "OrbitAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle OrbitsAffineAction
#! @Returns a list containing the orbits under the affine action of <A>K</A>
#! associated to  <A>der</A> if there are finitely many, or <K>fail</K> if there
#! are infinitely many.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, der
DeclareGlobalFunction( "OrbitsAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle NrOrbitsAffineAction
#! @Returns the number of orbits under the affine action of <A>K</A> associated
#! to <A>der</A>.
#! @Arguments K, der
DeclareGlobalFunction( "NrOrbitsAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle StabiliserAffineAction
#! @Returns the stabiliser of <A>g</A> under the affine action of <A>K</A> associated
#! to <A>der</A>.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, g, der
DeclareGlobalFunction( "StabiliserAffineAction" );
#! @Arguments K, g, der
DeclareGlobalFunction( "StabilizerAffineAction" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle RepresentativeAffineAction
#! @Returns an element of <A>K</A> that maps <A>g1</A> to <A>g2</A> under the
#! affine action of <A>K</A> associated to <A>der</A>, or <K>fail</K> if no such
#! element exists.
#! @Description
#! The group <A>K</A> must be a subgroup of <C>Source(<A>der</A>)</C>.
#! @Arguments K, g1, g2, der
DeclareGlobalFunction( "RepresentativeAffineAction" );
#! @EndGroup

#! @BeginExample
g1 := G.1;;
orb := OrbitAffineAction( H, g1, der );
#! f1^G
NrOrbitsAffineAction( H, der );
#! 10
stab := StabiliserAffineAction( H, g1, der );;
Set( stab );
#! [ <identity> of ..., f3, f3^2, f2^2*f5, f2*f4*f5,
#!   f2^2*f3*f5, f2*f3*f4*f5, f2^2*f3^2*f5, f2*f3^2*f4*f5 ]
g2 := G.1*G.4*G.5;;
h := RepresentativeAffineAction( H, g1, g2, der );;
aff( g1, h ) = g2;
#! true
#! @EndExample

#! @Section Operations on orbits of affine actions

#! @BeginGroup
#! @GroupTitle Representative
#! @Returns the group element that was used to construct <A>orb</A>.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareAttribute( "Representative", IsOrbitAffineActionRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle ActingDomain
#! @Returns the group whose affine action <A>orb</A> is an orbit of.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareAttribute( "ActingDomain", IsOrbitAffineActionRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle FunctionAction
#! @Returns the affine action that <A>orb</A> is an orbit of.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareAttribute( "FunctionAction", IsOrbitAffineActionRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle \in
#! @Returns <K>true</K> if <A>elm</A> is an element of <A>orb</A>, otherwise
#! <K>false</K>.
#! @Label for an element and an orbit of an affine action
#! @Arguments elm, orb
DeclareOperation( "\in", [ IsObject, IsOrbitAffineActionRep ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Size
#! @Returns the number of elements in <A>orb</A>.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareAttribute( "Size", IsOrbitAffineActionRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle StabiliserOfExternalSet
#! @Returns the stabiliser of <C>Representative(<A>orb</A>)</C> under the
#! action <C>FunctionAction(<A>orb</A>)</C>.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareAttribute( "StabiliserOfExternalSet", IsOrbitAffineActionRep );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle List
#! @Returns a list containing the elements of <A>orb</A>.
#! @Description
#! If <A>orb</A> is infinite, this will run forever. It is recommended to first
#! test the finiteness of <A>orb</A> using
#! <Ref Attr="Size" Label="of an orbit of an affine action" Style="Number"/>.
#! @Label of an orbit of an affine action
#! @Arguments orb
DeclareGlobalFunction( "List" );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Random
#! @Returns a random element in <A>orb</A>.
#! @Label in an orbit of an affine action
#! @Arguments orb
DeclareOperation( "Random", [ IsOrbitAffineActionRep ] );
#! @EndGroup

#! @BeginGroup
#! @GroupTitle \=
#! @Returns <K>true</K> if <A>orb1</A> is equal to <A>orb2</A>, otherwise
#! <K>false</K>.
#! @Label for orbits of an affine action
#! @Arguments orb1, orb2
DeclareOperation( "\=", [ IsOrbitAffineActionRep, IsOrbitAffineActionRep ] );
#! @EndGroup

#! @BeginExample
g2 in orb;
#! true
G.2 in orb;
#! false
Size( orb );
#! 8
#! @EndExample
