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
		local G, H, g, D1, D2, det;
		G := Source( hom1 );
		H := Range( hom1 );
		if not IsPcpGroup( G ) or not IsAbelian( G ) or not IsAbelian( H ) or 
			not HirschLength( G ) = HirschLength( H ) then
			TryNextMethod();
		fi;
		TG := TorsionSubgroup( G );
		TH := TorsionSubgroup( H );
		pG := NaturalHomomorphismByNormalSubgroupNC( G, TG );
		pH := NaturalHomomorphismByNormalSubgroupNC( H, TH );
		g := IndependentGeneratorsOfAbelianGroup( G );
		D1 := List( g, g -> IndependentGeneratorExponents( H, Image( hom1, g ) );
		D2 := List( g, g -> IndependentGeneratorExponents( H, Image( hom1, g ) );
		Print("ReidNrAbelian\n");
		det := Determinant( M1 - M2 );
		if det <> 0 then
			return det;
		else
			return infinity;
		fi;
	end
);


InstallMethod( ReidemeisterNumber, [IsGroupHomomorphism, IsGroupHomomorphism],
	function ( hom1, hom2 )
		local G, H, g, D1, D2, det;
		G := Source( hom1 );
		H := Range( hom1 );
		if not IsPcpGroup( G ) or not IsFreeAbelian( G ) or not IsFreeAbelian( H ) or 
			not HirschLength( G ) = HirschLength( H ) then
			TryNextMethod();
		fi;
		g := IndependentGeneratorsOfAbelianGroup( G );
		D1 := List( g, g -> IndependentGeneratorExponents( H, Image( hom1, g ) );
		D2 := List( g, g -> IndependentGeneratorExponents( H, Image( hom1, g ) );
		Print("ReidNrTFAbelian\n");
		det := Determinant( D1 - D2 );
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
