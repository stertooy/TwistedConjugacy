InstallMethod( AdaptedLowerCentralSeries,
	[IsPcpGroup and IsNilpotentGroup],
	AdaptedLowerCentralSeriesOfGroup
);

InstallMethod( AdaptedLowerCentralSeriesOfGroup,
	[IsPcpGroup and IsNilpotentGroup],
	function ( G )
		return List( LowerCentralSeriesOfGroup( G ), N -> IsolatorSubgroup( G, N ) );
	end
);
