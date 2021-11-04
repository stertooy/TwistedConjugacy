###############################################################################
##
## CoincidenceGroupByTrivialSubgroup@( hom1, hom2 )
##
CoincidenceGroupByTrivialSubgroup@ := function ( hom1, hom2 )
	local G, H, N, id, q, CoinHN;
	G := Range( hom1 );
	H := Source( hom1 );
	N := IntersectionKernels@( hom1, hom2 );
	id := IdentityMapping( G );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	CoinHN := CoincidenceGroup2(
		InducedHomomorphism( q, id, hom1 ),
		InducedHomomorphism( q, id, hom2 )
	);
	return PreImagesSet( q, CoinHN );
end;


###############################################################################
##
## CoincidenceGroupByFiniteQuotient@( hom1, hom2, N, M )
##
CoincidenceGroupByFiniteQuotient@ := function ( hom1, hom2, N, M )
	local G, H, p, q, CoinHN, hom1N, hom2N, tc, igs, pcgs, orbit, l, i, qh,
		pos, j, h, stab, n;
	G := Range( hom1 );
	H := Source( hom1 );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	CoinHN := CoincidenceGroup2(
		InducedHomomorphism( q, p, hom1 ),
		InducedHomomorphism( q, p, hom2 )
	);
	if not IsFinite( CoinHN ) then
		TryNextMethod();
	fi;
	hom1N := RestrictedHomomorphism( hom1, N, M );
	hom2N := RestrictedHomomorphism( hom2, N, M );
	tc := TwistedConjugation( hom1, hom2 );
	igs := Igs( CoincidenceGroup2( hom1N, hom2N ) );
	q := RestrictedHomomorphism( q, Source( q ), ImagesSource( q ) );
	q := q * IsomorphismPcGroup( CoinHN );
	CoinHN := Range( q );
	pcgs := Pcgs( CoinHN );
	orbit := [ One( CoinHN ) ];
	l := ListWithIdenticalEntries( Length( pcgs ), 0 );
	Add( l, 1 );
	for i in Reversed( [1..Length( pcgs )] ) do
		qh := pcgs[i];
		pos := fail;
		for j in [1..Length( orbit )] do
			h := PreImagesRepresentative( q, orbit[j] / qh );
			if RepTwistConjToId( hom1N, hom2N, tc( One( G ), h ) ) <> fail then
				pos := j-1;
				break;
			fi;
		od;
		if IsInt( pos ) then
			stab := ListWithIdenticalEntries( Length( pcgs ), 0 );
			stab[i] := 1;
			while pos > 0 do
				j := First( [i..Length( pcgs )] + 2, j -> l[j] <= pos );
				stab[j-1] := - QuoInt( pos, l[j] );
				pos := RemInt( pos, l[j] );
			od;
			qh := LinearCombinationPcgs( pcgs, stab );
			h := PreImagesRepresentative( q, qh );
			n := RepTwistConjToId( hom1N, hom2N, tc( One( G ), h ) );
			igs := AddToIgs( igs, [ h*n ] );
		else
			for j in [2..RelativeOrders( pcgs )[i]] do
				Append( orbit, orbit{ [1-l[i+1]..0] + Length( orbit ) } * qh );
			od;
		fi;
		l[i] := Length( orbit );
	od;
	return SubgroupByIgs( H, igs );
end;


###############################################################################
##
## CoincidenceGroupByCentralSubgroup@( hom1, hom2, N, M )
##
CoincidenceGroupByCentralSubgroup@ := function ( hom1, hom2, N, M )
	local G, H, p, q, CoinHN, Coin, diff;
	G := Range( hom1 );
	H := Source( hom1 );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	CoinHN := CoincidenceGroup2(
		InducedHomomorphism( q, p, hom1 ),
		InducedHomomorphism( q, p, hom2 )
	);
	Coin := PreImagesSet( q, CoinHN );
	diff := DifferenceGroupHomomorphisms@( hom1, hom2, Coin, G );
	return Kernel( diff );
end;


###############################################################################
##
## FixedPointGroupBySemidirectProduct@( aut )
##
FixedPointGroupBySemidirectProduct@ := function( aut )
	local G, S, emb, inc, pcp, C, fix;
	G := Source( aut );
	S := SemidirectProductWithAutomorphism@( G, aut );
	emb := Embedding( S, 2 );
	inc := RestrictedHomomorphism( emb, G, ImagesSource( emb ) );
	pcp := PcpsOfEfaSeries( S );
	C := CentralizerBySeries( S, [ S.1 ], pcp );
	fix := NormalIntersection( Range( inc ), C );
	return PreImagesSet( inc, fix );
end;


###############################################################################
##
## CoincidenceGroup2( hom1, hom2 )
##
InstallMethod(
	CoincidenceGroup2,
	"for infinite polycyclic source and finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	5,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( G ) or
			IsTrivial( G )
		) then
			TryNextMethod();
		fi;
		return CoincidenceGroupByTrivialSubgroup@( hom1, hom2 );
	end
);

InstallMethod(
	CoincidenceGroup2,
	"for infinite polycyclic source and infinite abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	4,
	function ( hom1, hom2 )
		local G, H, diff;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G ) or
			not IsAbelian( G )
		) then
			TryNextMethod();
		fi;
		diff := DifferenceGroupHomomorphisms@ ( hom1, hom2, H, G );
		return Kernel( diff );
	end
);

InstallMethod(
	CoincidenceGroup2,
	"for infinite polycyclic source and infinite nilpotent range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		local G, H, M, N;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G ) or
			not IsNilpotentGroup( G ) or
			IsAbelian( G )
		) then
			TryNextMethod();
		fi;
		M := Centre( G );
		N := IntersectionPreImage@( hom1, hom2, M );
		return CoincidenceGroupByCentralSubgroup@( hom1, hom2, N, M );
	end
);

InstallMethod(
	CoincidenceGroup2,
	"for infinite polycyclic source and infinite nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	2,
	function ( hom1, hom2 )
		local G, H, M, N;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G ) or
			not IsNilpotentByFinite( G ) or
			IsNilpotentGroup( G )
		) then
			TryNextMethod();
		fi;
		M := FittingSubgroup( G );
		N := IntersectionPreImage@( hom1, hom2, M );
		return CoincidenceGroupByFiniteQuotient@( hom1, hom2, N, M );
	end
);

InstallMethod(
	CoincidenceGroup2,
	"for infinite polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( hom1, hom2 )
		local G, H, M, N;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G )
		) then
			TryNextMethod();
		fi;
		M := DerivedSubgroup( G );
		N := IntersectionPreImage@( hom1, hom2, M );
		return CoincidenceGroupByFiniteQuotient@( hom1, hom2, N, M );
	end
);

InstallMethod(
	CoincidenceGroup2,
	"for isomorphisms with infinite polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	0,
	function ( aut1, aut2 )
		local G, H, aut;
		G := Range( aut1 );
		H := Source( aut1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G ) or
			not IsBijective( aut1 ) or
			not IsBijective( aut2 )
		) then
			TryNextMethod();
		fi;
		aut := aut1 * Inverse( aut2 );
		return FixedPointGroupBySemidirectProduct@( aut );
	end
);
