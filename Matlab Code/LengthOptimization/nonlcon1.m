function [c,ceq] = nonlcon1(x)
%NONLCON Non-Linear constraints for points 1 and 2 (yMin and yMax)

global P1 P2 eOffset

l = x(1:5);

alpha11 = x(6);
alpha21 = x(7);
alpha31 = x(8);

alpha12 = x(9);
alpha22 = x(10);
alpha32 = x(11);

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
z(1,2) = l(1);

x(2,2) = x(1,2) + cos(alpha12)*cos(alpha22)*l(2);
y(2,2) = y(1,2) + sin(alpha12)*cos(alpha22)*l(2);
z(2,2) = z(1,2) + sin(alpha22)*l(2);

x(3,2) = x(2,2) + cos(alpha12)*cos(alpha32)*l(3);
y(3,2) = y(2,2) + sin(alpha12)*cos(alpha32)*l(3);
z(3,2) = z(2,2) + sin(alpha32)*l(3);

% non-linear unequality constraints
c = [];

% non-linear equality constraints
ceq(1) = P1(1) - x(3,1);
ceq(2) = P1(2) - y(3,1);
ceq(3) = P1(3) - z(3,1) + l(4) + l(5) + eOffset;
ceq(4) = P2(1) - x(3,2);
ceq(5) = P2(2) - y(3,2);
ceq(6) = P2(3) - z(3,2) + l(4) + l(5) + eOffset;
ceq(7) = l(2) - l(3);

end

