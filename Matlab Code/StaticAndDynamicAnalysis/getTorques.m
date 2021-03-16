function Torques = getTorques(input,conversion)
%GETTORQUES Summary of this function goes here
%   Detailed explanation goes here

for i=1:5
    N(i,1) = input(i).Nx;
    N(i,2) = input(i).Ny;
    N(i,3) = input(i).Nz;
end

for i=1:5
    M(i,1) = N(i,conversion(i,1));
    M(i,2) = N(i,conversion(i,2));
    M(i,3) = N(i,conversion(i,3));
end

for i=1:5
    if abs(M(i,1)) < abs(M(i,2))
        mb1 = M(i,2);
        mb2 = M(i,1);
    else
        mb1 = M(i,1);
        mb2 = M(i,2);
    end
    Torques(i).Mb1 = mb1;
    Torques(i).Mb2 = mb2;
    Torques(i).Mt = M(i,3);
end

for i=1:5
    Torques(i).fb2 = round(Torques(i).Mb2/Torques(i).Mb1,2);
    Torques(i).ft = round(Torques(i).Mt/Torques(i).Mb1,2);
end

end

