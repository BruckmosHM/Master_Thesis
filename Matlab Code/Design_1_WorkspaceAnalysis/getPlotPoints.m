function [X,Y,Z] = getPlotPoints(d,r,theta)
%PLOTARM plot an arm with specific angles
%   Detailed explanation goes here

X(1) = 0;
Y(1) = 0;
Z(1) = 0;

[Xfor, Yfor, Zfor] = getCoordinates(theta,d,r,1);
X(2) = Xfor(1);
Y(2) = Yfor(1);
Z(2) = Zfor(1);

[Xfor, Yfor, Zfor] = getCoordinates(theta,d,r,2);
X(3) = Xfor(1);
Y(3) = Yfor(1);
Z(3) = Zfor(1);

[Xfor, Yfor, Zfor] = getCoordinates(theta,d,r,3);
X(4) = Xfor(1);
Y(4) = Yfor(1);
Z(4) = Zfor(1);

[Xfor, Yfor, Zfor] = getCoordinates(theta,d,r,4);
X(5) = Xfor(1);
Y(5) = Yfor(1);
Z(5) = Zfor(1);

[Xfor, Yfor, Zfor] = getCoordinates(theta,d,r,5);
X(6) = Xfor(1);
Y(6) = Yfor(1);
Z(6) = Zfor(1);

end

