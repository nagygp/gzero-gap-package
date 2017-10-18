#############################################################################
##
#W  frobenius.gi                  GZero Package                 Gabor P. Nagy
##
##  This file extends the GAP implementation of the AC-Frobenius automorphisms of finite fields. 
##
#Y  Copyright (C) 2017 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 10/01/2017
##

#############################################################################
##
#F  infinity^<fr> . . . . . . action of an AC-Frobenius automorphism on infinity
##
InstallOtherMethod( \^, "for an AC-Frobenius automorphism and infinity",
	[ IsInfinity, IsAC_FrobeniusAutomorphism ],
function( x, fr )
	return x;
end );

#############################################################################
##
#F  <FFE genus zero divisor>^<fr> . . . action of an AC-Frobenius automorphism on genus zero divisors
##
InstallOtherMethod( \^, "for a genus zero divisor and an AC-Frobenius automorphism",
	[ IsGZ_Divisor, IsAC_FrobeniusAutomorphism ],
function( D, fr )
	local pts;
	if Characteristic(D)<>Characteristic(fr) then Error("the arguments must have the same characteristic\n"); fi;
	pts:=List(D!.points,u->u^fr);
	return GZ_DivisorConstruct(D!.curve,pts,D!.orders);
end );

#E  frobenius.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
