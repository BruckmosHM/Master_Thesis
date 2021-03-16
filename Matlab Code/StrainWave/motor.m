function Nema = motor(i,motors)
%MOTOR Summary of this function goes here
%   Detailed explanation goes here
Nema.Nr = i;
Nema.type = motors(1);
Nema.torque = motors(2)/100;
Nema.m = motors(3)/1000;
if Nema.type==14
    Nema.B = 35;
    Nema.H = 35;
    Nema.D = 35;
elseif Nema.type==16
    Nema.B = 39;
    Nema.H = 39;
    Nema.D = 39;
elseif Nema.type==17
    Nema.B = 42;
    Nema.H = 42;
    Nema.D = 42;
elseif Nema.type==23
    Nema.B = 57;
    Nema.H = 57;
    Nema.D = 57;
end
Nema.L = motors(4);
Nema.Tm = Nema.torque/Nema.m;
    
end

