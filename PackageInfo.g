SetPackageInfo( rec(

PackageName := "TwistedConjugacy",
Subtitle := "Computation with twisted conjugacy classes",
Version := "2.1.0",
Date := "20/03/2022",
License := "GPL-2.0-or-later",

Persons := [
	rec(
		IsAuthor := true,
		IsMaintainer := true,
		FirstNames := "Sam",
		LastName := "Tertooy",
		WWWHome := "https://stertooy.github.io/",
		Email := "sam.tertooy@kuleuven.be",
		PostalAddress := Concatenation(
			"Wiskunde\n",
			"KU Leuven Campus Kulak Kortrijk\n",
			"Etienne Sabbelaan 53\n",
			"8500 Kortrijk\n",
			"Belgium"
		),
		Place := "Kortrijk",
		Institution := "KU Leuven Campus Kulak Kortrijk",
	),
],

SourceRepository := rec(
	Type := "git",
	URL := "https://github.com/sTertooy/TwistedConjugacy",
),

IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://sTertooy.github.io/TwistedConjugacy/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation(
	~.SourceRepository.URL,
	"/releases/download/v", ~.Version,
	"/", ~.PackageName, "-", ~.Version
),

ArchiveFormats := ".tar.gz",

Status := "dev",

AbstractHTML   :=  Concatenation(
	"The TwistedConjugacy package provides methods to calculate Reidemeister ",
	"classes, numbers, spectra and zeta functions, as well as coincidence ",
	"groups of group homomorphisms. These methods are, for the most part, ",
	"designed to be used with (group homomorphisms between) finite groups ",
	"and, if the package Polycyclic is also installed, polycyclically ",
	"presented groups."
),

PackageDoc := rec(
	BookName  := ~.PackageName,
	ArchiveURLSubset := ["doc"],
	HTMLStart := "doc/chap0.html",
	PDFFile   := "doc/manual.pdf",
	SixFile   := "doc/manual.six",
	LongTitle := ~.Subtitle,
),

Dependencies := rec(
	GAP := ">= 4.11",
	NeededOtherPackages := [
		[ "GAPDoc", "1.6.3" ]
	],
	SuggestedOtherPackages := [
		[ "AutoDoc", "2019.09.04" ],
		[ "Polycyclic", "2.15.1" ]
	],
	ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := [
	"coincidence group",
	"fixed point group",
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
			as coincidence groups of group homomorphisms. These methods are,
			for the most part, designed to be used with (group homomorphisms
			between) finite groups and, if the package <B>Polycyclic</B> is
			also installed, polycyclically presented groups.
        """,
        Acknowledgements := """
			This documentation was created using the <B>GAPDoc</B> and
			<B>AutoDoc</B> packages.
        """,
        Copyright := """
			&copyright; 2020-2022 Sam Tertooy <P/>
			The <B>TwistedConjugacy</B> package is free software, it may be
			redistributed and/or modified under the terms and conditions of the
			<URL Text="GNU Public License Version 2">
			https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html</URL> or
			(at your option) any later version.
        """
    )
),

));
