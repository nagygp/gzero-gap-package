###################################################################################
##
#W  automorphisms.gd                   GZero Package                  Gabor P. Nagy
##
##  Declaration file for automorphisms of genus zero curves and their codes
##
#Y  Copyright (C) 2017 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 08/07/2017
##

#############################################################################
##
#C  IsGZ_CurveAutomorphism(<obj>)
##
##  <#GAPDoc Label="IsGZ_CurveAutomorphism">
##  <ManSection>
##  <Filt Name="IsGZ_CurveAutomorphism" Arg='obj' Type='Category'/>
##
##  <Description>
##  With automorphisms of an algebraic curve <M>C</M> one means the automorphisms of the corresponding
##  algebraic function field <M>K(C)</M>. For genus zero curves over finite fields, the algebraic function
##  field is the field <M>K(t)</M> of rational functions in one indeterminate. <M>Aut(K(t))</M> consists of
##  fractional linear mappings <M>t\mapsto \frac{a+bt}{c+dt}</M>, where <M>ad-bc\neq 0</M>. Hence,
##  <M>Aut(K(t))\cong PGL(2,K)</M>.
##  <P/>With fixed Frobenius automorphism <M>\Phi:x\mapsto x^q</M>, we can speak of <M>GF(q)</M>-rational
##  automorphisms, or, automorphisms defined over <M>GF(q)</M>. These form a subgroup isomorphic to
##  <M>PGL(2,q)</M>, having a faithful permutation representation of the set <M>GF(q)\cup \{\infty\}</M>
##  of <M>GF(q)</M>-rational places.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsGZ_CurveAutomorphism", IsMultiplicativeElementWithInverse );
DeclareRepresentation( "IsGZ_CurveAutomorphismRep", IsPositionalObjectRep and IsMultiplicativeElement, [1] );
GZ_CurveAutomorphismFamily:=NewFamily("GZ_CurveAutomorphismFam");

#############################################################################
##
#C  GZ_CurveAutomorphism(<obj>)
##
##  <#GAPDoc Label="GZ_CurveAutomorphism">
##  <ManSection>
##  <Oper Name="GZ_CurveAutomorphism" Arg='mat'/>
##
##  <Returns>
##  the automorphism <M>t\mapsto \frac{a+bt}{c+dt}</M> of the genus zero curve, where <A>M</A> is the
##  nonsingular <M>2\times 2</M> matrix <M>\begin{pmatrix}a &amp; c\\ b&amp; d\end{pmatrix}</M>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("GZ_CurveAutomorphism", [ IsMatrix and IsFFECollColl ]);
DeclareSynonym("GZ_CurveAut",GZ_CurveAutomorphism);

#############################################################################
##
#C  MatrixGroupToGZ_CurveAutGroup(<matgr>,<agcode>)
##
##  <#GAPDoc Label="GZ_CurveAutGroup">
##  <ManSection> <Heading>AutomorphismGroup</Heading>
##  <Func Name="MatrixGroupToGZ_CurveAutGroup" Arg='matgr,C'/>
##
##  <Returns>
##  the GZ curve automorphism group $G$ corresponding to the matrix group <A>matgr</A>.
##  </Returns>
##  <Description>
##  The permutation action of <A>matgr</A> on the set of rational places of <A>C</A> is stored as
##  a nice monomorphism of $G$.
##  </Description>
##
##  <Oper Name="AutomorphismGroup" Arg='C'/>
##  <Returns>
##  the automorphism group of the genus zero curve <A>C</A>. The elements are genus zero automorphisms. The
##  group is isomorphic to <M>PGL(2,q)</M>, where <M>GF(q)</M> is the underlying field of <A>C</A>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "MatrixGroupToGZ_CurveAutGroup" );

#E  automorphisms.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here#! @Arguments matgr,orb
