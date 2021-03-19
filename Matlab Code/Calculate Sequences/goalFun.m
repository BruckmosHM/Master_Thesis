function Alpha = goalFun(x)
%GOALFUN goal Function -> Minimalize joint travel
Alpha = sum(abs(x));
end
