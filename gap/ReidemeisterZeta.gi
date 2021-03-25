###############################################################################
##
## ReidemeisterZetaCoefficients( endo1, endo2 )
##
InstallMethod( 
	ReidemeisterZetaCoefficients,
	"for finite groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ],
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
		L1 := List( [1..offset], n -> ReidemeisterNumber( endo1^n, endo2^n ) );
		L2 := RemovePeriodsList@(
			List( [1+offset..offset+order], n -> ReidemeisterNumber( endo1^n, endo2^n ) )
		);
		while not IsEmpty( L1 ) and L2[ Length( L2 ) ] = L1[ Length( L1 ) ] do
		   Remove( L1 );
		   L2 := Concatenation( [ Remove( L2 ) ], L2 );
		od;
		return [ L1, L2 ];
	end
);

RedispatchOnCondition(
	ReidemeisterZetaCoefficients,
	true, 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	[ IsEndoGeneralMapping, IsEndoGeneralMapping ],
	0
);
	
	
###############################################################################
##
## ReidemeisterZetaCoefficients( endo )
##
InstallOtherMethod(
	ReidemeisterZetaCoefficients,
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo )
		return ReidemeisterZetaCoefficients( 
			endo,
			IdentityMapping( Source( endo ) )
		);
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
## HasRationalReidemeisterZeta( endo1, endo2 )
##
InstallMethod( 
	HasRationalReidemeisterZeta,
	"for finite groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ], 
	function ( endo1, endo2 )
		local coeffs, L;
		if not IsFinite( Source( endo1 ) ) then
			TryNextMethod();
		fi;
		coeffs := ReidemeisterZetaCoefficients( endo1, endo2 );
		if not IsEmpty( coeffs[1] ) then
			return false;
		fi;
		L := DecomposePeriodicList@( coeffs[2] );
		if L = fail then
			return false;
		fi;
		return true;
	end
);

RedispatchOnCondition( 
	HasRationalReidemeisterZeta,
	true, 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	[ IsEndoGeneralMapping, IsEndoGeneralMapping ],
	0
);
	
###############################################################################
##
## HasRationalReidemeisterZeta( endo )
##
InstallOtherMethod(
	HasRationalReidemeisterZeta,
	[ IsGroupHomomorphism and IsEndoGeneralMapping ],
	function ( endo )
		return HasRationalReidemeisterZeta( 
			endo,
			IdentityMapping( Source( endo ) )
		);
	end
);

RedispatchOnCondition(
	HasRationalReidemeisterZeta,
	true, 
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0
);


###############################################################################
##
## ReidemeisterZeta( endo1, endo2 )
##
InstallMethod( 
	ReidemeisterZeta,
	"for finite groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ], 
	function ( endo1, endo2 )
		local coeffs, i, L;
		if not IsFinite( Source( endo1 ) ) then
			TryNextMethod();
		fi;
		coeffs := ReidemeisterZetaCoefficients( endo1, endo2 );
		if not IsEmpty( coeffs[1] ) then
			TryNextMethod();
		fi;
		L := DecomposePeriodicList@( coeffs[2] );
		if L = fail then
			TryNextMethod();
		fi;
		return function ( s )
			local zeta, i, ci, summand;
			zeta := 1;
			for i in [1..Length( L )] do
				ci := L[i];
				if ci <> 0 then
					zeta := zeta*( 1-s^i )^-ci;
				fi;
			od;
			return zeta;
		end;
	end
);

RedispatchOnCondition(
	ReidemeisterZeta,
	true, 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	[ IsEndoGeneralMapping, IsEndoGeneralMapping ],
	0
);
	
###############################################################################
##
## ReidemeisterZeta( endo )
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
InstallMethod(
	PrintReidemeisterZeta,
	"for finite groups",
	[ IsGroupHomomorphism and IsEndoGeneralMapping,
	  IsGroupHomomorphism and IsEndoGeneralMapping ], 
	function ( endo1, endo2 )
		local P, Q, L, coeffs, k, w, coeff, factors, powers, factor, power, zeta, i, summand, const;
		if not IsFinite( Source( endo1 ) ) then
			TryNextMethod();
		fi;
		coeffs := ReidemeisterZetaCoefficients( endo1, endo2 );
		Q := coeffs[1];
		P := coeffs[2];
		for i in [1..Length( Q )] do
			P := Concatenation( [ Remove( P ) ], P );
		od;
		Q := List( [1..Length( Q )], i -> Q[i] - P[(i-1) mod Length( P ) + 1] );
		if not IsEmpty( Q ) then
			summand := "";
			for i in [1..Length( Q )] do
				if Q[i] = 0 then
					continue;
				fi;
				if summand <> "" and Q[i] > 0 then
					summand := Concatenation( summand, "+" );
				elif Q[i] < 0 then
					summand := Concatenation( summand, "-" );
				fi;
				coeff := AbsInt( Q[i] )/i;
				if coeff = 1 then
					summand := Concatenation( summand, "s" );
				else
					summand := Concatenation( summand, PrintString( coeff ), "*s" );
				fi;
				if i <> 1 then
					summand := Concatenation( summand, "^", PrintString( i ) );
				fi;
			od;
			zeta := Concatenation( "exp(", summand, ")" );
		else
			zeta := "";
		fi;
		factors := [];
		powers := [];
		L := DecomposePeriodicList@TwistedConjugacy( P );
		if L = fail then
			k := Length( P );
			for w in List( [0..k-1], i -> E(k)^i ) do
				power := - Sum( [1..k], i -> P[i]*w^i )/k;
				if power = 0 then
					continue;
				fi;
				const := 1/w;
				factor := "";
				if const = -1 then
					factor := Concatenation( factor, "1+s" );
				elif const = 1 then
					factor := Concatenation( factor, "1-s" );
				elif PrintString( const )[1] = '-' then
					factor := Concatenation( factor, "1+", PrintString( -const ), "*s" );
				else
					factor := Concatenation( factor, "1-", PrintString( const ), "*s" );
				fi;
				Add( factors, factor );
				Add( powers, power );
			od;
		else
			for i in [1..Length( L )] do
				power := -L[i];
				if power = 0 then
					continue;
				fi;
				factor := "1-s";
				if i > 1 then
					factor := Concatenation( factor, "^", PrintString( i ) );
				fi;
				Add( factors, factor );
				Add( powers, power );
			od;
		fi;
		for i in [1..Length( factors )] do
			if zeta <> "" then
				zeta := Concatenation( zeta, "*" );
			fi;
			zeta := Concatenation( zeta, "(", factors[i], ")" );
			if not IsPosInt( powers[i] ) then
				zeta := Concatenation( zeta, "^(", PrintString( powers[i] ), ")" );
			elif powers[i] <> 1 then
				zeta := Concatenation( zeta, "^", PrintString( powers[i] ) );
			fi;
		od;
		return zeta;
	end
);


RedispatchOnCondition(
	PrintReidemeisterZeta,
	true, 
	[ IsGroupHomomorphism, IsGroupHomomorphism ],
	[ IsEndoGeneralMapping, IsEndoGeneralMapping ],
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
		return PrintReidemeisterZeta( 
			endo, 
			IdentityMapping( Source( endo ) ) 
		);
	end
);

RedispatchOnCondition(
	PrintReidemeisterZeta,
	true, 
	[ IsGroupHomomorphism ],
	[ IsEndoGeneralMapping ],
	0
);
