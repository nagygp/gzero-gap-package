#############################################################################
##
#W  divisors.gi                  GZero Package                 Gabor P. Nagy
##
##  Implementation file for arithmetics of genus zero divisors
##
#Y  Copyright (C) 2017 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 10/01/2017

#############################################################################
##  CONSTRUCTORS
##  -------------------------------------------------------------------------

#############################################################################
##
#F  GZ_DivisorConstruct(<curve>,<pts>,<ords>)
##
InstallGlobalFunction( GZ_DivisorConstruct, function(curve,pts,ords)
	local perm,i,ret;
	# input check
	# same length and curve?
	if not(IsGZ_Curve(curve) and Length(pts)=Length(ords)) then
		Error("wrong input for genus zero divisor constructor\n");
	fi;
	if pts<>[] then
		# points in increasing order?
		perm:=Sortex(pts);
		ords:=Permuted(ords,perm);
		# divisor points on the projective line?
		if not ForAll(pts,u->IsRingElementWithInverse(u) or IsInfinity(u)) then
			Error("wrong divisor points\n");
		fi;
		# orders integer?
		if not ForAll(ords,IsInt) then
			Error("orders must be integers\n");
		fi;
		# same point occur several times?
		for i in [1..Length(pts)-1] do
			if pts[i]=pts[i+1] then
				ords[i+1]:=ords[i+1]+ords[i];
				ords[i]:=0;
			fi;
		od;
		i:=1;
		while true do
			# points with zero coefficients?
			if IsZero(ords[i]) then
				Remove(pts,i);
				Remove(ords,i);
				i:=i-1;
			fi;
			if i>=Length(pts) then break; else i:=i+1; fi;
		od;
		# check coordinates (allow integers)
		for i in [1..Length(pts)] do
			if IsInt(pts[i]) then
				pts[i]:=Z(curve!.char)^0*pts[i];
			fi;
		od;
		if not ForAll(pts,u->IsInfinity(u) or Characteristic(u)=curve!.char) then
			Error("points must have the same characteristic");
		fi;
	fi;
	# object construction
	ret:=Objectify(
			NewType(GZ_DivisorFamily, IsGZ_Divisor and IsGZ_DivisorRep),
			rec(points:=pts,orders:=ords,curve:=curve)
		);
	return ret;
end);

#############################################################################
##
#F  IndeterminateOfGZ_Divisor(<D>)
##
InstallGlobalFunction( IndeterminateOfGZ_Divisor, function(D)
	return IndeterminateOfGZ_Curve(D!.curve);
end);

#############################################################################
##
#F  GZ_Divisor(curve,[[p_1,n_1],...,[p_k,n_k]])
#F  GZ_Divisor(curve,[p_1,...,p_k],[n_1,...,n_k])
##
InstallMethod( GZ_Divisor, "for curve, points and orders", true, [IsGZ_Curve,IsList,IsList], 0,
function(curve,pts,ords)
	return GZ_DivisorConstruct(curve,pts,ords);
end);

InstallMethod( GZ_Divisor, "for curve and list of point/order pairs", true, [IsGZ_Curve,IsList], 0,
function(curve,pairs)
	local pts,ords;
	pts:=List(pairs,u->u[1]);
	ords:=List(pairs,u->u[2]);
	return GZ_DivisorConstruct(curve,pts,ords);
end);


#############################################################################
##
#F  GZ_ZeroDivisor(curve)
##
InstallMethod( GZ_ZeroDivisor, "for curve", true, [IsGZ_Curve], 0,
function(curve)
	return GZ_Divisor(curve,[],[]);
end);

InstallMethod( ZeroMutable, "for a genus zero divisor",
	[ IsGZ_Divisor ],
function( D )
	return GZ_ZeroDivisor(D!.curve);
end );

#############################################################################
##
#F  GZ_1PointDivisor(curve,pt)
#F  GZ_1PointDivisor(curve,pt,n)
##
InstallMethod( GZ_1PointDivisor, "for curve and constant", true, [IsGZ_Curve,IsRingElementWithInverse], 0,
function(curve,pt)
	return GZ_Divisor(curve,[pt],[1]);
end);

InstallOtherMethod( GZ_1PointDivisor, "for curve and infinity", true, [IsGZ_Curve,IsInfinity], 0,
function(curve,pt)
	return GZ_Divisor(curve,[pt],[1]);
end);

InstallMethod( GZ_1PointDivisor, "for curve, constant and integer", true, [IsGZ_Curve,IsRingElementWithInverse,IsInt], 0,
function(curve,pt,k)
	return GZ_Divisor(curve,[pt],[k]);
end);

InstallOtherMethod( GZ_1PointDivisor, "for curve, infinity and integer", true, [IsGZ_Curve,IsInfinity,IsInt], 0,
function(curve,pt,k)
	return GZ_Divisor(curve,[pt],[k]);
end);


#############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  -------------------------------------------------------------------------

InstallMethod( ViewObj, "for a genus zero divisor",
	[ IsGZ_Divisor ],
function( D )
	Print( "<GZ divisor with support of length ", Size(D!.points), " over indeterminate ", IndeterminateOfGZ_Divisor(D), ">" );
end );

InstallMethod( Display, "for a genus zero divisor",
	[ IsGZ_Divisor ],
function( D )
	Print( "<GZ divisor with support of length ", Size(D!.points), " over indeterminate ", IndeterminateOfGZ_Divisor(D), ">" );
end );

InstallMethod( PrintObj, "for a genus zero divisor",
	[ IsGZ_Divisor ],
function( D )
	Print( "GZ_Divisor(", D!.curve, ",", D!.points, ",", D!.orders, ")" );
end );

InstallMethod( \=, "for two genus zero divisors",
	IsIdenticalObj,
	[ IsGZ_Divisor, IsGZ_Divisor ],
function( D1, D2 )
	return D1!.curve=D2!.curve and D1!.points=D2!.points and D1!.orders=D2!.orders;
end );

InstallMethod( \<, "for two genus zero divisors",
	IsIdenticalObj,
	[ IsGZ_Divisor, IsGZ_Divisor ],
function( D1, D2 )
	return [D1!.curve,D1!.points,D1!.orders]<[D2!.curve,D2!.points,D2!.orders];
end );

#############################################################################
##  ADDITION
##  -------------------------------------------------------------------------

InstallMethod( \+, "for two genus zero divisors",
	IsIdenticalObj,
	[ IsGZ_Divisor, IsGZ_Divisor ], 0,
function( D1, D2 )
	if D1!.curve<>D2!.curve then
		Error("two genus zero divisors must belong to the same curve\n");
	else
		return GZ_DivisorConstruct(
				D1!.curve,
				Concatenation(D1!.points,D2!.points),
				Concatenation(D1!.orders,D2!.orders)
			);
	fi;
end );

InstallMethod( \-, "for two genus zero divisors",
	IsIdenticalObj,
	[ IsGZ_Divisor and IsGZ_DivisorRep, IsGZ_Divisor and IsGZ_DivisorRep], 0,
function( D1, D2 )
	if D1!.curve<>D2!.curve then
		Error("two genus zero divisors must belong to the same curve\n");
	else
		return GZ_DivisorConstruct(
				D1!.curve,
				Concatenation(D1!.points,D2!.points),
				Concatenation(D1!.orders,-(D2!.orders))
			);
	fi;
end );

InstallMethod( \*, "for an integer and a genus zero divisor",
	[ IsInt, IsGZ_Divisor ],
function( k, D )
	return GZ_DivisorConstruct(D!.curve,D!.points,k*D!.orders);
end );

InstallMethod( AdditiveInverseOp, "for a genus zero divisor",
	[ IsGZ_Divisor ],
function( D )
	return GZ_DivisorConstruct(D!.curve,D!.points,-D!.orders);
end );


#############################################################################
#############################################################################
##
## DIVISOR UTILITY FUNCTIONS
##
#############################################################################
#############################################################################

InstallGlobalFunction( GZ_InfimumDivisor, function( D1, D2 )
	local sup,ord;
	if D1!.curve<>D2!.curve then
		Error("two genus zero divisors must belong to the same function field\n");
	else
		sup:=Union(Support(D1),Support(D2));
		ord:=List(sup,p->Minimum(Valuation(p,D1),Valuation(p,D2)));
		return GZ_DivisorConstruct(D1!.curve,sup,ord);
	fi;
end );

InstallGlobalFunction( GZ_SupremumDivisor, function( D1, D2 )
	local sup,ord;
	if D1!.curve<>D2!.curve then
		Error("two genus zero divisors must belong to the same function field\n");
	else
		sup:=Union(Support(D1),Support(D2));
		ord:=List(sup,p->Maximum(Valuation(p,D1),Valuation(p,D2)));
		return GZ_DivisorConstruct(D1!.curve,sup,ord);
	fi;
end );

InstallGlobalFunction( GZ_PositivePartOfDivisor, function( D )
	return GZ_SupremumDivisor(D,Zero(D));
end );

InstallGlobalFunction( GZ_NegativePartOfDivisor, function( D )
	return GZ_SupremumDivisor(-D,Zero(D));
end );

InstallGlobalFunction( GZ_MultiplicityOfRoot_NotNeeded, function( pol,t )
	local k;
	if IsZero(pol) then return -infinity; fi;
	k:=0;
	while Degree(pol)>0 and IsZero(Value(pol,t)) do
		pol:=pol/(IndeterminateOfUnivariateRationalFunction(pol)-t);
		k:=k+1;
	od;
	return k;
end );

InstallGlobalFunction( GZ_ValuationAtPlace_NotNeeded, function( t,ratfun )
	local denom,numer;
	numer:=NumeratorOfRationalFunction(ratfun);
	denom:=DenominatorOfRationalFunction(ratfun);
	if IsInfinity(t) then
		return Degree(denom)-Degree(numer);
	else
		return GZ_MultiplicityOfRoot_NotNeeded(numer,t)-GZ_MultiplicityOfRoot_NotNeeded(denom,t);
	fi;
end );

InstallMethod( Characteristic,
	"for a genus zero divisor",
	[ IsGZ_Divisor ],
function( D )
  return Characteristic(D!.curve);
end );

InstallMethod( UnderlyingField,
	"for a genus zero divisor",
	[ IsGZ_Divisor ],
function( D )
	return UnderlyingField(D!.curve);
end );

InstallMethod( Support,
	"for a genus zero divisor",
	[ IsGZ_Divisor ],
function( D )
  return D!.points;
end );

InstallMethod( Degree,
	"for a genus zero divisor",
	[ IsGZ_Divisor ],
function( D )
  return Sum(D!.orders);
end );

# We do not check it pt is on the projective line; we simply return 0.
InstallMethod( Valuation, "for a genus zero divisor and a constant",
	[ IsRingElementWithInverse, IsGZ_Divisor ],
function( pt, D )
	local pos;
	pos:=Position(D!.points,pt);
	if pos=fail then
		return 0;
	else
		return D!.orders[pos];
	fi;
end );

InstallOtherMethod( Valuation, "for a genus zero divisor and infinity",
	[ IsInfinity, IsGZ_Divisor ],
function( pt, D )
	local pos;
	pos:=Position(D!.points,pt);
	if pos=fail then
		return 0;
	else
		return D!.orders[pos];
	fi;
end );

InstallMethod( Valuation, "for a constant and a rational functions",
	[ IsRingElementWithInverse,IsUnivariateRationalFunction ],
function( pt, ratfun )
	if not IsUnivariateRationalFunction(ratfun) then
		Error("2nd argument must be an univariate rational function");
	fi;
	return GZ_ValuationAtPlace_NotNeeded(pt,ratfun);
end );

InstallOtherMethod( Valuation, "for infinity and a rational functions",
	[ IsInfinity,IsUnivariateRationalFunction ],
function( pt, ratfun )
	if not IsUnivariateRationalFunction(ratfun) then
		Error("2n argument must be an univariate rational function");
	fi;
	return GZ_ValuationAtPlace_NotNeeded(pt,ratfun);
end );

InstallMethod( IsRationalGZ_Divisor,
	"for a genus zero divisor",
	[ IsGZ_Divisor ],
function( D )
	local fr;
	fr:=FrobeniusAutomorphismOfGZ_Curve(D!.curve);
	return D=D^fr;
end );

InstallGlobalFunction( GZ_PrincipalDivisorUPolNC, function( C,f )
	# we assume f to be a nonzero polynomial and indeterminate is the same as the curve
	local rts,D;
	if Degree(f)=0 then
		return GZ_ZeroDivisor(C);
	else
		rts:=RootsOfUPol("split",f);
		D:=Sum(rts,x->GZ_1PointDivisor(C,x));
		return D-Degree(D)*GZ_1PointDivisor(C,infinity);
	fi;
end );

InstallGlobalFunction( GZ_PrincipalDivisor, function( C,f )
	local D;
	if not IsGZ_Curve(C) then
		Error("first argument must be a genus zero curve");
	fi;
	if not IsUnivariateRationalFunction(f) then
		Error("second argument must be a ratinal function");
	fi;
	if IndeterminateOfGZ_Curve(C)<>IndeterminateOfUnivariateRationalFunction(f) then
		Error("rational function and curve mismatch");
	fi;
	if IsZero(f) then
		Error("second argument cannot be the zero polynomial");
	fi;
	if IsUnivariatePolynomial(f) then
		D:=[f,One(f)];
	else
		D:=[NumeratorOfRationalFunction(f),DenominatorOfRationalFunction(f)];
	fi;
	return GZ_PrincipalDivisorUPolNC(C,D[1])-GZ_PrincipalDivisorUPolNC(C,D[2]);
end );
