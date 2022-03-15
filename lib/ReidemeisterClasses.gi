###############################################################################
##
## ReidemeisterClass( hom1, x, arg... )
##
InstallGlobalFunction(
	ReidemeisterClass,
	function ( hom1, x, arg... )
		local G, H, hom2, g, tc, tcc;
		G := Range( hom1 );
		H := Source( hom1 );
		if Length( arg ) = 0 then
			hom2 := IdentityMapping( G );
			g := x;
		else
			hom2 := x;
			g := arg[1];
		fi;
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
		local homs, homStrings, g, hom, homGensImgs;
		homs := GroupHomomorphismsOfReidemeisterClass( tcc );
		homStrings := [];
		g := Representative( tcc );
		for hom in homs do
			homGensImgs := MappingGeneratorsImages( hom );
			Add( homStrings, Concatenation( 
				String( homGensImgs[1] ),
				" -> ",
				String( homGensImgs[2] )
			));
		od;
		Print(
			"ReidemeisterClass( [ ",
			PrintString( homStrings[1] ),
			", ",
			PrintString( homStrings[2] ),
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
		local H, Coin;
		H := ActingDomain( tcc );
		Coin := StabilizerOfExternalSet( tcc );
		return IndexNC( H, Coin );
	end
);

InstallMethod(
	ListOp,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		local H, Coin, g, tc;
		if Size( tcc ) = infinity then
			return fail;
		fi;
		H := ActingDomain( tcc );
		Coin := StabilizerOfExternalSet( tcc );
		g := Representative( tcc );
		tc := FunctionAction( tcc );
		return List(
			RightTransversal( H, Coin ),
			h -> tc( g, h )
		);
	end
);

InstallMethod(
	StabilizerOfExternalSet,
	"for Reidemeister classes",
	[ IsReidemeisterClassGroupRep ],
	function ( tcc )
		local g, hom, G, inn;
		g := Representative( tcc );
		hom := GroupHomomorphismsOfReidemeisterClass( tcc );
		G := Range( hom[1] );
		inn := InnerAutomorphismNC( G, g^-1 );
		return CoincidenceGroup2( hom[1]*inn, hom[2] );
	end
);


###############################################################################
##
## ReidemeisterClasses( hom1, arg... )
##
InstallGlobalFunction(
	ReidemeisterClasses,
	function ( hom1, arg... )
		local G, hom2, Rcl;
		G := Range( hom1 );
		if Length( arg ) = 0 then
			hom2 := IdentityMapping( G );
		else
			hom2 := arg[1];
		fi;
		Rcl := RepresentativesReidemeisterClasses( hom1, hom2 );
		if Rcl = fail then
			return fail;
		fi;
		return List( Rcl, g -> ReidemeisterClass( hom1, hom2, g ) );
	end
);


###############################################################################
##
## RepresentativesReidemeisterClasses( hom1, hom2 )
##
InstallMethod(
	RepresentativesReidemeisterClasses,
	"for trivial range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	6,
	function ( hom1, hom2 )
		local G;
		G := Range( hom1 );
		if not IsTrivial( G ) then TryNextMethod(); fi;
		return [ One( G ) ];
	end
);

InstallMethod(
	RepresentativesReidemeisterClasses,
	"for finite source",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	5,
	function ( hom1, hom2 )
		local G, H, Rcl, tc, G_List, gens, orbits, foundOne, orbit;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsFinite( H ) then TryNextMethod(); fi;
		if not IsFinite( G ) then
			return fail;
		fi;
		Rcl := [];
		tc := TwistedConjugation( hom1, hom2 );
		G_List := AsSSortedListNonstored( G );
        gens := SmallGeneratingSet( H );
		orbits := OrbitsDomain( H, G_List, gens, gens, tc );
		foundOne := false;
		for orbit in orbits do
			if ( not foundOne ) and One( G ) in orbit then
				Add( Rcl, One( G ), 1 );
				foundOne := true;
			else
				Add( Rcl, orbit[1] );
			fi;
		od;
		return Rcl;
	end
);
