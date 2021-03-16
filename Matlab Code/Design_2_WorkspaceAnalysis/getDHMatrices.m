function  getDHMatrices()
%GETDHTRANSFORMATIONS Calculate DH Matrices from DH A0-n Matrices
%   5 DOF Systems only

syms c1 c2 c3 c4 c5 s1 s2 s3 s4 s5 d1 d2 d3 d4 d5 a3

n = 5;

A1 = [c1 0 -s1 0; s1 0 c1 0; 0 -1 0 d1; 0 0 0 1];
A2 = [c2 0 s2 0; s2 0 -c2 0; 0 1 0 d2; 0 0 0 1];
A3 = [c3 -s3 0 a3*c3; s3 c3 0 a3*s3; 0 0 1 d3; 0 0 0 1];
A4 = [c4 0 -s4 0; s4 0 c4 0; 0 -1 0 d4; 0 0 0 1];
A5 = [c5 -s5 0 0; s5 c5 0 0; 0 0 1 d5; 0 0 0 1];

P = struct;
T = struct;

T.T01 = A1;
T.T02 = A1*A2;
T.T03 = A1*A2*A3;
T.T04 = A1*A2*A3*A4;
T.T05 = A1*A2*A3*A4*A5;

P.T01.Px = T.T01(1,4);
P.T01.Py = T.T01(2,4);
P.T01.Pz = T.T01(3,4);

P.T02.Px = T.T02(1,4);
P.T02.Py = T.T02(2,4);
P.T02.Pz = T.T02(3,4);

P.T03.Px = T.T03(1,4);
P.T03.Py = T.T03(2,4);
P.T03.Pz = T.T03(3,4);

P.T04.Px = T.T04(1,4);
P.T04.Py = T.T04(2,4);
P.T04.Pz = T.T04(3,4);

P.T05.Px = T.T05(1,4);
P.T05.Py = T.T05(2,4);
P.T05.Pz = T.T05(3,4);
        

switch n
    case 1
        fprintf('X(i) = ');
        disp(P.T01.Px)
        fprintf('Y(i) = ');
        disp(P.T01.Py)
        fprintf('Z(i) = ');
        disp(P.T01.Pz)
    case 2
        fprintf('X(i) = ');
        disp(P.T02.Px)
        fprintf('Y(i) = ');
        disp(P.T02.Py)
        fprintf('Z(i) = ');
        disp(P.T02.Pz)
    case 3
        fprintf('X(i) = ');
        disp(P.T03.Px)
        fprintf('Y(i) = ');
        disp(P.T03.Py)
        fprintf('Z(i) = ');
        disp(P.T03.Pz)
    case 4
        fprintf('X(i) = ');
        disp(P.T04.Px)
        fprintf('Y(i) = ');
        disp(P.T04.Py)
        fprintf('Z(i) = ');
        disp(P.T04.Pz)
    case 5
        fprintf('X(i) = ');
        disp(P.T05.Px)
        fprintf('Y(i) = ');
        disp(P.T05.Py)
        fprintf('Z(i) = ');
        disp(P.T05.Pz)
end


end

