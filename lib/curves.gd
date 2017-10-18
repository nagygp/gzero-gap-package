#############################################################################
##
#W  curves.gd                   GZero Package                  Gabor P. Nagy
##
##  Declaration file for genus zero curves
##
#Y  Copyright (C) 2017 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 09/06/2017
##

#############################################################################
##
#C  IsGZ_Curve(<obj>)
##  
##  <#GAPDoc Label="IsGZ_Curve">
##  <ManSection>
##  <Filt Name="IsGZ_Curve" Arg='obj' Type='Category'/>
##  
##  <Description>
##  A genus zero curve is the projective line over an algebraically closed field.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsGZ_Curve", IsObject );

#############################################################################
##
#R  IsGZ_CurveRep
##
##  <ManSection>
##  <Filt Name="IsGZ_CurveRep" Arg='obj' Type='Representation'/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  
DeclareRepresentation( "IsGZ_CurveRep", IsComponentObjectRep, ["fieldsize","char","indnr"] );
BindGlobal("GZ_CurveFamily",NewFamily("GZ_CurveFam"));

#############################################################################
##
#F  GZ_Curve(<K>,<X>)
##
##  <#GAPDoc Label="GZ_Curve">
##  <ManSection>
##  <Oper Name="GZ_Curve" Arg='K,X'/>
##
##  <Description>
##  returns the corresponding genus zero divisor over the algebraic closure
##  of the field <A>K</A>. The indeterminate <A>X</A> generates the corresponding
##  rational function field <M>K(X)</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "GZ_Curve", [IsField,IsLaurentPolynomial] );

#############################################################################
##
#F  IndeterminateOfGZ_Curve(C)
##
##  <#GAPDoc Label="IndeterminateOfGZ_Curve">
##  <ManSection>
##  <Func Name="IndeterminateOfGZ_Curve" Arg='C'/>
##
##  <Description>
##  returns the indeterminate of the function field of the genus zero curve <A>C</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "IndeterminateOfGZ_Curve" );

#############################################################################
##  
#A  UnderlyingField(<C>)
##  
##  <#GAPDoc Label="UnderlyingField_Curve">
##  <ManSection>
##  <Attr Name="UnderlyingField" Arg='C'/>
##  
##  <Description>
##  The underlying field of a genus zero curve is the field of coefficients
##  of the corresponding algebraic function field.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingField", IsGZ_Curve );

#############################################################################
##
#F  RandomPlaceOfGZ_Curve(C)
#F  RandomPlaceOfGZ_Curve(C,d)
##
##  <#GAPDoc Label="RandomPlaceOfGZ_Curve">
##  <ManSection>
##  <Oper Name="RandomPlaceOfGZ_Curve" Arg='C'/>
##  <Oper Name="RandomPlaceOfGZ_Curve" Arg='C,d'/>
##
##  <Description>
##  returns a random rational place of the genus zero curve <A>C</A>. If the second
##  argument <A>d</A> is given, then it returns a place of degree <A>d</A>. Here,
##  a place is a 1-point divisor of degree one. Notice that the place at infinity is rational.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "RandomPlaceOfGZ_Curve", [IsGZ_Curve] );
DeclareOperation( "RandomPlaceOfGZ_Curve", [IsGZ_Curve,IsPosInt] );

#############################################################################
##
#F  FrobeniusAutomorphismOfGZ_Curve(C)
##
##  <#GAPDoc Label="FrobeniusAutomorphismOfGZ_Curve">
##  <ManSection>
##  <Oper Name="FrobeniusAutomorphismOfGZ_Curve" Arg='C'/>
##
##  <Description>
##  returns the Frobenius automorphism of the underlying field of the genus zero curve <A>C</A>.
##  More precisely, the output is an AC-Frobenius automorphism in the sense of the package <Package>OnAlgClosure</Package>,
##  acting on the algebraic closure of the underlying finite field.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "FrobeniusAutomorphismOfGZ_Curve", [IsGZ_Curve] );

