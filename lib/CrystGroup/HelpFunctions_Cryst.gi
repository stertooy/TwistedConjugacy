###############################################################################
##
## IsCrystallographic( G )
##
InstallMethod(
    IsCrystallographic,
    "for Pcp Groups",
    [ IsPcpGroup ],
    function ( G )
        local T, N;
        T := FittingSubgroup( G );
        return IsInt( IndexNC( G, T ) ) and IsFreeAbelian( T );
    end
);
