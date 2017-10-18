#############################################################################
##
#W  agcodes.gi                   GZero Package                  Gabor P. Nagy
##
##  Implementation file for genus zero agcodes
##
#Y  Copyright (C) 2017 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 09/06/2017

#############################################################################
##
#F  IsGZ_Code(<obj>)
##
InstallTrueMethod( IsGZ_Code, IsGZ_FunctionalCode );
InstallTrueMethod( IsGZ_Code, IsGZ_DifferentialCode );


#############################################################################
##  CONSTRUCTORS
##  -------------------------------------------------------------------------

#############################################################################
##
#F  GeneratorMatrixOfFunctionalGZ_CodeNC(<G>,<pls>)
##
InstallGlobalFunction( GeneratorMatrixOfFunctionalGZ_CodeNC, function(G,pls) 
	local rr,ret,f,p,indet,i,j,val,q;
	# the computation of the Riemann-Roch space is fast
	rr:=GZ_RiemannRochSpaceBasis(G);
	indet:=IndeterminateOfGZ_Divisor(G);
	q:=Size(UnderlyingField(G));
	ret:=CVEC_ZeroMat(Length(rr),CVecClass(GF(q),Length(pls)));
	i:=0;
	# filling out the entries of the generator matrix takes long
	for f in rr do
		i:=i+1;
		j:=0;
		for p in pls do
			j:=j+1;
			if IsFFE(p) then
				val:=Value(f,[indet],[p]);
			else
				val:=LeadingCoefficient(NumeratorOfRationalFunction(f)) /
					LeadingCoefficient(NumeratorOfRationalFunction(f));
			fi;
#			if IsZero(val) then val:=0*Z(q); else val:=Z(q)^LogFFE(val,Z(q)); fi;
			ret[i][j]:=val;
		od;
	od;
	MakeImmutable(ret);
	return ret;
end);

#############################################################################
##
#F  GZ_FunctionalCode(<G>,<D>)
#F  GZ_FunctionalCode(<G>)
##
InstallMethod( GZ_FunctionalCode, "for two genus zero divisors", true, [IsGZ_Divisor,IsGZ_Divisor], 0, 
function(G,D)
	local genmat,code,ff,len;
	if not (IsRationalGZ_Divisor(G) and IsRationalGZ_Divisor(D) and Set(D!.orders)=[1]) then
		Error("wrong input");
	fi;
	if not Intersection(Support(G),Support(D))=[] then 
		Error("supports of divisors must be disjoint");
	fi;
	genmat:=GeneratorMatrixOfFunctionalGZ_CodeNC(G,Support(D));
	ff:=UnderlyingField(G);
	len:=Length(Support(D));
	code:=Subspace(ff^len,Unpack(genmat));
	SetFilterObj(code,IsGZ_FunctionalCode);
	SetLength(code,len);
	SetGeneratorMatrixOfGZ_Code(code,genmat);
	if Degree(G)>=-2 then SetDesignedMinimumDistance(code,len-Degree(G)); fi;
	code!.gzcurve:=G!.curve;
	code!.gendivs:=[G,D];
	return code;
end);

InstallMethod( GZ_FunctionalCode, "for one genus zero divisor", true, [IsGZ_Divisor], 0, 
function(G)
	local ff,D;
	if not (IsRationalGZ_Divisor(G)) then
		Error("wrong input");
	fi;
	ff:=UnderlyingField(G);
	if ForAny(ff,x->x in Support(G)) then 
		Error("supports of divisor may not contain affine rational places");
	fi;
	D:=Sum(ff,x->GZ_1PointDivisor(G!.curve,x));
	return GZ_FunctionalCode(G,D);
end);

#############################################################################
##
#F  GZ_DifferentialCode(<G>,<D>)
#F  GZ_DifferentialCode(<G>)
##
InstallMethod( GZ_DifferentialCode, "for two genus zero divisors", true, [IsGZ_Divisor,IsGZ_Divisor], 0, 
function(G,D)
	local genmat,code,ff,len;
	if not (IsRationalGZ_Divisor(G) and IsRationalGZ_Divisor(D) and Set(D!.orders)=[1]) then
		Error("wrong input");
	fi;
	if not Intersection(Support(G),Support(D))=[] then 
		Error("supports of divisors must be disjoint");
	fi;
	genmat:=GeneratorMatrixOfFunctionalGZ_CodeNC(G,Support(D));
	genmat:=NullspaceMat(TransposedMat(genmat));
	ff:=UnderlyingField(G);
	len:=Length(Support(D));
	code:=Subspace(ff^len,List(genmat,Unpack));
	SetFilterObj(code,IsGZ_DifferentialCode);
	SetLength(code,len);
	SetGeneratorMatrixOfGZ_Code(code,genmat);
	if Degree(G)>=-2 then SetDesignedMinimumDistance(code,Degree(G)+2); fi;
	code!.gzcurve:=G!.curve;
	code!.gendivs:=[G,D];
	return code;
end);

InstallMethod( GZ_DifferentialCode, "for one genus zero divisor", true, [IsGZ_Divisor], 0, 
function(G)
	local ff,D;
	if not (IsRationalGZ_Divisor(G)) then
		Error("wrong input");
	fi;
	ff:=UnderlyingField(G);
	if ForAny(ff,x->x in Support(G)) then 
		Error("supports of divisor may not contain affine rational places");
	fi;
	D:=Sum(ff,x->GZ_1PointDivisor(G!.curve,x));
	return GZ_DifferentialCode(G,D);
end);

#############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  -------------------------------------------------------------------------

InstallMethod( ViewObj, "for a genus zero agcode",
	[ IsGZ_Code ], 10, 
function( C )
	Print( "<[", Length(C), ",", Dimension(C), "] genus zero AG-code over ", LeftActingDomain(C), ">" );
end );

InstallMethod( Display, "for a genus zero agcode",
	[ IsGZ_Code ], 10,
function( C )
	Print( "<[", Length(C), ",", Dimension(C), "] genus zero AG-code over ", LeftActingDomain(C), ">" );
end );

# Methods for vector spaces must be OK.

InstallMethod( PrintObj, "for a genus zero agcode",
	[ IsGZ_Code ], 10, 
function( C ) 
	if IsGZ_FunctionalCode(C) then 
		Print("GZ_FunctionalCode(", C!.gendivs[1], ",", C!.gendivs[2], ")"); 
	else
		Print("GZ_DifferentialCode(", C!.gendivs[1], ",", C!.gendivs[2], ")"); 
	fi;
end );

#InstallMethod( \=, "for two genus zero agcodes", IsIdenticalObj, [ IsGZ_Code, IsGZ_Code ], function( C1, C2 ) end );
#InstallMethod( \<, "for two genus zero agcodes", IsIdenticalObj, [ IsGZ_Code, IsGZ_Code ], function( C1, C2 ) end );

#############################################################################
##  UTILITIES
##  -------------------------------------------------------------------------

InstallMethod( UnderlyingField,
	"for a genus zero code",
	[ IsGZ_Code ],
function( C )
	return LeftActingDomain(C);
end );

#############################################################################
##  DECODING
##  -------------------------------------------------------------------------

InstallMethod( GZ_DECODER_DATA, "for a genus zero AG code", true, [ IsGZ_Code ], 0,
function(agcode)
	local t,F,pls,mat1,mat2;
	t:=Int((DesignedMinimumDistance(agcode)-1)/2);
	F:=t*GZ_1PointDivisor(agcode!.gzcurve,infinity);
	pls:=Support(agcode!.gendivs[2]);;
	if IsGZ_DifferentialCode(agcode) then
		mat1:=GeneratorMatrixOfFunctionalGZ_CodeNC(agcode!.gendivs[1]-F,pls);
	else
		mat1:=GeneratorMatrixOfFunctionalGZ_CodeNC(agcode!.gendivs[1]+F,pls);
		mat1:=NullspaceMat(TransposedMat(mat1));
	fi;
	mat2:=GeneratorMatrixOfFunctionalGZ_CodeNC(F,pls);
	mat2:=NullspaceMat(TransposedMat(mat2));
	return [mat1,mat2];
end);

InstallMethod( GZ_DecodeToCodeword, "for a genus zero AG code and a vector", true, [ IsGZ_Code, IsFFECollection ], 0,
function(agcode, received)
	local precomp,diag,i,sol,zeropos,mat,rhs;
	if not(Characteristic(agcode)=Characteristic(received)) then
		Error("arguments must have the same characteristic");
	fi;
	if not(Length(agcode)=Length(received)) then
		Error("arguments must have the same length");
	fi;

	precomp:=GZ_DECODER_DATA(agcode);
	diag:=CVEC_ZeroMat(Length(agcode),CVecClass(LeftActingDomain(agcode),Length(agcode)));
	for i in [1..Length(agcode)] do diag[i][i]:=received[i]; od;
	sol:=precomp[1]*diag;
	Append(sol,precomp[2]);
	sol:=NullspaceMat(TransposedMat(sol));

	zeropos:=List(sol,x->Filtered([1..Length(agcode)],i->IsZero(x[i])));
	zeropos:=Intersection(zeropos);

	mat:=ExtractSubMatrix(GeneratorMatrixOfGZ_Code(agcode),[1..Dimension(agcode)],Difference([1..Length(agcode)],zeropos));
	rhs:=received{Difference([1..Length(agcode)],zeropos)};

	sol:=SolutionMatDestructive(mat,rhs);
	if sol=fail then 
		return fail; 
	fi;
	if Is8BitVectorRep(sol) then 
		sol:=CVec(sol);
	else
		sol:=CVec(sol,CVecClass(LeftActingDomain(agcode),Length(sol)));
	fi;
	return sol*GeneratorMatrixOfGZ_Code(agcode);
end);



