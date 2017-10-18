#############################################################################
##
#W  curves.gi                   GZero Package                  Gabor P. Nagy
##
##  Implementation file for genus zero curves
##
#Y  Copyright (C) 2017 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 09/06/2017

#############################################################################
##  CONSTRUCTORS
##  -------------------------------------------------------------------------

#############################################################################
##
#F  GZ_Curve(<field>,<indet>)
##
InstallMethod( GZ_Curve, "for finite field and indeterminate", true, [IsField,IsLaurentPolynomial], 0, 
function(field,indet)
	local ret;
	# input check
	# same length and prime power?
	if not(IsFinite(field) and Characteristic(field)=Characteristic(indet)) then 
		Error("wrong input for genus zero curve\n");
	fi;
	# object construction
	ret:=Objectify(
			NewType(GZ_CurveFamily, IsGZ_Curve and IsGZ_CurveRep),
			rec(
				fieldsize:=Size(field),
				char:=Characteristic(field),
				indnr:=IndeterminateNumberOfUnivariateLaurentPolynomial(indet)
			)
		);
	return ret;
end);

#############################################################################
##
#F  IndeterminateOfGZ_Curve(<C>)
##
InstallGlobalFunction( IndeterminateOfGZ_Curve, function(C)
	return Indeterminate(GF(C!.char),C!.indnr);
end);

#############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  -------------------------------------------------------------------------

InstallMethod( ViewObj, "for a genus zero curve",
	[ IsGZ_Curve ],
function( C )
	Print( "<GZ curve over GF(", C!.fieldsize, ") with indeterminate ", IndeterminateOfGZ_Curve(C), ">" );
end );

InstallMethod( Display, "for a genus zero curve",
	[ IsGZ_Curve ],
function( C )
	Print( "<GZ curve over GF(", C!.fieldsize, ") with indeterminate ", IndeterminateOfGZ_Curve(C), ">" );
end );

InstallMethod( PrintObj, "for a genus zero curve",
	[ IsGZ_Curve ],
function( C )
	Print( "GZ_Curve(GF(", C!.fieldsize, "),", IndeterminateOfGZ_Curve(C), ")" );
end );

InstallMethod( \=, "for two genus zero curves",
	IsIdenticalObj,
	[ IsGZ_Curve, IsGZ_Curve ],
function( C1, C2 )
	return [C1!.fieldsize,C1!.indnr]=[C2!.fieldsize,C2!.indnr];
end );

InstallMethod( \<, "for two genus zero curves",
	IsIdenticalObj,
	[ IsGZ_Curve, IsGZ_Curve ],
function( C1, C2 )
	return [C1!.fieldsize,C1!.indnr]<[C2!.fieldsize,C2!.indnr];
end );

#############################################################################
##  UTILITIES
##  -------------------------------------------------------------------------

InstallMethod( Characteristic,
        "for a genus zero curve",
        [ IsGZ_Curve ],
function( C )
	return C!.char;
end );

InstallMethod( UnderlyingField,
	"for a genus zero curve",
	[ IsGZ_Curve ],
function( C )
	return GF(C!.fieldsize);
end );

InstallMethod( RandomPlaceOfGZ_Curve,
        "for a genus zero curve",
        [ IsGZ_Curve, IsPosInt ],
function( C, d )
	local q,t;
	q:=C!.fieldsize;
	t:=Random([0..q^d]);
	if d=1 and t=0 then t:=infinity;
	elif d=1 and t=1 then t:=0*Z(q);
	elif d=1 then t:=Z(q)^(t-1); 
	else 
		t:=Random([1..q^d-2]);
		while ForAny(PrimeDivisors(d),k->k<d and 0=((q^k-1)*t) mod (q^d-1)) do
		    t:=Random([1..q^d-1]);
		od;
		t:=Z(q^d)^t;
	fi;
	return GZ_1PointDivisor(C,t);
end );

InstallMethod( RandomPlaceOfGZ_Curve,
        "for a genus zero curve",
        [ IsGZ_Curve ],
function( C )
	return RandomPlaceOfGZ_Curve(C,1);
end );

InstallMethod( FrobeniusAutomorphismOfGZ_Curve,
        "for a genus zero curve",
        [ IsGZ_Curve ],
function( C )
	return AC_FrobeniusAutomorphism(C!.fieldsize);
end );
