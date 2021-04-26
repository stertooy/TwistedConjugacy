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
		homs := GroupHomomorphismsOfReidemeisterClass( tcc );
		return IndexNC( H, CoincidenceGroup(
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
		homs := GroupHomomorphismsOfReidemeisterClass( tcc );
		g := Representative( tcc );
		Coin := CoincidenceGroup(
			homs[1] * InnerAutomorphismNC( G, g^-1 ),
			homs[2]
		);
		if IndexNC( H, Coin ) = infinity then
			return fail;
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
	"for finite source and range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	5,
	function ( hom1, hom2 )
		local G, H, Rcl, orbit;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsFinite( H ) or
			not IsFinite( G )
		) then
			TryNextMethod();
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
