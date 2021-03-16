% staticAnalysisSym
%PLOTANALYSIS performs symbolic static analysis from Tsai
close all;clear;clc

syms th1 th2 th3 a1 a2 a3 fx fy nz m1 m2 m3 g0
n=3;

m = [m1,m2,m3];
g = [0;-g0;0];

T(1).A = [cos(th1) -sin(th1) 0 a1*cos(th1); sin(th1) cos(th1) 0 a1*sin(th1);0 0 1 0; 0 0 0 1];
T(2).A = [cos(th2) -sin(th2) 0 a2*cos(th2); sin(th2) cos(th2) 0 a2*sin(th2);0 0 1 0; 0 0 0 1];
T(3).A = [cos(th3) -sin(th3) 0 a3*cos(th3); sin(th3) cos(th3) 0 a3*sin(th3);0 0 1 0; 0 0 0 1];

T(1).T = T(1).A;
T(2).T = T(1).A*T(2).A;
T(3).T = T(1).A*T(2).A*T(3).A;

for i=1:n
    T(i).R = T(i).T(1:3,1:3);
    T(i).P = T(i).T(1:3,4);
end

theta = [th1;th2;th3];
alpha = [0;0;0];
a = [a1;a2;a3];
d = [0;0;0];

axisL = 50;  % Size of the axis

%% Vectors
% Link.rc, Link.r = vectors in relation to link frame
% Base.rc, Base.r = vectors in relation to base frame

for i=1:n
    Link(i).r = [a(i);0;0];
    Link(i).rc = [-a(i)/2;0;0];
%     Link(i).r  = [a(i); d(i)*sind(alpha(i)); d(i)*cosd(alpha(i))];
    Base(i).r  = T(i).R * Link(i).r;
    Base(i).rc = T(i).R * Link(i).rc;
    
%     try
%         arrow3(J(i).O',J(i).O'+Base(i).r','-d',1,2)  
%     catch
%     end
%     arrow3(J(i+1).O',J(i+1).O'+Base(i).rc','-.a',1,2)
end

%% Force/Torque Calculations in Base Frames
% Static(i).F = Forces, notation fi,i-1
% Static(i).N = Torques, notation fi,i-1
% Static(i).Nz/y/x = final Torques, projected torque on z/y/x-Axis

Base(4).F = [fx;fy;0];
Base(4).N = [0;0;nz];

for i=n:-1:1 % static recursive calculation
    Base(i).F = Base(i+1).F - m(i)*g;
    Base(i).N = Base(i+1).N + cross(Base(i).r,Base(i).F) - cross(Base(i).rc,m(i).*g);
end

Base(1).z = [0;0;1];
for i=2:n % axis for projection
    Base(i).z = T(i-1).R * [0;0;1];
end

for i=1:n % torque projection	
    Base(i).Nz = Base(i).z' * Base(i).N;
end


nzT3 = nz + fy*a3*cos(th1+th2+th3) - fx*a3*sin(th1+th2+th3) + 0.5*m3*g0*a3*cos(th1+th2+th3);
nzT2 = nz + fy*(a2*cos(th1+th2)+a3*cos(th1+th2+th3)) - fx*(a2*sin(th1+th2)+a3*sin(th1+th2+th3)) ...
    + 0.5*m2*g0*a2*cos(th1+th2) + m3*g0*(a2*cos(th1+th2)+0.5*a3*cos(th1+th2+th3));
nzT1 = nz + fy*(a1*cos(th1)+a2*cos(th1+th2)+a3*cos(th1+th2+th3)) - ...
    fx*(a1*sin(th1)+a2*sin(th1+th2)+a3*sin(th1+th2+th3))+ ...
    0.5*m1*g0*a1*cos(th1) + m2*g0*(a1*cos(th1)+0.5*a2*cos(th1+th2)) + ...
    m3*g0*(a1*cos(th1)+a2*cos(th1+th2)+0.5*a3*cos(th1+th2+th3));

simplify(Base(3).Nz-nzT3)
simplify(Base(2).Nz-nzT2)
simplify(Base(1).Nz-nzT1)

%% Plot axis
figure('name','Analysis','Position',[-1000 200 700 600]);
grid on; hold on; axis equal; 
zlabel('Z'); xlabel('X'); ylabel('Y');

% Origin / Joint 1
J(1).O = [0;0;0];  	% Origin
x1 = [axisL;0;0];    % Axis
y1 = [0;axisL;0];
z2 = [0;0;axisL];
plot3([J(1).O(1) x1(1)],[J(1).O(2) x1(2)],[J(1).O(3) x1(3)],'-r'); % x-Axis
plot3([J(1).O(1) y1(1)],[J(1).O(2) y1(2)],[J(1).O(3) y1(3)],'-g'); % y-Axis
plot3([J(1).O(1) z2(1)],[J(1).O(2) z2(2)],[J(1).O(3) z2(3)],'-b'); % z-Axis
plot3(J(1).O(1),J(1).O(2),J(1).O(3),'ob'); % Origin
text(J(1).O(1)+5,J(1).O(2),J(1).O(3),'0');

a = [100;100;50];
theta = deg2rad([30;30;45]);

P1 = matlabFunction(T(1).P);
R1 = matlabFunction(T(1).R);
T(1).P = P1(a(1),theta(1));
T(1).R = R1(theta(1));

P2 = matlabFunction(T(2).P);
R2 = matlabFunction(T(2).R);
T(2).P = P2(a(1),a(2),theta(1),theta(2));
T(2).R = R2(theta(1),theta(2));

P3 = matlabFunction(T(3).P);
R3 = matlabFunction(T(3).R);
T(3).P = P3(a(1),a(2),a(3),theta(1),theta(2),theta(3));
T(3).R = R3(theta(1),theta(2),theta(3));


for i=1:n    
    J(i+1).O = J(1).O + T(i).P;   	% Origin
    J(i+1).x = T(i).R*x1 + T(i).P;	% Axis
    J(i+1).y = T(i).R*y1 + T(i).P;
    J(i+1).z = T(i).R*z2 + T(i).P;
    plot3([J(i+1).O(1) J(i+1).x(1)],[J(i+1).O(2) J(i+1).x(2)],[J(i+1).O(3) J(i+1).x(3)],'-r');
    plot3([J(i+1).O(1) J(i+1).y(1)],[J(i+1).O(2) J(i+1).y(2)],[J(i+1).O(3) J(i+1).y(3)],'-g');
    plot3([J(i+1).O(1) J(i+1).z(1)],[J(i+1).O(2) J(i+1).z(2)],[J(i+1).O(3) J(i+1).z(3)],'-b');
    plot3(J(i+1).O(1),J(i+1).O(2),J(i+1).O(3),'ob');
    text(J(i+1).O(1)+5,J(i+1).O(2),J(i+1).O(3),num2str(i));
end

%% Plot Vectors
r1 = matlabFunction(Base(1).r);
rc1 = matlabFunction(Base(1).rc);
Base(1).r = r1(a(1),theta(1));
Base(1).rc = rc1(a(1),theta(1));

r2 = matlabFunction(Base(2).r);
rc2 = matlabFunction(Base(2).rc);
Base(2).r = r2(a(2),theta(1),theta(2));
Base(2).rc = rc2(a(2),theta(1),theta(2));

r3 = matlabFunction(Base(3).r);
rc3 = matlabFunction(Base(3).rc);
Base(3).r = r3(a(3),theta(1),theta(2),theta(3));
Base(3).rc = rc3(a(3),theta(1),theta(2),theta(3));


for i=1:n
    arrow3(J(i).O',J(i).O'+Base(i).r','-d',1,2)  
    arrow3(J(i+1).O',J(i+1).O'+Base(i).rc','-.a',1,2)
end



