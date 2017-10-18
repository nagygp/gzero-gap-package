LoadPackage("gzero");

#################

if not IsBound(q) then 
	q:=5^3;
fi;

# construct the curve and the divisors
Y:=Indeterminate(GF(q),"Y");
C:=GZ_Curve(GF(q),Y);
P_infty:=GZ_1PointDivisor(C,infinity); 

fr:=FrobeniusAutomorphismOfGZ_Curve(C);
G0:=Sum(AC_FrobeniusAutomorphismOrbit(fr,RandomPlaceOfGZ_Curve(C,4)));

#G:=Int(q/40+1)*G0+7*P_infty;
G:=Int(q/60+1)*G0+7*P_infty;
Degree(G);

len:=Int(0.8*q);
D:=Sum([1..len],i->GZ_1PointDivisor(C,Elements(GF(q))[i]));

# construct the AG differential code
agcode:=GZ_DifferentialCode(G,D);

#################

aut:=AutomorphismGroup(C);
a:=Random(aut);
agcode2:=agcode^a;


