function F = fsolveFun(x,P,l,eOffset)
%FSOLVEFUN Summary of this function goes here
%   Detailed explanation goes here

alpha1 = x(1);
alpha2 = x(2);
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


F(1) = P(1) - x(3,3);
F(2) = P(2) - y(3,3);
F(3) = P(3) - z(3,3) + l(4) + l(5) + eOffset;
end

