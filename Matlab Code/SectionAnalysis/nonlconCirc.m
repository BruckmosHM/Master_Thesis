function [c,ceq] = nonlconCirc(x,FpMax,My,Mz,Mt,l,sigmaOut,fOut,BuckleOut)
%NONLCON Summary of this function goes here
%   Detailed explanation goes here

global Re Rm MoS E fmax
ceq = [];

%% variables
R = x(1);
t = x(2);

r = R-t;
A = pi*(R^2-r^2);


%% Tension
Ib = pi/4*(R^4-r^4); 
It = (pi*((R*2)^4-(r*2)^4))/32;

Wb = Ib/R;
Wt = It*2/(2*R);

sigma_by = My/Wb;
sigma_bz = Mz/Wb;
tau = Mt/Wt;

sigma_v = sqrt(sigma_by^2 + sigma_bz^2 - sigma_by*sigma_bz + 3*tau^2);
c(1) = abs(sigma_v*MoS) - Re;

%% Deformation
f = My*l^2/(2*E*Ib);
c(2) = abs(f) - fmax;

%% Buckling
K = 2;
F_buckle = pi^2*E*Ib/(K*l^2);
c(3) = MoS - (F_buckle/FpMax);

%% Output Variables
sigmaOut.o = sigma_v;
fOut.o = f;
BuckleOut.o = F_buckle;

end

