function [x,y,z] = getCoordinates(l,alpha)
%GETCOORDINATES Calculates the endeffector coordinates from given angles

x(1) = 0;
y(1) = 0;
z(1) = 0;

x(2) = x(1) + cos(alpha(1))*l(1);
y(2) = 0;
z(2) = z(1) + sin(alpha(1))*l(1);

x(3) = x(2) + cos(alpha(2))*l(2);
y(3) = 0;
z(3) = z(2) + sin(alpha(2))*l(2);

x(4) = x(3);
y(4) = 0;
z(4) = z(3) - l(3);
        
x(5) = x(4);
y(5) = 0;
z(5) = z(4) - l(4);

 


end






