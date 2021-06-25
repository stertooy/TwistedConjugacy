###############################################################################
##
## DifferenceGroupHomomorphisms@( hom1, hom2 )
##
##	Returns the homomorphism that maps h to h^hom2*( h^hom1 )^-1
##  No verification is done to make sure this is actually a homomorphism
##
DifferenceGroupHomomorphisms@ := function ( hom1, hom2, N, M )
  	local gens, diff, imgs;
	gens := GeneratorsOfGroup( N );
	diff := function( n )
		return ImagesRepresentative( hom2, n ) /
			ImagesRepresentative( hom1, n );
	end;
	imgs := List( gens, diff );
	return GroupHomomorphismByImagesNC( N, M, gens, imgs );
end;


###############################################################################
##
## IntersectionPreImage@( hom1, hom2, N )
##
##  Returns hom1^-1(N) cap hom2^-1(N)
##  Note that N must be a normal subgroup
##
IntersectionPreImage@ := function ( hom1, hom2, N )
	return NormalIntersection(
		PreImagesSet( hom1, NormalIntersection( N, ImagesSource( hom1 ) ) ),
		PreImagesSet( hom2, NormalIntersection( N, ImagesSource( hom2 ) ) )
	);
end;


###############################################################################
##
## SemidirectProductWithAutomorphism@( G, aut )
##
##  Returns the semidirect product of G with Z, where Z acts on G by aut
##
SemidirectProductWithAutomorphism@ := function ( G, aut )
	local g, r, n, coll, i, j, e, elm, exp, S, s, H, info, embH, embG;
	g := Igs( G );
	n := Length( g );
	r := List( g, RelativeOrderPcp );
	coll := FromTheLeftCollector( n + 1 );
	SetRelativeOrderNC( coll, 1, 0 );
	for i in [1..n] do
		SetRelativeOrderNC( coll, i+1, r[i] );
		if r[i] > 0 then
			exp := Concatenation( [0], ExponentsByIgs( g, g[i]^r[i] ) );
			e := ObjByExponents( coll, exp );
			SetPowerNC( coll, i+1, e );
		fi;
		for j in [0..i-1] do
			if j = 0 then
				elm := ImagesRepresentative( aut, g[i] );
			else
				elm := g[i]^g[j];
			fi;
			exp := Concatenation( [0], ExponentsByIgs( g, elm ) );
			e := ObjByExponents( coll, exp );
			SetConjugateNC( coll, i+1, j+1, e );
		od;
	od;
	S := PcpGroupByCollector( coll );
	s := GeneratorsOfPcp( Pcp( S ) );
	H := SubgroupNC( S, [ s[1] ] );
	embG := GroupHomomorphismByImagesNC( G, S, g, s{[2..n+1]} );;
	embH := GroupHomomorphismByImagesNC( H, S, [ s[1] ], [ s[1] ] );;
	info := rec(
		groups := [ H, G ],
		lenlist := [ 0, 1, Length( s ) ],
		embeddings := [ embH, embG ],
		projections := true
	);
	SetSemidirectProductInfo( S, info );
	return S;
end;
