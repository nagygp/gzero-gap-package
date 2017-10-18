#############################################################################
##
#W    init.g                  The GZero package                 Gabor P. Nagy
##

#############################################################################
##  Starting from GAP 4.4 and having  a  PackageInfo.g  file  available,  the
##  commands  `DeclarePackage'  and   `DeclarePackageAutoDocumentation'   are
##  ignored. They are substituted by the entries:
##   .PackageName, .Version, .PackageDoc, .Dependencies and .AvailabilityTest
##  specified in the PackageInfo.g file.
##
##  Since GAP 4.4, commands with `Pkg' in their name have `Package'  instead,
##  e.g. `ReadPkg' became `ReadPackage'.
##

#############################################################################
##
#R  Read the declaration files.
##
ReadPackage( "gzero", "lib/curves.gd" );
ReadPackage( "gzero", "lib/divisors.gd" );
ReadPackage( "gzero", "lib/automorphisms.gd" );
ReadPackage( "gzero", "lib/riemannroch.gd" );
ReadPackage( "gzero", "lib/agcodes.gd" );
ReadPackage( "gzero", "lib/utils.gd" );

#E  init.g . . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here

