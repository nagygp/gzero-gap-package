#############################################################################
##
#W  divisors.gd                  GZero Package                 Gabor P. Nagy
##
##  Declaration file for arithmetics of genus zero divisors
##
#Y  Copyright (C) 2017 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 10/01/2017
##

#############################################################################
##
#C  IsGZ_Divisor(<obj>)
##
##  <#GAPDoc Label="IsGZ_Divisor">
##  <ManSection>
##  <Filt Name="IsGZ_Divisor" Arg='obj' Type='Category'/>
##
##  <Description>
##  A genus zero divisor is a divisor of an algebraic function field of genus 0.
##  Genus zero divisors form an additive commutative group.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsGZ_Divisor", IsAdditiveElementWithInverse and IsExtLElement );

#############################################################################
##
#R  IsGZ_DivisorRep
##
##  <ManSection>
##  <Filt Name="IsGZ_DivisorRep" Arg='obj' Type='Representation'/>
##
##  <Description>
##  </Description>
##  </ManSection>
##
DeclareRepresentation( "IsGZ_DivisorRep", IsAdditiveElement and IsComponentObjectRep, ["curve","char","indnr"] );
BindGlobal("GZ_DivisorFamily",NewFamily("GZ_DivisorFam",IsAdditivelyCommutativeElementFamily));

#############################################################################
##
#F  GZ_DivisorConstruct(<X>,<pts>,<ords>)
##
##  <#GAPDoc Label="GZ_DivisorConstruct">
##  <ManSection>
##  <Func Name="GZ_DivisorConstruct" Arg='X,pts,ords'/>
##
##  <Description>
##  returns the genus zero divisor over <M>K(X)</M> with points from <A>pts</A>
##  and corresponding orders from <A>ords</A>. <M>K</M> is the prime field of
##  the coefficient field of <A>X</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "GZ_DivisorConstruct" );

#############################################################################
##
#F  IndeterminateOfGZ_Divisor(D)
##
##  <#GAPDoc Label="IndeterminateOfGZ_Divisor">
##  <ManSection>
##  <Func Name="IndeterminateOfGZ_Divisor" Arg='D'/>
##
##  <Description>
##  returns the indeterminate of the function field of the genus zero divisor <A>D</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "IndeterminateOfGZ_Divisor" );

#############################################################################
##
#F  GZ_Divisor(<C>,<pts>,<ords>)
#F  GZ_Divisor(<C>,<pairs>)
##
##  <#GAPDoc Label="GZ_Divisor">
##  <ManSection>
##  <Oper Name="GZ_Divisor" Arg='C,pts,ords'/>
##  <Oper Name="GZ_Divisor" Arg='C,pairs'/>
##
##  <Description>
##  returns the corresponding genus zero divisor over the algebraic function
##  field <A>F</A>. If the indeterminate <A>X</A> is given, then <M>F=K(X)</M>,
##  where <M>K</M> is the prime field of the coefficient field of <A>X</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "GZ_Divisor", [IsGZ_Curve,IsList] );
DeclareOperation( "GZ_Divisor", [IsGZ_Curve,IsList,IsList] );

#############################################################################
##
#F  GZ_ZeroDivisor(<C>)
##
##  <#GAPDoc Label="GZ_ZeroDivisor">
##  <ManSection>
##  <Oper Name="GZ_ZeroDivisor" Arg='C'/>
##
##  <Description>
##  returns the zero divisor over the algebraic function field <A>F</A> of
##  genus zero. If the indeterminate <A>X</A> is given, then <M>F=K(X)</M>,
##  where <M>K</M> is the prime field of the coefficient field of <A>X</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "GZ_ZeroDivisor", [IsGZ_Curve] );

#############################################################################
##
#F  GZ_1PointDivisor(<C>, <pt>)
#F  GZ_1PointDivisor(<C>, <pt>, <m>)
##
##  <#GAPDoc Label="GZ_1PointDivisor">
##  <ManSection>
##  <Oper Name="GZ_1PointDivisor" Arg='C,pt'/>
##  <Oper Name="GZ_1PointDivisor" Arg='C,pt,m'/>
##
##  <Description>
##  returns the zero divisor over the algebraic function field <A>F</A> of
##  genus zero. If the indeterminate <A>X</A> is given, then <M>F=K(X)</M>,
##  where <M>K</M> is the prime field of the coefficient field of <A>X</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "GZ_1PointDivisor", [IsGZ_Curve,IsRingElementWithInverse] );
DeclareOperation( "GZ_1PointDivisor", [IsGZ_Curve,IsRingElementWithInverse,IsInt] );
DeclareOperation( "GZ_1PointDivisor", [IsGZ_Curve,IsInfinity] );
DeclareOperation( "GZ_1PointDivisor", [IsGZ_Curve,IsInfinity,IsInt] );

#############################################################################
#############################################################################
##
## DIVISOR UTILITY FUNCTIONS
##
#############################################################################
#############################################################################

#############################################################################
##
#F  GZ_SupremumDivisor(<D1>,<D2>)
##
##  <#GAPDoc Label="GZ_SupremumDivisor">
##  <ManSection>
##  <Func Name="GZ_SupremumDivisor" Arg='D1,D2'/>
##
##  <Description>
##  returns the place-wise maximum of the orders of <A>D1</A> and <A>D2</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "GZ_SupremumDivisor" );

#############################################################################
##
#F  GZ_InfimumDivisor(<D1>,<D2>)
##
##  <#GAPDoc Label="GZ_InfimumDivisor">
##  <ManSection>
##  <Func Name="GZ_InfimumDivisor" Arg='D1,D2'/>
##
##  <Description>
##  returns the place-wise minimum of the orders of <A>D1</A> and <A>D2</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "GZ_InfimumDivisor" );

#############################################################################
##
#F  GZ_PositivePartOfDivisor(<D>)
##
##  <#GAPDoc Label="GZ_PositivePartOfDivisor">
##  <ManSection>
##  <Func Name="GZ_PositivePartOfDivisor" Arg='D'/>
##
##  <Description>
##  returns the positive part of the divisor <A>D</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "GZ_PositivePartOfDivisor" );

#############################################################################
##
#F  GZ_NegativePartOfDivisor(<D>)
##
##  <#GAPDoc Label="GZ_NegativePartOfDivisor">
##  <ManSection>
##  <Func Name="GZ_NegativePartOfDivisor" Arg='D'/>
##
##  <Description>
##  returns the negative part of the divisor <A>D</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "GZ_NegativePartOfDivisor" );

#############################################################################
##
#F  GZ_MultiplicityOfRoot_NotNeeded(<pol>,<t>)
##
##  Returns the multiplicity of the root <t> in the polynomial <pol>.
##
DeclareGlobalFunction( "GZ_MultiplicityOfRoot_NotNeeded" );

#############################################################################
##
#F  GZ_ValuationAtPlace_NotNeeded(<t>,<ratfun>)
##
##  Returns the valuation of the rational function <ratfun> at the place <t>.
##  Taking no care of the indeterminate and other arguments.
##
DeclareGlobalFunction( "GZ_ValuationAtPlace_NotNeeded" );

#############################################################################
##
#A  UnderlyingField(<D>)
##
##  <#GAPDoc Label="UnderlyingField_Div">
##  <ManSection>
##  <Attr Name="UnderlyingField" Arg='D'/>
##
##  <Description>
##  The underlying field of a genus zero divisor is the field of coefficients
##  of the corresponding algebraic function field.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingField", IsGZ_Divisor );

#############################################################################
##
#A  Support(<D>)
##
##  <#GAPDoc Label="Support">
##  <ManSection>
##  <Attr Name="Support" Arg='D'/>
##
##  <Description>
##  The support of a genus zero divisor is the set of points with nonzero orders.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Support", IsGZ_Divisor );

#############################################################################
##
#F  Valuation(<t>,<D>)
#F  Valuation(<t>,<ratfun>)
##
##  <#GAPDoc Label="Valuation">
##  <ManSection>
##  <Oper Name="Valuation" Arg='t,D'/>
##  <Oper Name="Valuation" Arg='t,ratfun'/>
##
##  <Description>
##  The valuation of a genus zero divisor <M>D</M> at the point <M>t</M> is
##  its corresponding order. The valuation of a rational function <M>f=g/h</M>
##  at the point <A>t</A> is either the multiplicity of the root <A>t</A> in
##  <M>g</M>, or minus the multiplicity of the root <A>t</A> in <M>h</M>.
##  If <A>t</A> is <M>\infty</M> then the valuation is <M>\deg(h)-\deg(g)</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Valuation", [IsRingElementWithInverse,IsGZ_Divisor] );
DeclareOperation( "Valuation", [IsRingElementWithInverse,IsUnivariateRationalFunction] );

#############################################################################
##
#A  IsRationalGZ_Divisor(<D>)
##
##  <#GAPDoc Label="IsRationalGZ_Divisor">
##  <ManSection>
##  <Attr Name="IsRationalGZ_Divisor" Arg='D'/>
##
##  <Description>
##  Returns true if <A>D</A> is invariant under the Frobenius automorphism of the underling genus zero curve.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IsRationalGZ_Divisor", IsGZ_Divisor );

#############################################################################
##
#F  GZ_PrincipalDivisor(f)
##
##  <#GAPDoc Label="GZ_PrincipalDivisor">
##  <ManSection>
##  <Func Name="GZ_PrincipalDivisor" Arg='C,f'/>
##
##  <Description>
##  returns the principal divisor of the rational function <A>f</A> of the
##  genus zero curve <A>C</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "GZ_PrincipalDivisorUPolNC" );
DeclareGlobalFunction( "GZ_PrincipalDivisor" );
