###############################################################################
##
## ReidemeisterNumber( hom1, arg... )
##
InstallGlobalFunction(
	ReidemeisterNumber,
	function ( arg... )
		return CallFuncList( ReidemeisterNumberOp, arg );
	end
);


###############################################################################
##
## ReidemeisterNumberOp( hom1, hom2 )
##
InstallMethod(
	ReidemeisterNumberOp,
	"for finite source and finite abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( hom1, hom2 )
		local G, H, Coin;
		G := Range( hom1 );
		H := Source( hom1 );
		if  (
			not IsFinite( H ) or
			not IsFinite( G ) or
			not IsAbelian( G )
		) then TryNextMethod(); fi;
		Coin := CoincidenceGroup2( hom1, hom2 );
		return Size( G ) * Size( Coin ) / Size( H );
	end
);

InstallMethod(
	ReidemeisterNumberOp,
	"by counting Reidemeister classes",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	0,
	function ( hom1, hom2 )
		local Rcl;
		Rcl := RepresentativesReidemeisterClasses( hom1, hom2 );
		if Rcl <> fail then
			return Size( Rcl );
		else
			return infinity;
		fi;
	end
);

InstallOtherMethod(
	ReidemeisterNumberOp,
	"for finite non-abelian groups",
	[ IsGroupHomomorphism ],
	1,
	function ( endo )
		local G, cc; 
		G := Source( endo );
		if not (
			IsFinite( G ) and
			IsAbelian( G ) and
			HasConjugacyClasses( G )
		) then TryNextMethod(); fi; 
		cc := ShallowCopy( ConjugacyClasses( G ) );
		Remove( cc, 1 );
		return 1 + Number( cc, c -> ImagesRepresentative( 
			endo, 
			Representative( c )
		) in AsList( c ) );
	end
);

InstallOtherMethod(
	ReidemeisterNumberOp,
	"default to two-agument version",
	[ IsGroupHomomorphism ],
	0,
	function ( endo )
		local G, id; 
		G := Source( endo );
		id := IdentityMapping( G );
		return ReidemeisterNumberOp( endo, id );
	end
);
