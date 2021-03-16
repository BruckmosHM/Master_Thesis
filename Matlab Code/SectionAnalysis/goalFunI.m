function A = goalFunI(x)
%GOALFUN Summary of this function goes here
%   Detailed explanation goes here

B = x(1);
H = x(2);
tb = x(3);
th = x(4);

b = B-tb;
h = H-2*th;

A = B*H - b*h;
end
