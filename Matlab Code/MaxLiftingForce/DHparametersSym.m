function [T] = DHparametersSym(dh)
%DHparameters Returns the transformation matrices of the DH parameters
% A = Transformation matrices A^i-1_i
% T = Transformation matrices A^0_i
% R = Rotation matrices R^0_i
% P = Tranformation vector T^0_i

syms th1 th2 th3 th4 th5 real
n=5;

theta = [th1 th2 th3 th4 th5];
% theta = dh(:,1);
alpha = dh(:,2);
a = dh(:,3);
d = dh(:,4);

%% direct calculation
T(n).A = 0;
for i=1:n
    T(i).A = [
        cos(theta(i)) -sin(theta(i))*cosd(alpha(i)) sin(theta(i))*sind(alpha(i))  a(i)*cos(theta(i));
        sin(theta(i)) cos(theta(i))*cosd(alpha(i))  -cos(theta(i))*sind(alpha(i)) a(i)*sin(theta(i));
        0              sind(alpha(i))                 cosd(alpha(i))                 d(i); 
        0              0                              0                              1]; 

end

T(1).T = T(1).A;
T(2).T = T(1).A*T(2).A;
T(3).T = T(1).A*T(2).A*T(3).A;
T(4).T = T(1).A*T(2).A*T(3).A*T(4).A;
T(5).T = T(1).A*T(2).A*T(3).A*T(4).A*T(5).A;

disp('simplifying DH Transformation matrices..')
for i=1:n
    T(i).T = simplify(T(i).T);
%     fprintf(['T',num2str(i),'='])
%     disp(T(i).T)
    T(i).R = T(i).T(1:3,1:3);
    T(i).P = T(i).T(1:3,4);    
end


end


