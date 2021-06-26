###############################################################################
##
## ReidemeisterNumber( hom1, arg... )
##
InstallGlobalFunction(
	ReidemeisterNumber,
	function ( hom1, arg... )
		local G, hom2;
		G := Range( hom1 );
		if Length( arg ) = 0 then
			hom2 := IdentityMapping( G );
		else
			hom2 := arg[1];
		fi;
		return ReidemeisterNumberOp( hom1, hom2 );
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
		) then
			TryNextMethod();
		fi;
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
