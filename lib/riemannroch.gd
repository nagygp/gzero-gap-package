#############################################################################
##
#W  riemannroch.gd                GZero Package                Gabor P. Nagy
##
##  Declaration file for genus zero Riemann-Roch spaches
##
#Y  Copyright (C) 2017 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 10/01/2017
##

#############################################################################
##
#F  GZ_Equivalent1PointDivisor(<D>)
##
##  <#GAPDoc Label="GZ_Equivalent1PointDivisor">
##  <ManSection>
##  <Func Name="GZ_Equivalent1PointDivisor" Arg='D'/>
##
##  <Description>
##  returns the pair <M>f,m</M>, where <M>f</M> is a rational function
##  and <M>m</M> is an integer such that <M>D=Div(f)+m P_{\infty}</M>.
##  In particular, <M>D</M> is equivalent to the 1-point divisor <M>mP_{\infty}</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "GZ_Equivalent1PointDivisor" );


#############################################################################
##
#F  GZ_RiemannRochSpace(<D>)
##
##  <#GAPDoc Label="GZ_RiemannRochSpaceBasis">
##  <ManSection>
##  <Func Name="GZ_RiemannRochSpaceBasis" Arg='D'/>
##
##  <Description>
##  returns a <B>basis</B> of the Riemann-Roch space of the genus zero divisor 
##  <A>D</A>, which is defined by <M>\{ f \in K[Y] \mid Div(f) \geq - D \}</M>. 
##  
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "GZ_RiemannRochSpaceBasis" );
