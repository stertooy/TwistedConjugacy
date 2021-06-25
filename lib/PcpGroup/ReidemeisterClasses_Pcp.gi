###############################################################################
##
## ReidemeisterClassesByFiniteQuotient@( hom1, hom2, N, M )
##
ReidemeisterClassesByFiniteQuotient@ := function ( hom1, hom2, N, M )
	local G, H, p, q, GM, hom1HN, hom2HN, RclGM, tccGM, Rcl, hom1N, hom2N, pg,
		inn_pg, Coin, g, conj_g, inn_g_hom1N, RclM, igRclM,	inn_g, tc, m1,
		isNew, qh, h, m2;
	G := Range( hom1 );
	H := Source( hom1 );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	GM := Range( p );
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	RclGM := ReidemeisterClasses( hom1HN, hom2HN );
	if RclGM = fail then
		return fail;
	fi;
	Rcl := [];
	hom1N := RestrictedHomomorphism( hom1, N, M );
	hom2N := RestrictedHomomorphism( hom2, N, M );
	for tccGM in RclGM do
		pg := Representative( tccGM );
		inn_pg := InnerAutomorphismNC( GM, pg^-1 );
		Coin := CoincidenceGroup( hom1HN*inn_pg, hom2HN );
		if not IsFinite( Coin ) then
			TryNextMethod();
		fi;
		g := PreImagesRepresentative( p, pg );
		conj_g := ConjugatorAutomorphismNC( M, g^-1 );
		inn_g_hom1N := hom1N*conj_g;
		RclM := ReidemeisterClasses( inn_g_hom1N, hom2N );
		if RclM = fail then
			return fail;
		fi;
		igRclM := [];
		inn_g := InnerAutomorphismNC( G, g^-1 );
		tc := TwistedConjugation( hom1*inn_g, hom2 );
		for m1 in List( RclM, Representative ) do
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
		Append(
			Rcl,
			List( igRclM, m -> ReidemeisterClass( hom1, hom2, m*g ) )
		);
	od;
	return Rcl;
end;


###############################################################################
##
## ReidemeisterClassesByCentralSubgroup@( hom1, hom2, N, M )
##
ReidemeisterClassesByCentralSubgroup@ := function ( hom1, hom2, N, M )
	local G, H, p, q, hom1HN, hom2HN, RclGM, GM, Rcl, pg, inn_pg, CoinHN, Coin,
		g, inn_g, diff, r, coker, rm, tcc, m;
	G := Range( hom1 );
	H := Source( hom1 );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	RclGM := ReidemeisterClasses( hom1HN, hom2HN );
	if RclGM = fail then
		return fail;
	fi;
	GM := Range( p );
	Rcl := [];
	for pg in List( RclGM, Representative ) do
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
			if IsOne( rm ) and IsOne( pg ) then
				tcc := ReidemeisterClass( hom1, hom2, One( G ) );
				Add( Rcl, tcc, 1 );
			else
				m := PreImagesRepresentative( r, rm );
				tcc := ReidemeisterClass( hom1, hom2, m*g );
				Add( Rcl, tcc );
			fi;
		od;
	od;
	return Rcl;
end;


###############################################################################
##
## ReidemeisterClasses( hom1, hom2 )
##
InstallMethod(
	ReidemeisterClasses,
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
	ReidemeisterClasses,
	"for infinite polycyclic source and finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	4,
	function ( hom1, hom2 )
		local G, H, M, N;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsFinite( G ) or
			IsTrivial( G )
		) then
			TryNextMethod();
		fi;
		M := TrivialSubgroup( G );
		N := IntersectionPreImage@( hom1, hom2, M );
		return ReidemeisterClassesByFiniteQuotient@( hom1, hom2, N, M );
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for infinite polycyclic source and infinite abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		local G, H, diff, N, Rcl, p, pg, tcc, g;
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
			for pg in Range( p ) do
				if IsOne( pg ) then
					tcc := ReidemeisterClass( hom1, hom2, One( G ) );
					Add( Rcl, tcc, 1 );
				else
					g := PreImagesRepresentative( p, pg );
					tcc := ReidemeisterClass( hom1, hom2, g );
					Add( Rcl, tcc );
				fi;
			od;
			return Rcl;
		fi;
	end
);

InstallMethod(
	ReidemeisterClasses,
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
	ReidemeisterClasses,
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
	ReidemeisterClasses,
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
