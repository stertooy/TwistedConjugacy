###############################################################################
##
## CoincidenceGroupByFiniteCoin@( hom1, hom2, M )
##
CoincidenceGroupByFiniteCoin@ := function ( hom1, hom2, M )
	local G, H, N, p, q, CoinHN, hom1N, hom2N, tc, gens, CoinN, qh, h, n;
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
	gens := [];
	for qh in CoinHN do
		h := PreImagesRepresentative( q, qh );
		n := RepTwistConjToId( hom1N, hom2N, tc( One( G ), h ) );
		if n <> fail then
			Add( gens, h*n );
		fi;
	od;
	CoinN := CoincidenceGroup( hom1N, hom2N );
	return ClosureSubgroupNC(
		AsSubgroup( H, CoinN ),
		gens
	);
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
	Coin := PreImage( q, CoinHN );
	diff := DifferenceGroupHomomorphisms@ (
		RestrictedHomomorphism( hom1, Coin, G ),
		RestrictedHomomorphism( hom2, Coin, G )
	);
	return Kernel( diff );
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
			not IsFinite( G )
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
			not IsNilpotentGroup( G )
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
			not IsNilpotentByFinite( G )
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
	"for isomorphisms with infinite polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( aut1, aut2 )
		local G, H, aut;
		G := Range( aut1 );
		H := Source( aut1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G ) or
			IsNilpotentByFinite( G ) or
			not IsBijective( aut1 ) or
			not IsBijective( aut2 )
		) then
			TryNextMethod();
		fi;
		aut := aut1 * Inverse( aut2 );
		return FixedPointGroup( aut );
	end
);

InstallMethod(
	CoincidenceGroup,
	"for infinite polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	0,
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

###############################################################################
##
## FixedPointGroup( aut )
##
InstallMethod(
	FixedPointGroup,
	"for automorphisms of infinite polycyclic groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	1,
	function ( aut )
		local G, S, emb, inc, fix;
		G := Source( aut );
		if (
			not IsPcpGroup( G ) or
			IsNilpotentByFinite( G ) or 
			not IsBijective( aut )
		) then
			TryNextMethod();
		fi;
		S := SemidirectProductWithAutomorphism@( G, aut );;
		emb := Embedding( S, 2 );
		inc := RestrictedHomomorphism( emb, G, ImagesSource( emb ) );
		fix := Intersection2( Range( inc ), Centralizer( S, S.1 ) );;
		return PreImagesSet( inc, fix );
	end
);
