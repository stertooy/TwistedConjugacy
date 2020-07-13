###############################################################################
##
## ReidemeisterNumber( hom1, hom2 )
##
InstallMethod(
	ReidemeisterNumber,
	"by counting Reidemeister classes",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	0,
	function ( hom1, hom2 )
		local Rcl;
		Rcl := ReidemeisterClasses( hom1, hom2 );
		if Rcl <> fail then
			return Size( Rcl );
		else
			return infinity;
		fi;
	end
);

InstallMethod(
	ReidemeisterNumber,
	"for finite groups with abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	1,
	function ( hom1, hom2 )
		local G, H, Rcl;
		H := Source( hom1 );
		G := Range( hom1 );
		if not IsFinite( G ) or not IsFinite( H ) or
			not IsAbelian( G ) then
			TryNextMethod();
		fi;
		return Size( G ) / Size( H ) * Size( CoincidenceGroup( hom1, hom2 ) );
	end
);

InstallMethod(
	ReidemeisterNumber,
	"for pcp-groups with abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	20,
	function ( hom1, hom2 )
		local G, H;
		H := Source( hom1 );
		G := Range( hom1 );
		if not IsPcpGroup( H ) or not IsPcpGroup( G ) or 
			not IsAbelian( G ) then
			TryNextMethod();
		fi;
		return IndexNC( G, Image(
			DifferenceGroupHomomorphisms@( hom1, hom2 )
		));
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
		return ReidemeisterNumber( endo, IdentityMapping( Source( endo ) ) );
	end
);

RedispatchOnCondition(
	ReidemeisterNumber,
	true, 
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	999
);
