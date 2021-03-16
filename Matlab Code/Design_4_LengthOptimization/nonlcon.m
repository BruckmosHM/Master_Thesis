function [c,ceq] = nonlcon(x)
%NONLCON Non-Linear constraints for point 1

global P1

l = x(1:4);

alpha12 = x(5);
alpha22 = x(6);

% Loading - P1
x(1,2) = 0;
z(1,2) = 0;

x(2,2) = x(1,2) + cos(alpha12)*l(1);
z(2,2) = z(1,2) + sin(alpha12)*l(1);

x(3,2) = x(2,2) + cos(alpha22)*l(2);
z(3,2) = z(2,2) + sin(alpha22)*l(2);

% non-linear unequality constraints
c = [];

% non-linear equality constraints
ceq(1) = P1(1) - x(3,2);
ceq(2) = P1(2) - z(3,2) + l(3) + l(4);

end

