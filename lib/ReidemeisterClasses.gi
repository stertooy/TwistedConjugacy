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
		Print(
			"ReidemeisterClass( [ ",
			homStrings[1],
			", ",
			homStrings[2],
			" ], ",
			PrintString( Representative( tcc ) ),
			" )"
		);
		return;
	end
);

InstallMethod(
	Random,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		return FunctionAction( tcc )(
			Representative( tcc ),
			Random( ActingDomain( tcc ) )
		);
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
			( not IsPolycyclicGroup( H ) and
			  not IsFinite( H ) ) or
			( not IsPolycyclicGroup( G ) and
			  not IsFinite( H ) )
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
		local G, H, homs, g, Coin;
		G := ActingCodomain( tcc );
		H := ActingDomain( tcc );
		if (
			( not IsPolycyclicGroup( H ) and
			  not IsFinite( H ) ) or
			( not IsPolycyclicGroup( G ) and
			  not IsFinite( H ) )
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
			return List(
				RightTransversal( H, Coin ),
				h -> FunctionAction( tcc )( g, h )
			);
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
	"for trivial range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	7,
	function ( hom1, hom2 )
		local G;
		G := Range( hom1 );
		if not IsTrivial( G ) then
			TryNextMethod();
		fi;
		return [ ReidemeisterClass( hom1, hom2, One( G ) ) ];
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for finite source",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	6,
	function ( hom1, hom2 )
		local G, H, Rcl, orbit;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsFinite( H )
		) then
			TryNextMethod();
		fi;
		if not IsFinite( G ) then
			return fail;
		fi;
		Rcl := [];
		for orbit in OrbitsDomain( 
			H,
			AsSSortedListNonstored( G ),
			TwistedConjugation( hom1, hom2 )
		) do
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
	"for polycyclic source and finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	5,
	function ( hom1, hom2 )
		local G;
		G := Range( hom1 );
		if (
			not IsPolycyclicGroup( Source( hom1 ) ) or
			not IsFinite( G ) or
			IsTrivial( G )
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
	"for polycyclic or finite source and (polycyclic nilpotent-by-)finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	4,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			( not IsPolycyclicGroup( H ) and
			  not IsFinite( H ) ) or 
			( not ( IsPolycyclicGroup( G ) and
				    IsNilpotentByFinite( G ) ) and
			  not IsFinite( G ) )
		) then
			TryNextMethod();
		fi;
		if HirschLength( H ) >= HirschLength( G ) then
			TryNextMethod();
		fi;
		return fail;
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
			not IsPolycyclicGroup ( Source( hom1 ) ) or
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
	"for polycyclic source and nilpotent range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	2,
	function ( hom1, hom2 )
		local G;
		G := Range( hom1 );
		if (
			not IsPolycyclicGroup( Source( hom1 ) ) or
			not IsNilpotent( G ) or
			IsAbelian( G )
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
			not IsPolycyclicGroup( Source( hom1 ) ) or
			not IsPolycyclicGroup( G ) or
			not IsNilpotentByFinite( G ) or
			IsNilpotent( G ) or
			IsFinite( G )
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
			not IsPolycyclicGroup( Source( hom1 ) ) or
			not IsPolycyclicGroup( G ) or
			IsNilpotentByFinite( G )
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
