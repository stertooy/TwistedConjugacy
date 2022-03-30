###############################################################################
##
## ReidemeisterNumberOp( hom1, hom2 )
##
InstallMethod(
	ReidemeisterNumberOp,
	"for polycyclic source and (polycyclic nilpotent-by-)finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if not (
			IsPcpGroup( H ) and
			(
				IsPcpGroup( G ) and IsNilpotentByFinite( G ) or
				IsFinite( G )
			) and
			HirschLength( H ) < HirschLength( G )
		) then TryNextMethod(); fi;
		return infinity;
	end
);
