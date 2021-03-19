function rel = toRelAngles(abs)
%RELANGLES Calculates DH angles (rad) in Joint Angles for motor control (deg)

rel(1) = rad2deg(abs(1));
rel(2) = rad2deg(abs(2));
rel(3) = rel(2) + rad2deg(abs(3));
rel(4) = -rel(3) + rel(2);

rel = round(rel,1);    
end

