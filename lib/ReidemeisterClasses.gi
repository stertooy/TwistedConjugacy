###############################################################################
##
## ReidemeisterClass( hom1, hom2, g )
##
InstallMethod(
	ReidemeisterClass,
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	function ( hom1, hom2, g )
		local G, tcc;
		G := Range( hom1 );
		tcc := rec();
		ObjectifyWithAttributes(
			tcc, NewType(
				FamilyObj( G ),
				IsReidemeisterClassGroupRep and HasActingDomain and
				HasActingCodomain and HasRepresentative and 
				HasFunctionAction and HasGroupHomomorphismsOfReidemeisterClass
			),
			ActingDomain, Source( hom1 ),
			ActingCodomain, G,
			Representative, g,
			FunctionAction, TwistedConjugation( hom1, hom2 ),
			GroupHomomorphismsOfReidemeisterClass, [ hom1, hom2 ]
		);
		return tcc;
	end
);


###############################################################################
##
## ReidemeisterClass( endo, g )
##
InstallOtherMethod(
	ReidemeisterClass,
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsMultiplicativeElementWithInverse ],
	function ( endo, g )
		return ReidemeisterClass( endo, IdentityMapping( Source( endo ) ), g );
	end
);

RedispatchOnCondition(
	ReidemeisterClass,
	true,
	[ IsGroupHomomorphism, IsMultiplicativeElementWithInverse ],
	[ IsEndoGeneralMapping, IsMultiplicativeElementWithInverse ],
	0
);


###############################################################################
##
## Methods for operations/attributes on a ReidemeisterClass
##
InstallMethod(
	\in,
	"for Reidemeister classes",
	[ IsMultiplicativeElementWithInverse, IsReidemeisterClassGroupRep ],
	function ( g, tcc )
		local homs;
		homs := GroupHomomorphismsOfReidemeisterClass( tcc );
		return IsTwistedConjugate( 
			homs[1], homs[2],
			g, Representative( tcc )
		);
	end
);

InstallMethod(
	PrintObj,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		local homStrings, homs, G, i, gens;
		homStrings := [];
		homs := GroupHomomorphismsOfReidemeisterClass( tcc );
		G := ActingCodomain( tcc );
		for i in [1..2] do
			if homs[i] = IdentityMapping( G ) then
				gens := PrintString( GeneratorsOfGroup( G ) );
				homStrings[i] := Concatenation( gens, " -> ", gens );
			else
				homStrings[i] := PrintString( homs[i] );
			fi;
		od;
		Print( Concatenation(
			"ReidemeisterClass( [ ",
			homStrings[1],
			", ",
			homStrings[2],
			" ], ",
			PrintString( Representative( tcc ) ),
			" )"
		));
		return;
	end
);

InstallMethod(
	Random,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		local tc;
		tc := FunctionAction( tcc );
		return tc( Representative( tcc ), Random( ActingDomain( tcc ) ) );
	end
);

InstallMethod(
	Size,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		local G, H, homs;
		G := ActingCodomain( tcc );
		H := ActingDomain( tcc );
		if (
			not IsFinite( H ) and (
				not IsPolycyclicGroup( G ) or
				not IsPolycyclicGroup( H )
			)
		) then
			TryNextMethod();
		fi;
		homs := GroupHomomorphismsOfReidemeisterClass( tcc );
		return Index( H, CoincidenceGroup(
			homs[1] * InnerAutomorphismNC( G, Representative( tcc )^-1 ),
			homs[2]
		));
	end
);

InstallMethod(
	ListOp,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		local G, H, homs, g, Coin, tc;
		G := ActingCodomain( tcc );
		H := ActingDomain( tcc );
		if (
			not IsFinite( H ) and (
				not IsPolycyclicGroup( G ) or
				not IsPolycyclicGroup( H )
			)
		) then
			TryNextMethod();
		fi;
		homs := GroupHomomorphismsOfReidemeisterClass( tcc );
		g := Representative( tcc );
		Coin := CoincidenceGroup(
			homs[1] * InnerAutomorphismNC( G, g^-1 ),
			homs[2]
		);
		if Index( H, Coin ) = infinity then
			TryNextMethod();
		else
			tc := FunctionAction( tcc );
			return List( RightTransversal( H, Coin ), h -> tc( g, h ) );
		fi;
	end
);


###############################################################################
##
## ReidemeisterClassesByFiniteCoin@( hom1, hom2, M )
##
ReidemeisterClassesByFiniteCoin@ := function ( hom1, hom2, M )
	local G, H, N, p, q, hom1HN, hom2HN, RclGM, Rcl, hom1N, hom2N, pg,
		Coin, g, ighom1N, RclM, igRclM, tc, m, isNew, qh;
	if IsTrivial( M ) then
		TryNextMethod();
	fi;
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
	if IsTrivial( M ) then
		TryNextMethod();
	fi;
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
	"for finite pcp range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	6,
	function ( hom1, hom2 )
		local G, iso, Rcl;
		# TryNextMethod();
		G := Range( hom1 );
		if not IsFinite( G ) or not IsPcpGroup( G ) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( G );
		Rcl := ReidemeisterClasses( hom1*iso, hom2*iso );
		if Rcl = fail then
			return fail;
		fi;
		return List( Rcl, tcc -> ReidemeisterClass( hom1, hom2, PreImagesRepresentative(
			iso, Representative( tcc ) ) ) );
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for finite pcp source",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	5,
	function ( hom1, hom2 )
		local G, H, iso, inv, Rcl;
		# TryNextMethod();
		H := Source( hom1 );
		if not IsFinite( H ) or not IsPcpGroup( H ) then
			TryNextMethod();
		fi;
		iso := IsomorphismPcGroup( H );
		inv := InverseGeneralMapping( iso );
		Rcl := ReidemeisterClasses( inv*hom1, inv*hom2 );
		if Rcl = fail then
			return fail;
		fi;
		return List( Rcl, tcc -> ReidemeisterClass( hom1, hom2, Representative( tcc ) ) );
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for finite groups",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	4,
	function ( hom1, hom2 )
		local G, H, tc, Rcl, orbit;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsFinite( G ) or not IsFinite( H ) then
			TryNextMethod();
		fi;
		tc := TwistedConjugation( hom1, hom2 );
		Rcl := [];
		for orbit in OrbitsDomain( H, AsSSortedListNonstored( G ), tc ) do
			if One( G ) in orbit then
				Add( Rcl, ReidemeisterClass( hom1, hom2, One( G ) ), 1 );
			else
				Add( Rcl, ReidemeisterClass( hom1, hom2, orbit[1] ) );
			fi;
		od;
		return Rcl;
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for polycyclic source and abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		local G, H, N, Rcl, p, R, pg;
		G := Range( hom1 );
		if (
			not IsAbelian( G ) or 
			not IsPolycyclicGroup ( Source( hom1 ) )
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
	"for polycyclic source and nilpotent range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	2,
	function ( hom1, hom2 )
		local G;
		G := Range( hom1 );
		if (
			not IsNilpotent( G ) or IsAbelian( G ) or
			not IsPolycyclicGroup( Source( hom1 ) )
		) then
			TryNextMethod();
		fi;
		return ReidemeisterClassesByCentre@( hom1, hom2 );
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for polycyclic source and nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( hom1, hom2 )
		local G;
		G := Range( hom1 );
		if (
			not IsNilpotentByFinite( G ) or IsNilpotent( G ) or
			not IsPolycyclicGroup( Source( hom1 ) )
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
	"for polycyclic source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	0,
	function ( hom1, hom2 )
		local G;
		G := Range( hom1 );
		if (
			not IsPolycyclicGroup( G ) or IsNilpotentByFinite( G ) or
			not IsPolycyclicGroup( Source( hom1 ) )
		) then
			TryNextMethod();
		fi;
		return ReidemeisterClassesByFiniteCoin@(
			hom1, hom2, DerivedSubgroup( G )
		);
	end
);


###############################################################################
##
## ReidemeisterClasses( endo )
##
InstallOtherMethod(
	ReidemeisterClasses,
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo )
		return ReidemeisterClasses( endo, IdentityMapping( Source( endo ) ) );
	end
);

RedispatchOnCondition(
	ReidemeisterClasses,
	true,
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0
);
