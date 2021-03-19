function [c,ceq] = nonlcon(x,P,l,eOffset,limits)
%NONLCON Non-Linear constraints 

alpha1 = -x(1);
alpha2 = -x(2);
alpha3 = x(3);

% point to reach
x(1,3) = 0;
y(1,3) = 0;
z(1,3) = l(1);

x(2,3) = x(1,3) + cos(alpha1)*cos(alpha2)*l(2);
y(2,3) = y(1,3) + sin(alpha1)*cos(alpha2)*l(2);
z(2,3) = z(1,3) + sin(alpha2)*l(2);

x(3,3) = x(2,3) + cos(alpha1)*cos(alpha3)*l(3);
y(3,3) = y(2,3) + sin(alpha1)*cos(alpha3)*l(3);
z(3,3) = z(2,3) + sin(alpha3)*l(3);

% non-linear unequality constraints
c = [];

% non-linear equality constraints
ceq(1) = P(1) - x(3,3);
ceq(2) = P(2) - y(3,3);
ceq(3) = P(3) - z(3,3) + l(4) + l(5) + eOffset;

% ceq(4) = (alpha2 + alpha3) < 160;
% ceq(5) = (alpha2 + alpha3) > -135;

end

