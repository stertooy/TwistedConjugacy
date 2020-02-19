###############################################################################
##
## ReidemeisterNumber( hom1, hom2 )
##
InstallMethod( ReidemeisterNumber, [IsGroupHomomorphism, IsGroupHomomorphism],
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


###############################################################################
##
## ReidemeisterNumber( endo )
##
InstallOtherMethod( ReidemeisterNumber, [IsGroupHomomorphism and IsEndoGeneralMapping],
	function ( endo )
		return ReidemeisterNumber( endo, IdentityMapping( Source( endo ) ) );
	end
);

RedispatchOnCondition( ReidemeisterNumber, true, 
	[IsGroupHomomorphism],
	[IsEndoGeneralMapping], 0 );
