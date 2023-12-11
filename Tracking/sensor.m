close all; clear, clc

% Time Settings
tPause= 1e-2; % s
tCalibration= 2; % s
tMeasure= 10; % s

% Arduino Connection
SPL= serialportlist;
arduinoPort= SPL(end);
a= arduino(arduinoPort, 'Uno');

% Sensor Pins
P1= 'A0';  % X-Axis connected to analog pin A0
P2= 'A1';  % Y-Axis connected to analog pin A1

% Variables
ac1= [];
ac2= [];

a1= []; a2= [];
v1= []; v2= [];
x1= []; x2= [];

% CALIBRATION
for i= 1:tCalibration/tPause
    % read data from both sensors
    ac1(i) = readVoltage(a, P1);
    ac2(i) = readVoltage(a, P1);
    
    pause(tPause);  % adjust as needed
end

R1= mean(ac1);
R2= mean(ac2);

S1= 9.81/0.3; % (m/s2) /V
S2= 0; % (m/s2) /V

% MEASURE
for i= 1:tMeasure/tPause
    % read data from both sensors
    a1(i+1)= (readVoltage(a, P1)-R1)*S1;
    a2(i+1)= (readVoltage(a, P2)-R2)*S2;
    
    v1(i+1)= v1(i) + a1(i+1)*tPause;
    v2(i+1)= v2(i) + a2(i+1)*tPause;

    x1(i+1)= x1(i) + v1(i+1)*tPause;
    x2(i+1)= x2(i) + v2(i+1)*tPause;

    plot()
    
    pause(tPause);  % adjust as needed
end

clear a;
