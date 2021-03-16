function L = goalFun(x)
%GOALFUN goal function for point 1. Minimalize total Length
l = x(1:4);
L = sum(abs(l));
end

