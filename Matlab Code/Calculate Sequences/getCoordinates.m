function [x,y,z] = getCoordinates(l,alpha)
%GETCOORDINATES Calculates the endeffector coordinates from given angles

alpha(1) = -alpha(1);
alpha(2) = -alpha(2);

x(1) = 0;
y(1) = 0;
z(1) = 0;

x(2) = 0;
y(2) = 0;
z(2) = l(1);

x(3) = x(2) + cos(alpha(1))*cos(alpha(2))*l(2);
y(3) = y(2) + sin(alpha(1))*cos(alpha(2))*l(2);
z(3) = z(2) + sin(alpha(2))*l(2);

x(4) = x(3) + cos(alpha(1))*cos(alpha(3))*l(3);
y(4) = y(3) + sin(alpha(1))*cos(alpha(3))*l(3);
z(4) = z(3) + sin(alpha(3))*l(3);
        
x(5) = x(4);
y(5) = y(4);
z(5) = z(4) - l(4);

x(6) = x(5);
y(6) = y(5);
z(6) = z(5) - l(5);    

end






