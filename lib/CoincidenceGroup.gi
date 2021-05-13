###############################################################################
##
## CoincidenceGroup( hom1, hom2 )
##
InstallMethod(
	CoincidenceGroup,
	"for trivial range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	7,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsTrivial( G ) then
			TryNextMethod();
		fi;
		return H;
	end
);

InstallMethod(
	CoincidenceGroup,
	"for finite source",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	6,
	function ( hom1, hom2 )
		local G, H, tc;
		G := Range( hom1 );
		H := Source( hom1 );
		if not IsFinite( H ) then
			TryNextMethod();
		fi;
		tc := TwistedConjugation( hom1, hom2 );
		return Stabilizer( H, One( G ), tc );
	end
);


###############################################################################
##
## FixedPointGroup( endo )
##
InstallMethod(
	FixedPointGroup,
	"for infinite polycyclic groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	0,
	function ( endo )
		local G;
		G := Range( endo );
		return CoincidenceGroup( endo, IdentityMapping( G ) );
	end
);

RedispatchOnCondition(
	FixedPointGroup,
	true, 
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0
);
