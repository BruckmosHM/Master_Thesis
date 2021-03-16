%% Calculate minimal required Length of the Arm for 3 given Points
% Jakob Bruckmoser
% 21.10.2020
% Desc: This Script is for optimizing the total length of the arm for 3
%       given points, using a geometrical approoach to find the solutions.
clear all; 
clc; 
close all

%% Parameters

global P1 P2

xOffset = 100;    	% front offset to joint -> Goal Line
yOffset = -30;     	% joint offset from origin
zOffset = -277;  	% vertical distance from first joint to ground

RovWidth = 426;     % Rover Width
RovLength = 520;    % Rover Length
RovHeight = 150;    % Rover Height

yMin = -RovWidth/2-yOffset;
yMax = RovWidth/2-yOffset; 

% Loading
P1 = [-355 -131];

% Unloading
P2 = [xOffset zOffset];


%% Solve Unloading as its constraining

% Solver options
options = optimoptions('fmincon','Display','none');

% Linear Boundaries
A = [];
B = [];
Aeq = [];
Beq = [];

% Joint Boundaries
alphaUB = deg2rad([200;200]);
alphaLB = deg2rad([170;170]);
alpha0 = zeros(2,1);

% Link Limits
lMax = 400;
lMin = 60;

% Link Boundaries
lUB = zeros(4,1)+lMax;
lLB = zeros(4,1)+lMin;
l0 = [200;200;50;50];

% All Boundaries
LB = [lLB;alphaLB];
UB = [lUB;alphaUB];
x0 = [l0;alpha0];

% Solver
[x1, L, exitflag1] = fmincon(@goalFun,x0,A,B,Aeq,Beq,LB,UB,@nonlcon,options);
if (exitflag1 > 0)
    fprintf('Solution found for Point 1.\n');
    l = x1(1:4);
    alpha1 = x1(5:6);
else
    fprintf('No Solution found for Point 1.\n');
end


%% Check Solution for Point 2

options = optimoptions('fsolve','Display','none');
alpha0 = deg2rad([-40 -40]);

fun = @(alpha) checkPoint2(alpha,l);

[alpha,~,exitflag2] = fsolve(fun,alpha0,options);
if (exitflag2 > 0)
    fprintf('Solution found with LP1.\n');
    alpha2 = alpha;
else
    fprintf('No Solution found for Point 1.\n');
end


%% Print Solution

fprintf('\nLength L = %.1f mm\n\n',L);
fprintf(' L1 \tL2 \t\tL3 \t\tL4\n');
fprintf('---------------------------------------\n');
fprintf(' %.1f \t%.1f \t%.1f \t%.1f\n\n',l); 
fprintf('P1: \talpha1 = %.0f° \talpha2 = %.0f°\n',rad2deg(alpha1));
fprintf('P2: \talpha1 = %.0f° \talpha2 = %.0f°\n',rad2deg(alpha2));
 
h = figure('name','Workspace of the Arm','Position',[-1500 200 450 350]);
% view(45,30)
hold on
grid on;
axis equal;
xlabel('Coordinate-X position (mm)')
ylabel('Coordinate-Y position (mm)')
zlabel('Coordinate-Z position (mm)')

% Plot Rover
plotRover(yOffset);

% Plot arm reaching for P1
[X,Y,Z] = getCoordinates(l,alpha1);
plot3(X,Y,Z,'-ob','LineWidth',2)

% Plot arm reaching for P2
[X,Y,Z] = getCoordinates(l,alpha2);
plot3(X,Y,Z,'-ob','LineWidth',2)

design = 'Design4';
view(0,0)
exportgraphics(gcf,[design,'-xz.eps'],'ContentType','vector')
view(90,0)
exportgraphics(gcf,[design,'-yz.eps'],'ContentType','vector')
view(0,90)
exportgraphics(gcf,[design,'-xy.eps'],'ContentType','vector')
view(30,30)
exportgraphics(gcf,[design,'-iso.eps'],'ContentType','vector')



%% Create GIF

% for i=1:90
%     view(45+i,30);   
% 
%     if i == 1 
%         gif('Design4.gif','LoopCount',2,'frame',gcf) 
%     else 
%         gif 
%     end 
% end
% 
% for i=1:90
%     view(135-i,30);   
%     gif 
% end

%% Display Required Points

figure('name','Required Points','Position',[-1470 230 700 600]);
view(0,90)
hold on
% grid on;
axis equal;
xlabel('Coordinate-X position (mm)')
ylabel('Coordinate-Y position (mm)')
zlabel('Coordinate-Z position (mm)')

textOffset = 15;

% Plot Loading
X = -355;
Y = -yOffset;
Z = -131;
plot3(X,Y,Z,'*r')
text(X+textOffset,Y+textOffset,Z,'P_1','FontSize',12)

% Plot yMax
X = xOffset;
Y = yMax;
Z = zOffset;
plot3(X,Y,Z,'*r')
text(X+textOffset,Y+textOffset,Z,'P_2','FontSize',12)

% Plot yMax
X = xOffset;
Y = yMin;
Z = zOffset;
plot3(X,Y,Z,'*r')
text(X+textOffset,Y+textOffset,Z,'P_3','FontSize',12)

xlim([-650 150])
ylim([-260 300])

% Plot Origin
plot3(0,0,0,'ob')

% Plot Rover
plotRover(yOffset);

text(-120,-yOffset+15,0,'boom','FontSize',12)
text(textOffset,-textOffset,0,'M','FontSize',12)
text(-500,-35,0,'rover','FontSize',12)



    

