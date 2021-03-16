%RNE dynamical analysis of the manipulator with recursive Newton-Euler Method
close all;clear;clc

syms th1 th2 a1 a2 m1 m2 g0 thd1 thd2 thdd1 thdd2 real
n=2;

m = [m1,m2];
g = [0;-g0;0];
b = [0;0];

T(1).A = [cos(th1) -sin(th1) 0 a1*cos(th1); sin(th1) cos(th1) 0 a1*sin(th1);0 0 1 0; 0 0 0 1];
T(2).A = [cos(th2) -sin(th2) 0 a2*cos(th2); sin(th2) cos(th2) 0 a2*sin(th2);0 0 1 0; 0 0 0 1];

theta = [th1;th2];
alpha = [0;0];
a = [a1;a2];
d = [0;0];

thetad = [thd1 thd2];
thetadd = [thdd1 thdd2];
w0 = zeros(3,1); % velocities/accelerations of the rover
wd0 = zeros(3,1);
v0 = zeros(3,1);
vd0 = zeros(3,1);

f3 = [0;0;0]; % forces/torques on end effector
n3 = [0;0;0];

% b = zeros(5,1);  % viscous forces in joints

%% Vectors r, rc
for i=1:n
    Link(i).r = [a(i);0;0];
    Link(i).rc = [-a(i)/2;0;0];
end

%% Inertia Matrices
for i=1:n 
   D(i).I = (m(i)*a(i)^2/12).*[0 0 0; 0 1 0; 0 0 1];  
end



%% Forward computation - Recursive Newton Euler Formulation

for i=1:n % R^i_i-1
    D(i).RF = [cos(theta(i)) sin(theta(i)) 0;
        -cosd(alpha(i))*sin(theta(i)) cosd(alpha(i))*cos(theta(i)) sind(alpha(i));
        sind(alpha(i))*sin(theta(i)) -sind(alpha(i))*cos(theta(i)) cosd(alpha(i))];    
end

D(1).w = D(1).RF*(w0 + [0;0;1]*thetad(1));
for i=2:n % Angular velocity Propagation
    D(i).w = D(i).RF*(D(i-1).w + [0;0;1]*thetad(i));
end

D(1).wd = D(1).RF*(wd0 + [0;0;1]*thetadd(1) + cross(w0,[0;0;1]*thetad(1)));
for i=2:n % Angular acceleration Propagation
    D(i).wd = D(i).RF*(D(i-1).wd + [0;0;1]*thetadd(i) + cross(D(i-1).w,[0;0;1]*thetad(i)));
end

D(1).v = D(1).RF*(v0 + cross(D(1).w,Link(1).r));
for i=2:n % Linear velocity Propagation
    D(i).v = D(i).RF*(D(i-1).v + cross(D(i).w,Link(i).r));
end

D(1).vd = D(1).RF*vd0 + cross(D(1).wd,Link(1).r) + cross(D(1).w,(cross(D(1).w,Link(1).r)));
for i=2:n % Linear acceleration Propagation
    D(i).vd = D(i).RF*D(i-1).vd + cross(D(i).wd,Link(i).r) + ...
        cross(D(i).w,(cross(D(i).w,Link(i).r)));
end

for i=1:n % Linear acceleration of the Center of Mass
    D(i).vcid = D(i).vd + cross(D(i).wd,Link(i).rc) + cross(D(i).w,cross(D(i).w,Link(i).rc));
end

D(1).g = D(1).RF*g;
for i=2:n % Acceleration of Gravity
    D(i).g = D(i).RF*D(i-1).g;
end

%% Backward computation - Recursive Newton Euler Formulation
% fS = f*^i_i
% nS = n*^i_i
% fI = f^i_i,i-1    f in ith Link Frame
% fi = f^i-1_i,i-1  f in i-1th Link Frame
% nI = n^i_i,i-1    n in ith Link Frame
% ni = n^i-1_i,i-1  n in i-1th Link Frame

for i=n:-1:1 % f*^i_i and n*^i_i
    D(i).fS = -m(i)*D(i).vcid;
    D(i).nS = -D(i).I*D(i).wd - cross(D(i).wd,(D(i).I*D(i).w));
end

D(n).fI = f3 - m(n)*D(n).g - D(n).fS;
D(n).nI = n3 + cross((Link(n).r + Link(n).rc),D(n).fI) - cross(Link(n).rc,f3) - D(n).nS;
D(n).fi = T(n).A(1:3,1:3)*D(n).fI;
D(n).ni = T(n).A(1:3,1:3)*D(n).nI;
for i=n-1:-1:1
    D(i).fI = D(i+1).fi - m(i)*D(i).g - D(i).fS;
    D(i).nI = D(i+1).ni + cross((Link(i).r + Link(i).rc),D(i).fI) - ...
       cross(Link(i).rc,D(i+1).fi) - D(i).nS;
    D(i).fi = T(i).A(1:3,1:3)*D(i).fI;
    D(i).ni = T(i).A(1:3,1:3)*D(i).nI;
end

%% Joint Torque Equations

for i=1:n
    D(i).Nz = D(i).ni'*[0;0;1] + b(i)*thetad(i);
    D(i).Ny = D(i).ni'*[0;1;0] + b(i)*thetad(i);
    D(i).Nx = D(i).ni'*[1;0;0] + b(i)*thetad(i);
end

%% Result from Tsai
tau1 = ((1/3*m1+m2)*a1^2+m2*a1*a2*cos(th2)+1/3*m2*a2^2)*thdd1...
    + (1/2*m2*a1*a2*cos(th2)+1/3*m2*a2^2)*thdd2 - m2*a1*a2*sin(th2)*(thd1*thd2+1/2*thd2^2)...
    + g0*((1/2*m1+m2)*a1*cos(th1)+1/2*m2*a2*cos(th1+th2));
tau2 = (1/2*m2*a1*a2*cos(th2)+1/3*m2*a2^2)*thdd1 + 1/3*m2*a2^2*thdd2 ...
    + 1/2*m2*a1*a2*sin(th2)*thd1^2 + 1/2*m2*g0*a2*cos(th1+th2);

%% Validation
if simplify(tau1-D(1).Nz)==0 && simplify(tau2-D(2).Nz)==0
    disp('Calculation is valid.')
end

