#####
#
# TITLEPAGE
#
#####

#! @Abstract
#! The &TwistedConjugacy; package provides methods for solving the twisted
#! conjugacy problem (including the "search" and "multiple" variants) and for
#! computing Reidemeister classes, numbers, spectra, and zeta functions. It
#! also includes utility functions for working with (double) cosets, group
#! homomorphisms, and group derivations.
#! <P/>
#! These methods are primarily designed for use with finite groups and with
#! polycyclically presented groups (finite or infinite).

#! @Copyright
#! &copyright; 2020&ndash;&RELEASEYEAR; Sam Tertooy
#! <P/>
#! The &TwistedConjugacy; package is free software, it may be redistributed
#! and/or modified under the terms and conditions of the
#! <URL Text="GNU Public License Version 2">
#! https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html</URL> or
#! (at your option) any later version.

#! @Acknowledgements
#! This documentation was created using the &GAPDoc; and &AutoDoc; packages.



#####
#
# CHAPTER 1
#
#####

#! @Chapter thepkg
#! @ChapterTitle The TwistedConjugacy Package

#! @Section Introduction
#! This is the manual for the &GAP; 4 package &TwistedConjugacy; version
#! &VERSION;.
#! TODO more stuff here?


# Note to self: check https://docs.gap-system.org/pkg/agt/doc/chap1_mj.html
#  and https://docs.gap-system.org/pkg/anupq/doc/chap3_mj.html
# Chapter 1: Introduction
# Chapter 2: Mathematical Background

# TODOS:
# - Try use variables in this documentation (dependencies, version, ...)
# - Also distribute .zip?
# - Installation instructions
# ----- For Linux/WSL + For Cygwin + Via PackageManager
# - Update README
# - Use manual cross-references

#! @Section Installation
#! You can download &TwistedConjugacy; as a .tar.gz-archive
#! <URL Text='here'>&ARCHIVEURL;.tar.gz</URL>. After extracting, you should
#! place it in a suitable <F>pkg</F> folder. For example, on a Debian-based
#! Linux distribution (e.g. Ubuntu, Mint), you can place it in
#! <F>&dollar;HOME/.gap/pkg</F> (recommended) which makes it available for just
#! yourself, or in the &GAP; installation directory (<F>gap-X.Y.Z/pkg</F>)
#! which makes it available for all users.
#! You can use the following command to do this efficiently:
#! <Listing Type="Command">
#! wget -qO- https://[...].tar.gz | tar xzf - --one-top-level=&dollar;HOME/.gap/pkg
#!</Listing>
#! If the &PackageManager; package is installed and loaded, you can install
#! &TwistedConjugacy; from within a GAP session
#! using <Ref Func="InstallPackage" BookName="PackageManager" Style="Number"/>.
#! @BeginLog
InstallPackage( "https://[...].tar.gz" );
#! ...
#! true
#! @EndLog
# <Ref Func="ReadPackage" BookName="ref"/>.
# <Ref Func="TwistedConjugation" Style="Number"/>.

#! @Section Loading
#! Once installed, loading &TwistedConjugacy; can be done simply by running
#! <Ref Func="LoadPackage" BookName="ref" Style="Number"/>.
#! @BeginLog
LoadPackage( "TwistedConjugacy" );
#! ...
#! true
#! @EndLog

#! @Section Citing
#! If you use the &TwistedConjugacy; package in your research, we would love to
#! hear about your work via an email to the address
#! <Email>&SUPPORTEMAIL;</Email>.
#! If you have used the the &TwistedConjugacy; package in the preparation of a
#! paper and wish to refer to it, please cite it as described below.

#! <P/>

#! In &BibTeX;:
#! <Listing Type="BibTeX">
#! &AT;misc{TC&VERSION;,
#!     author =       {Tertooy, Sam},
#!     title =        {{TwistedConjugacy,
#!                     &SUBTITLE;,
#!                     Version &VERSION;}},
#!     note =         {GAP package},
#!     year =         {&RELEASEYEAR;},
#!     howpublished = {\url{https://stertooy.github.io/TwistedConjugacy}}
#! }</Listing><P/>
#! In &BibLaTeX;:
#! <Listing Type="BibLaTeX">
#! &AT;software{TC&VERSION;,
#!     author =   {Tertooy, Sam},
#!     title =    {TwistedConjugacy},
#!     subtitle = {&SUBTITLE;},
#!     version =  {&VERSION;},
#!     note =     {GAP package},
#!     year =     {&RELEASEYEAR;},
#!     url =      {&HOMEURL;}
#! }</Listing>

#! @Section Support
#! If you encounter any problems, please submit to them to the
#! <URL Text='issue tracker'>&ISSUEURL;</URL>.
#! If you have any questions on the usage or functionality of
#! &TwistedConjugacy;, you may contact me via email at
#! <Email>&SUPPORTEMAIL;</Email>.

#! <P/>

#! Bugs in &GAP;, in this package, or in any other package used directly or
#! indirectly, may cause functions provided by &TwistedConjugacy; to produce
#! errors or incorrect results.
#! To help detect such issues, you can enable internal checks by setting the
#! variable <C>ASSERT&#64;TwistedConjugacy</C> to <K>true</K>. Note that this
#! will come at the cost of reduced performance.

#! <P/>

#! For additional safety, you can enable &GAP;'s built-in assertion features by
#! calling <C>SetAssertionLevel( <A>lev</A> )</C> (we recommend setting
#! <A>lev</A> to <C>2</C>) and, when working with PcpGroups, settings the
#! variables <C>CHECK_CENT&#64;Polycyclic</C>, <C>CHECK_IGS&#64;Polycyclic</C>
#! and <C>CHECK_INTSTAB&#64;Polycyclic</C> to <K>true</K>.



#####
#
# CHAPTER 2
#
#####

#! @Chapter Mathematical Background

#! Let $G$ and $H$ be groups and let $\varphi$ and $\psi$ be group
#! homomorphisms from $H$ to $G$. The pair $(\varphi,\psi)$ induces a
#! (right) group action of $H$ on $G$ given by the map $$G \times H \to G
#! \colon (g,h) \mapsto \varphi(h)^{-1} g\,\psi(h).$$
#! This group action is called **$(\varphi,\psi)$-twisted conjugation**. The
#! orbits are called **Reidemeister classes** or **twisted conjugacy classes**,
#! and the number of Reidemeister classes is called the **Reidemeister number**
#! $R(\varphi,\psi)$ of the pair $(\varphi,\psi)$. The stabiliser of the
#! identity $1_G$ under the $(\varphi,\psi)$-twisted conjugacy action of $H$ is
#! exactly the **coincidence group**
#! $$\operatorname{Coin}(\varphi,\psi) =
#! \left\{\, h \in H \mid \varphi(h) = \psi(h) \, \right\}.$$
#! Generalising this, the stabiliser of any $g \in G$ is the coincidence group
#! $\operatorname{Coin}(\iota_g\varphi,\psi)$, with $\iota_g$ the inner
#! automorphism of $G$ that conjugates by $g$.

#! <P/>

#! Twisted conjugacy originates in Reidemeister-Nielsen fixed point and coincidence theory,
#! where it serves as a tool for studying fixed and coincidence points of continuous maps
#! between topological spaces. Below, we briefly illustrate how and where this algebraic notion
#! pops up when studying coincidence points.

#! Let $X$ and $Y$ be topological spaces with universal covers
#! $p \colon \tilde{X} \to X$ and $q \colon \tilde{Y} \to Y$ and let
#! $\mathcal{D}(X), \mathcal{D}(Y)$ be their covering transformations groups.

#! Let $f,g \colon X \to Y$ be continuous maps with lifts
#! $\tilde{f}, \tilde{g} \colon \tilde{X} \to \tilde{Y}$. By $f_*\colon 
#! \mathcal{D}(X) \to \mathcal{D}(Y)$, denote the group homomorphism defined by
#! $\tilde{f} \circ \gamma = f_*(\gamma) \circ \tilde{f}$ for all  $\gamma \in 
#! \mathcal{D}(X)$, and let $g_*$ be defined similarly. The
#! set of coincidence points $\operatorname{Coin}(f,g)$ equals the union
#! $$\operatorname{Coin}(f,g) = \bigcup_{\alpha \in \mathcal{D}(Y)}
#! p(\operatorname{Coin}(\tilde{f}, \alpha \tilde{g})).$$
#! For any two elements $\alpha, \beta \in \mathcal{D}(Y)$, the sets
#! $p(\operatorname{Coin}(\tilde{f}, \alpha \tilde{g}))$ and
#! $p(\operatorname{Coin}(\tilde{f}, \beta \tilde{g}))$ are either disjoint or
#! equal. Moreover, they are equal if and only if there exists some $\gamma
#! \in \mathcal{D}(X)$ such that $\alpha = f_*(\gamma)^{-1} \circ \beta \circ
#! g_*(\gamma)$, which is exactly the same as saying that $\alpha$ and $\beta$
#! are $(f_*,g_*)$-twisted conjugate. Thus,
#! $$\operatorname{Coin}(f,g) = \bigsqcup_{[\alpha]}
#! p(\operatorname{Coin}(\tilde{f}, \alpha \tilde{g})),$$
#! where $[\alpha]$ runs over the $(f_*,g_*)$-twisted conjugacy classess. For
#! sufficiently well-behaved spaces $X$ and $Y$ (e.g. nilmanifolds of equal dimension)
#! we have that if $R(f_*,g_*) &lt; \infty$, then 
#! $$R(f_*,g_*) \leq \left|\operatorname{Coin}(f,g)\right|,$$
#! whereas if $R(f_*,g_*) = \infty$ there exist continuous maps $f'$ and $g'$ homotopic to $f$ and $g$ respectively such that
#! $\operatorname{Coin}(f',g') = \varnothing$.





#####
#
# CHAPTER 3
#
#####

#! @Chapter Twisted Conjugacy


###
# SECTION 1
###

#! @Section The Twisted Conjugation Action
#! Let $G$ and $H$ be groups and let $\varphi$ and $\psi$ be group
#! homomorphisms from $H$ to $G$. The pair $(\varphi,\psi)$ induces a
#! (right) group action of $H$ on $G$ given by the map $$G \times H \to G
#! \colon (g,h) \mapsto \varphi(h)^{-1} g\,\psi(h).$$
#! This group action is called **$(\varphi,\psi)$-twisted conjugation**.

#! @Arguments hom1[, hom2]
#! @Returns a function that maps the pair <C>(g,h)</C> to <A>hom1</A><C>(h)⁻¹</C> <C>g</C> <A>hom2</A><C>(h)</C>.
#! @Description If <A>hom2</A> is omitted, then <A>hom1</A> must be an endomorphism, and <A>hom2</A> is taken to be the identity map.
DeclareGlobalFunction( "TwistedConjugation" );


###
# SECTION 2
###

#! @Section The Twisted Conjugacy (Search) Problem
#! Given groups $G$ and $H$, group homomorphisms $\varphi$ and $\psi$ from $H$
#! to $G$ and elements $g_1, g_2 \in G$, the **twisted conjugacy problem** is
#! the decision problem that asks whether $g_1$ and $g_2$ are $(\varphi,\psi)$-twisted
#! conjugate.
#! The **twisted conjugacy search problem** is the problem of determining
#! an explicit $h$ such that $\varphi(h)^{-1}g_1\psi(h) = g_2$ (under the assumption that such
#! $h$ exists).

#! @Arguments hom1[, hom2], g1[, g2]
#! @Returns <K>true</K> if <A>g1</A> and <A>g2</A> are <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugate, otherwise <K>false</K>.
#! @Description
#! If <A>hom2</A> is omitted, then <A>hom1</A> must be an endomorphism, and <A>hom2</A> is taken to be the identity map.
#! If <A>g2</A> is omitted, it is taken to be the identity element.
#!
#! This function relies on the output of <C>RepresentativeTwistedConjugation</C>.
DeclareGlobalFunction( "IsTwistedConjugate" );

#! @Arguments hom1[, hom2], g1[, g2]
#! @Returns an element that maps <A>g1</A> to <A>g2</A> under the <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugacy action, or <K>fail</K> if no such element exists.
#! @Description
#! If <A>hom2</A> is omitted, then <A>hom1</A> must be an endomorphism, and <A>hom2</A> is taken to be the identity map.
#! If <A>g2</A> is omitted, it is taken to be the identity element.
#!
#! If the source group is finite, this function relies on orbit-stabiliser algorithms provided by &GAP;. 
#! Otherwise, it relies on a mixture of the algorithms described in <Cite Key='roma16-a' Where='Thm. 3'/>, <Cite Key='bkl20-a' Where='Sec. 5.4'/>, <Cite Key='roma21-a' Where='Sec. 7'/> and <Cite Key='dt21-a'/>.
DeclareGlobalFunction( "RepresentativeTwistedConjugation" );

#! @BeginExample
G := AlternatingGroup( 6 );;
H := SymmetricGroup( 5 );;
phi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,4)(3,6), () ] );;
psi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,4), () ] );;
tc := TwistedConjugation( phi, psi );;
g1 := (4,6,5);;
g2 := (1,6,4,2)(3,5);;
IsTwistedConjugate( psi, phi, g1, g2 );
#! false
h := RepresentativeTwistedConjugation( phi, psi, g1, g2 );
#! (1,2)
tc( g1, h ) = g2;
#! true
#! @EndExample


###
# SECTION 3
###

#! @Section The Multiple Twisted Conjugacy (Search) Problem
#! Let $H$ and $G_1, \ldots, G_n$ be groups. For each $i \in \{1,\ldots,n\}$, let $g_i,g_i' \in G_i$ and let $\varphi_i,\psi_i\colon H \to G_i$ be group homomorphisms.
#! The **multiple twisted conjugacy problem** is
#! the decision problem that asks whether there exists some $h \in H$ such that
#! $\varphi_i(h)^{-1}g_i\psi_i(h) = g_i'$ for all $i \in \{1,\ldots,n\}$.

#! The **multiple twisted conjugacy search problem** is the problem of determining
#! an explicit $h$ such that $\varphi_i(h)^{-1}g_i\psi_i(h) = g_i'$ for all $i \in \{1,\ldots,n\}$ (under the assumption that such
#! $h$ exists).

#! <P/>

#! By setting $G = G_1 \times \cdots \times G_n$ and defining the group homomorphisms
#! $$ \varphi \colon H \to G \colon h \mapsto (\varphi_1(h), \ldots, \varphi_n(g)),$$
#! $$ \psi \colon H \to G \colon h \mapsto (\psi_1(h), \ldots, \psi_n(g)),$$
#! these problems reduce to their non-multiple variants.

#! @Arguments hom1List[, hom2List], g1List[, g2List]
#! @Returns <K>true</K> if <A>g1List</A><C>[i]</C> and <A>g2List</A><C>[i]</C> are <C>(<A>hom1List</A>[i],<A>hom2List</A>[i])</C>-twisted conjugate
#! for all <C>i</C> via a common twisted conjugator, otherwise <K>false</K>.
#! @Description
#! If <A>hom2List</A> is omitted, then <A>hom1List</A> must be a list of endomorphisms, and <A>hom2List</A> is taken to be a list of identity maps.
#! If <A>g2List</A> is omitted, it is taken to be a list of identity elements.
DeclareGlobalFunction( "IsTwistedConjugateMultiple" );

#! @Arguments hom1List[, hom2List], g1List[, g2List]
#! @Returns an element that maps <A>g1List</A><C>[i]</C> to <A>g2List</A><C>[i]</C> under the <C>(<A>hom1List</A>[i],<A>hom2List</A>[i])</C>-twisted conjugacy action, or <K>fail</K> if no such element exists.
#! @Description
#! If <A>hom2List</A> is omitted, then <A>hom1List</A> must be a list of endomorphisms, and <A>hom2List</A> is taken to be a list of identity maps.
#! If <A>g2List</A> is omitted, it is taken to be a list of identity elements.
DeclareGlobalFunction( "RepresentativeTwistedConjugationMultiple" );

#! @BeginExample
H := SymmetricGroup( 5 );;
G := AlternatingGroup( 6 );;
phi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,4)(3,6), () ] );;
psi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,4), () ] );;
tau := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,2)(3,6), () ] );;
khi := GroupHomomorphismByImages( H, G, [ (1,2)(3,5,4), (2,3)(4,5) ],
 [ (1,3)(4,6), () ] );;
IsTwistedConjugateMultiple( [ phi, psi ], [ khi, tau ],
 [ (1,5)(4,6), (1,4)(3,5) ], [ (1,4,5,3,6), (2,4,5,6,3) ] );
#! true
RepresentativeTwistedConjugationMultiple( [ phi, psi ], [ khi, tau ],
 [ (1,5)(4,6), (1,4)(3,5) ], [ (1,4,5,3,6), (2,4,5,6,3) ] );
#! (1,2)
#! @EndExample



#! @Chapter Reidemeister Classes

#! The orbits of the $(\varphi,\psi)$-twisted conjugacy action are called the
#! **Reidemeister classes of $(\varphi,\psi)$** or the
#! **$(\varphi,\psi)$-twisted conjugacy classes**. We denote the Reidemeister
#! class of $g \in G$ by $[g]_{\varphi,\psi}$.

#! @Section Creating a Reidemeister Class

#! @BeginGroup TwistedConjugacyClassGroup
#! @Arguments hom1[, hom2], g
#! @Returns the <C>(<A>hom1</A>,<A>hom2</A>)</C>-twisted conjugacy class of <A>g</A>.
#! @Description If <A>hom2</A> is omitted, then <A>hom1</A> must be an endomorphism, and <A>hom2</A> is taken to be the identity map.
DeclareGlobalFunction( "ReidemeisterClass" );
#! @Arguments hom1[, hom2], g
DeclareGlobalFunction( "TwistedConjugacyClass" );
#! @EndGroup

#! @Section Operations on Reidemeister Classes



#! @Group RepresentativeTCC
#! @GroupTitle Representative
#! @Label of a twisted conjugacy class
#! @Arguments tcc
#! @Returns the group element that was used to construct <A>tcc</A>.
DeclareAttribute( "Representative", IsReidemeisterClassGroupRep );

#! @Group ActionDomainTCC
#! @GroupTitle ActionDomain
#! @Label of a twisted conjugacy class
#! @Arguments tcc
#! @Returns the group whose twisted conjugacy action <A>tcc</A> is an orbit of.
DeclareAttribute( "ActionDomain", IsReidemeisterClassGroupRep );

#! @Group FunctionActionTCC
#! @GroupTitle FunctionAction
#! @Label of a twisted conjugacy class
#! @Arguments tcc
#! @Returns the twisted conjugacy action that <A>tcc</A> is an orbit of.
DeclareAttribute( "FunctionAction", IsReidemeisterClassGroupRep );

#! @Group InTCC
#! @GroupTitle \in
#! @Label for an element and a twisted conjugacy class
#! @Arguments g, tcc
#! @Returns <K>true</K> if <A>g</A> is an element of <A>tcc</A>, otherwise <K>false</K>.
DeclareOperation( "\in", [ IsObject, IsReidemeisterClassGroupRep ] );

#! @Group SizeTCC
#! @GroupTitle Size
#! @Label of a twisted conjugacy class
#! @Arguments tcc
#! @Returns the number of elements in <A>tcc</A>.
#! @Description
#! This is calculated using the orbit-stabiliser theorem.
DeclareAttribute( "Size", IsReidemeisterClassGroupRep );


#! @Group StabiliserOfExternalSetTCC
#! @GroupTitle StabiliserOfExternalSet
#! @Label of a twisted conjugacy class
#! @Arguments tcc
#! @Returns the stabiliser of <C>Representative(<A>tcc</A>)</C> under the action
#! <C>FunctionAction(<A>tcc</A>)</C>.
#! @Description
#! This is calculated using <Ref Func="CoincidenceGroup"/>.
DeclareAttribute( "StabiliserOfExternalSet", IsReidemeisterClassGroupRep );

#! @Group ListTCC
#! @GroupTitle List
#! @Label of a twisted conjugacy class
#! @Arguments tcc
#! @Returns a list containing the elements of <A>tcc</A>.
#! @Description If <A>tcc</A> is infinite, this will run forever. It is recommended
#! to first test the finiteness of <A>tcc</A> using <Ref Attr="Size" Label="of a twisted conjugacy class"/>.
DeclareGlobalFunction( "List" );

#! @Group RandomTCC
#! @GroupTitle Random
#! @Label for twisted conjugacy classes
#! @Arguments tcc
#! @Returns a random element in <A>tcc</A>.
DeclareOperation( "Random", [ IsReidemeisterClassGroupRep ] );

#! @Group EqualsTCC
#! @GroupTitle \=
#! @Label for twisted conjugacy classes
#! @Arguments tcc1, tcc2
#! @Returns <K>true</K> if <A>tcc1</A> is equal to <A>tcc2</A>, otherwise <K>false</K>.
DeclareOperation( "\=", [ IsReidemeisterClassGroupRep, IsReidemeisterClassGroupRep ] );


#! @Section Calculating all Reidemeister Classes

#! @BeginGroup ReidemeisterClassesGroup
#! @Arguments hom1[, hom2][, N]
#! @Returns a list containing the Reidemeister classes of (<A>hom1</A>, <A>hom2</A>) if there are finitely many, or <K>fail</K> otherwise.
#! @Description
#! If <A>hom2</A> is omitted, then <A>hom1</A> must be an endomorphism, and <A>hom2</A> is taken to be the identity map.
#! If <A>N</A> is provided, it must be a normal subgroup of <C>Range(<A>hom1</A>)</C>; the function will then only return the
#! Reidemeister classes that intersect <A>N</A> non-trivially.
#! It is guaranteed that the Reidemeister class of the identity is in the first position, and that the representatives of the classes belong to <A>N</A> if this argument is present.
#! <P />
#! If $G$ and $H$ are finite, this function relies on an orbit-stabiliser algorithm.
#! Otherwise, it relies on the algorithms in <Cite Key='dt21-a'/> and <Cite Key='tert25-a'/>.
DeclareGlobalFunction( "ReidemeisterClasses" );
#! @Arguments hom1[, hom2][, N]
DeclareGlobalFunction( "TwistedConjugacyClasses" );
#! @EndGroup

#! @BeginGroup RepresentativesReidemeisterClassesGroup
#! @Arguments hom1[, hom2][, N]
#! @Returns a list containing representatives of the Reidemeister classes of (<A>hom1</A>, <A>hom2</A>) if there are finitely many, or <K>fail</K> otherwise.
#! @Description
#! If <A>hom2</A> is omitted, then <A>hom1</A> must be an endomorphism, and <A>hom2</A> is taken to be the identity map.
#! If <A>N</A> is provided, it must be a normal subgroup of <C>Range(<A>hom1</A>)</C>; the function will then only return the representatives of 
#! the Reidemeister classes that intersect <A>N</A> non-trivially.
#! It is guaranteed that the identity is in the first position, and that all elements belong to <A>N</A> if this argument is present.
DeclareGlobalFunction( "RepresentativesReidemeisterClasses" );
#! @Arguments hom1[, hom2][, N]
DeclareGlobalFunction( "RepresentativesTwistedConjugacyClasses" );
#! @EndGroup



#! @BeginExample
tcc := ReidemeisterClass( phi, psi, g1 );
#! (4,6,5)^G
Representative( tcc );
#! (4,6,5)
ActingDomain( tcc ) = H;
#! true
FunctionAction( tcc )( g1, h );
#! (1,6,4,2)(3,5)
List( tcc );
#! [ (4,6,5), (1,6,4,2)(3,5) ]
Size( tcc );
#! 2
StabiliserOfExternalSet( tcc );
#! Group([ (1,2,3,4,5), (1,3,4,5,2) ])
ReidemeisterClasses( phi, psi ){[1..7]};
#! [ ()^G, (4,5,6)^G, (4,6,5)^G, (3,4)(5,6)^G, (3,4,5)^G, (3,4,6)^G, (3,5,4)^G ]
RepresentativesReidemeisterClasses( phi, psi ){[1..7]};
#! [ (), (4,5,6), (4,6,5), (3,4)(5,6), (3,4,5), (3,4,6), (3,5,4) ]
NrTwistedConjugacyClasses( phi, psi );
#! 184
#! @EndExample


#! @Chapter Reidemeister Numbers and Spectra
#! @ChapterLabel reidnrspec
#! @ChapterTitle Reidemeister Numbers and Spectra

#! @Section Reidemeister Numbers
#!  The number of Reidemeister classes is called the Reidemeister number $R(\varphi,\psi)$ and is always a positive integer or infinity.
#! @BeginGroup ReidemeisterNumberGroup
#! @Description
#! Returns the Reidemeister number of ( <A>hom1</A>, <A>hom2</A> ), i.e. the number of Reidemeister classes.
#! <P/>
#! If $G$ is abelian, this function relies on (a generalisation of) <Cite Key='jian83-a' Where='Thm. 2.5'/>.
#! If $G = H$, $G$ is finite non-abelian and $\psi = \operatorname{id}_G$, it relies on <Cite Key='fh94-a' Where='Thm. 5'/>.
#! Otherwise, it uses the output of <C>RepresentativesReidemeisterClasses</C>.
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "ReidemeisterNumber" );
#! @Arguments hom1[, hom2]
DeclareGlobalFunction( "NrTwistedConjugacyClasses" );
#! @EndGroup

#! @Section Reidemeister Spectra
#! The set of all Reidemeister numbers of automorphisms is called the **Reidemeister spectrum** and is denoted by $\operatorname{Spec}_R(G)$, i.e.
#! $$\operatorname{Spec}_R(G) := \{\, R(\varphi) \mid \varphi \in \operatorname{Aut}(G) \,\}.$$
#! The set of all Reidemeister numbers of endomorphisms is called the **extended Reidemeister spectrum** and is denoted by $\operatorname{ESpec}_R(G)$, i.e.
#! $$\operatorname{ESpec}_R(G) := \{\, R(\varphi) \mid \varphi \in \operatorname{End}(G) \,\}.$$
#! The set of all Reidemeister numbers of pairs of homomorphisms from a group $H$ to a group $G$ is called the **coincidence Reidemeister spectrum** of $H$ and $G$ and is denoted by $\operatorname{CSpec}_R(H,G)$, i.e.
#! $$\operatorname{CSpec}_R(H,G) := \{\, R(\varphi, \psi) \mid \varphi,\psi \in \operatorname{Hom}(H,G) \,\}.$$
#! If <A>H</A> = <A>G</A> this is also denoted by $\operatorname{CSpec}_R(G)$.
#! The set of all Reidemeister numbers of pairs of homomorphisms from every group $H$ to a group $G$ is called the **total Reidemeister spectrum** and is denoted by $\operatorname{TSpec}_R(G)$, i.e.
#! $$\operatorname{TSpec}_R(G) := \bigcup_{H} \operatorname{CSpec}_R(H,G).$$

#! <P/>

#! Please note that the functions below are only implemented for finite groups.

#! @Description
#! Returns the Reidemeister spectrum of <A>G</A>.
#! <P />

#! If $G$ is abelian, this function relies on the results from <Cite Key='send23-a'/>.

#! @Arguments G
DeclareGlobalFunction( "ReidemeisterSpectrum" );

#! @Description
#! Returns the extended Reidemeister spectrum of <A>G</A>.
#! @Arguments G
DeclareGlobalFunction( "ExtendedReidemeisterSpectrum" );

#! @Description
#! Returns the coincidence Reidemeister spectrum of <A>H</A> and <A>G</A>.
#! @Arguments [H, ]G
DeclareGlobalFunction( "CoincidenceReidemeisterSpectrum" );

#! @Description
#! Returns the total Reidemeister spectrum of <A>G</A>.
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


#! @Chapter Reidemeister Zeta Functions
#! @ChapterLabel reidzeta
#! @ChapterTitle Reidemeister Zeta Functions

#! @Section Reidemeister Zeta Functions
#! Let $\varphi,\psi\colon G \to G$ be endomorphisms such that $R(\varphi^n,\psi^n) &lt; \infty$ for all $n \in \mathbb{N}$. Then the **Reidemeister zeta function** $Z_{\varphi,\psi}(s)$ of the pair $(\varphi,\psi)$ is defined as
#! $$Z_{\varphi,\psi}(s) := \exp \sum_{n=1}^\infty \frac{R(\varphi^n,\psi^n)}{n} s^n.$$
#! <P/>
#! Please note that the functions below are only implemented for endomorphisms of finite groups.

#! @BeginGroup ReidemeisterZetaCoefficientsGroup
#! @Description
#! For a finite group, the sequence of Reidemeister numbers of the iterates of <A>endo1</A> and <A>endo2</A>, i.e. the sequence $R(<A>endo1</A>,<A>endo2</A>)$, $R(<A>endo1</A>^2,<A>endo2</A>^2)$, ..., is eventually periodic, i.e. there exist a periodic sequence $(P_n)_{n \in \mathbb{N}}$ and an eventually zero sequence $(Q_n)_{n \in \mathbb{N}}$ such that
#! $$\forall n \in \mathbb{N}: R(\varphi^n,\psi^n) = P_n + Q_n.$$
#! This function returns a list containing two sublists: the first sublist contains one period of the sequence $(P_n)_{n \in \mathbb{N}}$, the second sublist contains $(Q_n)_{n \in \mathbb{N}}$ up to the part where it becomes the constant zero sequence.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "ReidemeisterZetaCoefficients" );
#! @EndGroup

#! @BeginGroup IsRationalReidemeisterZetaGroup
#! @Description
#! Returns <K>true</K> if the Reidemeister zeta function of <A>endo1</A> and <A>endo2</A> is rational, and <K>false</K> otherwise.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "IsRationalReidemeisterZeta" );
#! @EndGroup

#! @BeginGroup ReidemeisterZetaGroup
#! @Description
#! Returns the Reidemeister zeta function of <A>endo1</A> and <A>endo2</A> if it is rational, and <K>fail</K> otherwise.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "ReidemeisterZeta" );
#! @EndGroup

#! @BeginGroup PrintReidemeisterZetaGroup
#! @Description
#! Returns a string describing the Reidemeister zeta function of <A>endo1</A> and <A>endo2</A>. This is often more readable than evaluating <C>ReidemeisterZeta</C> in an indeterminate, and does not require rationality.
#! @Arguments endo1[, endo2]
DeclareGlobalFunction( "PrintReidemeisterZeta" );
#! @EndGroup

#! @BeginExample
khi := GroupHomomorphismByImages( G, G, [ (1,2,3,4,5), (4,5,6) ],
 [ (1,2,6,3,5), (1,4,5) ] );;
ReidemeisterZetaCoefficients( khi );
#! [ [ 7 ], [  ] ]
IsRationalReidemeisterZeta( khi );
#! true
ReidemeisterZeta( khi );
#! function( s ) ... end
s := Indeterminate( Rationals, "s" );;
ReidemeisterZeta( khi )(s);
#! (1)/(-s^7+7*s^6-21*s^5+35*s^4-35*s^3+21*s^2-7*s+1)
PrintReidemeisterZeta( khi );
#! "(1-s)^(-7)"
#! @EndExample





#####
#
# CHAPTER 4
#
#####

#! @Chapter Cosets
#! @ChapterLabel csts
#! @ChapterTitle Cosets in PcpGroups

#! Please note that the functions below are implemented only for PcpGroups.


###
# SECTION 1
###

#! @Section Right cosets

#! @BeginGroup IntersectionCosets
#! @Description
#! Calculates the intersection of the (right) cosets <A>C1</A>, <A>C2</A>, ... Alternatively, <A>list</A> may be a list of (right) cosets. This intersection is either a new coset, or an empty list.
#! @Arguments C1, C2, ...
#! @Label of right cosets
DeclareGlobalFunction( "Intersection" );
#! @Arguments list
#! @Label of a list of right cosets
DeclareGlobalFunction( "Intersection" );
#! @EndGroup

#! @BeginExample
G := ExamplesOfSomePcpGroups( 5 );;
H := Subgroup( G, [ G.1*G.2^-1*G.3^-1*G.4^-1, G.2^-1*G.3*G.4^-2 ] );;
K := Subgroup( G, [ G.1*G.3^-2*G.4^2, G.1*G.4^4 ] );;
x := G.1*G.3^-1;;
y := G.1*G.2^-1*G.3^-2*G.4^-1;;
z := G.1*G.2*G.3*G.4^2;;
Hx := RightCoset( H, x );;
Ky := RightCoset( K, y );;
Intersection( Hx, Ky );
#! RightCoset(<group with 2 generators>,<object>)
Kz := RightCoset( K, z );;
Intersection( Hx, Kz );
#! [  ]
#! @EndExample


###
# SECTION 2
###

#! @Section Double cosets

#! @Description
#! Given an element <A>g</A> of a group and a double coset <A>D</A> of that same group, this function tests whether <A>g</A> is an element of <A>D</A>.
#! @Arguments g, D
#! @Label for an element and a double coset
#! @Returns <K>true</K> if <A>g</A> is an element of the double coset <A>D</A>, otherwise <K>false</K>.
DeclareOperation( "\in", [ IsMultiplicativeElementWithInverse, IsDoubleCoset ] );

#! @Arguments C, D
#! @Label for double cosets
#! @Returns <K>true</K> if <A>C</A> and <A>D</A> are the same double coset, otherwise <K>false</K>.
DeclareOperation( "=", [ IsDoubleCoset, IsDoubleCoset ] );

#! @Arguments D
#! @Label for a double coset
#! @Returns the size of the double coset <A>D</A>.
DeclareOperation( "Size", [ IsDoubleCoset ] );

#! @BeginGroup DoubleCosetsGroup
#! @Returns a duplicate-free list of all double cosets <A>H</A>$g$<A>K</A> for $g \in$<A>G</A> if there are finitely many, otherwise <K>fail</K>.
#! @Description
#! The groups <A>H</A> and <A>K</A> must be subgroups of the group <A>G</A>.
#! The <C>NC</C> version does not check whether <A>H</A> and <A>K</A> are subgroups of <A>G</A>.
#! @Arguments G, H, K
DeclareGlobalFunction( "DoubleCosets" );
#! @Arguments G, H, K
#! <Label Name="DoubleCosetsNC"/>
DeclareOperation( "DoubleCosetsNC", [ IsPcpGroup, IsPcPGroup, IsPcPGroup ] );
#! @EndGroup

#! @Arguments G, H, K
#! @Returns a list of double coset representatives and their sizes, the entries
#! are lists of the form <C>[ r, n ]</C> where <C>r</C> and <C>n</C> are an
#! element of the double coset and the size of the coset, respectively.
#! @Description
#! While for finite groups this operation is faster than
#! <Ref Oper="DoubleCosetsNC" />, for PcpGroups this operation is usually slower
#! since the calculation of the sizes requires the construction of
#! coincidence groups (see <Ref Func="CoincidenceGroup" />).
DeclareOperation( "DoubleCosetRepsAndSizes", [ IsPcpGroup, IsPcPGroup, IsPcPGroup ] );
#! @EndGroup

#! @BeginGroup DoubleCosetIndexGroup
#! @Returns the double coset index of the pair (<A>H</A>,<A>K</A>).
#! @Description
#! The groups <A>H</A> and <A>K</A> must be subgroups of the group <A>G</A>.
#! The <C>NC</C> version does not check whether <A>H</A> and <A>K</A> are subgroups of <A>G</A>.
#! @Arguments G, H, K
DeclareGlobalFunction( "DoubleCosetIndex" );
#! @Arguments G, H, K
DeclareOperation( "DoubleCosetIndexNC", [ IsGroup, IsGroup, IsGroup ] );
#! @EndGroup

#! @BeginExample
HxK := DoubleCoset( H, x, K );;
HyK := DoubleCoset( H, y, K );;
HzK := DoubleCoset( H, z, K );;
y in HxK;
#! true
z in HxK;
#! false
HxK = HyK;
#! true
HxK = HzK;
#! false
DCS := DoubleCosets( G, H, K );
#! [ DoubleCoset(<group with 2 generators>,<object>,<group with 2 generators>),
#!   DoubleCoset(<group with 2 generators>,<object>,<group with 2 generators>) ]
#! @EndExample



#####
#
# CHAPTER 5
#
#####

#! @Chapter Homomorphisms
#! @ChapterLabel homs
#! @ChapterTitle Group Homomorphisms


###
# SECTION 1
###

#! @Section Representatives of homomorphisms between groups

#! Please note that the functions below are only implemented for finite groups.

#! @Description
#! Let <A>G</A> be a group. This command returns a list of the automorphisms of <A>G</A> up to composition with inner automorphisms.
#! @Arguments G
DeclareGlobalFunction( "RepresentativesAutomorphismClasses" );

#! @Description
#! Let <A>G</A> be a group. This command returns a list of the endomorphisms of <A>G</A> up to composition with inner automorphisms.
#! This does the same as calling <C>AllHomomorphismClasses(<A>G</A>,<A>G</A>)</C>, but should be faster for abelian and non-2-generated groups.
#! For 2-generated groups, this function takes its source code from <C>AllHomomorphismClasses</C>.
#! @Arguments G
DeclareGlobalFunction( "RepresentativesEndomorphismClasses" );

#! @Description
#! Let <A>G</A> and <A>H</A> be groups. This command returns a list of the homomorphisms from <A>H</A> to <A>G</A>, up to composition with inner automorphisms of <A>G</A>.
#! This does the same as calling <C>AllHomomorphismClasses(<A>H</A>,<A>G</A>)</C>, but should be faster for abelian and non-2-generated groups.
#! For 2-generated groups, this function takes its source code from <C>AllHomomorphismClasses</C>.
#! @Arguments H, G
DeclareGlobalFunction( "RepresentativesHomomorphismClasses" );

#! @BeginExample
G := SymmetricGroup( 6 );;
Auts := RepresentativesAutomorphismClasses( G );;
Size( Auts );
#! 2
ForAll( Auts, IsGroupHomomorphism and IsEndoMapping and IsBijective );
#! true
Ends := RepresentativesEndomorphismClasses( G );;
Size( Ends );
#! 6
ForAll( Ends, IsGroupHomomorphism and IsEndoMapping );
#! true
H := SymmetricGroup( 5 );;
Homs := RepresentativesHomomorphismClasses( H, G );;
Size( Homs );
#! 6
ForAll( Homs, IsGroupHomomorphism );
#! true
#! @EndExample


###
# SECTION 2
###

#! @Section Coincidence and Fixed Point Groups

#! @Description
#! Let <A>endo</A> be an endomorphism of a group G. This command returns the subgroup of G consisting of the elements fixed under the endomorphism <A>endo</A>.
#! <P />
#! This function does the same as <C>CoincidenceGroup</C>(<A>endo</A>,$\operatorname{id}_G$).
#! @Arguments endo
DeclareGlobalFunction( "FixedPointGroup" );

#! @Description
#! Let <A>hom1</A>, <A>hom2</A>, ... be group homomorphisms from a group H to a group G. This command returns the subgroup of H consisting of the elements h for which h^<A>hom1</A> = h^<A>hom2</A> = ...
#! <P />
#! For infinite non-abelian groups, this function relies on a mixture of the algorithms described in <Cite Key='roma16-a' Where='Thm. 2'/>, <Cite Key='bkl20-a' Where='Sec. 5.4'/> and <Cite Key='roma21-a' Where='Sec. 7'/>.
#! @Arguments hom1, hom2[, ...]
DeclareGlobalFunction( "CoincidenceGroup" );

#! @BeginExample
phi := GroupHomomorphismByImages( G, G, [ (1,2,5,6,4), (1,2)(3,6)(4,5) ],
 [ (2,3,4,5,6), (1,2) ] );;
Set( FixedPointGroup( phi ) );
#! [ (), (1,2,3,6,5), (1,3,5,2,6), (1,5,6,3,2), (1,6,2,5,3) ]
psi := GroupHomomorphismByImages( H, G, [ (1,2,3,4,5), (1,2) ],
 [ (), (1,2) ] );;
khi := GroupHomomorphismByImages( H, G, [ (1,2,3,4,5), (1,2) ],
 [ (), (1,2)(3,4) ] );;
CoincidenceGroup( psi, khi ) = AlternatingGroup( 5 );
#! true
#! @EndExample


###
# SECTION 3
###

#! @Section Induced and restricted group homomorphisms

#! @Description
#! Let <A>hom</A> be a group homomorphism from a group H to a group G, let <A>epi1</A> be an epimorphism from H to a group Q and let <A>epi2</A> be an epimorphism from G to a group P such that the kernel of <A>epi1</A> is mapped into the kernel of <A>epi2</A> by <A>hom</A>. This command returns the homomorphism from Q to P induced by <A>hom</A> via <A>epi1</A> and <A>epi2</A>, that is, the homomorphism from Q to P which maps h<C>^<A>epi1</A></C> to <C>(</C>h<C>^<A>hom</A>)^<A>epi2</A></C>, for any element h of H. This generalises <C>InducedAutomorphism</C> to homomorphisms.
#! @Arguments epi1, epi2, hom
DeclareGlobalFunction( "InducedHomomorphism" );

#! @Description
#! Let <A>hom</A> be a group homomorphism from a group H to a group G, and let <A>N</A> be subgroup of H such that its image under <A>hom</A> is a subgroup of <A>M</A>. This command returns the homomorphism from N to M induced by <A>hom</A>. This is similar to <C>RestrictedMapping</C>, but the range is explicitly set to <A>M</A>.
#! @Arguments hom, N, M
DeclareGlobalFunction( "RestrictedHomomorphism" );

#! @BeginExample
G := PcGroupCode( 1018013, 28 );;
phi := GroupHomomorphismByImages( G, G, [ G.1, G.3 ],
 [ G.1*G.2*G.3^2, G.3^4 ] );;
N := DerivedSubgroup( G );;
p := NaturalHomomorphismByNormalSubgroup( G, N );
#! [ f1, f2, f3 ] -> [ f1, f2, <identity> of ... ]
ind := InducedHomomorphism( p, p, phi );
#! [ f1 ] -> [ f1*f2 ]
Source( ind ) = Range( p ) and Range( ind ) = Range( p );
#! true
res := RestrictedHomomorphism( phi, N, N );
#! [ f3 ] -> [ f3^4 ]
Source( res ) = N and Range( res ) = N;
#! true
#! @EndExample



#####
#
# CHAPTER 6
#
#####

#! @Chapter Derivations
#! @ChapterLabel ders
#! @ChapterTitle Group Derivations


###
# SECTION 1
###

#! @Section Creating group derivations

#! The functions below only work for derivations between finite groups or between PcpGroups. 

#! @Description
#! <C>GroupDerivationByImages</C> works in the same vein as <C>GroupHomomorphismByImages</C>. The group <A>H</A> acts on the group <A>G</A> via <A>act</A>,
#! which must be a homomorphism from <A>H</A> into a group of automorphisms of <A>G</A>. This command then returns the group derivation defined by mapping the list
#! <A>gens</A> of generators of <A>H</A> to the list <A>imgs</A> of images in <A>G</A>.
#!
#! If omitted, the arguments <A>gens</A> and <A>imgs</A> default to the <C>GeneratorsOfGroup</C> value of <A>H</A> and <A>G</A> respectively.
#!
#! If <A>gens</A> does not generate <A>H</A> or the mapping of the generators does not extend to a group derivation then <K>fail</K> is returned.
#! This test can be expensive, so if one is certain that the given arguments produce a group derivation, the checks can be avoided by calling
#! <C>GroupDerivationByImagesNC</C> instead.
#! @Arguments H, G[[, gens], imgs], act
DeclareGlobalFunction( "GroupDerivationByImages" );

#! @Description
#! <C>GroupDerivationByImagesNC</C> does the same as <C>GroupDerivationByImages</C>, but does not check if the given map is indeed a group derivation.
#! @Arguments H, G[[, gens], imgs], act
DeclareGlobalFunction( "GroupDerivationByImagesNC" );

#! @Description
#! <C>GroupDerivationByFunction</C> works in the same vein as <C>GroupHomomorphismByFunction</C>. The group <A>H</A> acts on the group <A>G</A> via <A>act</A>,
#! which must be a homomorphism from <A>H</A> into a group of automorphisms of <A>G</A>. This command then returns the group derivation defined by mapping the
#! element <C>h</C> of <A>H</A> to the element <A>fun</A>( <C>h</C> ) of <A>G</A>, where <A>fun</A> is a <B>GAP</B> function.
#!
#! No test are performed to check whether the arguments really produce a group derivation.
#! @Arguments H, G, fun, act
DeclareGlobalFunction( "GroupDerivationByFunction" );

#! @BeginExample
H := PcGroupCode( 149167619499417164, 72 );;
G := PcGroupCode( 5551210572, 72 );;
inn := InnerAutomorphism( G, G.2 );;
hom := GroupHomomorphismByImages(
     G, G,
     [ G.1*G.2, G.5 ], [ G.1*G.2^2*G.3^2*G.4, G.5 ]
   );;
act := GroupHomomorphismByImages(
     H, AutomorphismGroup( G ),
     [ H.2, H.1*H.4 ], [ inn, hom ]
   );;
gens := [ H.2, H.1*H.4 ];;
imgs := [ G.5, G.2 ];;
der := GroupDerivationByImages( H, G, gens, imgs, act );
#! Group derivation [ f2, f1*f4 ] -> [ f5, f2 ]
#! @EndExample


###
# SECTION 2
###

#! @Section Operations for Group Derivations

#! @Description
#! Returns <K>true</K> if the group derivation <A>der</A> is injective, and <K>false</K> otherwise.
#! @Arguments der
#! @Label for group derivations
DeclareProperty( "IsInjective", IsGroupDerivation );

#! @Description
#! Returns <K>true</K> if the group derivation <A>der</A> is surjective, and <K>false</K> otherwise.
#! @Arguments der
#! @Label for group derivations
DeclareProperty( "IsSurjective", IsGroupDerivation );

#! @Description
#! Calculates the set of elements that are mapped to the identity by <A>der</A>.
#! This will always be a subgroup of <C>Source</C>( <A>der</A> ).
#! @Arguments der
#! @Label of a group derivation
DeclareOperation( "Kernel", [ IsGroupDerivation ] );

#! @BeginGroup ImageGroup
#! @Description
#! Calculates the image of the group derivation <A>der</A>.
#! One can optionally give an element <A>elm</A> or a subgroup <A>sub</A> as a second argument,
#! in which case <C>Image</C> will calculate the image of this argument under <A>der</A>.
#! @Arguments der
DeclareGlobalFunction( "Image" );
#! @Arguments der, elm
#! @Label of an element under a group derivation
DeclareGlobalFunction( "Image" );
#! @Arguments der, coll
#! @Label of a subgroup under a group derivation
DeclareGlobalFunction( "Image" );
#! @EndGroup

#! @Description
#! Calculates a preimage of the element <A>elm</A> under the group derivation <A>der</A>.
#! @Arguments der, elm
#! @Label of an element under a group derivation
DeclareOperation( "PreImagesRepresentative", [ IsGeneralMapping, IsObject ] );

#! @Description
#! Calculates the preimages of the element <A>elm</A> under the group derivation <A>der</A>.
#! This will always be a (right) coset of <C>Kernel</C>( <A>der</A> ).
#! @Arguments der, elm
#! @Label of an element under a group derivation
DeclareGlobalFunction( "PreImages" );

#! @BeginExample
IsInjective( der ) or IsSurjective( der );
#! false
K := Kernel( der );;
Size( K );
#! 9
ImH := Image( der );
#! Group derivation image in Group( [ f1, f2, f3, f4, f5 ] )
h1 := H.1*H.3;;
g := Image( der, h1 );
#! f2*f4
ImK := Image( der, K );
#! Group derivation image in Group( [ f1, f2, f3, f4, f5 ] )
h2 := PreImagesRepresentative( der, g );;
Image( der, h2 ) = g;
#! true
PreIm := PreImages( der, g );
#! RightCoset(<group of size 9 with 2 generators>,<object>)
PreIm = RightCoset( K, h2 );
#! true
#! @EndExample

###
# SECTION 3
###

#! @Section Images of Group Derivations

#! @Description
#! Given an element <A>g</A> of a PcpGroup and a double coset <A>D</A> of that same group, this function tests whether <A>g</A> is an element of <A>D</A>.
#! @Arguments img
#! @Label for a group derivation image
DeclareAttribute( "Size", IsGroupDerivationImageRep );

#! @Description
#! Given double cosets <A>C</A> and <A>D</A> of a PcpGroup, this function tests whether <A>C</A> and <A>D</A> are equal.
#! @Arguments g, img
#! @Label for an element and a group derivation
DeclareOperation( "\in", [ IsObject, IsGroupDerivationImageRep ] );

#! @BeginExample
Size( ImH );
#! 8
Size( ImK );
#! 1
g in ImH;
#! true
g in ImK;
#! false
List( ImK );
#! [ <identity> of ... ]
#! @EndExample
