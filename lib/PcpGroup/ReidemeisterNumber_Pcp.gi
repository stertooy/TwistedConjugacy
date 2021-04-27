###############################################################################
##
## ReidemeisterNumber( hom1, hom2 )
##
InstallMethod(
	ReidemeisterNumber,
	"for polycyclic or finite source and nilpotent-by-finite range",
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	3,
	function ( hom1, hom2 )
		local G, H;
		G := Range( hom1 );
		H := Source( hom1 );
		if ((
				not IsPcpGroup( H ) and
				not IsFinite( H )
			) or
			not IsNilpotentByFinite( G ) or
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
		local G;
		G := Range( hom1 );
		if (
			not IsPcpGroup( Source( hom1 ) ) or
			not IsPcpGroup( G ) or
			not IsAbelian( G )
		) then
			TryNextMethod();
		fi;
		return IndexNC( G, Image(
			DifferenceGroupHomomorphisms@( hom1, hom2 )
		));
	end
);
