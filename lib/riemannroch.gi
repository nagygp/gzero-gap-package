#############################################################################
##
#W  riemannroch.gi               GZero Package                  Gabor P. Nagy
##
##  Implementation file for genus zero Riemann-Roch spaches
##
#Y  Copyright (C) 2017 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 10/01/2017
##

InstallGlobalFunction( GZ_Equivalent1PointDivisor, function( D )
	local Y,i,f,fe,q;
	if not IsGZ_Divisor(D) then 
		Error("argument must be a genus zero divisor");
	fi;
	Y:=IndeterminateOfGZ_Divisor(D);
	f:=One(Y);
	q:=Size(UnderlyingField(D));
	for i in [1..Length(D!.points)] do
		if not IsInfinity(D!.points[i]) then 
			f:=f*(Y-D!.points[i])^D!.orders[i];
		fi;
	od;
	if IsRationalGZ_Divisor(D) then
		if IsUnivariatePolynomial(f) then 
			f:=UPolCoeffsToSmallFieldNC(f,q);
		else
			f:=UPolCoeffsToSmallFieldNC(NumeratorOfRationalFunction(f),q)/UPolCoeffsToSmallFieldNC(DenominatorOfRationalFunction(f),q);
		fi;
	fi;
	return [f,Degree(D)];
end );


InstallGlobalFunction( GZ_RiemannRochSpaceBasis, function( D )
	local f,m,Y;
	if not IsGZ_Divisor(D) then 
		Error("argument must be a genus zero divisor");
	fi;
	Y:=IndeterminateOfGZ_Divisor(D);
	m:=GZ_Equivalent1PointDivisor(D);
	f:=1/m[1]; m:=m[2];
	return List([0..m],i->Y^i*f);
end );
