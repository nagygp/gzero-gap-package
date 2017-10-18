###################################################################################
##
#W  automorphisms.gi                   GZero Package                  Gabor P. Nagy
##
##  Implementation file for automorphisms of genus zero curves and their codes
##
#Y  Copyright (C) 2017 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 08/07/2017
##

#############################################################################
##  CONSTRUCTORS
##  -------------------------------------------------------------------------

InstallMethod( GZ_CurveAutomorphism, "for a matrix over a finite field",
	[ IsMatrix and IsFFECollColl ],
function(m) 
	if Length(m)<>2 or Length(m[1])<>2 or IsZero(m[1][1]*m[2][2]-m[1][2]*m[2][1]) then
		Error("argument must be a 2x2 nonsingular matrix over a finite field\n");
	fi;
	return Objectify(
		NewType(GZ_CurveAutomorphismFamily,IsGZ_CurveAutomorphism and IsGZ_CurveAutomorphismRep),
		[m/First(m[1],x->not(IsZero(x))),Characteristic(m)]); 
end);

InstallMethod( Characteristic,
	"for a GZ curve automorphism",
	[ IsGZ_CurveAutomorphism ],
function( x )
  return x![2];
end );


#############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  -------------------------------------------------------------------------

InstallMethod( ViewObj, "for a GZ curve automorphism",
	[ IsGZ_CurveAutomorphism ], 10,
function( obj )
	Print( "GZ_CurveAut(", obj![1], ")" );
end );

InstallMethod( Display, "for a GZ curve automorphism",
	[ IsGZ_CurveAutomorphism ], 10,
function( obj )
	Print( "GZ_CurveAut(", obj![1], ")" );
end );

InstallMethod( PrintObj, "for a GZ curve automorphism",
	[ IsGZ_CurveAutomorphism ], 10,
function( obj )
	Print( "GZ_CurveAut(", obj![1], ")" );
end );

InstallMethod( \=, "for two GZ curve automorphisms",
	IsIdenticalObj,
	[ IsGZ_CurveAutomorphism, IsGZ_CurveAutomorphism ],
function( m1,m2 )
	return m1![1] = m2![1];
end );

InstallMethod( \<, "for two GZ curve automorphisms",
	IsIdenticalObj,
	[ IsGZ_CurveAutomorphism, IsGZ_CurveAutomorphism ],
function( m1, m2 )
	return m1![1] < m2![1];;
end );


#############################################################################
##  MULTIPLICATION
##  -------------------------------------------------------------------------

InstallMethod( \*, "for two GZ curve automorphisms",
	IsIdenticalObj,
	[ IsGZ_CurveAutomorphism, IsGZ_CurveAutomorphism ],
function( m1, m2 )
	if m1![2]=m2![2] then 
		return GZ_CurveAutomorphism(m1![1]*m2![1]);
	else
		Error("two GZ curve automorphisms must have the same characteristic\n");
	fi;
end );

InstallMethod( InverseMutable, "for a GZ curve automorphism and a positive integer",
	[ IsGZ_CurveAutomorphism ],
function( m )
	return GZ_CurveAutomorphism(m![1]^(-1));
end );

InstallMethod( OneMutable, "for a GZ curve automorphism",
	[ IsGZ_CurveAutomorphism ],
function( m )
	return GZ_CurveAutomorphism(One(m![1])); 
end );

InstallMethod( \^, "for a GZ curve automorphism and a positive integer",
	[ IsGZ_CurveAutomorphism, IsPosInt ],
function( m, k )
	return GZ_CurveAutomorphism(m![1]^k);
end );

#############################################################################
##  AC-FROBENIUS ACTIONS
##  -------------------------------------------------------------------------

InstallOtherMethod( \^, "for infinity and an AC-Frobenius automorphism",
	[ IsInfinity, IsAC_FrobeniusAutomorphism ],
function( x, fr )
	return x;
end );

InstallOtherMethod( \^, "for a genus zero divisor and an AC-Frobenius automorphism",
	[ IsGZ_Divisor, IsAC_FrobeniusAutomorphism ],
function( D, fr )
	local pts;
	if Characteristic(D)<>Characteristic(fr) then Error("the arguments must have the same characteristic\n"); fi;
	pts:=List(D!.points,u->u^fr);
	return GZ_DivisorConstruct(D!.curve,pts,D!.orders);
end );

InstallOtherMethod( \^, "for a GZ curve automorphism and an AC-Frobenius automorphism",
	[ IsGZ_CurveAutomorphism, IsAC_FrobeniusAutomorphism ],
function( m, fr )
	return GZ_CurveAutomorphism(m![1]^fr);
end );


#############################################################################
##  GZ CURVE AUTOMORPHISM ACTIONS
##  -------------------------------------------------------------------------

InstallOtherMethod( \^, "for an AC-Frobenius automorphism and infinity",
	[ IsInfinity, IsAC_FrobeniusAutomorphism ],
function( x, fr )
	return x;
end );

InstallOtherMethod( \^, "for a genus zero divisor and an AC-Frobenius automorphism",
	[ IsGZ_Divisor, IsAC_FrobeniusAutomorphism ],
function( D, fr )
	local pts;
	if Characteristic(D)<>Characteristic(fr) then Error("the arguments must have the same characteristic\n"); fi;
	pts:=List(D!.points,u->u^fr);
	return GZ_DivisorConstruct(D!.curve,pts,D!.orders);
end );

InstallOtherMethod( \^, "for normed row vector and a GZ curve automorphism", 
	[ IsFFECollection, IsGZ_CurveAutomorphism ],
function( x, m )
	local y;
	if Characteristic(x)<>Characteristic(m) then 
		Error("the arguments must have the same characteristic");
	fi;
	y:=First(x,u->not(IsZero(u)));
	if y=fail or not(IsOne(y)) then
		Error("action only defined for normed row vectors");
	fi;
	y:=OnLines(x,m![1]);
	if IsCVecRep(x) then
		return CVec(y,CVecClass(x));
	else
		return y;
	fi;
end );

InstallOtherMethod( \^, "for a finite field element and a GZ curve automorphism", 
	[ IsFFE, IsGZ_CurveAutomorphism ],
function( x, m )
	m:=m![1];
	if IsZero(m[1][1]+x*m[2][1]) then
		return infinity;
	else
		return (m[1][2]+x*m[2][2])/(m[1][1]+x*m[2][1]);
	fi;
end );

InstallOtherMethod( \^, "for infinity and a GZ curve automorphism", 
	[ IsInfinity, IsGZ_CurveAutomorphism ],
function( x, m )
	m:=m![1];
	if IsZero(m[2][1]) then
		return infinity;
	else
		return m[2][2]/m[2][1];
	fi;
end );

InstallOtherMethod( \^, "for a genus zero divisor and a GZ curve automorphism", 
	[ IsGZ_Divisor, IsGZ_CurveAutomorphism ],
function( D, m )
	return GZ_DivisorConstruct(D!.curve,OnTuples(D!.points,m),D!.orders);
end );

InstallOtherMethod( \^, "for a genus zero AG-code and a GZ curve automorphism", 
	[ IsGZ_Code, IsGZ_CurveAutomorphism ],
function( C, m )
	local fr;
	fr:=FrobeniusAutomorphismOfGZ_Curve(C!.gzcurve);
	if m<>m^fr then
		Error("curve automorphism must be rational");
	fi;
	if IsGZ_FunctionalCode(C) then 
		return GZ_FunctionalCode(C!.gendivs[1]^fr,C!.gendivs[2]^fr); 
	else
		return GZ_DifferentialCode(C!.gendivs[1]^fr,C!.gendivs[2]^fr);
	fi;	
end );

#############################################################################
##  GZ CURVE AUTOMORPHISM GROUPS
##  -------------------------------------------------------------------------
InstallGlobalFunction( MatrixGroupToGZ_CurveAutGroup, 
function(matgr,C)
	local xset,projgr;
	projgr:=GroupWithGenerators(List(GeneratorsOfGroup(matgr),GZ_CurveAutomorphism));
	xset:=ExternalSet(projgr,Concatenation(Elements(UnderlyingField(C)),[infinity]));
	SetNiceMonomorphism(projgr,ActionHomomorphism(xset));
	SetIsHandledByNiceMonomorphism(projgr,true);
	SetName(projgr,Concatenation("<group of GZ curve automorphisms of size ",String(Size(projgr)),">"));
	projgr!.curve:=C;
	return projgr;
end );

InstallOtherMethod( AutomorphismGroup, "for a genus zero curve", 
	[ IsGZ_Curve ],
function( C )
	return MatrixGroupToGZ_CurveAutGroup(GL(2,Size(UnderlyingField(C))),C);
end );



























#E  automorphisms.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
