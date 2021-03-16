%% Calculate max Lifting force with given arm length and Motor
% Jakob Bruckmoser
% 16.03.2021
% statical and dynamical Analysis of the joint torques and Forces
% - Static (recursive)
% - Dynamic (recursive Newton Euler)
% - theta [deg], thetad [rad/s], thetadd [rad/s^2]
close all; clc; clear;

% general Matlab Functions
path = 'C:\Users\Jakob\Google Drive\Hochschule München\02 Master\3. Semester\UCF FSI\Pre-Design\Short Arm Test\';
addpath('C:\Users\Jakob\Google Drive\Hochschule München\02 Master\3. Semester\UCF FSI\Pre-Design\MatlabFunctions')
diary([path,'MotorVariation.txt'])

%% Arm Selection
armLength = "long";
l = [117 220.3 220.3 79 41];    
m = [0.11 0.24 0.19 0.08 0.05];	% [kg] masses of the links

% armLength = "short";
% l = [117 190 190 79 41];    
% m = [0.11 0.22 0.17 0.08 0.05];	% [kg] masses of the links

%% Motor Selection
% motor.Torque = 0.4;  % [Nm] 40Ncm - Stepperonline - 17HS15-0404S
% motor.mass = 0.29;

motor.Torque = 0.6;  % [Nm] 60Ncm - Stepperonline - 17HS24-0644S
motor.mass = 0.5;

%% Constants
gLun = 1.625;       	% [m/s^2] lunar gravity
g0 = 9.81;              % [m/s^2] earth gravity

thetad = zeros(1,5);        % joint rotation velocities
thetadd = zeros(1,5);       % joint rotation accelerations

tHalf = 10;     % [s] time for half rotation
tDec = 2;      	% [s] deceleration time
thetadd(1) = pi/(tHalf*tDec);  % [rad/s^2]

armOffsets = [0 2.5 -75];

alpha = [90;0;0;90;0];
a = [armOffsets(1);l(2);l(3);0;0];
d = [l(1);armOffsets(2);armOffsets(3);0;l(4)+l(5)];

N = [0;0;0];	% [Nmm] external torque on end effector
g = [0;0;-g0];

% mm = [0.17 0.2 0.17 0.17 0] + motor.mass;	% [kg] masses of transmissions and motors
mm = [0.17 0.2+0.21 0.17 0.17 0] + 0.29;	% [kg] small motors except on Joint 2

% Moments of Inertia from Fusion
MoI = getMomentsOfInertia(path); % [kg m^2]

%% Dynamic Analysis 
theta = [0;0;0;0;0];    % transformation matrices
dh = [theta,alpha,a,d];
T = DHparameters(dh);

i = -15;
F = [0;0;i]*gLun*1.2; % start guess
RneDynamic = RNE(m,mm,MoI,dh,g,thetad,thetadd,T,F,N,l); % inital calculation

while (RneDynamic(2).Nz/1000 > motor.Torque*30)
    i = i + 0.1;
    F = [0;0;i]*gLun*1.2; 
    RneDynamic = RNE(m,mm,MoI,dh,g,thetad,thetadd,T,F,N,l);
end

for i=1:5
    ForceTorque.Dynamic(i).Joint = i;
    ForceTorque.Dynamic(i).Fx = round(RneDynamic(i).fI(1),2);
    ForceTorque.Dynamic(i).Fy = round(RneDynamic(i).fI(2),2);
    ForceTorque.Dynamic(i).Fz = round(RneDynamic(i).fI(3),2);
    ForceTorque.Dynamic(i).Nx = round(RneDynamic(i).Nx/1000,2);
    ForceTorque.Dynamic(i).Ny = round(RneDynamic(i).Ny/1000,2);
    ForceTorque.Dynamic(i).Nz = round(RneDynamic(i).Nz/1000,2);
end

fprintf('Parameter:\n max Motor Torque: %i Ncm\n Arm Length: %s\n',motor.Torque*100, armLength);

fprintf('\nDynamic Results\n')
disp(struct2table(ForceTorque.Dynamic))

fprintf('\nMax Load Lunar: %.1f kg\n',-F(3)/1.2/gLun);
fprintf('Max Load Earth: %.1f kg\n',-F(3)/1.2/g0);
    
%% Export
diary on
diary off
% save([path,'ForceTorque.mat'],'ForceTorque')




