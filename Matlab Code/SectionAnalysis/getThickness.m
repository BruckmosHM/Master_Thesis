function [c,ceq] = getThickness(x,R,FpMax,Mb,l,sigmaOut,fOut)
%NONLCON Summary of this function goes here
%   Detailed explanation goes here

global Re Rm MoS E FcritC fmax
ceq = [];

%% variables
t = x(1);

r = R-t;
A = pi*(R^2-r^2);
Mt = Mb/4;

%% Tension
Ib = pi/4*(R^4-r^4); 
It = (pi*((R*2)^4-(r*2)^4))/32;

Wb = Ib/R;
Wt = It*2/(2*R);

sigma_b = Mb/Wb;
tau = Mt/Wt;

sigma_v = sqrt(sigma_b^2 + sigma_b^2 - sigma_b*sigma_b + 3*tau^2);
c(1) = abs(sigma_v*MoS) - Re;

%% Deformation
f = Mb*l^2/(2*E*Ib);
c(2) = abs(sqrt(f^2+f^2)) - fmax;

%% Output Variables
sigmaOut.o = sigma_v;
fOut.o = f;

end

