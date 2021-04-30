###############################################################################
##
## ReidemeisterClass( hom1, hom2, g )
##
InstallMethod(
	ReidemeisterClass,
	[ IsGroupHomomorphism, IsGroupHomomorphism,
	  IsMultiplicativeElementWithInverse ],
	function ( hom1, hom2, g )
		local G, H, tc, tcc;
		G := Range( hom1 );
		H := Source( hom1 );
		tc := TwistedConjugation( hom1, hom2 );
		tcc := rec();
		ObjectifyWithAttributes(
			tcc, NewType(
				FamilyObj( G ),
				IsReidemeisterClassGroupRep and
				HasActingDomain and
				HasRepresentative and
				HasFunctionAction and
				HasGroupHomomorphismsOfReidemeisterClass
			),
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
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsMultiplicativeElementWithInverse ],
	function ( endo, g )
		local G;
		G := Range( endo );
		return ReidemeisterClass( endo, IdentityMapping( G ), g );
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
		local hom;
		hom := GroupHomomorphismsOfReidemeisterClass( tcc );
		return IsTwistedConjugate( 
			hom[1], hom[2],
			g, Representative( tcc )
		);
	end
);

InstallMethod(
	PrintObj,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		local hom, G, g, homString, i;
		hom := GroupHomomorphismsOfReidemeisterClass( tcc );
		G := Range( hom[1] );
		g := Representative( tcc );
		homString := [];
		for i in [1..2] do
			if hom[i] = IdentityMapping( G ) then
				homString[i] := PrintString(
					GroupHomomorphismByImagesNC( G, G )
				);
			else
				homString[i] := PrintString( hom[i] );
			fi;
		od;
		Print(
			"ReidemeisterClass( [ ",
			homString[1],
			", ",
			homString[2],
			" ], ",
			PrintString( g ),
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
		local H, g, h, tc;
		H := ActingDomain( tcc );
		g := Representative( tcc );
		h := Random( H );
		tc := FunctionAction( tcc );
		return tc( g, h );
	end
);

InstallMethod(
	Size,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		local G, H, g, inn, hom, Coin;
		H := ActingDomain( tcc );
		Coin := StabiliserOfExternalSet( tcc );
		return IndexNC( H, Coin );
	end
);

InstallMethod(
	ListOp,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		local G, H, g, inn, hom, Coin, tc;
		H := ActingDomain( tcc );
		Coin := StabiliserOfExternalSet( tcc );
		if IndexNC( H, Coin ) = infinity then
			return fail;
		else
			g := Representative( tcc );
			tc := FunctionAction( tcc );
			return List(
				RightTransversal( H, Coin ),
				h -> tc( g, h )
			);
		fi;
	end
);

InstallMethod(
	StabiliserOfExternalSet,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		local G, H, g, inn, hom, Coin, tc;
		H := ActingDomain( tcc );
		g := Representative( tcc );
		hom := GroupHomomorphismsOfReidemeisterClass( tcc );
		G := Range( hom[1] );
		inn := InnerAutomorphismNC( G, g^-1 );
		return CoincidenceGroup( hom[1]*inn, hom[2] );
	end
);


###############################################################################
##
## ReidemeisterClasses( hom1, hom2 )
##
InstallMethod(
	ReidemeisterClasses,
	"for trivial range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	6,
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
	5,
	function ( hom1, hom2 )
		local G, H, Rcl, tc, G_List, orbits, orbit;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsFinite( H ) then
			TryNextMethod();
		elif not IsFinite( G ) then
			return fail;
		fi;
		Rcl := [];
		tc := TwistedConjugation( hom1, hom2 );
		G_List := AsSSortedListNonstored( G );
		orbits := OrbitsDomain( H, G_List, tc );
		for orbit in orbits do
			if One( G ) in orbit then
				Add( Rcl, ReidemeisterClass( hom1, hom2, One( G ) ), 1 );
			else
				Add( Rcl, ReidemeisterClass( hom1, hom2, orbit[1] ) );
			fi;
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
		local G;
		G := Range( endo );
		return ReidemeisterClasses( endo, IdentityMapping( G ) );
	end
);

RedispatchOnCondition(
	ReidemeisterClasses,
	true,
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0
);
