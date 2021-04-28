###############################################################################
##
## ReidemeisterNumber( hom1, hom2 )
##
InstallMethod(
	ReidemeisterNumber,
	"for polycyclic source and (polycyclic nilpotent-by-)finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if (
			not IsPcpGroup( H ) or
			not ( 
				IsPcpGroup( G ) and IsNilpotentByFinite( G ) or
				IsFinite( G )
			) or
			HirschLength( H ) >= HirschLength( G )
		) then
			TryNextMethod();
		fi;
		return infinity;
	end
);

InstallMethod(
	ReidemeisterNumber,
	"for infinite polycyclic source and infinite abelian range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	2,
	function ( hom1, hom2 )
		local G, H, diff, N;
		H := Source( hom1 );
		G := Range( hom1 );
		if (
			not IsPcpGroup( H ) or
			not IsPcpGroup( G ) or
			not IsAbelian( G )
		) then
			TryNextMethod();
		fi;
		diff := DifferenceGroupHomomorphisms@( hom1, hom2 );
		N := Image( diff );
		return IndexNC( G, N );
	end
);
