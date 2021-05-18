###############################################################################
##
## CoincidenceGroupByFiniteCoin@( hom1, hom2, M )
##
CoincidenceGroupByFiniteCoin@ := function ( hom1, hom2, M )
	local G, H, N, p, q, CoinHN, hom1N, hom2N, tc, igs, pcgs, orbit, l, i, qh,
		pos, j, h, m, stab, n;
	G := Range( hom1 );
	H := Source( hom1 );
	N := IntersectionPreImage@( hom1, hom2, M );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	CoinHN := CoincidenceGroup(
		InducedHomomorphism( q, p, hom1 ),
		InducedHomomorphism( q, p, hom2 )
	);
	if not IsFinite( CoinHN ) then
		TryNextMethod();
	fi;
	hom1N := RestrictedHomomorphism( hom1, N, M );
	hom2N := RestrictedHomomorphism( hom2, N, M );
	tc := TwistedConjugation( hom1, hom2 );
	igs := Igs( CoincidenceGroup( hom1N, hom2N ) );
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
				pos := j;
				break;
			fi;
		od;
		if IsInt( pos ) then
			stab := ListWithIdenticalEntries( Length( pcgs ), 0 );
			stab[i] := 1;
			j := i + 2;
			while pos <> 1 do
				while l[j] >= pos do
					j := j + 1;
				od;
				stab[j-1] := - QuoInt( pos-1, l[j] );
				pos := ( pos-1 ) mod l[j] + 1;
			od;
			qh := LinearCombinationPcgs( pcgs, stab );
			h := PreImagesRepresentative( q, qh );
			n := RepTwistConjToId( hom1N, hom2N, tc( One( G ), h ) );
			igs := AddToIgs( igs, [ h*n ] );
		else
			m := l[i+1];
			Append( orbit, orbit{[1..m]} * qh );
			for j in [ 3..RelativeOrders( pcgs )[i] ] do
				Append( orbit, orbit{[1-m..0] + Length( orbit )} * qh );
			od;
		fi;
		l[i] := Length( orbit );
	od;
	return SubgroupByIgs( H, igs );
	
end;


###############################################################################
##
## CoincidenceGroupByCentre@( hom1, hom2 )
##
CoincidenceGroupByCentre@ := function ( hom1, hom2 )
	local G, H, M, N, p, q, CoinHN, Coin, diff;
	G := Range( hom1 );
	H := Source( hom1 );
	M := Centre( G );
	N := IntersectionPreImage@( hom1, hom2, M );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	CoinHN := CoincidenceGroup(
		InducedHomomorphism( q, p, hom1 ),
		InducedHomomorphism( q, p, hom2 )
	);
	Coin := PreImagesSet( q, CoinHN );
	diff := DifferenceGroupHomomorphisms@ (
		RestrictedHomomorphism( hom1, Coin, G ),
		RestrictedHomomorphism( hom2, Coin, G )
	);
	return Kernel( diff );
end;


###############################################################################
##
## FixedPointGroupBySemidirectProduct@( aut )
##
FixedPointGroupBySemidirectProduct@ := function( aut )
	local G, S, emb, inc, fix;
	G := Source( aut );
	S := SemidirectProductWithAutomorphism@( G, aut );
	emb := Embedding( S, 2 );
	inc := RestrictedHomomorphism( emb, G, ImagesSource( emb ) );
	fix := NormalIntersection( Range( inc ), Centralizer( S, S.1 ) );
	return PreImagesSet( inc, fix );
end;


###############################################################################
##
## CoincidenceGroup( hom1, hom2 )
##

InstallMethod(
	CoincidenceGroup,
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
		return CoincidenceGroupByFiniteCoin@(
			hom1, hom2,
			TrivialSubgroup( G )
		);
	end
);

InstallMethod(
	CoincidenceGroup,
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
		diff := DifferenceGroupHomomorphisms@ ( hom1, hom2 );
		return Kernel( diff );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for infinite polycyclic source and infinite nilpotent range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		local G, H;
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
		return CoincidenceGroupByCentre@( hom1, hom2 );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for infinite polycyclic source and infinite nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	2,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G ) or
			not IsNilpotentByFinite( G ) or
			IsNilpotent( G )
		) then
			TryNextMethod();
		fi;
		return CoincidenceGroupByFiniteCoin@(
			hom1, hom2,
			FittingSubgroup( G )
		);
	end
);

InstallMethod(
	CoincidenceGroup,
	"for infinite polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G )
		) then
			TryNextMethod();
		fi;
		return CoincidenceGroupByFiniteCoin@(
			hom1, hom2,
			DerivedSubgroup( G )
		);
	end
);

InstallMethod(
	CoincidenceGroup,
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
