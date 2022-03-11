###############################################################################
##
## ReidemeisterSpectrum( G )
##
InstallGlobalFunction(
	ReidemeisterSpectrum,
	function ( G )
		IsFinite( G );
		IsAbelian( G );
		return ReidemeisterSpectrumOp( G );
	end
);


###############################################################################
##
## ReidemeisterSpectrumOp( G )
##
InstallMethod(
	ReidemeisterSpectrumOp,
	"for finite abelian groups of odd order",
	[ IsGroup and IsFinite and IsAbelian ],
	2,
	function ( G )
		local ord;
		ord := Size( G );
		if IsEvenInt( ord ) then
			TryNextMethod();
		fi;
		return DivisorsInt( ord );
	end
);

InstallMethod(
	ReidemeisterSpectrumOp,
	"for finite abelian 2-groups",
	[ IsGroup and IsFinite and IsAbelian ],
	1,
	function ( G )
		local ord, pow, inv, m, fac;
		ord := Size( G );
		pow := Log2Int( ord );
		if ord <> 2^pow then
			TryNextMethod();
		fi;
		inv := Collected( AbelianInvariants( G ) );
		inv := List( Filtered( inv, x -> x[2] = 1 ), y -> y[1] );
		m := 0;
		while not IsEmpty( inv ) do
			fac := Remove( inv, 1 );
			if not IsEmpty( inv ) and fac*2 = inv[1] then
				Remove( inv );
			fi;
			m := m+1;
		od;
		return List( [m..pow], x -> 2^x );
	end
);

InstallMethod(
	ReidemeisterSpectrumOp,
	"for finite abelian groups",
	[ IsGroup and IsFinite and IsAbelian ],
	0,
	function ( G )
		local inv, invEven, invOdd, ordEven, ordOdd, H, specEven, specOdd;
		inv := AbelianInvariants( G );
		invEven := Filtered( inv, IsEvenInt );
		invOdd := Filtered( inv, IsOddInt );
		ordEven := Product( invEven );
		ordOdd := Product( invOdd );
		H := AbelianGroupCons( IsPcGroup, invEven );
		specEven := ReidemeisterSpectrumOp( H );
		specOdd := DivisorsInt( ordOdd );
		return Set( Cartesian( specEven, specOdd ), Product );
	end
);

InstallMethod(
	ReidemeisterSpectrumOp,
	"for finite groups",
	[ IsGroup and IsFinite ],
	function ( G )
		local Aut, Inn, p, Out, Out_reps, Aut_reps;
		Aut := AutomorphismGroup( G );
		Inn := InnerAutomorphismsAutomorphismGroup( Aut );
		p := NaturalHomomorphismByNormalSubgroupNC( Aut, Inn );
        Out := ImagesSource( p );
		Out_reps := List( ConjugacyClasses( Out ), Representative );
		Aut_reps := List( Out_reps, r -> PreImagesRepresentative( p, r ) );
		return Set( Aut_reps, ReidemeisterNumber );
	end
);


###############################################################################
##
## ExtendedReidemeisterSpectrum( G )
##
InstallGlobalFunction(
	ExtendedReidemeisterSpectrum,
	function ( G )
		IsFinite( G );
		IsAbelian( G );
		return ExtendedReidemeisterSpectrumOp( G );
	end
);


###############################################################################
##
## ExtendedReidemeisterSpectrumOp( G )
##
InstallMethod(
	ExtendedReidemeisterSpectrumOp,
	"for finite abelian groups",
	[ IsGroup and IsFinite and IsAbelian ],
	function ( G )
		return DivisorsInt( Size( G ) );
	end
);

InstallMethod(
	ExtendedReidemeisterSpectrumOp,
	"for finite groups",
	[ IsGroup and IsFinite ],
	function ( G )
		local R, id, End_reps;
		id := IdentityMapping( G );
		End_reps := RepresentativesEndomorphismClasses( G );
		return Set( End_reps, endo -> ReidemeisterNumberOp( endo, id ) );
	end
);


###############################################################################
##
## CoincidenceReidemeisterSpectrum( H, ... )
##
InstallGlobalFunction(
	CoincidenceReidemeisterSpectrum,
	function ( H, arg... )
		local G;
		if Length( arg ) = 0 then
			if IsAbelian( H ) then
				return ExtendedReidemeisterSpectrumOp( H );
			fi;
			G := H;
		else
			G := arg[1];
			IsFinite( G );
			IsAbelian( G );
		fi;
		return CoincidenceReidemeisterSpectrumOp( H, G );
	end
);


###############################################################################
##
## CoincidenceReidemeisterSpectrum( H, G )
##
InstallMethod(
	CoincidenceReidemeisterSpectrumOp,
	"for finite abelian range",
	[ IsGroup, IsGroup and IsFinite and IsAbelian ],
	function ( H, G )
		local Hom_reps, SpecR, hom1, hom2, R;
		Hom_reps := RepresentativesHomomorphismClasses( H, G );
		SpecR := [];
		hom1 := Hom_reps[1];
		for hom2 in Hom_reps do
			R := ReidemeisterNumberOp( hom1, hom2 );
			AddSet( SpecR, R );
		od;
		return SpecR;
	end
);

InstallMethod(
	CoincidenceReidemeisterSpectrumOp,
	"for finite range",
	[ IsGroup, IsGroup and IsFinite ],
	function ( H, G )
		local Hom_reps, SpecR, hom1, hom2, R;
		Hom_reps := RepresentativesHomomorphismClasses( H, G );
		SpecR := [];
		for hom1 in Hom_reps do
			for hom2 in Hom_reps do
				R := ReidemeisterNumberOp( hom1, hom2 );
				AddSet( SpecR, R );
			od;
		od;
		return SpecR;
	end
);
