function [c,ceq] = nonlcon3(x)
%NONLCON Non-Linear constraints for points 1 and 2 with given Lengths from
%   calculation of point 3

global P1 P2 L1 L2 L3 L4 L5

l = [L1 L2 L3 L4 L5];

alpha11 = x(1);
alpha21 = x(2);
alpha31 = x(3);

alpha12 = x(4);
alpha22 = x(5);
alpha32 = x(6);

% alpha13 = x(12);
% alpha23 = x(13);
% alpha33 = x(14);

% Ymax - P1
x(1,1) = 0;
y(1,1) = 0;
z(1,1) = l(1);

x(2,1) = x(1,1) + cos(alpha11)*cos(alpha21)*l(2);
y(2,1) = y(1,1) + sin(alpha11)*cos(alpha21)*l(2);
z(2,1) = z(1,1) + sin(alpha21)*l(2);

x(3,1) = x(2,1) + cos(alpha11)*cos(alpha31)*l(3);
y(3,1) = y(2,1) + sin(alpha11)*cos(alpha31)*l(3);
z(3,1) = z(2,1) + sin(alpha31)*l(3);

% Ymin - P2
x(1,2) = 0;
y(1,2) = 0;
z(1,2) = l(2);

x(2,2) = x(1,2) + cos(alpha12)*cos(alpha22)*l(2);
y(2,2) = y(1,2) + sin(alpha12)*cos(alpha22)*l(2);
z(2,2) = z(1,2) + sin(alpha22)*l(2);

x(3,2) = x(2,2) + cos(alpha12)*cos(alpha32)*l(3);
y(3,2) = y(2,2) + sin(alpha12)*cos(alpha32)*l(3);
z(3,2) = z(2,2) + sin(alpha32)*l(3);

% % unloading - P3
% x(1,3) = 0;
% y(1,3) = 0;
% z(1,3) = l(2);
% 
% x(2,3) = x(1,3) + cos(alpha13)*cos(alpha23)*l(2);
% y(2,3) = y(1,3) + sin(alpha13)*cos(alpha23)*l(2);
% z(2,3) = z(1,3) + sin(alpha23)*l(2);
% 
% x(3,3) = x(2,3) + cos(alpha13)*cos(alpha33)*l(3);
% y(3,3) = y(2,3) + sin(alpha13)*cos(alpha33)*l(3);
% z(3,3) = z(2,3) + sin(alpha33)*l(3);

% non-linear unequality constraints
c = [];

% non-linear equality constraints
ceq(1) = P1(1) - x(3,1);
ceq(2) = P1(2) - y(3,1);
ceq(3) = P1(3) - z(3,1) + l(4) + l(5);
ceq(4) = P2(1) - x(3,2);
ceq(5) = P2(2) - y(3,2);
ceq(6) = P2(3) - z(3,2) + l(4) + l(5);
% ceq(7) = P3(1) - x(3,3);
% ceq(8) = P3(2) - y(3,3);
% ceq(9) = P3(3) - z(3,3) + l(4) + l(5);

end

