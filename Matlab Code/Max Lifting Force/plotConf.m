function plotConf(T)
%PLOTANALYSIS plots the current configuration
figure('name','Analysis','Position',[-1876 482 533 410]);
grid on; hold on; axis equal; view(30,30); 
zlabel('Z'); xlabel('X'); ylabel('Y');

axisL = 70;  % Size of the axis

% Origin / Joint 1
J(1).O = [0;0;0];  	% Origin
x1 = [axisL;0;0];    % Axis
y1 = [0;axisL;0];
z2 = [0;0;axisL];
plot3([J(1).O(1) x1(1)],[J(1).O(2) x1(2)],[J(1).O(3) x1(3)],'-r'); % x-Axis
plot3([J(1).O(1) y1(1)],[J(1).O(2) y1(2)],[J(1).O(3) y1(3)],'-g'); % y-Axis
plot3([J(1).O(1) z2(1)],[J(1).O(2) z2(2)],[J(1).O(3) z2(3)],'-b'); % z-Axis
plot3(J(1).O(1),J(1).O(2),J(1).O(3),'ob'); % Origin
% text(J(1).O(1)+10,J(1).O(2)+20,J(1).O(3),'0');

for i=1:5
    J(i+1).O = J(1).O + T(i).P;   	% Origin
    J(i+1).x = T(i).R*x1 + T(i).P;	% Axis
    J(i+1).y = T(i).R*y1 + T(i).P;
    J(i+1).z = T(i).R*z2 + T(i).P;
    plot3([J(i+1).O(1) J(i+1).x(1)],[J(i+1).O(2) J(i+1).x(2)],[J(i+1).O(3) J(i+1).x(3)],'-r');
    plot3([J(i+1).O(1) J(i+1).y(1)],[J(i+1).O(2) J(i+1).y(2)],[J(i+1).O(3) J(i+1).y(3)],'-g');
    plot3([J(i+1).O(1) J(i+1).z(1)],[J(i+1).O(2) J(i+1).z(2)],[J(i+1).O(3) J(i+1).z(3)],'-b');
    plot3(J(i+1).O(1),J(i+1).O(2),J(i+1).O(3),'ob');
end


l2z = - J(2).O(2) + J(3).O(2);

x = [J(1).O(1), J(2).O(1),  J(2).O(1),      J(3).O(1),      J(3).O(1),  J(4).O(1),  J(4).O(1),  J(6).O(1)];
y = [J(1).O(2), J(2).O(2),  J(2).O(2)+75,   J(2).O(2)+75,   J(3).O(2),  J(3).O(2),  J(4).O(2),  J(6).O(2)];
z = [J(1).O(3), J(2).O(3),  J(2).O(3),      J(3).O(3),      J(3).O(3),  J(4).O(3),  J(4).O(3),  J(6).O(3)];

% x = [J(1).O(1),J(2).O(1),   J(2).O(1),  J(3).O(1),J(3).O(1),    J(4).O(1),J(5).O(1),J(6).O(1)];
% y = [J(1).O(2),J(2).O(2),   l2z,        J(3).O(2),J(4).O(2),    J(4).O(2),J(5).O(2),J(6).O(2)];
% z = [J(1).O(3),J(2).O(3),   J(2).O(3),  J(3).O(3),J(3).O(3),    J(4).O(3),J(5).O(3),J(6).O(3)];
plot3(x,y,z,'-k','LineWidth',2)

legend('x-Axis','y-Axis','z-Axis');

    
end

