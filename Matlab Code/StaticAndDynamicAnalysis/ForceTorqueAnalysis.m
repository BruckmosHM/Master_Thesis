%% Static and Dynamic Analysis according to Tsai
% Jakob Bruckmoser
% 18.02.2021
% statical and dynamical Analysis of the joint torques and Forces
% - Static (recursive)
% - Dynamic (recursive Newton Euler)
% - theta [deg], thetad [rad/s], thetadd [rad/s^2]
close all; clc; clear;

% general Matlab Functions
path = 'C:\Users\Jakob\Google Drive\Hochschule München\02 Master\3. Semester\UCF FSI\Pre-Design\5. Iteration\';
addpath('C:\Users\Jakob\Google Drive\Hochschule München\02 Master\3. Semester\UCF FSI\Pre-Design\MatlabFunctions')
diary([path,'ForceTorque.txt'])
load([path,'ArmLengths.mat'])   % [mm] length of the links
% l = [117 220.3 220.3 71 34];
armOffsets = [0 2.5 -75];

% Moments of Inertia from Fusion
MoI = getMomentsOfInertia(path); % [kg m^2]

%% Parameters
gLun = 1.625;       	% [m/s^2] lunar gravity
g0 = 9.81;              % [m/s^2] earth gravity
F = [0;0;-8]*gLun*1.2; 	% [N] external force on end effector * Load Factor of Safety
N = [0;0;0];            % [Nmm] external torque on end effector
g = [0;0;-g0];
m = [0.11 0.24 0.19 0.08 0.05];     % [kg] masses of the links
mm = [0.17 0.2 0.17 0.17 0] + 0.28;	% [kg] masses of transmissions and motors

r1 = zeros(1,5)+20;     % [mm] inner diameter of links
r2 = zeros(1,5)+40;     % [mm] outer diameter of links

thetad = zeros(1,5);        % joint rotation velocities
thetadd = zeros(1,5);       % joint rotation accelerations

tHalf = 10;     % [s] time for half rotation
tDec = 2;      	% [s] deceleration time
thetadd(1) = pi/(tHalf*tDec);  % [rad/s^2]

alpha = [90;0;0;90;0];
a = [armOffsets(1);l(2);l(3);0;0];
d = [l(1);armOffsets(2);armOffsets(3);0;l(4)+l(5)];

%% Static analysis in worst case
theta = [0;0;0;0;0];    % transformation matrices
dh = [theta,alpha,a,d];
T = DHparameters(dh);
plotConf(T);

[BaseS,LinkS] = staticAnalysis(T,dh,l,F,N,g,m,mm);
RneStatic = RNE(m,mm,MoI,dh,g,zeros(1,5),zeros(1,5),T,F,N,l);

Diff(1,1) = abs(sum(round(LinkS(1).F,3))) - abs(sum(round(RneStatic(1).fI,3)));
Diff(1,2) = sum(abs(round(LinkS(1).N,3))) - sum(abs(round(RneStatic(1).ni,3)));
for i=2:5
    Diff(i,1) = abs(sum(round(LinkS(i).F,3))) - abs(sum(round(RneStatic(i).fI,3)));
    Diff(i,2) = abs(sum(round(LinkS(i).N,3))) - abs(sum(round(RneStatic(i).ni,3)));
end  

if Diff == 0  
    for i=1:5
        ForceTorque.Static(i).Joint = i;
        ForceTorque.Static(i).Fx = round(RneStatic(i).fI(1),2);
        ForceTorque.Static(i).Fy = round(RneStatic(i).fI(2),2);
        ForceTorque.Static(i).Fz = round(RneStatic(i).fI(3),2);
        ForceTorque.Static(i).Nx = round(RneStatic(i).Nx/1000,2);
        ForceTorque.Static(i).Ny = round(RneStatic(i).Ny/1000,2);
        ForceTorque.Static(i).Nz = round(RneStatic(i).Nz/1000,2);
    end
    fprintf('Static Results\n')
    fprintf('\ttheta = [%i;%i;%i;%i;%i]\n',theta)
    disp(struct2table(ForceTorque.Static)) 
else
    fprintf('Static Analysis and RNE do not match!\n')
    disp(Diff)
end


%% Dynamic Analysis in worst case
theta = [0;0;0;0;0];    % transformation matrices
dh = [theta,alpha,a,d];
T = DHparameters(dh);

RneDynamic = RNE(m,mm,MoI,dh,g,thetad,thetadd,T,F,N,l);
for i=1:5
    ForceTorque.Dynamic(i).Joint = i;
    ForceTorque.Dynamic(i).Fx = round(RneDynamic(i).fI(1),2);
    ForceTorque.Dynamic(i).Fy = round(RneDynamic(i).fI(2),2);
    ForceTorque.Dynamic(i).Fz = round(RneDynamic(i).fI(3),2);
    ForceTorque.Dynamic(i).Nx = round(RneDynamic(i).Nx/1000,2);
    ForceTorque.Dynamic(i).Ny = round(RneDynamic(i).Ny/1000,2);
    ForceTorque.Dynamic(i).Nz = round(RneDynamic(i).Nz/1000,2);
end
fprintf('\nDynamic Results\n')
fprintf('\ttheta = [%i;%i;%i;%i;%i], ',theta)
fprintf('thetad = [%i;%i;%i;%i;%i], ',thetad)
fprintf('thetadd = [%.1f;%i;%i;%i;%i]\n',thetadd)
disp(struct2table(ForceTorque.Dynamic))

%% Torsion/Bending Interaction
% for i=1:5:5
%     ForceTorque.TorsionBending(i).Mb1 = ForceTorque.Static(i).Nx;
%     ForceTorque.TorsionBending(i).Mb2 = ForceTorque.Static(i).Ny;
%     ForceTorque.TorsionBending(i).Mt = ForceTorque.Static(i).Nz;
% end
% for i=2:3
%     ForceTorque.TorsionBending(i).Mb1 = ForceTorque.Static(i).Ny;
%     ForceTorque.TorsionBending(i).Mb2 = ForceTorque.Static(i).Nz;
%     ForceTorque.TorsionBending(i).Mt = ForceTorque.Static(i).Nx;
% end
% ForceTorque.TorsionBending(4).Mb1 = ForceTorque.Static(i).Nx;
% ForceTorque.TorsionBending(4).Mb2 = ForceTorque.Static(i).Nz;
% ForceTorque.TorsionBending(4).Mt = ForceTorque.Static(i).Ny;

for i=1:4:5
    ForceTorque.TorsionBending(i,1) = 1;
    ForceTorque.TorsionBending(i,2) = 2;
    ForceTorque.TorsionBending(i,3) = 3;
end
for i=2:3
    ForceTorque.TorsionBending(i,1) = 2;
    ForceTorque.TorsionBending(i,2) = 3;
    ForceTorque.TorsionBending(i,3) = 1;
end
ForceTorque.TorsionBending(4,1) = 1;
ForceTorque.TorsionBending(4,2) = 3;
ForceTorque.TorsionBending(4,3) = 2;

ForceTorque.Factors = getTorques(ForceTorque.Dynamic,ForceTorque.TorsionBending);
struct2table(ForceTorque.Factors)


%% Export
diary on
diary off
save([path,'ForceTorque.mat'],'ForceTorque')




