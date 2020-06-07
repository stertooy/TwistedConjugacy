###############################################################################
##
## FixedPointGroup( endo )
##
InstallMethod( FixedPointGroup, [IsGroupHomomorphism and IsEndoGeneralMapping],
	function ( endo )
		return CoincidenceGroup( endo, IdentityMapping( Source( endo ) ) );
	end
);

RedispatchOnCondition( FixedPointGroup, true, 
	[IsGroupHomomorphism], [IsEndoGeneralMapping], 0 );


###############################################################################
##
## CoincidenceGroup( hom1, hom2 )
##
InstallMethod( CoincidenceGroup, "for abelian range", 
	[IsGroupHomomorphism, IsGroupHomomorphism], 1,
	function ( hom1, hom2 )
		if not IsAbelian( Range( hom1 ) ) then
			TryNextMethod();
		fi;
		return Kernel( DifferenceGroupHomomorphisms@ ( hom1, hom2 ) );
	end
);

InstallMethod( CoincidenceGroup, "for finite source", 
	[IsGroupHomomorphism, IsGroupHomomorphism], 0,
	function ( hom1, hom2 )
		local H;
		H := Source( hom1 );
		if not IsFinite( H ) then
			TryNextMethod();
		fi;
		return SubgroupNC( H, Filtered( H, h -> h^hom1 = h^hom2 ) );
	end
);
