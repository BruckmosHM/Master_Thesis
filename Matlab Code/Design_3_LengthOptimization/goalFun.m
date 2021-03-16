function L = goalFun(x)
%GOALFUN goal function for points 1-3. Minimalize total Length
l = x(1:5);
L = sum(abs(l));
end

