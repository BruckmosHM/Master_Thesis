%% Strain Wave Calculation and Motor Selection
% Jakob Bruckmoser
% 23.11.2020
clear;clc

%% Parameters
M = 14;        	% required torque in Nm
ratio = 1/3; 	% length/teeth ratio HTD 3M


%% Motors (type,torque,mass,length)

motors = [
%     14,14,140,26;
%     14,18,170,34;
    14,23,220,42;
    14,40,350,52;    
    16,21,190,34;
%     16,18,210,34;
    16,25,270,44;    
%     17,16,140,20;
    17,26,230,34;
    17,45,280,39;
    23,55,470,41;
    23,60,500,42];

for i=1:length(motors)
    Nema(i) = motor(i,motors(i,:));
end


%% calculations

for i=1:length(Nema)
    Nema(i).Trans = Nema(i).torque/M;
    Nema(i).Flex = ceil(2/Nema(i).Trans);
    Nema(i).Circ = Nema(i).Flex+2;
    
    Nema(i).BeltL = Nema(i).Flex/ratio;   % T2.5 Timing Belt
    Nema(i).BeltD = Nema(i).BeltL/(2*pi)*2;
    
    Nema(i).module = Nema(i).D/Nema(i).Flex;
    Nema(i).P = Nema(i).module * pi;    
end

struct2table(Nema)
writetable(struct2table(Nema),'Nema.xlsx')
% struct2table(Nema(6))

%% Gearing parameters
n = 6;
m = 1.25;

% Gear(1) = external(m,Nema(n).Flex);
% Gear(2) = internal(m,Nema(n).Circ);

Gear(1) = external(m,40);
Gear(2) = internal(m,42);

struct2table(Gear)
writetable(struct2table(Gear),'Gear.xlsx')







