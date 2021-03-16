function Gear = internal(m,z)
%INTERNAL Summary of this function goes here
%   Detailed explanation goes here
Gear.Nr = 'Circ';
Gear.z = z;

Gear.c = 0.167;
Gear.m = m;

Gear.p = Gear.m * pi;

Gear.d = Gear.m*Gear.z;
Gear.h = 2*Gear.m + Gear.c;
Gear.ha = Gear.m;
Gear.hf = Gear.m + Gear.c;

Gear.db = Gear.d*cosd(20);
Gear.rhof = 0.38*Gear.m;
Gear.sp = Gear.p/2;

Gear.da = Gear.d - 2*Gear.m;
Gear.df = Gear.d + 2*Gear.hf;
end

