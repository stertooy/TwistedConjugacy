###############################################################################
##
## AdaptedLowerCentralSeries( G )
##
InstallMethod(
	AdaptedLowerCentralSeries,
	[ IsPcpGroup and IsNilpotentGroup ],
	AdaptedLowerCentralSeriesOfGroup
);


###############################################################################
##
## AdaptedLowerCentralSeriesOfGroup( G )
##
InstallMethod(
	AdaptedLowerCentralSeriesOfGroup,
	[ IsPcpGroup and IsNilpotentGroup ],
	function ( G )
		return List( 
			LowerCentralSeriesOfGroup( G ),
			N -> IsolatorSubgroup( G, N )
		);
	end
);
