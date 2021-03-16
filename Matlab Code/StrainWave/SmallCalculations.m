%% min dimensions of Adapter plate shaft

global Re Mt

Mt = 14000;
% Re = 26.4;
Re = 3;

clear;clc;
R0 = 10;
options = optimoptions('fsolve','Display', 'off');
R = fsolve(@minR,R0,options);
fprintf('Rmin = %.2f [mm]\nDmin = %.2f [mm]\n',R,2*R);

t0 = 0.4;
t = fsolve(@minT,t0,options);
fprintf('Tmin = %.2f [mm]\n',t);

% Bearing Pressure / Lochleibung
% sigma = F / (d*s*n)

n = 6;
s0 = 4;
fun = @(x) bearingPressure(x,n);
s = fsolve(fun,s0,options);
fprintf('Smin = %.2f [mm]\n',s);



%% Functions
function F = minR(x)
global Re Mt

R = x;
r = 3.5;

It = (pi*((R*2)^4-(r*2)^4))/32;
Wt = It*2/(2*R);
tau = Mt/Wt;

F(1) = tau - (Re/2 *1.2 * 2);
end

function F = minT(x)
global Re Mt

t = x;
R = 23;
r = R-t;

It = (pi*((R*2)^4-(r*2)^4))/32;
Wt = It*2/(2*R);
tau = Mt/Wt;

F(1) = tau - (Re/2 *1.2 * 2);
end

function F = bearingPressure(x,n)
global Re Mt

s = x(1);
d = 3;
F = Mt/(sind(45)*10*n);

sigma = F/(d*s);

F(1) = sigma - Re/2*1.2*2;
end


