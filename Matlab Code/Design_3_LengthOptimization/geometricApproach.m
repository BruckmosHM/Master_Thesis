%% Calculate minimal required Length of the Arm for 3 given Points
% Jakob Bruckmoser
% 20.10.2020
% Desc: This Script is for optimizing the total length of the arm for 3
%       given points. It used a geometrical approoach to find the solutions.
clear all; 
clc; 
close all

%% Parameters

global P1 P2 P3 L1 L2 L3 L4 L5

xOffset = 100;    	% front offset to joint -> Goal Line
yOffset = -30;     	% joint offset from origin
zOffset = -277;  	% vertical distance from first joint to ground

RovWidth = 426;     % Rover Width
RovLength = 520;    % Rover Length
RovHeight = 150;    % Rover Height

yMin = -RovWidth/2-yOffset;
yMax = RovWidth/2-yOffset; 

% Ymax
P1 = [xOffset yMax zOffset];

% Ymin
P2 = [xOffset yMin zOffset];

% Loading
P3 = [-355 -yOffset -131];

%% Start and Boundary Conditions

% Link Limits
lMax = 300;
lMin = 85;

lUB = zeros(5,1)+lMax;
lLB = zeros(5,1)+lMin;

%% Linear Boundaries
A = [];
B = [];
Aeq = [];
Beq = [];

%% Solve P1 and P2

% Solver options
options = optimoptions('fmincon','Display','none');

% Joint Limits
alphaMax = 270;
alphaMin = -80;

% Joint Boundaries
alphaUB = zeros(6,1)+deg2rad(alphaMax);
alphaLB = zeros(6,1)+deg2rad(alphaMin);
alpha0 = zeros(6,1);

% Link Boundaries
% lUB = zeros(5,1)+lMax;
% lLB = zeros(5,1)+lMin;
l0 = [50;300;300;50;50];

% All Boundaries
LB = [lLB;alphaLB];
UB = [lUB;alphaUB];
x0 = [l0;alpha0];

% Solver
[x1, LP1P2, exitflag1] = fmincon(@goalFun,x0,A,B,Aeq,Beq,LB,UB,@nonlcon1,options);
if (exitflag1 > 0)
    fprintf('Solution found with LP1P2 = %.1f mm\n',LP1P2);
else
    fprintf('No Solution found for Point 1 and 2.\n');
end

%% Solve P3

% Joint Limits
alphaMax = 360;
alphaMin = 0;

% Joint Boundaries
alphaUB = zeros(3,1)+deg2rad(alphaMax);
alphaLB = zeros(3,1)+deg2rad(alphaMin);
alpha0 = zeros(3,1);

% Link Boundaries
% lUB = zeros(5,1)+lMax;
% lLB = zeros(5,1)+lMin;
l0 = [50;200;200;50;50];

% All Boundaries
LB = [lLB;alphaLB];
UB = [lUB;alphaUB];
x0 = [l0;alpha0];

% Solver
[x2, LP3, exitflag2] = fmincon(@goalFun,x0,A,B,Aeq,Beq,LB,UB,@nonlcon2,options);
if (exitflag2 > 0)
    fprintf('Solution found with LP3 = %.1f mm\n',LP3);
else
    fprintf('No Solution found for Point 3.\n');
end

%% Evaluation

if (LP1P2 < LP3)
    fprintf('  -> LP3 is constraining.\n');
    L = LP3;
    l = x2(1:5);
    alpha3 = x2(6:8);
    
    L1 = x2(1);
    L2 = x2(2);
    L3 = x2(3);
    L4 = x2(4);
    L5 = x2(5);
    
    % Joint Limits
    alphaMax = 180;
    alphaMin = -180;

    % Joint Boundaries
    UB = zeros(6,1)+deg2rad(alphaMax);
    LB = zeros(6,1)+deg2rad(alphaMin);
    alpha0 = zeros(6,1);

    % Solver
    [x3, ~, exitflag3] = fmincon(@goalFun2,alpha0,A,B,Aeq,Beq,LB,UB,@nonlcon3,options);
    if (exitflag3 > 0)
        fprintf('Solution found for Point 1/2 with LP3.\n');
    else
        fprintf('No Solution found for Point 1/2 with LP3.\n');
    end
    alpha1 = x3(1:3);
    alpha2 = x3(4:6);    
    
else
    fprintf('  -> LP1P2 is constraining with L = %.1f\n',LP1P2);
    L = LP1P2;
    l = x1(1:5);
    alpha1 = x1(6:8);
    alpha2 = x1(9:11);
end

%% Print Solution

fprintf('\nLength L = %.1f mm\n\n',L);
fprintf(' L1 \tL2 \t\tL3 \t\tL4 \t\tL5\n');
fprintf('---------------------------------------\n');
fprintf(' %.1f \t%.1f \t%.1f \t%.1f \t%.1f\n\n',l); 
fprintf('P1: \talpha1 = %.0f° \talpha2 = %.0f° \talpha3 = %.0f°\n',rad2deg(alpha1));
fprintf('P2: \talpha1 = %.0f° \talpha2 = %.0f° \talpha3 = %.0f°\n',rad2deg(alpha2));
fprintf('P3: \talpha1 = %.0f° \talpha2 = %.0f° \talpha3 = %.0f°\n',rad2deg(alpha3));

h = figure('name','Workspace of the Arm','Position',[-1500 200 450 350]);
hold on
grid on;
axis equal;
xlabel('Coordinate-X position (mm)')
ylabel('Coordinate-Y position (mm)')
zlabel('Coordinate-Z position (mm)')

plot3(P1(1),P1(2),P1(3),'*r');
plot3(P2(1),P2(2),P2(3),'*r');
view(0,90)

% Plot Rover
plotRover(yOffset);

% Plot arm reaching for P1
try
    [X,Y,Z] = getCoordinates(l,alpha1);
    plot3(X,Y,Z,'-ob','LineWidth',2)
catch
end

% Plot arm reaching for P2
try
    [X,Y,Z] = getCoordinates(l,alpha2);
    plot3(X,Y,Z,'-ob','LineWidth',2)
catch
end

% Plot arm reaching for P3
try
    [X,Y,Z] = getCoordinates(l,alpha3);
    plot3(X,Y,Z,'-ob','LineWidth',2)
catch
end


%% Create GIF
% for i=1:90
%     view(45+i,30);   
% 
%     if i == 1 
%         gif('Design3.gif','LoopCount',2,'frame',gcf) 
%     else 
%         gif 
%     end 
% end
% 
% for i=1:90
%     view(135-i,30);   
%     gif 
% end
    
design = 'Design3';
view(0,0)
exportgraphics(gcf,[design,'-xz.eps'],'ContentType','vector')
view(90,0)
exportgraphics(gcf,[design,'-yz.eps'],'ContentType','vector')
view(0,90)
exportgraphics(gcf,[design,'-xy.eps'],'ContentType','vector')
view(30,30)
exportgraphics(gcf,[design,'-iso.eps'],'ContentType','vector')

    

