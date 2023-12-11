close all; clear, clc

% For real life
m= 30000; % Mass of the building
a= 0.3; % Column thickness
h= 3; % Column height
E= 38e9; % Concrete modulus of elasticity
mu= 50; % Viscosity
A= 2 * (2.2*1.4); %Plate area
y= 0.075; % Gap
zSt= 0.05; % Zeta for building
I= (a^4)/12; % Area moment of inertia of the columns
k= 4*(3*E*I/(h^3)); % Column stiffness
wn= sqrt(k/m); % Natural frequency

bNS= mu*A/y % Damping coef for VWD
bVWD= 44.8e3;
bSt= zSt*2*m*wn; % Damping coef for Structure
bT= bVWD+bSt; % Total damping coef
zT= bT/(2*wn*m); 

% s^2+c1*s+c2
c1= 2*wn*zT;
c2= wn^2;
num= [1 0 0];
den= [1 c1 c2];
TFvwd= tf(num,den)

figure, step(TFvwd)

c1N=2*wn*zSt;
c2N=wn^2;
numN= [1 0 0];
denN= [1 c1N c2N];
TFn= tf(numN,denN)

figure, step(TFn)
