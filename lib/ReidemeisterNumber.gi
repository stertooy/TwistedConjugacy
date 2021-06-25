###############################################################################
##
## ReidemeisterNumber( hom1, hom2 )
##
InstallMethod(
	ReidemeisterNumber,
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
		Coin := CoincidenceGroup( hom1, hom2 );
		return Size( G ) / Size( H ) * Size( Coin );
	end
);

InstallMethod(
	ReidemeisterNumber,
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


###############################################################################
##
## ReidemeisterNumber( endo )
##
InstallOtherMethod(
	ReidemeisterNumber,
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo )
		local G;
		G := Range( endo );
		return ReidemeisterNumber( endo, IdentityMapping( G ) );
	end
);

RedispatchOnCondition(
	ReidemeisterNumber,
	true,
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0
);
