###############################################################################
##
## ReidemeisterClass( hom1, hom2, g )
##
InstallMethod(
	ReidemeisterClass,
	"for double twisted conjugacy",
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	function ( hom1, hom2, g )
		local G, H, fam, typ, tc, tcc;
		G := Range( hom1 );
		H := Source( hom1 );
		typ := NewType( 
			FamilyObj( G ),
			IsReidemeisterClassGroupRep and HasActingDomain and 
			HasRepresentative and HasFunctionAction
		);
		tc := TwistedConjugation( hom1, hom2 );
		tcc := rec();
		ObjectifyWithAttributes(
			tcc, typ,
			ActingDomain, H,
			Representative, g,
			FunctionAction, tc,
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
	"for twisted conjugacy",
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
			homs[1], homs[2], g,
			Representative( tcc )
		);
	end 
);

InstallMethod(
	PrintObj,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		local homStrings, homs, i, G, gens;
		homStrings := [];
		homs := GroupHomomorphismsOfReidemeisterClass( tcc );
		for i in [1..2] do
			G := Source( homs[i] );
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


###############################################################################
##
## ReidemeisterClassesByFiniteCoin@( hom1, hom2, M )
##
ReidemeisterClassesByFiniteCoin@ := function ( hom1, hom2, M ) 
	local G, H, N, p, q, hom1HN, hom2HN, RclGM, Rcl, hom1N, hom2N, pg,
	ighom1HN, Coin, g, ighom1, ighom1N, RclM, igRclM, tc, m, isNew, qh, m2;
	G := Range( hom1 );
	H := Source( hom1 );
	N := IntersectionPreImage@( hom1, hom2, M );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
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
		ighom1HN := ComposeWithInnerAutomorphism@( pg^-1, hom1HN );
		Coin := CoincidenceGroup( ighom1HN, hom2HN );
		if not IsFinite( Coin ) then
			TryNextMethod();
		fi;
		g := PreImagesRepresentative( p, pg );
		ighom1 := ComposeWithInnerAutomorphism@( g^-1, hom1 );
		ighom1N := ComposeWithInnerAutomorphism@( g^-1, hom1N );
		RclM := ReidemeisterClasses(
			ighom1N,
			hom2N
		);
		if RclM = fail then
			return fail;
		fi;
		RclM := List( RclM, g -> Representative( g ) );
		igRclM := [ Remove( RclM, 1 ) ];
		tc := TwistedConjugation( ighom1, hom2 );
		for m in RclM do
			isNew := true;
			for qh in Coin do
				m2 := tc( m, PreImagesRepresentative( q, qh ) );
				if ForAny( 
					igRclM, k -> IsTwistedConjugate( ighom1N, hom2N, k, m2 )
				) then
					isNew := false;
					break;
				fi;
			od;
			if isNew then
				Add( igRclM, m );
			fi;
		od;
		Append( Rcl, 
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
	local G, H, M, N, q, p, hom1HN, hom2HN, RclGM,Rcl, pg, g, ighom1, ighom1HN,
	CoinHN, qinvCoinHN, gens, deltaLift, pCoker, coker, pm, m;
	G := Range( hom1 );
	H := Source( hom1 );
	M := Centre( G );
	N := IntersectionPreImage@( hom1, hom2, M );
	q := NaturalHomomorphismByNormalSubgroupNC( H, N );
	p := NaturalHomomorphismByNormalSubgroupNC( G, M );
	hom1HN := InducedHomomorphism( q, p, hom1 );
	hom2HN := InducedHomomorphism( q, p, hom2 );
	RclGM := ReidemeisterClasses( hom1HN, hom2HN );
	if RclGM = fail then
		return fail;
	fi;
	RclGM := List( RclGM, g -> Representative( g ) );
	Rcl := [];
	for pg in RclGM do
		g := PreImagesRepresentative( p, pg );
		ighom1 := ComposeWithInnerAutomorphism@(  g^-1, hom1 );
		ighom1HN := ComposeWithInnerAutomorphism@( pg^-1, hom1HN );
		CoinHN := CoincidenceGroup( ighom1HN, hom2HN );
		qinvCoinHN := PreImage( q, CoinHN );
		gens := GeneratorsOfGroup( qinvCoinHN );
		deltaLift := GroupHomomorphismByImagesNC(
			qinvCoinHN, M,
			gens, List( gens, h -> h^hom2 *( h^ighom1 )^-1 )
		);
		pCoker := NaturalHomomorphismByNormalSubgroupNC( 
			M, 
			Image( deltaLift )
		);
		coker := Image( pCoker );
		if not IsFinite( coker ) then
			return fail;
		fi;
		for pm in coker do
			if pm = One( coker ) and pg = One( Image( p ) ) then
				Add( Rcl, ReidemeisterClass( 
					hom1, hom2, One( G )
				), 1 );
			else
				m := PreImagesRepresentative( pCoker, pm );
				Add( Rcl, ReidemeisterClass( 
					hom1, hom2, m*g
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
	"for pcp-groups with abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	4,
	function ( hom1, hom2 )
		local G, H, N, Rcl, p, pg, R;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup ( H ) or not IsPcpGroup( G ) or
		not IsAbelian( G ) then
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
	"for pcp-groups with nilpotent range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup ( G ) or not IsPcpGroup( H ) or
		not IsNilpotent( G ) or IsAbelian( G ) then
			TryNextMethod();
		fi;
		return ReidemeisterClassesByCentre@( hom1, hom2 );
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for pcp-groups with nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	2,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup ( G ) or not IsPcpGroup( H ) or
		not IsNilpotentByFinite( G ) or IsNilpotent( G ) then
			TryNextMethod();
		fi;
		return ReidemeisterClassesByFiniteCoin@( 
			hom1, hom2, 
			FittingSubgroup( G )
		);
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for pcp-groups",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsPcpGroup ( G ) or not IsPcpGroup( H ) or
		IsNilpotentByFinite( G ) then
			TryNextMethod();
		fi;
		return ReidemeisterClassesByFiniteCoin@( 
			hom1, hom2, DerivedSubgroup( G )
		);
	end
);

InstallMethod(
	ReidemeisterClasses,
	"for finite groups",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	0,
	function ( hom1, hom2 )
		local G, H, xset, s, Rcl, i, tcc, pos;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsFinite( G ) or not IsFinite( H ) then
			TryNextMethod();
		fi;
		xset := AsSSortedListNonstored( G );
		s := HasAsList( G ) or HasAsSSortedList( G );
		Rcl := [];
		for i in OrbitsDomain( H, xset, TwistedConjugation( hom1, hom2 ) ) do
			if One( G ) in i then
				tcc := ReidemeisterClass( hom1, hom2, One( G ) );
				pos := 1;
			else
				tcc := ReidemeisterClass( hom1, hom2, i[1] );
				pos := Length( Rcl )+1;
			fi;
			SetSize( tcc, Length( i ) );
			if s or Length( i ) < 5 then
				SetAsSSortedList( tcc, SortedList( i ) );
			fi;
            Add( Rcl, tcc, pos );
		od;
		return Rcl;
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
