function [Xfin,Yfin,Zfin,theta] = getCoordinates(THETA, d, r, n)
%GETCOORDINATES Calculation Forward Kinematics for DOF 5
%   Calculates the endeffector coordinates from given angles
%   Forward Kinematics solution determined via DHInverse

d1 = d(1);
d2 = d(2);
d3 = d(3);
d4 = d(4);
d5 = d(5);

a3 = r(3);

X = zeros(length(THETA),1);
Y = zeros(length(THETA),1);
Z = zeros(length(THETA),1);

theta = struct;
theta.t1 = zeros(length(THETA),1);
theta.t2 = zeros(length(THETA),1);
theta.t3 = zeros(length(THETA),1);
theta.t4 = zeros(length(THETA),1);
theta.t5 = zeros(length(THETA),1);

% tempOld = 0;

for i=1:length(THETA)
    
    q1 = THETA(i,1);
    q2 = THETA(i,2);
    q3 = THETA(i,3);
    q4 = THETA(i,4);
    q5 = THETA(i,5);
    
    c1 = cos(q1);
    c2 = cos(q2);
    c3 = cos(q3);
    c4 = cos(q4);
    c5 = cos(q5);

    s1 = sin(q1);
    s2 = sin(q2);
    s3 = sin(q3);
    s4 = sin(q4);
    s5 = sin(q5); 
    
    switch n
        case 1
            X(i) = 0;
            Y(i) = 0;
            Z(i) = d1;
            
        case 2
            X(i) = -d2*s1;
            Y(i) = c1*d2; 
            Z(i) = d1; 
            
        case 3
            X(i) = c1*d3*s2 - d2*s1 - a3*s1*s3 + a3*c1*c2*c3;
            Y(i) = c1*d2 + a3*c1*s3 + d3*s1*s2 + a3*c2*c3*s1;
            Z(i) = d1 + c2*d3 - a3*c3*s2;
            
        case 4
            X(i) = c1*d3*s2 - d2*s1 + c1*d4*s2 - a3*s1*s3 + a3*c1*c2*c3;
            Y(i) = c1*d2 + a3*c1*s3 + d3*s1*s2 + d4*s1*s2 + a3*c2*c3*s1;
            Z(i) = d1 + c2*d3 + c2*d4 - a3*c3*s2; 
            
        case 5
            X(i) = c1*d3*s2 - d2*s1 - d5*(c4*(c3*s1 + c1*c2*s3) - s4*(s1*s3 - c1*c2*c3)) + ...
                c1*d4*s2 - a3*s1*s3 + a3*c1*c2*c3;
            Y(i) = d5*(c4*(c1*c3 - c2*s1*s3) - s4*(c1*s3 + c2*c3*s1)) + c1*d2 + a3*c1*s3 + ...
                d3*s1*s2 + d4*s1*s2 + a3*c2*c3*s1;
            Z(i) = d1 + c2*d3 + c2*d4 + d5*(c3*s2*s4 + c4*s2*s3) - a3*c3*s2;
    end
    
    
    theta.t1(i) = q1;
    theta.t2(i) = q2;
    theta.t3(i) = q3;
    theta.t4(i) = q4;
    theta.t5(i) = q5;
    
%     temp = round((i/length(THETA))*100);
%     r = rem(temp,10);
%     
%     if (r==0) && (temp ~= tempOld)
%         clc;
%         fprintf('%i%%\n',temp);
%     end
%     
%     tempOld = temp;
end

% disp('Calculation Ended')

% Coordinate Frame adjustment

Xfin = X;
Yfin = -Z;
Zfin = Y;


% R = zeros(length(X),1);
% for i=1:length(X)    
%     R(i,1) = Xfin(i);
%     R(i,2) = Yfin(i);
%     R(i,3) = Zfin(i);
%     R(i) = sqrt(X(i)^2+Y(i)^2+Z(i)^2);
% end

end






