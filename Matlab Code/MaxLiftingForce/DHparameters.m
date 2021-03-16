function [T] = DHparameters(dh)
%DHparameters Returns the transformation matrices of the DH parameters
% A = Transformation matrices A^i-1_i
% T = Transformation matrices A^0_i
% R = Rotation matrices R^0_i
% P = Tranformatino vector T^0_i

theta = dh(:,1);
alpha = dh(:,2);
a = dh(:,3);
d = dh(:,4);

%% direct calculation
for i=1:5
    T(i).A = [
        cosd(theta(i)) -sind(theta(i))*cosd(alpha(i)) sind(theta(i))*sind(alpha(i))  a(i)*cosd(theta(i));
        sind(theta(i)) cosd(theta(i))*cosd(alpha(i))  -cosd(theta(i))*sind(alpha(i)) a(i)*sind(theta(i));
        0              sind(alpha(i))                 cosd(alpha(i))                 d(i); 
        0              0                              0                              1]; 
end

T(1).T = T(1).A;
T(2).T = T(1).A*T(2).A;
T(3).T = T(1).A*T(2).A*T(3).A;
T(4).T = T(1).A*T(2).A*T(3).A*T(4).A;
T(5).T = T(1).A*T(2).A*T(3).A*T(4).A*T(5).A;

for i=1:5
%     fprintf(['TT',num2str(i),'='])
%     disp(T(i).T)
    T(i).R = T(i).T(1:3,1:3);
    T(i).P = T(i).T(1:3,4);    
end

% %% symbolic solve
% syms th1 th2 th3 th4 th5
% 
% Tsym(1).A = [
%         cosd(th1)   -sind(th1)*cosd(alpha(i))   sind(th1)*sind(alpha(i))    a(i)*cosd(th1);
%         sind(th1)   cosd(th1)*cosd(alpha(i))    -cosd(th1)*sind(alpha(i))   a(i)*sind(th1);
%         0           sind(alpha(i))             	cosd(alpha(i))             	d(i); 
%         0        	0                          	0                          	1]; 
% Tsym(2).A = [
%         cosd(th2)   -sind(th2)*cosd(alpha(i))   sind(th2)*sind(alpha(i))    a(i)*cosd(th2);
%         sind(th2)   cosd(th2)*cosd(alpha(i))    -cosd(th2)*sind(alpha(i))   a(i)*sind(th2);
%         0           sind(alpha(i))             	cosd(alpha(i))             	d(i); 
%         0        	0                          	0                          	1];
% Tsym(3).A = [
%         cosd(th3)   -sind(th3)*cosd(alpha(i))   sind(th3)*sind(alpha(i))    a(i)*cosd(th3);
%         sind(th3)   cosd(th3)*cosd(alpha(i))    -cosd(th3)*sind(alpha(i))   a(i)*sind(th3);
%         0           sind(alpha(i))             	cosd(alpha(i))             	d(i); 
%         0        	0                          	0                          	1];
% Tsym(4).A = [
%         cosd(th4)   -sind(th4)*cosd(alpha(i))   sind(th4)*sind(alpha(i))    a(i)*cosd(th4);
%         sind(th4)   cosd(th4)*cosd(alpha(i))    -cosd(th4)*sind(alpha(i))   a(i)*sind(th4);
%         0           sind(alpha(i))             	cosd(alpha(i))             	d(i); 
%         0        	0                          	0                          	1];
% Tsym(5).A = [
%         cosd(th5)   -sind(th5)*cosd(alpha(i))   sind(th5)*sind(alpha(i))    a(i)*cosd(th5);
%         sind(th5)   cosd(th5)*cosd(alpha(i))    -cosd(th5)*sind(alpha(i))   a(i)*sind(th5);
%         0           sind(alpha(i))             	cosd(alpha(i))             	d(i); 
%         0        	0                          	0                          	1];
% 
% Tsym(1).T = Tsym(1).A;
% Tsym(2).T = Tsym(1).A*Tsym(2).A;
% Tsym(3).T = Tsym(1).A*Tsym(2).A*Tsym(3).A;
% Tsym(4).T = Tsym(1).A*Tsym(2).A*Tsym(3).A*Tsym(4).A;
% Tsym(5).T = Tsym(1).A*Tsym(2).A*Tsym(3).A*Tsym(4).A*Tsym(5).A;
% 
% for i=1:5
%    Tsym(i).R = Tsym(i).T(1:3,1:3);
%    Tsym(i).P = Tsym(i).T(1:3,4);    
% end


end


