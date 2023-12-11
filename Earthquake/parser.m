clear all, clc
% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 9);

% Specify range and delimiter
opts.DataLines = [65, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["var"];
opts.VariableTypes = ["double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
Er= readtable("/Users/hakancan/Documents/School/MECH 491/Earthquake/TK.4612..HNE.D.INT-20230206_0000008.DIS.MP.ASC", opts);
Nr= readtable("/Users/hakancan/Documents/School/MECH 491/Earthquake/TK.4612..HNN.D.INT-20230206_0000008.DIS.MP.ASC", opts);
E= Er{:, 1};
N= Nr{:, 1};
t= linspace(0, 125, length(E))';

% Clear temporary variables
save data.mat t E N