# Test(Filename(DirectoriesPackageLibrary("gzero"),"../tst/testall.tst"));
LogTo("/tmp/gzerotest.log");
START_TEST("GZero package: testall.tst");
SizeScreen([72]);
LoadPackage("gzero",false);

### curves
Y:=Indeterminate(GF(9),"Y");
C:=GZ_Curve(GF(9),Y);
aut:=AutomorphismGroup(C);
Random(aut);

### divisors
p1:=GZ_1PointDivisor(C,infinity);
p2:=GZ_1PointDivisor(C,Z(3));  
d:=3*p1-4*p2;
Support(d);
UnderlyingField(d);
Zero(d);
Characteristic(d);

d:=GZ_Divisor(C,[Z(27)^2,Z(3),infinity],[5,-1,2]);
Valuation(Z(3),d);
Valuation(Z(3)^2,d);

fr:=AC_FrobeniusAutomorphism(9);
d^fr;
Support(d^fr);
Support(d);

rf:=Y^8-1;
List(GF(9),u->Valuation(u,rf));
List(GF(9),u->Valuation(u,One(Y)));
List(GF(9),u->Valuation(u,Zero(Y)));


List(GF(3),u->Valuation(u,One(Y)));
List(GF(3),u->Valuation(u,Zero(Y)));

### RR spaces
a:=RandomPlaceOfGZ_Curve(C,4);
fr:=FrobeniusAutomorphismOfGZ_Curve(C);
d:=Sum(AC_FrobeniusAutomorphismOrbit(fr,a));
IsRationalGZ_Divisor(d);

GZ_RiemannRochSpaceBasis(3*d);
ForAll(last,x->x=x^fr);

### AG codes
code:=GZ_FunctionalCode(d);
Print(code);
DesignedMinimumDistance(code);

### decoding
q:=5^3;
# construct the curve and the divisors
Y:=Indeterminate(GF(q),"Y");
C:=GZ_Curve(GF(q),Y);
P_infty:=GZ_1PointDivisor(C,infinity); 

fr:=FrobeniusAutomorphismOfGZ_Curve(C);
P4:=Sum(AC_FrobeniusAutomorphismOrbit(fr,RandomPlaceOfGZ_Curve(C,4)));
G:=5*P4+7*P_infty;
Degree(G);

len:=90;
D:=Sum([1..len],i->GZ_1PointDivisor(C,Elements(GF(q))[i]));

# construct the AG differential code
agcode:=GZ_DifferentialCode(G,D);
DesignedMinimumDistance(agcode);
Length(agcode)-Degree(G)-1;

# test codeword generation
t:=Int((DesignedMinimumDistance(agcode)-1)/2);
sent:=Random(agcode);;
err:=RandomVectorOfGivenWeight(GF(q),Length(agcode),t);;
received:=sent+err;;

# decoding
sent_decoded:=GZ_DecodeToCodeword(agcode,received);
sent=sent_decoded;

### Example: BCH code construct
my_BCH:=function(n,l,delta,F)
	local q,m,r,s,beta,Y,C,D_beta,P_0,P_infty,agcode;
	#
	q:=Size(F);
	m:=OrderMod(q,n);
	beta:=Z(q^m)^((q^m-1)/n);
	#
	Y:=Indeterminate(F,"Y");
	C:=GZ_Curve(GF(q^m),Y);
	D_beta:=Sum([0..n-1],i->GZ_1PointDivisor(C,beta^i));
	P_0:=GZ_1PointDivisor(C,0);
	P_infty:=GZ_1PointDivisor(C,infinity);
	#
	r:=l-1;
	s:=n+1-delta-l;
	agcode:=GZ_FunctionalCode(r*P_0+s*P_infty,D_beta);
	#
	return RestrictVectorSpace(agcode,F);
end;

####
q:=2;
n:=35;
l:=1;
delta:=5;

C0:=BCHCode(n,l,delta,GF(q)); 
C1:=my_BCH(n,l,delta,GF(q)); 

Collected(List(C0,x->Number(x,y->IsOne(y))));
Collected(List(C1,x->Number(x,y->IsOne(y))));

SetDesignedMinimumDistance(C1,delta);
DesignedMinimumDistance(C1);
STOP_TEST( "testall.tst", 10000 );
LogTo();

