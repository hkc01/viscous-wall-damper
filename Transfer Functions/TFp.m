close all; clear, clc

% For prototype
m= 5; % Mass of the building
a= 15.8e-3; % Column thickness
h= 0.1568; % Column height
E= 19E6; % LEGO modulus of elasticity
mu= 0.615; % Viscosity
A= 2*0.00863; % Plate area
y= 0.003; % Gap
zSt= 0.05; % Zeta for building
I= (a^4)/12; % Area moment of inertia of the columns
k= 4*(3*E*I/(h^3)); % Column stiffness
wn= sqrt(k/m); % Natural frequency

bNS= 2*mu*A/y; % Damping coef for VWD
bVWD= bNS*10;
bSt= zSt*2*m*wn; % Damping coef for Structure
bT= bVWD+bSt; % Total damping coef
zTotal= bT/(2*wn*m); 

% s^2+c1*s+c2
c1= 2*wn*zTotal;
c2= wn^2;
num= [1 0 0];
den= [1 c1 c2];
TFvwd= tf(num,den)
%step(TFvwd)

c1N= 2*wn*zSt;
c2N= wn^2;
numN= [1 0 0];
denN= [1 c1N c2N];
TFn= tf(numN,denN)
%step(TFn)

save("TFp.mat", "TFn", "TFvwd")