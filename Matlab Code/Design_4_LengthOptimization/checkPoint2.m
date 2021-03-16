function F = checkPoint2(alpha,l)

global P2

F(1) = cos(alpha(1))*l(1) + cos(alpha(2))*355/2 - P2(1);
F(2) = sin(alpha(1))*l(2) + sin(alpha(2))*355/2 - (P2(2) + l(3) + l(4));
end