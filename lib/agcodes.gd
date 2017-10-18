#############################################################################
##
#W  agcodes.gd                   GZero Package                  Gabor P. Nagy
##
##  Declaration file for genus zero agcodes
##
#Y  Copyright (C) 2017 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 09/06/2017
##

#############################################################################
##
#C  IsGZ_Code(<obj>)
##  
##  <#GAPDoc Label="IsGZ_Code">
##  <ManSection>
##  <Filt Name="IsGZ_Code" Arg='obj' Type='Category'/>
##  <Filt Name="IsGZ_FunctionalCode" Arg='obj' Type='Category'/>
##  <Filt Name="IsGZ_DifferentialCode" Arg='obj' Type='Category'/>
##  
##  <Description>
##  A genus zero code is an algebraic-geometric code defined on an algebraic curve of genus zero.
##  AG-codes are either of functional or of differential type.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareFilter( "IsGZ_FunctionalCode" );
DeclareFilter( "IsGZ_DifferentialCode" );
DeclareCategory( "IsGZ_Code", IsVectorSpace );

#############################################################################
##
#C  GeneratorMatrixOfFunctionalGZ_CodeNC(G,pls)
##  
##  <#GAPDoc Label="GeneratorMatrixOfFunctionalGZ_CodeNC">
##  <ManSection>
##  <Func Name="GeneratorMatrixOfFunctionalGZ_CodeNC" Arg='G,pls'/>
##  
##  <Description>
##  returns the generator matrix of the functional AG code <M>C_L(D,G)</M>, where
##  <M>D</M> is the sum of the degree one places in the list <A>pls</A>. The support of 
##  <A>G</A> must be disjoint from <A>pls</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "GeneratorMatrixOfFunctionalGZ_CodeNC" );

#############################################################################
##
#F  GZ_FunctionalCode(<G>,<D>)
#F  GZ_FunctionalCode(<G>)
##
##  <#GAPDoc Label="GZ_FunctionalCode">
##  <ManSection>
##  <Oper Name="GZ_FunctionalCode" Arg='G,D'/>
##  <Oper Name="GZ_FunctionalCode" Arg='G'/>
##
##  <Description>
##  returns the functional AG code 
##  <M>C_L(D,G)=\{(f(P_1),\ldots,f(P_n)) \mid f\in L(G)\}.</M> 
##  <M>D</M> and <M>G</M> are rational divisors of the
##  genus zero curve <M>C</M>. <M>D=P_1+\cdots+D_n</M>, where <M>P_1,\ldots,P_n</M> are degree one places
##  of <M>C</M>. The supports of <M>D</M> and <M>G</M> are disjoint. If <M>D</M> is not given then it is the 
##  sum of affine rational places of <M>C</M>. By the Riemann-Roch theorem, functional codes have 
##  dimension <M>\deg(G)+1-g</M>. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "GZ_FunctionalCode", [IsGZ_Divisor,IsGZ_Divisor] );
DeclareOperation( "GZ_FunctionalCode", [IsGZ_Divisor] );

#############################################################################
##
#F  GZ_DifferentialCode(<G>,<D>)
#F  GZ_DifferentialCode(<G>)
##
##  <#GAPDoc Label="GZ_DifferentialCode">
##  <ManSection>
##  <Oper Name="GZ_DifferentialCode" Arg='G,D'/>
##  <Oper Name="GZ_DifferentialCode" Arg='G'/>
##
##  <Description>
##  returns the differential AG code 
##  <M>C_\Omega(D,G) = \{res_{P_1}(\omega),\ldots,res_{P_n}(\omega) \mid \omega \in \Omega(G-D)\}.</M>
##  <M>D</M> and <M>G</M> are rational divisors of the
##  genus zero curve <M>C</M>. <M>D=P_1+\cdots+D_n</M>, where <M>P_1,\ldots,P_n</M> are degree one places
##  of <M>C</M>. The supports of <M>D</M> and <M>G</M> are disjoint. If <M>D</M> is not given then it is the 
##  sum of affine rational places of <M>C</M>. The differential code is the dual of the corresponding 
##  functional code. By the Riemann-Roch theorem, differential codes have dimension <M>n-\deg(G)-1+g</M>. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "GZ_DifferentialCode", [IsGZ_Divisor,IsGZ_Divisor] );
DeclareOperation( "GZ_DifferentialCode", [IsGZ_Divisor] );



#############################################################################
##
#F  UnderlyingCurveOfGZ_Code(C)
##
##  <#GAPDoc Label="UnderlyingCurveOfGZ_Code">
##  <ManSection>
##  <Func Name="UnderlyingCurveOfGZ_Code" Arg='C'/>
##
##  <Description>
##  returns the underlying genus zero curve of the AG code <A>C</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "UnderlyingCurveOfGZ_Code" );

#############################################################################
##  
#A  UnderlyingField(<C>)
##  
##  <#GAPDoc Label="UnderlyingField_Code">
##  <ManSection>
##  <Attr Name="UnderlyingField" Arg='C'/>
##  
##  <Description>
##  The underlying field of an AG code is its left acting domain. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingField", IsGZ_Code );

#############################################################################
##
#A  Length(<C>)
##  
##  <#GAPDoc Label="Length_Code">
##  <ManSection>
##  <Attr Name="Length" Arg='C'/>
##  
##  <Description>
##  returns the length of the AG code <A>C</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Length", IsGZ_Code );

#############################################################################
##
#A  GeneratorMatrixOfGZ_Code(<C>)
##  
##  <#GAPDoc Label="GeneratorMatrixOfGZ_Code">
##  <ManSection>
##  <Attr Name="GeneratorMatrixOfGZ_Code" Arg='C'/>
##  
##  <Description>
##  returns the generator matrix of the AG code <A>C</A> in <Package>CVEC</Package> matrix format.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "GeneratorMatrixOfGZ_Code", IsGZ_Code );

#############################################################################
##  
#A  DesignedMinimumDistance(<C>)
##  
##  <#GAPDoc Label="DesignedMinimumDistance">
##  <ManSection>
##  <Attr Name="DesignedMinimumDistance" Arg='C'/>
##  
##  <Description>
##  returns the designed minimum distance <M>\delta</M> of the genus zero AG code <A>C</A>. 
##  When <M>\deg(G)\geq 2g-2</M>, then the general formulas for <M>\delta</M> are as follows. 
##  For the functional code <M>C_L(D,G)</M>, <M>\delta=n-\deg(G)</M>, and for the differential
##  code <M>C_\Omega(D,G)</M>, <M>\delta=\deg(G)-(2g-2)</M>. For genus zero curves, <M>g=0</M> and
##  these formulas give the true minimum distances. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DesignedMinimumDistance", IsGZ_Code );

################
### DECODING ###
################
#############################################################################
##  
#A  GZ_DecodeToCodeword(<C>,<w>)
##  
##  <#GAPDoc Label="GZ_DecodeToCodeword">
##  <ManSection>
##  <Oper Name="GZ_DecodeToCodeword" Arg='C,w'/>
##  
##  <Description>
##  Let <M>\delta</M> be the designed minimum distance of <A>C</A>, and define <M>t=[(\delta-1)/2]</M>.
##  If there is a codeword <M>c\in C</M> with <M>d(c,w)\leq t</M> then <M>c</M> is returned.
##  Otherwise, the output is <C>fail</C>.
##  <P/>The decoding algorithm is from [Hoholdt-Pellikaan 1995]. The function <C>GZ_DECODER_DATA</C> 
##  precomputes two matrices which are stored as attributes of the AG code. The decoding consists
##  of solving linear equations. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "GZ_DECODER_DATA", IsGZ_Code );
DeclareOperation( "GZ_DecodeToCodeword", [IsGZ_Code,IsFFECollection] );

