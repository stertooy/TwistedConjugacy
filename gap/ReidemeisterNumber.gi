###############################################################################
##
## ReidemeisterNumber( hom1, hom2 )
##
InstallMethod( ReidemeisterNumber, [IsGroupHomomorphism, IsGroupHomomorphism],
	function ( hom1, hom2 )
		local G, H, Rcl;
		G := Source( hom1 );
		H := Range( hom1 );
		if IsFinite( G ) and IsAbelian( G ) and IsFinite( H ) then
			TryNextMethod();
		fi;
		Rcl := ReidemeisterClasses( hom1, hom2 );
		if Rcl <> fail then
			return Size( Rcl );
		else
			return infinity;
		fi;
	end
);

InstallMethod( ReidemeisterNumber, [IsGroupHomomorphism, IsGroupHomomorphism],
	function ( hom1, hom2 )
		local G, H, Rcl;
		H := Source( hom1 );
		G := Range( hom1 );
		if not IsFinite( G ) or not IsAbelian( G ) or not IsFinite( H ) then
			TryNextMethod();
		fi;
		return Size( G ) / Size( H ) * Size( CoincidenceGroup( hom1, hom2 ) );
	end
);

InstallMethod( ReidemeisterNumber, [IsGroupHomomorphism, IsGroupHomomorphism],
	function ( hom1, hom2 )
		local G, H, M1, M2, TG, TH, a, A, R, det, F, p;
		G := Source( hom1 );
		H := Range( hom1 );
		if not IsPcpGroup( G ) or not IsAlmostBieberbachGroup( G ) or not IsAlmostBieberbachGroup( H ) or 
			not HirschLength( G ) = HirschLength( H ) then
			TryNextMethod();
		fi;
		# TODO: fix this: make basis from preimages from generators of ALCS
		TG := FittingSubgroup( G );
		TH := FittingSubgroup( H );
		M1 := List( Pcp( TG ), g -> ExponentsByPcp( Pcp( TH ), Image( hom1, g ) ) );
		M2 := List( Pcp( TG ), g -> ExponentsByPcp( Pcp( TH ), Image( hom2, g ) ) );
		Print("aloha\n");
		R := 0;
		p := NaturalHomomorphismByNormalSubgroupNC( H, TH );
		F := LinearActionOnPcp( List( Image( p ), h -> PreImagesRepresentative( p, h) ), Pcp ( TH ) );
		for A in F do
			PrintArray(A);
			det := Determinant( M1 - A*M2 );
			if det = 0 then
				return infinity;
			else
				R := R + AbsInt(det);
			fi;
		od;
		return R / Size( F );
		
		
	end
);

InstallMethod( ReidemeisterNumber, [IsGroupHomomorphism, IsGroupHomomorphism],
	function ( hom1, hom2 )
		local G, H, M1, M2, det;
		G := Source( hom1 );
		H := Range( hom1 );
		if not IsPcpGroup( G ) or not IsNilpotent( G ) or not IsNilpotent( H ) or 
			not HirschLength( G ) = HirschLength( H ) then
			TryNextMethod();
		fi;
		# TODO: this will probably be a part of the averaging formula
		M1 := List( Pcp( G ), g -> ExponentsByPcp( Pcp( H ), Image( hom1, g ) ) );
		M2 := List( Pcp( G ), g -> ExponentsByPcp( Pcp( H ), Image( hom2, g ) ) );
		Print("hi\n");
		det := Determinant( M1 - M2 );
		if det <> 0 then
			return det;
		else
			return infinity;
		fi;
	end
);

RedispatchOnCondition( ReidemeisterNumber, true, 
	[IsGroupHomomorphism, IsGroupHomomorphism],
	[IsEndoGeneralMapping, IsEndoGeneralMapping], 0 );


###############################################################################
##
## ReidemeisterNumber( endo )
##
InstallOtherMethod( ReidemeisterNumber, 
	[IsGroupHomomorphism and IsEndoGeneralMapping],
	function ( endo )
		return ReidemeisterNumber( endo, IdentityMapping( Source( endo ) ) );
	end
);

RedispatchOnCondition( ReidemeisterNumber, true, 
	[IsGroupHomomorphism],
	[IsEndoGeneralMapping], 0 );
