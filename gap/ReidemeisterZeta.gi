###############################################################################
##
## ReidemeisterZetaCoefficients( endo )
##
InstallMethod(
	ReidemeisterZetaCoefficients,
	"for finite groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo )
		local G, H, endoR, L;
		H := Source( endo );
		if not IsFinite( H ) then
			TryNextMethod();
		fi;
		G := fail;
		while H <> G do
			G := H;
			H := Image( endo, G );
		od;
		L := List( [ 1..Order( RestrictedMapping( endo, G ) ) ],
			n -> ReidemeisterNumber( endo^n )
		);
		return RemovePeriodsList@( L );
	end
);

RedispatchOnCondition(
	ReidemeisterZetaCoefficients,
	true, 
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0
);


###############################################################################
##
## ReidemeisterZeta( endo )
##
InstallMethod(
	ReidemeisterZeta,
	"for finite groups", 
	[ IsGroupHomomorphism and IsEndoGeneralMapping ], 
	function ( endo )
		local L;
		if not IsFinite( Source( endo ) ) then
			TryNextMethod();
		fi;
		L := DecomposePeriodicList@( ReidemeisterZetaCoefficients( endo ) );
		return function ( z )
			local zeta, i, ci;
			zeta := 1;
			for i in [ 1..Length( L ) ] do
				ci := L[i];
				if ci <> 0 then
					zeta := zeta*( 1-z^i )^-ci;
				fi;
			od;
			return zeta;
		end;
	end
);

RedispatchOnCondition(
	ReidemeisterZeta,
	true, 
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0
);


###############################################################################
##
## PrintReidemeisterZeta( endo )
##
InstallMethod(
	PrintReidemeisterZeta,
	"for finite groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo )
		local L, zeta, i, ci;
		if not IsFinite( Source( endo ) ) then
			TryNextMethod();
		fi;
		L := DecomposePeriodicList@( ReidemeisterZetaCoefficients( endo ) );
		zeta := "";
		for i in [1..Length( L )] do
			ci := L[i];
			if ci <> 0 then
				if zeta <> "" then
					zeta := Concatenation( zeta, " * " );
				fi;
				zeta := Concatenation( 
					zeta, "( 1-z^", PrintString( i ), 
					" )^-", PrintString( ci )
				);
			fi;
		od;
		return zeta;
	end
);

RedispatchOnCondition(
	PrintReidemeisterZeta,
	true, 
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0
);
