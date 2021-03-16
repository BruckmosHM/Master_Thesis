function rel = relAngles(abs)
%RELANGLES Summary of this function goes here
%   Detailed explanation goes here

rel(1) = 360 - rad2deg(abs(1));
rel(2) = -rad2deg(abs(2));
rel(3) = rel(2) + rad2deg(abs(3));
rel(4) = 360 + rel(3) - rel(2);

for i=1:length(rel)
    if rel(i) > 360
        rel(i) = rel(i) - 360;
    elseif rel(i) < -360
        rel(i) = rel(i) + 360;
    end    
end
    
end

