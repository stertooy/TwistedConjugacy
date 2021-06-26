###############################################################################
##
## ReidemeisterSpectrum( G )
##
InstallGlobalFunction(
	ReidemeisterSpectrum,
	function ( G )
		return ReidemeisterSpectrumOp( G );
	end
);


###############################################################################
##
## ReidemeisterSpectrumOp( G )
##
InstallMethod(
	ReidemeisterSpectrumOp,
	"for finite abelian groups",
	[ IsGroup and IsFinite and IsAbelian ],
	function ( G )
		local inv, invOdd, invEven, occ, singleOcc, Aut, Aut_reps, productOdd,
			productEven, specOdd, specEven;
		inv := AbelianInvariants( G );
		invOdd := Filtered( inv, IsOddInt );
		invEven := Filtered( inv, IsEvenInt );
		if IsEmpty( invOdd ) and IsEmpty( invEven ) then
			return [1];
		elif IsEmpty( invOdd ) then
			occ := TransposedMat( Collected( invEven ) )[2];
			singleOcc := Filtered( occ, IsOne );
			if IsEmpty( singleOcc ) then
				return DivisorsInt( Product( invEven ) );
			fi;
			Aut := AutomorphismGroup( G );
			Aut_reps := List( ConjugacyClasses( Aut ), Representative );
			return Set( Aut_reps, ReidemeisterNumber );
		elif IsEmpty( invEven ) then
			return DivisorsInt( Product( invOdd ) );
		else
			productOdd := DirectProduct( List( invOdd, CyclicGroup ) );
			productEven := DirectProduct( List( invEven, CyclicGroup ) );
			specOdd := ReidemeisterSpectrumOp( productOdd );
			specEven := ReidemeisterSpectrumOp( productEven );
			return Set( Cartesian( specOdd, specEven ), Product );
		fi;
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
		Out := Range( p );
		Out_reps := List( ConjugacyClasses( Out ), Representative );
		Aut_reps := List( Out_reps, r -> PreImagesRepresentative( p, r ) );
		return Set( Aut_reps, ReidemeisterNumber );
	end
);

RedispatchOnCondition(
	ReidemeisterSpectrumOp,
	true,
	[ IsGroup ],
	[ IsFinite ],
	0
);


###############################################################################
##
## ExtendedReidemeisterSpectrum( G )
##
InstallGlobalFunction(
	ExtendedReidemeisterSpectrum,
	function ( G )
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
		local End_reps, id;
		End_reps := AllHomomorphismClasses( G, G );
		id := IdentityMapping( G );
		return Set( End_reps, endo -> ReidemeisterNumberOp( endo, id ) );
	end
);

RedispatchOnCondition(
	ExtendedReidemeisterSpectrumOp,
	true,
	[ IsGroup ],
	[ IsFinite ],
	0
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
			else
				return CoincidenceReidemeisterSpectrumOp( H, H );
			fi;
		else
			G := arg[1];
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
		Hom_reps := AllHomomorphismClasses( H, G );
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
		Hom_reps := AllHomomorphismClasses( H, G );
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

RedispatchOnCondition(
	CoincidenceReidemeisterSpectrumOp,
	true,
	[ IsGroup, IsGroup ],
	[ IsGroup, IsFinite ],
	0
);
