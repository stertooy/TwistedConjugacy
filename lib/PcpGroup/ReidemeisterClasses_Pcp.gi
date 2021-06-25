###############################################################################
##
## ReidemeisterClassesByTrivialSubgroup@( hom1, hom2 )
##
ReidemeisterClassesByTrivialSubgroup@ := function ( hom1, hom2 )
	local G, H, N, id, q, hom1HN, hom2HN;
	G := Range( hom1 );
	H := Source( hom1 );
	N := IntersectionKernels@( hom1, hom2 );
	id := IdentityMapping( G );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	hom1HN := InducedHomomorphism( q, id, hom1 );
	hom2HN := InducedHomomorphism( q, id, hom2 );
	return RepresentativesReidemeisterClasses( hom1HN, hom2HN );
end;


###############################################################################
##
## ReidemeisterClassesByFiniteQuotient@( hom1, hom2, N, M )
##
ReidemeisterClassesByFiniteQuotient@ := function ( hom1, hom2, N, M )
	local G, H, p, q, GM, hom1HN, hom2HN, RclGM, Rcl, hom1N, hom2N, pg,
		inn_pg, Coin, g, conj_g, inn_g_hom1N, RclM, igRclM,	inn_g, tc, m1,
		isNew, qh, h, m2;
	G := Range( hom1 );
	H := Source( hom1 );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	GM := Range( p );
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	RclGM := RepresentativesReidemeisterClasses( hom1HN, hom2HN );
	if RclGM = fail then
		return fail;
	fi;
	Rcl := [];
	hom1N := RestrictedHomomorphism( hom1, N, M );
	hom2N := RestrictedHomomorphism( hom2, N, M );
	for pg in RclGM do
		inn_pg := InnerAutomorphismNC( GM, pg^-1 );
		Coin := CoincidenceGroup( hom1HN*inn_pg, hom2HN );
		if not IsFinite( Coin ) then
			TryNextMethod();
		fi;
		g := PreImagesRepresentative( p, pg );
		conj_g := ConjugatorAutomorphismNC( M, g^-1 );
		inn_g_hom1N := hom1N*conj_g;
		RclM := RepresentativesReidemeisterClasses( inn_g_hom1N, hom2N );
		if RclM = fail then
			return fail;
		fi;
		igRclM := [];
		inn_g := InnerAutomorphismNC( G, g^-1 );
		tc := TwistedConjugation( hom1*inn_g, hom2 );
		for m1 in RclM do
			isNew := true;
			for qh in Coin do
				h := PreImagesRepresentative( q, qh );
				m2 := tc( m1, h );
				if ForAny(
					igRclM,
					k -> IsTwistedConjugate(
						inn_g_hom1N, hom2N,
						k, m2
					)
				) then
					isNew := false;
					break;
				fi;
			od;
			if isNew then
				Add( igRclM, m1 );
			fi;
		od;
		Append( Rcl, List( igRclM, m -> m*g ) );
	od;
	return Rcl;
end;


###############################################################################
##
## ReidemeisterClassesByCentralSubgroup@( hom1, hom2, N, M )
##
ReidemeisterClassesByCentralSubgroup@ := function ( hom1, hom2, N, M )
	local G, H, p, q, hom1HN, hom2HN, RclGM, GM, Rcl, foundOne, pg, inn_pg,
		CoinHN, Coin, g, inn_g, diff, r, coker, rm, m;
	G := Range( hom1 );
	H := Source( hom1 );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	RclGM := RepresentativesReidemeisterClasses( hom1HN, hom2HN );
	if RclGM = fail then
		return fail;
	fi;
	GM := Range( p );
	Rcl := [];
	foundOne := false;
	for pg in RclGM do
		inn_pg := InnerAutomorphismNC( GM, pg^-1 );
		CoinHN := CoincidenceGroup(	hom1HN*inn_pg, hom2HN	);
		Coin := PreImagesSet( q, CoinHN );
		g := PreImagesRepresentative( p, pg );
		inn_g := InnerAutomorphismNC( G, g^-1 );
		diff := DifferenceGroupHomomorphisms@ ( hom1*inn_g, hom2, Coin, G );
		r := NaturalHomomorphismByNormalSubgroupNC(	M, ImagesSource( diff ) );
		coker := Range( r );
		if not IsFinite( coker ) then
			return fail;
		fi;
		for rm in coker do
			if ( not foundOne ) and IsOne( rm ) and IsOne( pg ) then
				Add( Rcl, One( G ), 1 );
				foundOne := true;
			else
				m := PreImagesRepresentative( r, rm );
				Add( Rcl, m*g );
			fi;
		od;
	od;
	return Rcl;
end;


###############################################################################
##
## RepresentativesReidemeisterClasses( hom1, hom2 )
##
InstallMethod(
	RepresentativesReidemeisterClasses,
	"for polycyclic source and (polycyclic nilpotent-by-)finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	7,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not (
				IsPcpGroup( G ) and IsNilpotentByFinite( G ) or
				IsFinite( G )
			) or
			HirschLength( H ) >= HirschLength( G )
		) then
			TryNextMethod();
		fi;
		return fail;
	end
);

InstallMethod(
	RepresentativesReidemeisterClasses,
	"for infinite polycyclic source and finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	4,
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
		return ReidemeisterClassesByTrivialSubgroup@( hom1, hom2 );
	end
);

InstallMethod(
	RepresentativesReidemeisterClasses,
	"for infinite polycyclic source and infinite abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		local G, H, diff, N, Rcl, p, foundOne, pg, g;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup ( H ) or
			not IsPcpGroup( G ) or
			not IsAbelian( G )
		) then
			TryNextMethod();
		fi;
		diff := DifferenceGroupHomomorphisms@( hom1, hom2, H, G );
		N := ImagesSource( diff );
		if IndexNC( G, N ) = infinity then
			return fail;
		else
			Rcl := [];
			p := NaturalHomomorphismByNormalSubgroupNC( G, N );
			foundOne := false;
			for pg in Range( p ) do
				if IsOne( pg ) then
					Add( Rcl, One( G ), 1 );
					foundOne := true;
				else
					g := PreImagesRepresentative( p, pg );
					Add( Rcl, g );
				fi;
			od;
			return Rcl;
		fi;
	end
);

InstallMethod(
	RepresentativesReidemeisterClasses,
	"for infinite polycyclic source and infinite nilpotent range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	2,
	function ( hom1, hom2 )
		local G, H, M, N;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G ) or
			not IsNilpotent( G ) or
			IsAbelian( G )
		) then
			TryNextMethod();
		fi;
		
		M := Centre( G );
		N := IntersectionPreImage@( hom1, hom2, M );
		return ReidemeisterClassesByCentralSubgroup@( hom1, hom2, N, M );
	end
);

InstallMethod(
	RepresentativesReidemeisterClasses,
	"for infinite polycyclic source and infinite nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( hom1, hom2 )
		local G, H, M, N;
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
		M := FittingSubgroup( G );
		N := IntersectionPreImage@( hom1, hom2, M );
		return ReidemeisterClassesByFiniteQuotient@( hom1, hom2, N, M );
	end
);

InstallMethod(
	RepresentativesReidemeisterClasses,
	"for infinite polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	0,
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
		return ReidemeisterClassesByFiniteQuotient@( hom1, hom2, N, M );
	end
);
