###############################################################################
##
## ReidemeisterSpectrum( G )
##
InstallMethod(
	ReidemeisterSpectrum,
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
			specOdd := ReidemeisterSpectrum( productOdd );
			specEven := ReidemeisterSpectrum( productEven );
			return Set( Cartesian( specOdd, specEven ), Product );
		fi;
	end
);

InstallMethod(
	ReidemeisterSpectrum,
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
	ReidemeisterSpectrum,
	true,
	[ IsGroup ],
	[ IsFinite ],
	0
);


###############################################################################
##
## ExtendedReidemeisterSpectrum( G )
##
InstallMethod(
	ExtendedReidemeisterSpectrum,
	"for finite abelian groups",
	[ IsGroup and IsFinite and IsAbelian ],
	function ( G )
		return DivisorsInt( Size( G ) );
	end
);

InstallMethod(
	ExtendedReidemeisterSpectrum,
	"for finite groups",
	[ IsGroup and IsFinite ],
	function ( G )
		local Hom_reps;
		Hom_reps := AllHomomorphismClasses( G, G );
		return Set( Hom_reps, ReidemeisterNumber );
	end
);

RedispatchOnCondition(
	ExtendedReidemeisterSpectrum,
	true,
	[ IsGroup ],
	[ IsFinite ],
	0
);


###############################################################################
##
## CoincidenceReidemeisterSpectrum( H, G )
##
InstallMethod(
	CoincidenceReidemeisterSpectrum,
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
	CoincidenceReidemeisterSpectrum,
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
	CoincidenceReidemeisterSpectrum,
	true,
	[ IsGroup, IsGroup ],
	[ IsGroup, IsFinite ],
	0
);


###############################################################################
##
## CoincidenceReidemeisterSpectrum( G )
##
InstallOtherMethod(
	CoincidenceReidemeisterSpectrum,
	[ IsGroup and IsFinite and IsAbelian ],
	function ( G )
		return ExtendedReidemeisterSpectrum( G );
	end
);

InstallOtherMethod(
	CoincidenceReidemeisterSpectrum,
	[ IsGroup and IsFinite ],
	function ( G )
		return CoincidenceReidemeisterSpectrum( G, G );
	end
);

RedispatchOnCondition(
	CoincidenceReidemeisterSpectrum,
	true,
	[ IsGroup ],
	[ IsFinite ],
	0
);
