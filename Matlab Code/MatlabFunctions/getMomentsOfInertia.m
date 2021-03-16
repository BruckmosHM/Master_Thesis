function MoI = getMomentsOfInertia(path)
%GETMOMENTSOFINTERTIA Summary of this function goes here
%   Detailed explanation goes here
for i=1:5
    MoI(i).Component = ['Link ',num2str(i)];
    
    xls = readcell([path,'Properties.xlsx'],'Sheet',['Link ',num2str(i)],'Range','B18:B26');  
    MoI(i).CoM = read(xls);
    
    xls = readcell([path,'Properties.xlsx'],'Sheet',['Link ',num2str(i)],'Range','B29:B37');
    MoI(i).Origin = read(xls);   
end


MoI(6).Component = 'Rover';
xls = readcell([path,'Properties.xlsx'],'Sheet','Rover','Range','B18:B26');
MoI(6).CoM = read(xls);
xls = readcell([path,'Properties.xlsx'],'Sheet','Rover','Range','B29:B37');
MoI(6).Origin = read(xls);


end

function MoII = read(xls)
    Ixx = sscanf(xls{1,1},'Ixx = %f'); 
    Ixy = sscanf(xls{2,1},'Ixy = %f');
    Ixz = sscanf(xls{3,1},'Ixz = %f');
    Iyx = sscanf(xls{4,1},'Iyx = %f');
    Iyy = sscanf(xls{5,1},'Iyy = %f');
    Iyz = sscanf(xls{6,1},'Iyz = %f');
    Izx = sscanf(xls{7,1},'Izx = %f');
    Izy = sscanf(xls{8,1},'Izy = %f');
    Izz = sscanf(xls{9,1},'Izz = %f');
    MoII = [Ixx,Ixy,Ixz;Iyx,Iyy,Iyz;Izx,Izy,Izz]*1e-9;
end

