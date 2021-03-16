function [x,y] = getCircleLineIntersection(x0,y0,r,d)
%GETCIRCLELINEINTERSECTION Summary of this function goes here

c = d^2 - 2*d*x0 + x0^2 + y0^2 - r^2;

if c <= 0
    x(1) = d;
    x(2) = d;
    y1 = (2*y0 + sqrt(4*y0^2-4*c))/2;    
    y2 = (2*y0 - sqrt(4*y0^2-4*c))/2;
    
    if y1>y2
        y(1) = y1;
        y(2) = y2;
    else
        y(1) = y2;
        y(2) = y1;
    end
    
else
    x = [0 0];
    y = [0 0];    
end




end

