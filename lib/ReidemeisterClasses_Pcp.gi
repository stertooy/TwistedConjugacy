###############################################################################
##
## ReidemeisterClassesByFiniteCoin@( hom1, hom2, M )
##
ReidemeisterClassesByFiniteCoin@ := function ( hom1, hom2, M )
	local G, H, N, p, q, hom1HN, hom2HN, RclGM, Rcl, hom1N, hom2N, pg,
		Coin, g, ighom1N, RclM, igRclM, tc, m, isNew, qh;
	G := Range( hom1 );
	N := IntersectionPreImage@( hom1, hom2, M );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( Source( hom1 ), N );
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	RclGM := ReidemeisterClasses(
		hom1HN,
		hom2HN
	);
	if RclGM = fail then
		return fail;
	fi;
	RclGM := List( RclGM, g -> Representative( g ) );
	Rcl := [];
	hom1N := RestrictedHomomorphism( hom1, N, M );
	hom2N := RestrictedHomomorphism( hom2, N, M );
	for pg in RclGM do
		Coin := CoincidenceGroup(
			hom1HN * InnerAutomorphismNC( Range( p ), pg^-1 ),
			hom2HN
		);
		if not IsFinite( Coin ) then
			TryNextMethod();
		fi;
		g := PreImagesRepresentative( p, pg );
		ighom1N := hom1N * ConjugatorAutomorphismNC( M, g^-1 );
		RclM := ReidemeisterClasses(
			ighom1N,
			hom2N
		);
		if RclM = fail then
			return fail;
		fi;
		RclM := List( RclM, g -> Representative( g ) );
		igRclM := [ Remove( RclM, 1 ) ];
		tc := TwistedConjugation(
			hom1 * InnerAutomorphismNC( G, g^-1 ),
			hom2
		);
		for m in RclM do
			isNew := true;
			for qh in Coin do
				if ForAny(
					igRclM, k -> IsTwistedConjugate(
						ighom1N, hom2N,
						k, tc( m, PreImagesRepresentative( q, qh ) )
					)
				) then
					isNew := false;
					break;
				fi;
			od;
			if isNew then
				Add( igRclM, m );
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
## ReidemeisterClassesByCentre@( hom1, hom2 )
##
ReidemeisterClassesByCentre@ := function ( hom1, hom2 )
	local G, M, p, q, hom1HN, hom2HN, RclGM, GM, Rcl, pg, g, Coin, r, cok, rm;
	G := Range( hom1 );
	M := Centre( G );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC(
		Source( hom1 ),
		IntersectionPreImage@( hom1, hom2, M )
	);
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	RclGM := ReidemeisterClasses( hom1HN, hom2HN );
	if RclGM = fail then
		return fail;
	fi;
	GM := Range( p );
	Rcl := [];
	for pg in List( RclGM, g -> Representative( g ) ) do
		g := PreImagesRepresentative( p, pg );
		Coin := PreImage( q, CoincidenceGroup(
			hom1HN * InnerAutomorphismNC( GM, pg^-1 ),
			hom2HN
		));
		r := NaturalHomomorphismByNormalSubgroupNC(
			M, Image( DifferenceGroupHomomorphisms@ (
				RestrictedHomomorphism( hom1, Coin, G ) * 
					InnerAutomorphismNC( G, g^-1 ),
				RestrictedHomomorphism( hom2, Coin, G )
			))
		);
		cok := Image( r );
		if not IsFinite( cok ) then
			return fail;
		fi;
		for rm in cok do
			if rm = One( cok ) and pg = One( GM ) then
				Add( Rcl, ReidemeisterClass( 
					hom1, hom2,
					One( G )
				), 1 );
			else
				Add( Rcl, ReidemeisterClass( 
					hom1, hom2,
					PreImagesRepresentative( r, rm ) * g
				));
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
	"for polycyclic or finite source and nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	7,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if ((
				not IsPcpGroup( H ) and
				not IsFinite( H )
			) or
			not IsNilpotentByFinite( G ) or
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
		local G;
		G := Range( hom1 );
		if (
			not IsPcpGroup( Source( hom1 ) ) or
			not IsFinite( G )
		) then
			TryNextMethod();
		fi;
		return ReidemeisterClassesByFiniteCoin@(
			hom1, hom2,
			TrivialSubgroup( G )
		);
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for infinite polycyclic source and infinite abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		local G, H, N, Rcl, p, R, pg;
		G := Range( hom1 );
		if (
			not IsPcpGroup ( Source( hom1 ) ) or
			not IsPcpGroup( G ) or
			not IsAbelian( G )
		) then
			TryNextMethod();
		fi;
		N := Image( DifferenceGroupHomomorphisms@( hom1, hom2 ) );
		if IndexNC( G, N ) = infinity then
			return fail;
		else
			Rcl := [];
			p := NaturalHomomorphismByNormalSubgroupNC( G, N );
			R := Range( p );
			for pg in R do
				if pg = One( R ) then
					Add( Rcl, ReidemeisterClass( hom1, hom2, One( G ) ), 1 );
				else
					Add( Rcl, ReidemeisterClass(
						hom1, hom2, PreImagesRepresentative( p, pg )
					));
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
		local G;
		G := Range( hom1 );
		if (
			not IsPcpGroup( Source( hom1 ) ) or
			not IsPcpGroup( G ) or
			not IsNilpotent( G )
		) then
			TryNextMethod();
		fi;
		return ReidemeisterClassesByCentre@( hom1, hom2 );
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for infinite polycyclic source and infinite nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( hom1, hom2 )
		local G;
		G := Range( hom1 );
		if (
			not IsPcpGroup( Source( hom1 ) ) or
			not IsPcpGroup( G ) or
			not IsNilpotentByFinite( G )
		) then
			TryNextMethod();
		fi;
		return ReidemeisterClassesByFiniteCoin@(
			hom1, hom2, FittingSubgroup( G )
		);
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for infinite polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	0,
	function ( hom1, hom2 )
		local G;
		G := Range( hom1 );
		if (
			not IsPcpGroup( Source( hom1 ) ) or
			not IsPcpGroup( G ) or
			IsNilpotentByFinite( G )
		) then
			TryNextMethod();
		fi;
		return ReidemeisterClassesByFiniteCoin@(
			hom1, hom2, DerivedSubgroup( G )
		);
	end
);
