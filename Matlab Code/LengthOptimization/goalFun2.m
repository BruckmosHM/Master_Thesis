function Alpha = goalFun2(x)
%GOALFUN goal Function for point 1 and 2 contstrained by LP3. Minimalize
%   joint travel
Alpha = sum(abs(x));
end

