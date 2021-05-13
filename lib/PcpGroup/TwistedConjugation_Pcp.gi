###############################################################################
##
## RepTwistConjToIdByFiniteCoin( hom1, hom2, g, M )
##
RepTwistConjToIdByFiniteCoin@ := function ( hom1, hom2, g, M )
	local G, H, N, p, q, hom1HN, hom2HN, pg, qh1, Coin, h1, tc, m1, hom1N,
		hom2N, qh2, h2, m2,	n;
	G := Range( hom1 );
	H := Source( hom1 );
	N := IntersectionPreImage@( hom1, hom2, M );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	pg := ImagesRepresentative( p, g );
	qh1 := RepTwistConjToId( hom1HN, hom2HN, pg );
	if qh1 = fail then
		return fail;
	fi;
	Coin := CoincidenceGroup( hom1HN, hom2HN );
	if not IsFinite( Coin ) then
		TryNextMethod();
	fi;
	h1 := PreImagesRepresentative( q, qh1 );
	tc := TwistedConjugation( hom1, hom2 );
	m1 := tc( g, h1 );
	hom1N := RestrictedHomomorphism( hom1, N, M );
	hom2N := RestrictedHomomorphism( hom2, N, M );
	for qh2 in Coin do
		h2 := PreImagesRepresentative( q, qh2 );
		m2 := tc( m1, h2 );
		n := RepTwistConjToId( hom1N, hom2N, m2 );
		if n <> fail then
			return h1*h2*n;
		fi;
	od;
	return fail;
end;


###############################################################################
##
## RepTwistConjToIdByCentre( hom1, hom2, g )
##
RepTwistConjToIdByCentre@ := function ( hom1, hom2, g ) 
	local G, H, M, N, p, q, hom1HN, hom2HN, pg, qh1, h1, tc, m1, Coin,
		hom1Coin, hom2Coin, delta, h2, m2, hom1N, hom2N, n;
	G := Range( hom1 );
	H := Source( hom1 );
	M := Centre( G );
	N := IntersectionPreImage@( hom1, hom2, M );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	pg := ImagesRepresentative( p, g );
	qh1 := RepTwistConjToId( hom1HN, hom2HN, pg );
	if qh1 = fail then
		return fail;
	fi;
	h1 := PreImagesRepresentative( q, qh1 );
	tc := TwistedConjugation( hom1, hom2 );
	m1 := tc( g, h1 );
	Coin := PreImagesSet( q, CoincidenceGroup( hom1HN, hom2HN ) );
	hom1Coin := RestrictedHomomorphism( hom1, Coin, G );
	hom2Coin := RestrictedHomomorphism( hom2, Coin, G );
	delta := DifferenceGroupHomomorphisms@ ( hom1Coin, hom2Coin );
	if not m1 in ImagesSource( delta ) then
		return fail;
	fi;
	h2 := PreImagesRepresentative( delta, m1 );
	m2 := tc( m1, h2 );
	hom1N := RestrictedHomomorphism( hom1, N, M );
	hom2N := RestrictedHomomorphism( hom2, N, M );
	n := RepTwistConjToId( hom1N, hom2N, m2 );
	return h1*h2*n;
end;


###############################################################################
##
## RepTwistConjToId( hom1, hom2, g )
##
InstallMethod(
	RepTwistConjToId,
	"for infinite polycyclic source and finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	5,
	function ( hom1, hom2, g )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		return RepTwistConjToIdByFiniteCoin@(
			hom1, hom2,
			g,
			TrivialSubgroup( G )
		);
	end
);

InstallMethod(
	RepTwistConjToId,
	"for infinite polycyclic source and infinite abelian range", 
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	4,
	function ( hom1, hom2, g )
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
		diff := DifferenceGroupHomomorphisms@( hom1, hom2 );
		if not g in ImagesSource( diff ) then
			return fail;
		fi;
		return PreImagesRepresentative( diff, g );
	end
);

InstallMethod(
	RepTwistConjToId,
	"for infinite polycyclic source and infinite nilpotent range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	3,
	function ( hom1, hom2, g )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G ) or
			not IsNilpotent( G )
		) then
			TryNextMethod();
		fi;
		return RepTwistConjToIdByCentre@( hom1, hom2, g );
	end
);

InstallMethod(
	RepTwistConjToId,
	"for infinite polycyclic source and infinite nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	2,
	function ( hom1, hom2, g )
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
		return RepTwistConjToIdByFiniteCoin@( 
			hom1, hom2,
			g,
			FittingSubgroup( G )
		);
	end
);

InstallMethod(
	RepTwistConjToId,
	"for isomorphisms with infinite polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	1,
	function ( aut1, aut2, g )
		local G, H, S, emb, s, hs;
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
		S := SemidirectProductWithAutomorphism@( H, aut2 * Inverse( aut1 ) );
		emb := Embedding( S, 2 );
		s := ImagesRepresentative( emb, PreImagesRepresentative( aut1, g ) );
		hs := ConjugacyElementsBySeries( 
			S,
			S.1, S.1*s,
			PcpsOfEfaSeries( S )
		);
		if hs = false then
			return fail;
		fi;
		hs := S.1^( -ExponentsByPcp( Pcp( S ), hs )[1] ) * hs;
		return PreImagesRepresentative( emb, hs )^-1;
	end
);

InstallMethod(
	RepTwistConjToId,
	"for infinite polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	0,
	function ( hom1, hom2, g )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G )
		) then
			TryNextMethod();
		fi;
		return RepTwistConjToIdByFiniteCoin@(
			hom1, hom2,
			g,
			DerivedSubgroup( G )
		);
	end
);
