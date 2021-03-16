function [P] = plotArmAtPoint(X,Y,Z,theta,point,d,r)
%PLOTARMATPOINT plot the rover arm at specific point/nearest point
%   plots the arm in an existing figure at the orientation specified to the nearest point

ptCloud = pointCloud([X Y Z]);
[indices] = findNearestNeighbors(ptCloud,point,1);
% x = find(X==ptCloud.Location(indices,1));
% y = find(Y==ptCloud.Location(indices,2));
% z = find(Z==ptCloud.Location(indices,3));
P = [X(indices) Y(indices) Z(indices)];

% iTheta = x(ismember(x,y)==1);
thetaP(1) = theta.t1(indices);
thetaP(2) = theta.t2(indices);
thetaP(3) = theta.t3(indices);
thetaP(4) = theta.t4(indices);
thetaP(5) = theta.t5(indices);

% Plot arm
[Px,Py,Pz] = getPlotPoints(d,r,[thetaP;thetaP;thetaP;thetaP;thetaP]);
plot3(Px(1:3),Py(1:3),Pz(1:3),'-ob','LineWidth',2);
plot3(Px(3:4),Py(3:4),Pz(3:4),'--ob','LineWidth',2);
plot3(Px(4:end),Py(4:end),Pz(4:end),'-ob','LineWidth',2);
% plot3(Px,Py,Pz,'-ob','LineWidth',2)

end

