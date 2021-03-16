function [c,ceq] = nonlcon4(x)
%NONLCON Non-Linear constraints for points 1 and 2 with given Lengths from
%   calculation of point 3

global P3 L1 L2 L3 L4 L5 eOffset

l = [L1 L2 L3 L4 L5];

alpha13 = x(1);
alpha23 = x(2);
alpha33 = x(3);

% grabbing - P3
x(1,3) = 0;
y(1,3) = 0;
z(1,3) = l(1);

x(2,3) = x(1,3) + cos(alpha13)*cos(alpha23)*l(2);
y(2,3) = y(1,3) + sin(alpha13)*cos(alpha23)*l(2);
z(2,3) = z(1,3) + sin(alpha23)*l(2);

x(3,3) = x(2,3) + cos(alpha13)*cos(alpha33)*l(3);
y(3,3) = y(2,3) + sin(alpha13)*cos(alpha33)*l(3);
z(3,3) = z(2,3) + sin(alpha33)*l(3);

% non-linear unequality constraints
c = [];

% non-linear equality constraints
ceq(1) = P3(1) - x(3,3);
ceq(2) = P3(2) - y(3,3);
ceq(3) = P3(3) - z(3,3) + l(4) + l(5) + eOffset;

end

