###############################################################################
##
## ToggleSafeMode@()
##
ToggleSafeMode@ := function()
    local new, onoff;
    new := not SAFEMODE@;
    SAFEMODE@ := new;
    ASSERT@ := new;
    if TestPackageAvailability( "polycyclic", "2.16" ) = true then
        CHECK_CENT@Polycyclic := new;
        CHECK_IGS@Polycyclic := new;
        CHECK_INTNORM@Polycyclic := new;
        CHECK_INTSTAB@Polycyclic := new;
        CHECK_NORM@Polycyclic := new;
        CHECK_SCHUR_PCP@Polycyclic := new;
    fi;
    onoff := "off";
    if SAFEMODE@ then onoff := "on"; fi;
    Print("TwistedConjugacy's Safe Mode is now ",onoff,".\n");
end;
