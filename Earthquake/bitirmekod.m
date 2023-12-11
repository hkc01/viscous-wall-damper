close all, clear, clc
% For real life
m= 30000; % Mass of the building
a=0.3; % Column thickness
h=3; % Column height
E=38*10^6; % Concrete modulus of elasticity
mu= 250; %Viscosity
A= 2.2*1.4; %Plate area
y= 0.075 % Gap
zSt= 0.05 % Zeta for building
I= (a^4)/12; % Area moment of inertia of the columns
k= 48*E*I/(h^3); % Column stiffness
wn= sqrt(k/m); % Natural frequency

bVWD= mu*A/y; % Damping coef for VWD
bSt= zSt*2*m*wn; % Damping coef for Structure
bT= bVWD+bSt; % Total damping coef
Dtotal= bT/(2*wn*m); 
%%
% s^2+k1*s+k2
k1=2*wn*Dtotal
k2=wn^2
k11=2*wn*zSt
k21=wn^2
num=[1 0 0]
den=[1 k1 k2]
num1=[1 0 0]
den1=[1 k11 k21]
Tf=tf(num,den)
Tf1=tf(num1,den1)
figure(1)
step(Tf)
figure(2)
step(Tf1)

%Uoutput=Uinput*Tf
%u=      %İnverse laplace of Uoutput
%% % For our prototype
m=4 % bina kütle
a=0.015 % kolon kenar
h=0.1568 %  kolon uzunluk
E=1.9*10^6 % Beton modules of elasticity
mu= 0.55 %Viscosity of fluid
A= 0.01 %Plate alan
y= 0.002 %gap
zSt= 0.05 %Damping Coef for building
I= (a^4)/12
k= 48*E*I/(h^3)
wn=(k/m)^0.5
b=mu*A/y
Dvwd=b/(m*2*wn)
Dtotal=zSt+Dvwd
bT=2*wn*Dtotal*m
% s^2+k1*s+k2
k1=2*wn*Dtotal
k2=wn^2
num=[1 0 0]
den=[1 k1 k2]
Tf=tf(num,den)
%Uoutput=



