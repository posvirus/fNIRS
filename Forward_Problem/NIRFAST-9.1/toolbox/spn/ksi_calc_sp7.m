function [f1,f2,f3,f4,g1,g2,g3,g4,h1,h2,h3,h4,i1,i2,i3,i4] = ksi_calc_sp7(mesh);

%Calculates the boundary condition values for SP3 case based on equations 28a & 28b
%of Klose 2006 paper.  

BC=bound_coeffs(mesh,7);

A=BC(:,1:4);
B=BC(:,5:8);
C=BC(:,9:12);
D=BC(:,13:16);
E=BC(:,17:20);
F=BC(:,21:24);
G=BC(:,25:28);
H=BC(:,29:32);

M1=(7/24+A(:,2))-3.*D(:,2).*((1+B(:,1)).\((1/8)+C(:,1)));
M2=(1+B(:,2))-21*D(:,2).*((1+B(:,1)).\D(:,1));
M3=((1/8)+C(:,2))-3*D(:,2).*((1+B(:,1)).\((1/2)+A(:,1)));
M4= ((41/384)+E(:,2))+3*D(:,2).*((1+B(:,1)).\((-1/16)+E(:,1)));
M5=11*F(:,2)+33*D(:,2).*((1+B(:,1)).\F(:,1));
M6=((-1/16)+G(:,2))+3*D(:,2).*((1+B(:,1)).\((5/128)+G(:,1)));
M7=15*H(:,2)+45*D(:,2).*((1+B(:,1)).\H(:,1));

N1=((407/1920)+A(:,3))-3*D(:,3).*((1+B(:,1)).\((-1/16)+E(:,1)));
N2=(1+B(:,3))-33*D(:,3).*((1+B(:,1)).\F(:,1));
N3= ((-1/16)+C(:,3))-3*D(:,3).*((1+B(:,1)).\((1/2)+A(:,1)));
N4= ((41/384)+E(:,3))+3*D(:,3).*((1+B(:,1)).\((1/8)+C(:,1)));
N5=7*F(:,3)+21*D(:,3).*((1+B(:,1)).\D(:,1));
N6=((233/2560)+G(:,3))+3*D(:,3).*((1+B(:,1)).\((5/128)+G(:,1)));
N7=15*H(:,3)+45*D(:,3).*((1+B(:,1)).\H(:,1));

P1=((3023/17920)+A(:,4))-3*D(:,4).*((1+B(:,1)).\((5/128)+G(:,1)));
P2=(1+B(:,4))-45*D(:,4).*((1+B(:,1)).\H(:,1)); 
P3=((5/128)+C(:,4))-3*D(:,4).*((1+B(:,1)).\((1/2)+A(:,1)));
P4=((-1/16)+E(:,4))+3*D(:,4).*((1+B(:,1)).\((1/8)+C(:,1)));
P5=7*F(:,4)+21*D(:,4).*((1+B(:,1)).\D(:,1));
P6=((233/2560)+G(:,4))+3*D(:,4).*((1+B(:,1)).\((-1/16)+E(:,1)));
P7=11*H(:,4)+33*D(:,4).*((1+B(:,1)).\F(:,1));

R1=M1-M5.*((N2-N5.*(M2.\M5)).\(N4-N5.*(M2.\M1)));
R2=M3+M5.*((N2-N5.*(M2.\M5)).\(N3+N5.*(M2.\M3)));
R3=M4-M5.*((N2-N5.*(M2.\M5)).\(N1-N5.*(M2.\M4)));
R4=M6+M5.*((N2-N5.*(M2.\M5)).\(N6+N5.*(M2.\M6)));
R5=M7+M5.*((N2-N5.*(M2.\M5)).\(N7+N5.*(M2.\M7)));

S1=((1/2)+A(:,1))-7*D(:,1).*(M2.\M3)-(11*F(:,1)+7.*D(:,1).*(M2.\M5)).*((N2-N5.*(M2.\M5)).\(N3+N5.*(M2.\M3)));
S2=((1/8)+C(:,1))+7*D(:,1).*(M2.\M1)+(11*F(:,1)+7*D(:,1).*(M2.\M5)).*((N2-N5.*(M2.\M5)).\(N4-N5.*(M2.\M1)));
S3=((-1/16)+E(:,1))+7*D(:,1).*(M2.\M4)-(11*F(:,1)+7*D(:,1).*(M2.\M5)).*((N2-N5.*(M2.\M5)).\(N1-N5.*(M2.\M4)));
S4=((5/128)+G(:,1))+7*D(:,1).*(M2.\M6)+(11*F(:,1)+7*D(:,1).*(M2.\M5)).*((N2-N5.*(M2.\M5)).\(N6+N5.*(M2.\M6)));
S5=15*H(:,1)+7*D(:,1).*(M2.\M7)+(11*F(:,1)+7*D(:,1).*(M2.\M5)).*((N2-N5.*(M2.\M5)).\(N7+N5.*(M2.\M7)));

T1=P1-P5.*(M2.\M6)-(P7+P5.*(M2.\M5)).*((N2-N5.*(M2.\M5)).\(N6+N5.*(M2.\M6)));
T2=P2-P5.*(M2.\M7)-(P7+P5.*(M2.\M5)).*((N2-N5.*(M2.\M5)).\(N7+N5.*(M2.\M7)));
T3=P3+P5.*(M2.\M3)+(P7+P5.*(M2.\M5)).*((N2-N5.*(M2.\M5)).\(N3+N5.*(M2.\M3)));
T4=P4-P5.*(M2.\M1)+(P7+P5.*(M2.\M5)).*((N2-N5.*(M2.\M5)).\(N4-N5.*(M2.\M1)));
T5=P6+P5.*(M2.\M4)-(P7+P5.*(M2.\M5)).*((N2-N5.*(M2.\M5)).\(N1-N5.*(M2.\M4)));

f1= (1+B(:,1)).\(S1-S5.*(T2.\T3));
g1= -(1+B(:,1)).\(S2+S5.*(T2.\T4));
h1= -(1+B(:,1)).\(S3+S5.*(T2.\T5));
i1=-(1+B(:,1)).\(S4-S5.*(T2.\T1));

f2= M2.\(R1-R5.*(T2.\T4));
g2=M2.\(R2+R5.*(T2.\T3));
h2= M2.\(R3+R5.*(T2.\T5));
i2=M2.\(R4-R5.*(T2.\T1));

f3= (N2-N5.*(M2.\M5)).\(N1-N5.*(M2.\M4)-(N7+N5.*(M2.\M7)).*(T2.\T5));
g3= (N2-N5.*(M2.\M5)).\(N3+N5.*(M2.\M3)+(N7+N5.*(M2.\M7)).*(T2.\T3));
h3= (N2-N5.*(M2.\M5)).\(N4-N5.*(M2.\M1)+(N7+N5.*(M2.\M7)).*(T2.\T4));
i3= (N2-N5.*(M2.\M5)).\(N6+N5.*(M2.\M6)-(N7+N5.*(M2.\M7)).*(T2.\T1));

f4= T2.\T1;
g4=T2.\T3;
h4=T2.\T4;
i4=T2.\T5;

clear M* N* P* R* S* T* 
