###############################################################################
##
## ReidemeisterZetaCoefficients( endo1, endo2 )
##
InstallMethod( ReidemeisterZetaCoefficients, "for finite groups",
	[IsGroupHomomorphism and IsEndoGeneralMapping,
	 IsGroupHomomorphism and IsEndoGeneralMapping],
	function ( endo1, endo2 )
		local G, G1, G2, steps, order, offset, L1, L2;
		G := Source( endo1 );
		if not IsFinite( G ) then
			TryNextMethod();
		fi;
		# Start first endomorphism
		G1 := fail;
		G2 := G;
		steps := -1;
		while G1 <> G2 do
			steps := steps + 1;
			G1 := G2;
			G2 := Image( endo1, G1 );
		od;
		order := Order( RestrictedMapping( endo1, G1 ) );
		offset := steps;
		# Start second endomorphism
		G1 := fail;
		G2 := G;
		steps := -1;
		while G1 <> G2 do
			steps := steps + 1;
			G1 := G2;
			G2 := Image( endo2, G1 );
		od;
		order := LcmInt( order, Order( RestrictedMapping( endo2, G1 ) ) );
		offset := Maximum( offset, steps );
		# TODO: improve calculation of powers of endo1 and endo2
		L1 := List([1..offset], n -> ReidemeisterNumber( endo1^n, endo2^n ) );
		L2 := RemovePeriodsList@(
			List([1+offset..offset+order], n -> ReidemeisterNumber( endo1^n, endo2^n ) )
		);
		while not IsEmpty( L1 ) and L2[ Length( L2 ) ] = L1[ Length( L1 ) ] do
		   Remove( L1 );
		   L2 := Concatenation( [ Remove( L2 ) ], L2 );
		od;
		return [L1,L2];
	end
);

RedispatchOnCondition( ReidemeisterZetaCoefficients, true, 
	[IsGroupHomomorphism, IsGroupHomomorphism],
	[IsEndoGeneralMapping, IsEndoGeneralMapping], 0 );
	
###############################################################################
##
## ReidemeisterZetaCoefficients( endo )
##
InstallOtherMethod(
	ReidemeisterZetaCoefficients,
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo )
		return ReidemeisterZetaCoefficients( endo, IdentityMapping( Source( endo ) ) );
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
## ReidemeisterZeta( endo1, endo2 )
##
InstallMethod( ReidemeisterZeta, "for finite groups", 
	[IsGroupHomomorphism and IsEndoGeneralMapping,
	 IsGroupHomomorphism and IsEndoGeneralMapping], 
	function ( endo1, endo2 )
		local coeffs, L1, L2, i, L;
		if not IsFinite( Source( endo1 ) ) then
			TryNextMethod();
		fi;
		coeffs := ReidemeisterZetaCoefficients( endo1, endo2 );
		L1 := coeffs[1];
		L2 := coeffs[2];
		for i in [1..Length(L1)] do
			L2 := Concatenation( [ Remove( L2 ) ], L2 );
		od;
		L1 := List( [1..Length(L1)], i -> L1[i] - L2[(i-1) mod Length(L2) + 1] );
		L := DecomposePeriodicList@( L2 );
		if L = fail then
			TryNextMethod();
		fi;
		return function ( z )
			local zeta, i, ci, summand;
			if not IsEmpty( L1 ) then
				summand := 0;
				for i in [1..Length(L1)] do
					summand := summand + L1[i]/i*z^i;
				od;
				zeta := Exp( Float( summand ) );
			else
				zeta := 1;
			fi;
			for i in [1..Length( L )] do
				ci := L[i];
				if ci <> 0 then
					zeta := zeta*( 1-z^i )^-ci;
				fi;
			od;
			return zeta;
		end;
	end
);

RedispatchOnCondition( ReidemeisterZeta,
	true, 
	[IsGroupHomomorphism, IsGroupHomomorphism],
	[IsEndoGeneralMapping, IsEndoGeneralMapping],
	0
);
	
###############################################################################
##
## PrintReidemeisterZeta( endo )
##
InstallOtherMethod(
	ReidemeisterZeta,
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo )
		return ReidemeisterZeta( endo, IdentityMapping( Source( endo ) ) );
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
## PrintReidemeisterZeta( endo1, endo2 )
##
InstallMethod( PrintReidemeisterZeta, "for finite groups",
	[IsGroupHomomorphism and IsEndoGeneralMapping,
	 IsGroupHomomorphism and IsEndoGeneralMapping], 
	function ( endo1, endo2 )
		local coeffs, L1, L2, L, zeta, i, summand, ci;
		if not IsFinite( Source( endo1 ) ) then
			TryNextMethod();
		fi;
		coeffs := ReidemeisterZetaCoefficients( endo1, endo2 );
		L1 := coeffs[1];
		L2 := coeffs[2];
		for i in [1..Length(L1)] do
			L2 := Concatenation( [ Remove( L2 ) ], L2 );
		od;
		L1 := List( [1..Length(L1)], i -> L1[i] - L2[(i-1) mod Length(L2) + 1] );
		L := DecomposePeriodicList@( L2 );
		if L = fail then
			TryNextMethod();
		fi;
		if not IsEmpty( L1 ) then
			summand := "";
			for i in [1..Length(L1)] do
				if L1[i] = 0 then
					continue;
				fi;
				if summand <> "" and L1[i] > 0 then
					summand := Concatenation( summand, "+" );
				elif L1[i] < 0 then
					summand := Concatenation( summand, "-" );
				fi;
				summand := Concatenation( summand, PrintString( AbsInt( L1[i] )/i ), "z" );
				if i <> 1 then
					summand := Concatenation( summand, "^", PrintString( i ) );
				fi;
			od;
			zeta := Concatenation("e^(",summand,")");
		else
			zeta := "";
		fi;
		for i in [1..Length( L )] do
			ci := L[i];
			if ci <> 0 then
				if zeta <> "" then
					zeta := Concatenation( zeta, " * " );
				fi;
				zeta := Concatenation( zeta, "(1-z");
				if i <> 1 then
					zeta := Concatenation( zeta, "^", PrintString( i ) );
				fi;
				zeta := Concatenation( zeta, ")");
				if ci < 0 and ci <> -1 then
					zeta := Concatenation( zeta, "^", PrintString( -ci ) );
				elif ci > 0 then
					zeta := Concatenation( zeta, "^-", PrintString( ci ) );
				fi;
			fi;
		od;
		return zeta;
	end
);


RedispatchOnCondition( PrintReidemeisterZeta,
	true, 
	[IsGroupHomomorphism, IsGroupHomomorphism],
	[IsEndoGeneralMapping, IsEndoGeneralMapping],
	0
);
	
###############################################################################
##
## PrintReidemeisterZeta( endo )
##
InstallOtherMethod(
	PrintReidemeisterZeta,
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo )
		return PrintReidemeisterZeta( endo, IdentityMapping( Source( endo ) ) );
	end
);

RedispatchOnCondition(
	PrintReidemeisterZeta,
	true, 
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0
);
