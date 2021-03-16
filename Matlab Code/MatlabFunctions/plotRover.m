function plotRover(yOffset)
%PLOTROVER plot the rover inside a existing figure (3D plot)

trans = 0.1;

WhlsDia = 228;
WhlsThk = 118;
RovWidth = 191;
BeamLength = 284;
h1 = -188;
h2 = -480;
h3 = -148;
h4 = -521;
v1 = -131;
v2 = -163;
v3 = -249;


xRov = [h3 h3 h4 h4 h3 h3 h4 h4]; 
yRov = [RovWidth/2 -RovWidth/2 RovWidth/2 -RovWidth/2 ...
    RovWidth/2 -RovWidth/2 RovWidth/2 -RovWidth/2]-yOffset;
zRov = [v1 v1 v1 v1 v3 v3 v3 v3];

Rov= convhull(xRov,yRov,zRov,'Simplify',true);
trimesh(Rov,xRov,yRov,zRov,'FaceColor','k','FaceAlpha',trans,'EdgeColor','k','LineStyle',':');


[xCyl,yCyl,zCyl] = cylinder(WhlsDia/2);
zCyl = zCyl*WhlsThk;

% First Wheel Front Left
x = xCyl+h1;
y = zCyl+RovWidth/2-yOffset;
z = yCyl+v2;
wh1 = convhull(x,y,z,'Simplify',true);
trimesh(wh1,x,y,z,'FaceColor','k','FaceAlpha',trans,'EdgeColor','k','LineStyle',':');

% second Wheel Rear Left
x = xCyl+h2;
y = zCyl+RovWidth/2-yOffset;
z = yCyl+v2;
wh1 = convhull(x,y,z,'Simplify',true);
trimesh(wh1,x,y,z,'FaceColor','k','FaceAlpha',trans,'EdgeColor','k','LineStyle',':');

% third Wheel Rear Right
x = xCyl+h2;
y = zCyl-RovWidth/2-yOffset-WhlsThk;
z = yCyl+v2;
wh1 = convhull(x,y,z,'Simplify',true);
trimesh(wh1,x,y,z,'FaceColor','k','FaceAlpha',trans,'EdgeColor','k','LineStyle',':');

% fourth Wheel Front Right
x = xCyl+h1;
y = zCyl-RovWidth/2-yOffset-WhlsThk;
z = yCyl+v2;
wh1 = convhull(x,y,z,'Simplify',true);
trimesh(wh1,x,y,z,'FaceColor','k','FaceAlpha',trans,'EdgeColor','k','LineStyle',':');

% Beam
x = -sin(pi/4)*BeamLength;
y = -yOffset;
z = -cos(pi/4)*BeamLength;
plot3([0 x],[-yOffset y],[0 z],'-.k')





end

