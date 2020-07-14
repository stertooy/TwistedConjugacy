###############################################################################
##
## AdaptedLowerCentralSeries( G )
##
InstallMethod(
	AdaptedLowerCentralSeries,
	[ IsPcpGroup and IsNilpotentGroup ],
	AdaptedLowerCentralSeriesOfGroup
);

RedispatchOnCondition(
	AdaptedLowerCentralSeries,
	true, 
	[ IsGroup ],
	[ IsPcpGroup and IsNilpotentGroup ],
	0
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

RedispatchOnCondition(
	AdaptedLowerCentralSeriesOfGroup,
	true, 
	[ IsGroup ],
	[ IsPcpGroup and IsNilpotentGroup ],
	0
);
