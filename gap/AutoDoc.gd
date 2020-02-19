#####
#
# TITLE PAGE
#
#####

#! @Copyright
#! &copyright; 2020 by Sam Tertooy
#! <Br /><Br />
#! The <B>TwistedConjugacy</B> package is free software, it may be redistributed and/or modified under the terms and conditions of the <URL Text="GNU Public License Version 2">https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html</URL> or (at your option) any later version.

#! @Acknowledgements
#! This documentation was created using the <B>AutoDoc</B> package. The algorithms in this package are based on <Cite Key='fels00-1' /> and <Cite Key='dt20-1' />.



#####
#
# CHAPTER 1
#
#####

#! @Chapter Twisted Conjugacy
#! @ChapterLabel twicon
#! @ChapterTitle Twisted Conjugacy
#! Please note that currently the functions in this chapter are implemented only for (endomorphisms of) finite groups and pcp-groups.


###
# SECTION 1
###

#! @Section Twisted Conjugation Action
#! Let $G$ be a group and $\varphi: G \to G$ an endomorphism. Then $\varphi$ induces a (right) group action on $G$ given by $G \times G \to G: (g,h) \mapsto g \cdot h = h^{-1} g\varphi(h)$. This group action is called **$\varphi$-twisted conjugation**, and induces an equivalence relation on the group. We say that $g_1, g_2 \in G$ are $\varphi$-twisted conjugate, denoted by $g_1 \sim_{\varphi} g_2$, if and only if there exists some element $h \in G$ such that $g_1 \cdot h = g_2$, or equivalently $g_1 = h g_2 \varphi(h)^{-1}$.


#! @Description
#! Implements the twisted conjugation (right) group action induced by the endomorphism <A>endo</A>. This is the twisted conjugacy analogue of <C>OnPoints</C>.
#! @Arguments endo
DeclareOperation( "TwistedConjugation" , [IsGroupHomomorphism] );

#! @Description
#! Tests whether the elements <A>g1</A> and <A>g2</A> are twisted conjugate under the twisted conjugacy action of the endomorphism <A>endo</A>. This is the twisted conjugacy analogue of <C>IsConjugate</C>.
#! @Arguments endo, g1, g2
DeclareOperation( "IsTwistedConjugate", [IsGroupHomomorphism, IsObject, IsObject] );

#! @Description
#! Computes an element that maps <A>g1</A> to <A>g2</A> under the twisted conjugacy action of the endomorphism <A>endo</A> and returns <C>fail</C> if no such element exists. This is the twisted conjugacy analogue of <C>RepresentativeAction</C>.
#! @Arguments endo, g1, g2
DeclareOperation( "RepresentativeTwistedConjugation", [IsGroupHomomorphism, IsObject, IsObject] );


###
# SECTION 2
###

#! @Section Reidemeister Classes
#! The equivalence classes of the equivalence relation $\sim_{\varphi}$ are called the **Reidemeister classes of $\varphi$** or the **$\varphi$-twisted conjugacy classes**. We denote the Reidemeister class of $g \in G$ by $[g]_{\varphi}$. The number of Reidemeister classes is called the Reidemeister number $R(\varphi)$ and is always a positive integer or infinity.

#! @BeginGroup ReidemeisterClassGroup
#! @Description
#! Creates the Reidemeister class of an endomorphism <A>endo</A> of a group G with representative <A>g</A>. The following attributes and operations are available:
#! * <C>Representative</C>, which returns <A>g</A>,
#! * <C>GroupHomomorphismsOfReidemeisterClass</C>, which returns a list containing <A>endo</A> and the identity map on G (to be compatible with double twisted conjugacy classes),
#! * <C>ActingDomain</C>, which returns the group G,
#! * <C>FunctionAction</C>, which returns the twisted conjugacy action of <A>endo</A> on G,
#! * <C>Random</C>, which returns a random element belonging to the Reidemeister class,
#! * <C>\in</C>, which can be used to test if an element belongs to the Reidemeister class - only guaranteed to work if the Reidemeister number of <A>endo</A> is finite,
#! * <C>AsList</C>, which lists all elements in the Reidemeister class - only works for finite groups.
#! * <C>Size</C>, which gives the number of elements in the Reidemeister class - only works for finite groups.
#! This is the twisted conjugacy analogue of <C>ConjugacyClass</C>.
#! @Arguments endo, g
DeclareOperation( "ReidemeisterClass", [IsGroupHomomorphism, IsObject] );
#! @Arguments endo, g
DeclareOperation( "TwistedConjugacyClass", [IsGroupHomomorphism, IsObject] );
#! @EndGroup

#! @BeginGroup ReidemeisterClassesGroup
#! @Description
#! Returns a list containing the Reidemeister classes of <A>endo</A> if the Reidemeister number of <A>endo</A> is finite, and returns <C>fail</C> otherwise. It is guaranteed that the Reidemeister class of the identity is in the first position. This is the twisted conjugacy analogue of <C>ConjugacyClasses</C>.
#! @Arguments endo
DeclareOperation( "ReidemeisterClasses", [IsGroupHomomorphism] );
#! @Arguments endo
DeclareOperation( "TwistedConjugacyClasses", [IsGroupHomomorphism] );
#! @EndGroup

#! @BeginGroup ReidemeisterNumberGroup
#! @Description
#! Returns the Reidemeister number of <A>endo</A>, i.e. the number of Reidemeister classes. This is the twisted conjugacy analogue of <C>NrConjugacyClasses</C>.
#! @Arguments endo
DeclareOperation( "ReidemeisterNumber", [IsGroupHomomorphism] );
#! @Arguments endo
DeclareOperation( "NrTwistedConjugacyClasses", [IsGroupHomomorphism] );
#! @EndGroup


###
# SECTION 3
###

#! @Section Reidemeister Spectra
#! The set of all Reidemeister numbers of automorphisms is called the **Reidemeister spectrum** and is denoted by $\mathrm{Spec}_R(G)$, i.e. 
#! $$\mathrm{Spec}_R(G) := \{ R(\varphi) \mid \varphi \in \mathrm{Aut}(G)\}.$$
#! The set of all Reidemeister numbers of endomorphisms is called the **extended Reidemeister spectrum** and is denoted by $\mathrm{ESpec}_R(G)$, i.e. 
#! $$\mathrm{ESpec}_R(G) := \{ R(\varphi) \mid \varphi \in \mathrm{End}(G)\}.$$

#! @Description
#! Returns the Reidemeister spectrum of <A>G</A>.
#! @Arguments G
DeclareAttribute( "ReidemeisterSpectrum", IsGroup );

#! @Description
#! Returns the extended Reidemeister spectrum of <A>G</A>.
#! @Arguments G
DeclareAttribute( "ExtendedReidemeisterSpectrum", IsGroup );


###
# SECTION 4
###

#! @Section Zeta Functions
#! Let $\varphi: G \to G$ be an endomorphism such that $R(\varphi^n) &lt; \infty$ for all $n \in \mathbb{N}$. Then the Reidemeister zeta function $R_{\varphi}(z)$ of $\varphi$ is defined as
#! $$R_{\varphi}(z) := \exp \sum_{n=1}^\infty R(\varphi^n) \frac{z^n}{n}.$$
#! Please note that the functions below are only implemented for endomorphisms of finite groups.

#! @Description
#! Returns the Reidemeister zeta function of <A>endo</A>.
#! @Arguments endo
DeclareOperation( "ReidemeisterZeta", [IsGroupHomomorphism] );

#! @Description
#! Returns a string describing the Reidemeister zeta function of <A>endo</A>.
#! @Arguments endo
DeclareOperation( "PrintReidemeisterZeta", [IsGroupHomomorphism] );

#! @Description
#! For a finite group, the sequence of Reidemeister numbers of the iterates of <A>endo</A>, i.e. the sequence R(<A>endo</A>), R(<A>endo</A>^2), ..., is periodic (see <Cite Key='fels00-1' Where='Theorem 16'/>). This function returns a list containing the first period of this sequence.
#! @Arguments endo
DeclareAttribute( "ReidemeisterZetaCoefficients", IsGroupHomomorphism );


#####
#
# CHAPTER 2
#
#####

#! @Chapter Double Twisted Conjugacy
#! @ChapterLabel dubtwicon
#! @ChapterTitle Double Twisted Conjugacy
#! Please note that currently the functions in this chapter are implemented only for (homomorphisms of) finite groups and (endomorphisms of) pcp-groups.

###
# SECTION 1
###

#! @Section Double Twisted Conjugation Action
#! Let $G,H$ be groups and $\varphi,\psi: H \to G$ group homomorphisms. Then the pair $(\varphi,\psi)$ induces a (right) group action on $G$ given by $G \times H \to G: (g,h) \mapsto g \cdot h = \psi(h)^{-1} g\varphi(h)$. This group action is called **$(\varphi,\psi)$-twisted conjugation**, and induces an equivalence relation on the group. We say that $g_1, g_2 \in G$ are $(\varphi,\psi)$-twisted conjugate, denoted by $g_1 \sim_{\varphi,\psi} g_2$, if and only if there exists some element $h \in H$ such that $g_1 \cdot h = g_2$, or equivalently $g_1 = \psi(h) g_2 \varphi(h)^{-1}$.

#! @Description
#! Implements the twisted conjugation (right) group action induced by the pair of homomorphisms ( <A>hom1</A>, <A>hom2</A> ).
#! @Arguments hom1, hom2
DeclareOperation( "TwistedConjugation" , [IsGroupHomomorphism, IsGroupHomomorphism] );

#! @Description
#! Tests whether the elements <A>g1</A> and <A>g2</A> are double twisted conjugate under the twisted conjugacy action of the pair of homomorphisms ( <A>hom1</A>, <A>hom2</A> ).
#! @Arguments hom1, hom2, g1, g2
DeclareOperation( "IsTwistedConjugate", [IsGroupHomomorphism, IsGroupHomomorphism, IsObject, IsObject] );

#! @Description
#! Computes an element that maps <A>g1</A> to <A>g2</A> under the twisted conjugacy action of the pair of homomorphisms ( <A>hom1</A>, <A>hom2</A> ) and returns <C>fail</C> if no such element exists.
#! @Arguments hom1, hom2, g1, g2
DeclareOperation( "RepresentativeTwistedConjugation", [IsGroupHomomorphism, IsGroupHomomorphism, IsObject, IsObject] );


###
# SECTION 2
###

#! @Section Reidemeister Coincidence Classes
#! The equivalence classes of the equivalence relation $\sim_{\varphi,\psi}$ are called the **Reidemeister coincidence classes of $(\varphi,\psi)$** or the **$(\varphi,\psi)$-twisted conjugacy classes**. We denote the Reidemeister class of $g \in G$ by $[g]_{\varphi,\psi}$. The number of Reidemeister coincidence classes is called the Reidemeister coincidence number $R(\varphi,\psi)$ and is always a positive integer or infinity.

#! @BeginGroup ReidemeisterCoincidenceClassGroup
#! @Description
#! Creates the Reidemeister coincidence class of the pair of homomorphisms ( <A>hom1</A>, <A>hom2</A> ) $H \to G$ with representative <A>g</A>. The following attributes and operations are available:
#! * <C>Representative</C>, which returns <A>g</A>,
#! * <C>GroupHomomorphismsOfReidemeisterClass</C>, which returns [ <A>hom1</A>, <A>hom2</A> ],
#! * <C>ActingDomain</C>, which returns the group H,
#! * <C>FunctionAction</C>, which returns the twisted conjugacy action on G,
#! * <C>Random</C>, which returns a random element belonging to the Reidemeister class,
#! * <C>\in</C>, which can be used to test if an element belongs to the Reidemeister class - only guaranteed to work if the Reidemeister number R( <A>hom1</A>, <A>hom2</A> ) is finite,
#! * <C>AsList</C>, which lists all elements in the Reidemeister class - only works for finite groups.
#! * <C>Size</C>, which gives the number of elements in the Reidemeister class - only works for finite groups.
#!
#! @Arguments hom1, hom2, g
DeclareOperation( "ReidemeisterClass", [IsGroupHomomorphism, IsGroupHomomorphism, IsObject] );
#! @Arguments hom1, hom2, g
DeclareOperation( "TwistedConjugacyClass", [IsGroupHomomorphism, IsGroupHomomorphism, IsObject] );
#! @EndGroup

#! @BeginGroup ReidemeisterCoincidenceClassesGroup
#! @Description
#! Returns a list containing the Reidemeister coincidence classes of ( <A>hom1</A>, <A>hom2</A> ) if the Reidemeister number R( <A>hom1</A>, <A>hom2</A> ) is finite, and returns <C>fail</C> otherwise. It is guaranteed that the Reidemeister class of the identity is in the first position.
#! @Arguments hom1, hom2
DeclareOperation( "ReidemeisterClasses", [IsGroupHomomorphism, IsGroupHomomorphism] );
#! @Arguments hom1, hom2
DeclareOperation( "TwistedConjugacyClasses", [IsGroupHomomorphism, IsGroupHomomorphism] );
#! @EndGroup

#! @BeginGroup ReidemeisterCoincidenceNumberGroup
#! @Description
#! Returns the Reidemeister number of ( <A>hom1</A>, <A>hom2</A> ), i.e. the number of Reidemeister classes.
#! @Arguments hom1, hom2
DeclareOperation( "ReidemeisterNumber", [IsGroupHomomorphism, IsGroupHomomorphism] );
#! @Arguments hom1, hom2
DeclareOperation( "NrTwistedConjugacyClasses", [IsGroupHomomorphism, IsGroupHomomorphism] );
#! @EndGroup



#####
#
# CHAPTER 3
#
#####

#! @Chapter Miscellaneous
#! @ChapterLabel misc
#! @ChapterTitle Miscellaneous


###
# SECTION 1
###

#! @Section Groups

#! @Description
#! Let <A>endo</A> be an endomorphism of a group G. This command returns the subgroup of G consisting of the elements fixed under the endomorphism <A>endo</A>. This command is implemented only for endomorphisms of finite groups and abelian groups.
#! @Arguments endo
DeclareOperation( "FixedPointGroup", [IsGroupHomomorphism] );

#! @Description
#! Let <A>hom1</A>, <A>hom2</A> be group homomorphisms from H to G. This command returns the subgroup of H consisting of the elements <C>h</C> for which <C>h^<A>hom1</A> = h^<A>hom2</A></C>. This command is implemented only for homomorphisms where either H is finite or G is abelian.
#! @Arguments hom1, hom2
DeclareOperation( "CoincidenceGroup", [IsGroupHomomorphism, IsGroupHomomorphism] );


###
# SECTION 2
###

#! @Section Morphisms

#! @Description
#! Let <A>endo</A> be an endomorphism of a group G and <A>epi</A> be an epimorphism from G to a group H such that the kernel of <A>epi</A> is fixed under <A>endo</A>. This command returns the endomorphism of H induced by <A>endo</A> via <A>epi</A>, that is, the endomorphism of H which maps g<C>^<A>epi</A></C> to <C>(</C>g<C>^<A>endo</A>)^<A>epi</A></C>, for any element g of G. This generalises <C>InducedAutomorphism</C> to endomorphisms.
#! @Arguments epi, endo
DeclareGlobalFunction( "InducedEndomorphism" ); # Extends InducedAutomorphism

#! @Description
#! Let <A>endo</A> be an endomorphism of a group G and <A>N</A> be subgroup of G invariant under <A>endo</A>. This command returns the endomorphism of N induced by <A>endo</A>. This is similar to <C>RestrictedMapping</C>, but the range is explicitly set to <A>N</A>.
#! @Arguments endo, N
DeclareGlobalFunction( "RestrictedEndomorphism" ); 
