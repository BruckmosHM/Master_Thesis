%% Calculate the workspace and ground Intersection with Forward Kinematics and DH Matrices
% Jakob Bruckmoser
% 20.10.2020
% Preparation: get DH Transformation Matrices in "getDHMatrices" and save
% them in "getCoordinates"
% Desc: This Script is for calculating the workspace of Design 1

clc;
clear;
close all

%% Calculation Parameters

xOffset = 100;    	% front offset to joint -> Goal Line
yOffset = -30;     	% joint offset from origin
zOffset = -277;  	% vertical distance from first joint to ground

RovWidth = 426;     % Rover Width
RovLength = 520;    % Rover Length
RovHeight = 150;    % Rover Height

%% Denivat Hartenberg parameters
d1 = 50;
d2 = 100;
d3 = 250;
d4 = -50;
d5 = -250;
d = [d1 d2 d3 d4 d5];

r1 = 0;
r2 = 0;
r3 = 117;
r4 = 0;
r5 = 0;
r = [0 0 r3 0 0];

% joint limits and steps/resolution
stepSizeTheta = 3;
theta1 = -pi/2:pi/(2*stepSizeTheta):pi/2;
theta2 = (-pi:pi/(2*stepSizeTheta):pi)+pi/2;
theta3 = -pi/2:pi/(2*stepSizeTheta):pi/2;
theta4 = -pi/2:pi/(2*stepSizeTheta):pi/2;
theta5 = 0;

%% calculate Forward Kinematics

THETA = allcomb(theta1,theta2,theta3,theta4,theta5);
[X,Y,Z,theta] = getCoordinates(THETA,d,r,5);

figure('name','Workspace of the Arm','Position',[-1500 200 700 600]);
view(45,30)
hold on
grid on;
axis equal;
xlabel('Coordinate-X position (mm)')
ylabel('Coordinate-Y position (mm)')
zlabel('Coordinate-Z position (mm)')

%% Plot Workspace

% plot3(X(:),Y(:),Z(:),'o','Color','r','MarkerSize',2);

% % Plot arm with no Angles
% [Px,Py,Pz] = getPlotPoints(d,r,zeros(5));
% plot3(Px,Py,Pz,'-ok','LineWidth',2)
% plot3(0,0,0,'ok','MarkerFaceColor','k')

% Plot arm at specific Point
% yMax
point = [xOffset RovWidth/2-yOffset zOffset];
plotArmAtPoint(X,Y,Z,theta,point,d,r);

% % yMin (intersection with rover)
% point = [xOffset -RovWidth/2+yOffset zOffset];
% plotArmAtPoint(X,Y,Z,theta,point,d,r);

% Loading
point = [-350 -yOffset -120];
plotArmAtPoint(X,Y,Z,theta,point,d,r);

% Plot Rover
plotRover(yOffset)
hold off

% Create Convex Hull Surface around Workspace
[k,av] = convhull(X,Y,Z,'Simplify',true);
% trimesh(k,X,Y,Z,'FaceColor','k','FaceAlpha',0.1,'EdgeColor','k','LineStyle',':');
S1.faces = k;
S1.vertices = [X,Y,Z];

% Create Ground Surface
[x,y,z] = meshgrid(0:100:500,-400:100:400,zOffset:1:zOffset+1);
x = x(:);
y = y(:);
z = z(:);
[k2,av1] = convhull(x,y,z);
% trisurf(k2,x,y,z,'FaceColor','cyan')
S2.faces = k2;
S2.vertices = [x,y,z];

% Calculate Intersection between Ground and Workspace Area
[intersect12, Surf12] = SurfaceIntersection(S1, S2);
x = Surf12.vertices(:,1);
y = Surf12.vertices(:,2);
z = Surf12.vertices(:,3);

% Get right Intersection
h = find(z==zOffset);
n = length(h);
x_0 = zeros(n,1);
y_0 = zeros(n,1);

for i=1:n    
    x_0(i) = x(h(i));
    y_0(i) = y(h(i));    
end

% sort matrices
h = find(y_0 < 0);
n = length(h);
xInter = zeros(n,1);
yInter = zeros(n,1);
for i=1:n    
    xInter(i) = x_0(h(i));
    yInter(i) = y_0(h(i));    
end

h = find(y_0 >= 0);
k = length(h);
for i=1:k-1   
    xInter(i+n) = x_0(h(k-i));
    yInter(i+n) = y_0(h(k-i));    
end

%% Plot Ground Intersection

% Plot Intersection on Ground
figure('name','Ground Intersection','Position',[-750 200 700 600]);
grid on
hold on
axis equal

% plot intersection points
plot(xInter,yInter,'*k','MarkerSize',4);

% plot intersection circle
FitCircle = CircleFitByPratt([xInter,yInter]);
th = linspace(0,2*pi,50)';
x = FitCircle(3)*cos(th)+FitCircle(1);
y = FitCircle(3)*sin(th)+FitCircle(2);
plot(x,y,'--k');

[x,y] = getCircleLineIntersection(FitCircle(1),FitCircle(2),FitCircle(3),xOffset);
plot(x,y,'*r','MarkerSize',10)

% Plot Goal Line
yMin = -RovWidth/2+yOffset;
yMax = RovWidth/2-yOffset;
plot([xOffset xOffset],[yMin yMax],'-ob')
hold off



