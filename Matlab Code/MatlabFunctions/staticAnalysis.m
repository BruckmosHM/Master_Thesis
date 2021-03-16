function [Base,Link] = staticAnalysis(T,dh,l,F,N,g,m,mm)
%PLOTANALYSIS performs and plots the static analysis
% - plots the axis 
% - plots the Forces and Torques (not yet implemented)

% theta = dh(:,1);
alpha = dh(:,2);
a = dh(:,3);
d = dh(:,4);
n = 5;

% m = m + mm;
% mm = zeros(5,1);

%% Vectors
% Link.rc, Link.r = vectors in relation to link frame
% Base.rc, Base.r = vectors in relation to base frame

Link(1).rc = [0;-l(1)/2;0];
Link(2).rc = [-l(2)/2;0;0];
Link(3).rc = [-l(3)/2;0;0];
Link(4).rc = [0;0;l(4)/2];
Link(5).rc = [0;0;-l(5)/2];

for i=1:5
    Link(i).r  = [a(i); d(i)*sind(alpha(i)); d(i)*cosd(alpha(i))];
    Base(i).r  = T(i).R * Link(i).r;
    Base(i).rc = T(i).R * Link(i).rc;
end

%% Force/Torque Calculations in Base Frames
% Static(i).F = Forces, notation fi,i-1
% Static(i).N = Torques, notation fi,i-1
% Static(i).Nz/y/x = final Torques, projected torque on z/y/x-Axis

Base(6).F = -F;
Base(6).N = N;

for i=5:-1:1 % static recursive calculation
    Base(i).F = Base(i+1).F - m(i)*g - mm(i)*g;
    Base(i).N = Base(i+1).N + cross(Base(i).r,Base(i).F) - cross(Base(i).rc,m(i).*g);
end

Base(1).x = [1;0;0];
Base(1).y = [0;1;0];
Base(1).z = [0;0;1];
for i=2:5 % axis for projection
    Base(i).x = T(i-1).R * [1;0;0];
    Base(i).y = T(i-1).R * [0;1;0];
    Base(i).z = T(i-1).R * [0;0;1];
end

for i=1:5 % torque projection	
    Base(i).Nx = Base(i).x' * Base(i).N;
    Base(i).Ny = Base(i).y' * Base(i).N;
    Base(i).Nz = Base(i).z' * Base(i).N;
end


%% Force/Torque Calculations in Link Frames
% Static(i).F = Forces, notation fi,i-1
% Static(i).N = Torques, notation fi,i-1
% Static(i).Nz/y/x = final Torques, projected torque on z/y/x-Axis

Link(1).g = T(1).A(1:3,1:3)'*g;
for i=2:n % gravity vector
    Link(i).g = T(i).A(1:3,1:3)'*Link(i-1).g;
end

Link(6).f = -T(5).R'*F; % End Effector Output Forces
Link(6).n = T(5).R'*N;
for i=5:-1:1 % Forces in Link Frames
    Link(i).F = Link(i+1).f - m(i)*Link(i).g - mm(i)*Link(i).g;   % Force in ith frame
    Link(i).f = T(i).A(1:3,1:3)*Link(i).F;      % Force in i-1th frame
    Link(i).N = Link(i+1).n + cross(Link(i).r,Link(i).F) - cross(Link(i).rc,(m(i)*Link(i).g));
    Link(i).n = T(i).A(1:3,1:3)*Link(i).N; 
end


    
end

