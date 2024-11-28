SetPackageInfo( rec(

PackageName := "TwistedConjugacy",
Subtitle := "Computation with twisted conjugacy classes",
Version := "2.4.0",
Date := "2024-11-23",
License := "GPL-2.0-or-later",

Persons := [
    rec(
        IsAuthor := true,
        IsMaintainer := true,
        FirstNames := "Sam",
        LastName := "Tertooy",
        WWWHome := "https://stertooy.github.io/",
        Email := "sam.tertooy@kuleuven.be",
        PostalAddress := """
            Wiskunde
            KU Leuven Kulak Kortrijk Campus
            Etienne Sabbelaan 53
            8500 Kortrijk
            Belgium
        """,
        Place := "Kortrijk, Belgium",
        Institution := "KU Leuven Kulak Kortrijk Campus",
    ),
],

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/stertooy/", ~.PackageName ),
),
SupportEmail := "sam.tertooy@kuleuven.be",

IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := Concatenation( "https://stertooy.github.io/", ~.PackageName ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "/README.md" ),
ArchiveURL      := Concatenation(
    ~.SourceRepository.URL,
    "/releases/download/v", ~.Version,
    "/", ~.PackageName, "-", ~.Version
),

ArchiveFormats := ".tar.gz",

AbstractHTML := """
    The TwistedConjugacy package provides methods to calculate Reidemeister
    classes, numbers, spectra and zeta functions, as well as other methods
    related to homomorphisms, endomorphisms and automorphisms of groups.
    These methods are, for the most part, designed to be used with finite
    groups and polycyclically presented groups.
""",

PackageDoc := rec(
    BookName  := ~.PackageName,
    ArchiveURLSubset := ["doc"],
    HTMLStart := "doc/chap0_mj.html",
    PDFFile   := "doc/manual.pdf",
    SixFile   := "doc/manual.six",
    LongTitle := ~.Subtitle,
),

Dependencies := rec(
    GAP := ">= 4.13",
),

Extensions := [
    rec(
        needed := [ [ "Polycyclic", "2.16" ] ],
        filename := "read_pcp.g"
    )
],

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := [
    "coincidence group",
    "endomorphism",
    "fixed point group",
    "homomorphism",
    "Reidemeister number",
    "Reidemeister spectrum",
    "Reidemeister zeta function",
    "twisted conjugacy",
],

AutoDoc := rec(
    TitlePage := rec(
        Abstract := """
            The <B>TwistedConjugacy</B> package provides methods to calculate
            Reidemeister classes, numbers, spectra and zeta functions, as well
            as other methods related to homomorphisms, endomorphisms and
            automorphisms of groups. These methods are, for the most part,
            designed to be used with finite groups and polycyclically presented
            groups.
        """,
        Acknowledgements := """
            This documentation was created using the <B>GAPDoc</B> and
            <B>AutoDoc</B> packages.
        """,
        Copyright := """
            &copyright; 2020-2024 Sam Tertooy <P/>
            The <B>TwistedConjugacy</B> package is free software, it may be
            redistributed and/or modified under the terms and conditions of the
            <URL Text="GNU Public License Version 2">
            https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html</URL> or
            (at your option) any later version.
        """
    )
),

));
