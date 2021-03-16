function [c,ceq] = nonlconI(x,FpMax,My,Mz,Mt,l,sigmaOut,fyOut,fzOut,BuckleOut)
%NONLCON Summary of this function goes here
%   Detailed explanation goes here

global Re Rm MoS E fmax
ceq = [];

%% variables
B = x(1);
H = x(2);
tb = x(3);
th = x(4);

b = B-tb;
h = H-2*th;
% A = B*H - b*h;

%% Tension
Iy = (B*H^3 - b*h^3)/12;
Iz = (H*B^3 - h*b^3)/12;
It = 1.31/3*(2*B*th^3 + (H-2*th)*tb);

Wby = Iy*2/H;
Wbz = Iz*2/B;
if tb>th
    Wt = It/tb;
else
    Wt = It/th;
end

sigma_y = My/Wby;	
sigma_z = Mz/Wbz;
tau_t = Mt/Wt;

sigma_v = sqrt(sigma_y^2 + sigma_z^2 - sigma_y*sigma_z + 3*tau_t^2);
c(1) = abs(sigma_v*MoS) - Re;

%% Deformation
fy = My*l^2/(2*E*Iy);
fz = Mz*l^2/(2*E*Iz);

f_v = sqrt(fy^2 + fz^2);
c(2) = abs(f_v) - fmax;

%% Buckling
K = 2;
if Iy>Iz
    Ib = Iz;
else
    Ib = Iy;
end
F_buckle = pi^2*E*Ib/(K*l^2);
c(3) = MoS - (F_buckle/FpMax);

%% Output Parameters
sigmaOut.o = sigma_v;
fyOut.o = fy;
fzOut.o = fz;
BuckleOut.o = F_buckle;

end

