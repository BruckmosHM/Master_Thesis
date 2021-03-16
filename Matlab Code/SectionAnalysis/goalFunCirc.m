function A = goalFunCirc(x)
%GOALFUN Summary of this function goes here
%   Detailed explanation goes here

R = x(1);
t = x(2);

r = R-t;
A = pi*(R^2-r^2);

% r = R-t;
% A = pi*(R^2-r^2);
% Ib = -pi/4*(R^4-r^4);
% G = A^2 + Ib;
end

