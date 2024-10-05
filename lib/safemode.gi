###############################################################################
##
## ToggleSafeMode@()
##
ToggleSafeMode@ := function()
    local new, onoff;
    new := not SAFEMODE@;
    SAFEMODE@ := new;
    ASSERT@ := new;
    onoff := "off";
    if SAFEMODE@ then onoff := "on"; fi;
    Print("TwistedConjugacy's Safe Mode is now ",onoff,".\n");
end;
