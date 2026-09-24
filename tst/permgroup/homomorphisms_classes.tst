gap> START_TEST( "Testing TwistedConjugacy: complete homomorphism class sets" );

# Canonical image tuples compare actual target-conjugacy classes, independently
# of the representatives or generating sets selected by either implementation.
# All groups here are small enough to enumerate the target for this test only.
gap> TWCtestClassKeys := function( H, G, maps )
>     local gens, elts, tuples;
>     gens := GeneratorsOfGroup( H );
>     tuples := List( maps, hom -> List( gens, x -> Image( hom, x ) ) );
>     if IsAbelian( G ) then return tuples; fi;
>     elts := Elements( G );
>     return List( tuples, tuple -> Minimum(
>         List( elts, g -> OnTuples( tuple, g ) ) ) );
> end;;

# Recheck the defining images with the checked constructor: a mapping created
# by GroupHomomorphismByImagesNC can already claim to be a homomorphism.
gap> TWCtestValidMaps := function( H, G, maps )
>     local gens;
>     gens := GeneratorsOfGroup( H );
>     return ForAll( maps, hom ->
>         IsIdenticalObj( Source( hom ), H ) and
>         IsIdenticalObj( Range( hom ), G ) and
>         IsGroupHomomorphism( hom ) and
>         GroupHomomorphismByImages( H, G, gens,
>             List( gens, x -> Image( hom, x ) ) ) <> fail );
> end;;

gap> TWCtestHomClasses := function( H, G )
>     local maps, keys, expected;
>     maps := RepresentativesHomomorphismClasses( H, G );
>     if not TWCtestValidMaps( H, G, maps ) then return false; fi;
>     keys := TWCtestClassKeys( H, G, maps );
>     expected := TWCtestClassKeys( H, G, AllHomomorphismClasses( H, G ) );
>     return Length( keys ) = Length( Set( keys ) ) and
>         Set( keys ) = Set( expected );
> end;;

gap> TWCtestEndClasses := function( G )
>     local maps, keys, expected, nonbijective, nonbijectiveKeys, explicit;
>     nonbijective := RepresentativesEndomorphismClasses( G, false );
>     maps := RepresentativesEndomorphismClasses( G );
>     if not TWCtestValidMaps( G, G, maps ) then return false; fi;
>     keys := TWCtestClassKeys( G, G, maps );
>     expected := TWCtestClassKeys( G, G, AllHomomorphismClasses( G, G ) );
>     if not TWCtestValidMaps( G, G, nonbijective ) then return false; fi;
>     nonbijectiveKeys := TWCtestClassKeys( G, G, nonbijective );
>     explicit := RepresentativesEndomorphismClasses( G, true );
>     return Length( keys ) = Length( Set( keys ) ) and
>         Set( keys ) = Set( expected ) and
>         ForAll( nonbijective, hom -> not IsBijective( hom ) ) and
>         Length( nonbijectiveKeys ) = Length( Set( nonbijectiveKeys ) ) and
>         Set( nonbijectiveKeys ) = Set( TWCtestClassKeys( G, G,
>             Filtered( maps, hom -> not IsBijective( hom ) ) ) ) and
>         TWCtestValidMaps( G, G, explicit ) and
>         Length( explicit ) = Length( maps ) and
>         Set( TWCtestClassKeys( G, G, explicit ) ) = Set( keys );
> end;;

# Primary and mixed-prime abelian groups, including three necessary generators.
gap> ForAll( [ IsPcGroup, IsPermGroup ], filt -> ForAll(
>     [ [ 4, 2 ], [ 6, 2 ], [ 9, 3 ], [ 2, 2, 2 ] ],
>     orders -> TWCtestEndClasses( AbelianGroup( filt, orders ) ) ) );
true
gap> ForAll( [ IsPcGroup, IsPermGroup ], filt -> ForAll(
>     [ [ [ 4, 2 ], [ 8, 2 ] ], [ [ 6, 2 ], [ 9, 3 ] ],
>       [ [ 9, 3 ], [ 6, 2 ] ] ],
>     orders -> TWCtestHomClasses( AbelianGroup( filt, orders[ 1 ] ),
>                                 AbelianGroup( filt, orders[ 2 ] ) ) ) );
true

# Two-generator nilpotent and non-nilpotent solvable groups, then examples
# requiring three generators. Exercise both pc and permutation representations.
gap> ForAll( [ IsPcGroup, IsPermGroup ], filt -> ForAll(
>     [ DihedralGroup( filt, 8 ), DihedralGroup( filt, 6 ),
>       DirectProduct( DihedralGroup( filt, 8 ), CyclicGroup( filt, 2 ) ),
>       DirectProduct( DihedralGroup( filt, 6 ),
>                      ElementaryAbelianGroup( filt, 4 ) ) ],
>     TWCtestEndClasses ) );
true

# Asymmetric pairs exercise cyclic, abelianization and general source methods.
gap> TWCtestPairs := [
>     [ CyclicGroup( IsPcGroup, 6 ), SymmetricGroup( 4 ) ],
>     [ DihedralGroup( IsPcGroup, 8 ), QuaternionGroup( IsPermGroup, 8 ) ],
>     [ DihedralGroup( IsPermGroup, 6 ), DihedralGroup( IsPcGroup, 12 ) ],
>     [ AlternatingGroup( 4 ), AbelianGroup( IsPcGroup, [ 6, 2 ] ) ],
>     [ ElementaryAbelianGroup( IsPcGroup, 8 ), DihedralGroup( IsPermGroup, 8 ) ],
>     [ DirectProduct( DihedralGroup( IsPermGroup, 8 ),
>                      CyclicGroup( IsPermGroup, 2 ) ), SymmetricGroup( 4 ) ],
>     [ DirectProduct( SymmetricGroup( 3 ), CyclicGroup( IsPermGroup, 2 ),
>                      CyclicGroup( IsPermGroup, 2 ) ), SymmetricGroup( 4 ) ]
> ];;
gap> ForAll( TWCtestPairs, pair -> TWCtestHomClasses( pair[ 1 ], pair[ 2 ] ) );
true

# Equality of groups must not replace the caller's distinct source object.
# A redundant supplied generating list must not affect completeness either.
gap> TWCtestG := DihedralGroup( IsPermGroup, 8 );;
gap> TWCtestH := Group( Concatenation( GeneratorsOfGroup( TWCtestG ),
>     [ One( TWCtestG ), Product( GeneratorsOfGroup( TWCtestG ) ) ] ) );;
gap> TWCtestG = TWCtestH and not IsIdenticalObj( TWCtestG, TWCtestH );
true
gap> TWCtestHomClasses( TWCtestG, TWCtestG ) and
>     TWCtestHomClasses( TWCtestH, TWCtestG ) and
>     TWCtestHomClasses( TWCtestG, TWCtestH ) and TWCtestEndClasses( TWCtestH );
true

# Small non-abelian simple and quasisimple groups, including a nontrivial
# central quotient as a source/target pair.
gap> TWCtestA5 := AlternatingGroup( 5 );;
gap> TWCtestSL25 := ImagesSource( IsomorphismPermGroup( SL( 2, 5 ) ) );;
gap> TWCtestEndClasses( TWCtestA5 ) and TWCtestEndClasses( TWCtestSL25 );
true
gap> TWCtestHomClasses( TWCtestA5, SymmetricGroup( 5 ) ) and
>     TWCtestHomClasses( TWCtestSL25, TWCtestA5 ) and
>     TWCtestHomClasses( TWCtestA5, TWCtestSL25 );
true

# Direct factors must have commuting images, and simultaneous conjugacy must
# still be taken in the whole target. Include the full/non-bijective comparison
# for a solvable product and a non-solvable, non-perfect product.
gap> TWCtestS3S3 := DirectProduct( SymmetricGroup( 3 ), SymmetricGroup( 3 ) );;
gap> TWCtestA5C2 := DirectProduct( TWCtestA5, CyclicGroup( IsPermGroup, 2 ) );;
gap> TWCtestA5A5 := DirectProduct( TWCtestA5, TWCtestA5 );;
gap> TWCtestEndClasses( TWCtestS3S3 ) and TWCtestEndClasses( TWCtestA5C2 );
true
gap> TWCtestEndClasses( TWCtestA5A5 );
true
gap> TWCtestHomClasses( TWCtestS3S3, SymmetricGroup( 3 ) ) and
>     TWCtestHomClasses( TWCtestA5A5, TWCtestA5 ) and
>     TWCtestHomClasses( DirectProduct( TWCtestSL25,
>         CyclicGroup( IsPermGroup, 2 ) ), SymmetricGroup( 3 ) );
true

# Reconstruct small solvable products as pc groups, independently of the
# DirectProduct objects and their stored factor embeddings.
gap> TWCtestPcProducts := List( [ TWCtestS3S3,
>     DirectProduct( DihedralGroup( IsPermGroup, 8 ),
>                    CyclicGroup( IsPermGroup, 2 ) ) ],
>     G -> ImagesSource( IsomorphismPcGroup( G ) ) );;
gap> ForAll( TWCtestPcProducts, TWCtestEndClasses );
true

# Codomain factors must also combine correctly in a pc group, including when
# the caller's source is an equal group with a different object identity.
gap> TWCtestPcTarget := DirectProduct( DihedralGroup( IsPcGroup, 6 ),
>     CyclicGroup( IsPcGroup, 2 ) );;
gap> TWCtestEndClasses( TWCtestPcTarget ) and
>     TWCtestHomClasses( DihedralGroup( IsPermGroup, 8 ), TWCtestPcTarget ) and
>     TWCtestHomClasses( DihedralGroup( IsPcGroup, 6 ), TWCtestPcTarget );
true
gap> TWCtestPcEqualSource := Group( Concatenation(
>     GeneratorsOfGroup( TWCtestPcTarget ), [ One( TWCtestPcTarget ) ] ) );;
gap> TWCtestPcEqualSource = TWCtestPcTarget and
>     not IsIdenticalObj( TWCtestPcEqualSource, TWCtestPcTarget );
true
gap> TWCtestHomClasses( TWCtestPcEqualSource, TWCtestPcTarget ) and
>     TWCtestHomClasses( TWCtestPcTarget, TWCtestPcEqualSource );
true

# Regular actions are transitive, so their point orbits cannot reveal the
# direct factors. Rebuilding the group also removes the stored decomposition.
# Keep the supplied generators to exercise the bounded two-generator search.
gap> TWCtestRegularSource := DirectProduct(
>     TWCtestSL25, CyclicGroup( IsPermGroup, 2 ) );;
gap> TWCtestUnmarkedSL25C2 := Group( GeneratorsOfGroup( Action(
>     TWCtestRegularSource, Elements( TWCtestRegularSource ), OnRight ) ) );;
gap> SetSmallGeneratingSet( TWCtestUnmarkedSL25C2,
>     GeneratorsOfGroup( TWCtestUnmarkedSL25C2 ) );;
gap> IsTransitive( TWCtestUnmarkedSL25C2 ) and
>     not HasDirectProductInfo( TWCtestUnmarkedSL25C2 ) and
>     Length( SmallGeneratingSet( TWCtestUnmarkedSL25C2 ) ) > 2;
true
gap> TWCtestEndClasses( TWCtestUnmarkedSL25C2 );
true

# The search cannot find a pair when the abelianization needs three generators.
gap> TWCtestRegularSource := DirectProduct(
>     TWCtestA5, ElementaryAbelianGroup( IsPermGroup, 8 ) );;
gap> TWCtestUnmarkedRank3 := Group( GeneratorsOfGroup( Action(
>     TWCtestRegularSource, Elements( TWCtestRegularSource ), OnRight ) ) );;
gap> IsTransitive( TWCtestUnmarkedRank3 ) and
>     not HasDirectProductInfo( TWCtestUnmarkedRank3 );
true
gap> TWCtestHomClasses( TWCtestUnmarkedRank3, SymmetricGroup( 3 ) );
true

# Orbit projections need not be independent: this diagonal S3 has two orbits,
# each with image S3, but it is not the full product of those images.
gap> TWCtestDiagonal := Group( (1,2)(4,5), (1,2,3)(4,5,6) );;
gap> TWCtestEndClasses( TWCtestDiagonal );
true

# A decomposition cached separately from DirectProductInfo is equally valid.
gap> TWCtestCachedFactors := Group( GeneratorsOfGroup( TWCtestS3S3 ) );;
gap> DirectFactorsOfGroup( TWCtestCachedFactors );;
gap> TWCtestEndClasses( TWCtestCachedFactors );
true

# Trivial groups, including the empty non-bijective endomorphism list.
gap> ForAll( [ IsPcGroup, IsPermGroup ], filt ->
>     TWCtestEndClasses( TrivialGroup( filt ) ) and
>     TWCtestHomClasses( TrivialGroup( filt ), TWCtestG ) and
>     TWCtestHomClasses( TWCtestG, TrivialGroup( filt ) ) );
true

gap> Unbind( TWCtestClassKeys );; Unbind( TWCtestValidMaps );;
gap> Unbind( TWCtestHomClasses );; Unbind( TWCtestEndClasses );;
gap> Unbind( TWCtestPairs );; Unbind( TWCtestG );; Unbind( TWCtestH );;
gap> Unbind( TWCtestA5 );; Unbind( TWCtestSL25 );;
gap> Unbind( TWCtestS3S3 );; Unbind( TWCtestA5C2 );; Unbind( TWCtestA5A5 );;
gap> Unbind( TWCtestPcProducts );;
gap> Unbind( TWCtestPcTarget );; Unbind( TWCtestPcEqualSource );;
gap> Unbind( TWCtestUnmarkedSL25C2 );; Unbind( TWCtestUnmarkedRank3 );;
gap> Unbind( TWCtestRegularSource );; Unbind( TWCtestDiagonal );;
gap> Unbind( TWCtestCachedFactors );;
gap> STOP_TEST( "homomorphisms_classes.tst" );
