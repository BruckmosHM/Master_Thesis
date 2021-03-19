%% Calculate a standard loading/unloading sequence
% Jakob Bruckmoser
% 19.03.2021
% calculate the joint angles for a loading/unloading sequence with DH parameters
close all; clc; clear;

addpath('C:\Users\Jakob\Google Drive\Hochschule München\02 Master\3. Semester\UCF FSI\Pre-Design\MatlabFunctions')
path = 'C:\Users\Jakob\Google Drive\Hochschule München\02 Master\3. Semester\UCF FSI\Pre-Design\Calculate Sequences\';
diary([path,'TrajectoryAngles.txt'])
fprintf("\n%s\n",datetime('now'));


%% Parameters
l = [117 220.3 220.3 79 41];   

armOffsets = [0 2.5 -75];

alpha = [90;0;0;90;0];
a = [armOffsets(1);l(2);l(3);0;0];
d = [l(1);armOffsets(2);armOffsets(3);0;l(4)+l(5)];

theta = [0;0;0;0;0];    % transformation matrices
dh = [theta,alpha,a,d];
T = DHparameters(dh);

xOffset = 245;    	% front offset to joint -> Goal Line
yOffset = -110-25; 	% joint offset from origin
zOffset = -230;  	% vertical distance from first joint to ground
eOffset = 0;       % end effector offset

RovWidth = 426;     % Rover Width
RovLength = 520;    % Rover Length
RovHeight = 150;    % Rover Height

%% Solver Options/Parameter
% Linear Boundaries
A = [];
B = [];
Aeq = [];
Beq = [];

% Solver options
options = optimoptions('fmincon','Display','none');

% Joint Limits
alphaMax = 180;
alphaMin = -180;

% Joint Boundaries
% UB = zeros(3,1)+deg2rad(alphaMax);
% LB = zeros(3,1)+deg2rad(alphaMin);

UB = deg2rad([0;0;180]);
LB = deg2rad([-180;-180;-180]);

alpha0 = zeros(3,1);

%% Single Point Solver
% % % Point to reach
% P = [-330 -yOffset (-34+51)];
% 
% fun = @(x) nonlcon(x,P,l,eOffset);
% [x, ~, flag] = fmincon(@goalFun,alpha0,A,B,Aeq,Beq,LB,UB,fun,options);
% 
% fprintf("Angles for Single Point:\n");
% relAngles(x)
% 
% fun = @(x) fsolveFun(x,P,l,eOffset);
% fsolveOptions = optimoptions('fsolve','Display','none');
% x = fsolve(fun,alpha0,fsolveOptions);
% fprintf("Angles for Single Point with Fsolve:\n");
% relAngles(x)


%% Trajectory Points Solver

% Trajectory
P(1,:) = [245 0 zOffset];
P(2,:) = [250 200 150];
P(3,:) = [0 250 150];
P(4,:) = [-200 200 100];
P(5,:) = [-330 -yOffset (-34+51)];

for i=1:size(P,1)
    fun = @(x) nonlcon(x,P(i,:),l,eOffset);
    
    [x, ~, flag] = fmincon(@goalFun,alpha0,A,B,Aeq,Beq,LB,UB,fun,options); 
    
    if (flag < 0)
        fprintf('Error at Point %i. Flag: %i\n\n',i,flag);
    end
    
    Abs(i,:) = x;
    Rel(i,:) = toRelAngles(x);
end

fprintf("Angles for trajectory:\n");
Rel

%% Plot
h = figure('name','Workspace of the Arm','Position',[-1690 115 1100 780]);
hold on
grid on;
axis equal;
xlabel('Coordinate-X position (mm)')
ylabel('Coordinate-Y position (mm)')
zlabel('Coordinate-Z position (mm)')

view(45,30);
plotRover(yOffset);

[X,Y,Z] = getCoordinates(l,deg2rad([0 0 0]));
plot3(X,Y,Z,'-or','LineWidth',2)


for i=1:size(P,1)    
    plot3(P(i,1),P(i,2),P(i,3),'-ob','LineWidth',2)
end
fnplt(cscvn(P'),'r',2);

for i=1:size(P,1)
    try
        [X,Y,Z] = getCoordinates(l,Abs(i,:));
        plot3(X,Y,Z,'-ob','LineWidth',2)
    catch
    end    
end

diary on
diary off






