function [DBase,DLink] = RNE(m,mm,MoI,dh,g,thetad,thetadd,T,F,N,l)
%RNE dynamical analysis of the manipulator with recursive Newton-Euler Method

theta = dh(:,1);
alpha = dh(:,2);
a = dh(:,3);
d = dh(:,4);

w0 = zeros(3,1); % velocities/accelerations of the rover
wd0 = zeros(3,1);
v0 = zeros(3,1);
vd0 = zeros(3,1);

f6 = T(5).R*-F; % forces/torques on end effector
n6 = N;

b = zeros(5,1);  % viscous forces in joints

%% Inertia Matrices
for i=1:5
    D(i).I = MoI(i).CoM;
end 

%% Link vectors
% Link.rc, Link.r = vectors in relation to link frame
% Base.rc, Base.r = vectors in relation to base frame

Link(1).rc = [0;-l(1)/2;0];
Link(2).rc = [-l(2)/2;0;0];
Link(3).rc = [-l(3)/2;0;0];
Link(4).rc = [0;0;l(4)/2];
Link(5).rc = [0;0;-l(5)/2];
for i=1:5
    Link(i).r  = [a(i); d(i)*sind(alpha(i)); d(i)*cosd(alpha(i))];
end


%% Forward computation - Recursive Newton Euler Formulation
for i=1:5 % R^i_i-1
    D(i).RF = [cosd(theta(i)) sind(theta(i)) 0;
        -cosd(alpha(i))*sind(theta(i)) cosd(alpha(i))*cosd(theta(i)) sind(alpha(i));
        sind(alpha(i))*sind(theta(i)) -sind(alpha(i))*cosd(theta(i)) cosd(alpha(i))];    
end

D(1).w = D(1).RF*(w0 + [0;0;1]*thetad(1));
for i=2:5 % Angular velocity Propagation
    D(i).w = D(i).RF*(D(i-1).w + [0;0;1]*thetad(i));
end

D(1).wd = D(1).RF*(wd0 + [0;0;1]*thetadd(1) + cross(w0,[0;0;1]*thetad(1)));
for i=2:5 % Angular acceleration Propagation
    D(i).wd = D(i).RF*(D(i-1).wd + [0;0;1]*thetadd(i) + cross(D(i-1).w,[0;0;1]*thetad(i)));
end

D(1).v = D(1).RF*(v0 + cross(D(1).w,Link(1).r));
for i=2:5 % Linear velocity Propagation
    D(i).v = D(i).RF*(D(i-1).v + cross(D(i).w,Link(i).r));
end

D(1).vd = D(1).RF*vd0 + cross(D(1).wd,Link(1).r) + cross(D(1).w,(cross(D(1).w,Link(1).r)));
for i=2:5 % Linear acceleration Propagation
    D(i).vd = D(i).RF*D(i-1).vd + cross(D(i).wd,Link(i).r) + ...
        cross(D(i).w,(cross(D(i).w,Link(i).r)));
end

for i=1:5 % Linear acceleration of the Center of Mass
    D(i).vcid = D(i).vd + cross(D(i).wd,Link(i).rc) + cross(D(i).w,cross(D(i).w,Link(i).rc));
end

D(1).g = D(1).RF*g;
for i=2:5 % Acceleration of Gravity
    D(i).g = D(i).RF*D(i-1).g;
end

%% Backward computation - Recursive Newton Euler Formulation
% fS = f*^i_i
% nS = n*^i_i
% fI = f^i_i,i-1    f in ith Link Frame
% fi = f^i-1_i,i-1  f in i-1th Link Frame
% nI = n^i_i,i-1    n in ith Link Frame
% ni = n^i-1_i,i-1  n in i-1th Link Frame

for i=5:-1:1 % f*^i_i and n*^i_i
    D(i).fS = -m(i)*D(i).vcid;
    D(i).nS = -D(i).I*D(i).wd - cross(D(i).wd,(D(i).I*D(i).w));
end

f6 = f6 - mm(5)*D(5).g;
D(5).fI = f6 - m(5)*D(5).g - D(5).fS;
D(5).nI = n6 + cross((Link(5).r + Link(5).rc),D(5).fI) - cross(Link(5).rc,f6) - D(5).nS;
D(5).fi = T(5).A(1:3,1:3)*D(5).fI;
D(5).ni = T(5).A(1:3,1:3)*D(5).nI;
for i=4:-1:1
    D(i+1).fi = D(i+1).fi - mm(i)*D(i).g;
    D(i).fI = D(i+1).fi - m(i)*D(i).g - D(i).fS;
    D(i).nI = D(i+1).ni + cross((Link(i).r + Link(i).rc),D(i).fI) - ...
       cross(Link(i).rc,D(i+1).fi) - D(i).nS;
    D(i).fi = T(i).A(1:3,1:3)*D(i).fI;
    D(i).ni = T(i).A(1:3,1:3)*D(i).nI;
end

%% Joint Torque Equations

for i=1:5
    D(i).Nz = D(i).ni'*[0;0;1] + b(i)*thetad(i);
    D(i).Ny = D(i).ni'*[0;1;0] + b(i)*thetad(i);
    D(i).Nx = D(i).ni'*[1;0;0] + b(i)*thetad(i);
end

% for i=1:5
%     DBaseNice(i).Joint = ['Joint',num2str(i)];    
%     DBaseNice(i).FxB = D(i).fI(1);
%     DBaseNice(i).FyB = D(i).fI(2);
%     DBaseNice(i).FzB = D(i).fI(3);  
%     DBaseNice(i).Nx = D(i).Nx;
%     DBaseNice(i).Ny = D(i).Ny;
%     DBaseNice(i).Nz = D(i).Nz;
% end

DBase = D;

%% Calculations to Link Frame

DLink = 0;


end

