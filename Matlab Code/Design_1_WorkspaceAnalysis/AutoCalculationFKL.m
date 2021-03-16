%% Calculate all possible positions with variing Lengths (d-Parameters)
% Jakob Bruckmoser
% 16.10.2020
% Preparation: get DH Transformation Matrices in "getDHMatrices" and save
% them in "getCoordinates"
% Desc: This Script is for calculating the workspace of Design 1

clc;
clear;
close all

%% Result Matrix
Res = zeros(20,15);
% Res(1:10) = ['Suitable','ArmLength','yMax Miss','yMin Miss','d1','d2','d3','d4','d5','r3'];

%% Calculation Parameters

eps = 2;            % precision when Arm suitable or not

xOffset = 100;    	% front offset to joint -> Goal Line
yOffset = -30;     	% joint offset from origin
zOffset = -277;  	% vertical distance from first joint to ground

RovWidth = 426;     % Rover Width
RovLength = 520;    % Rover Length
RovHeight = 150;    % Rover Height

%% Denivat Hartenberg parameters - Autocalculation Parameters

stepSizeD = 3;
stepSizeTheta = 5;

start = 50;
End = 60;
d1 = start:(End-start)/stepSizeD:End;

start = 100;
End = 150;
d2 = start:(End-start)/stepSizeD:End;

start = 250;
End = 350;
d3 = start:(End-start)/stepSizeD:End;

start = -100;
End = -50;
d4 = start:(End-start)/stepSizeD:End;

start = -250;
End = -150;
d5 = start:(End-start)/stepSizeD:End;

start = 50;
End = 150;
r3 = start:(End-start)/stepSizeD:End;

all = allcomb(d1,d2,d3,d4,d5,r3);

% joint limits and steps/resolution
theta1 = -pi/2:pi/(2*stepSizeTheta):0;
theta2 = (-pi/2:pi/(2*stepSizeTheta):pi/2)+pi/2;
theta3 = -pi/2:pi/(2*stepSizeTheta):pi/2;
theta4 = -pi/2:pi/(2*stepSizeTheta):pi/2;
theta5 = 0;
THETA = allcomb(theta1,theta2,theta3,theta4,theta5);

%% Auto Calculation

tempOld = 0;
disp('Auto Calculation has Started')
for i=1:length(all)
    d = all(i,1:5);
    r = [0 0 all(i,6) 0 0];
    
    Res(i,5:9) = d;     % D parameters in Res Array
    Res(i,10) = r(3);   % r parameters in Res Array
    
    Res(i,2) = sum(abs(d)) + sum(abs(r));   % Total Length of Arm in Res Array
    
    [X,Y,Z,theta] = getCoordinates(THETA,d,r,5);

    % Create Convex Hull Surface around Workspace
    [k,av] = convhull(X,Y,Z,'Simplify',true);
    S1.faces = k;
    S1.vertices = [X,Y,Z];

    % Create Ground Surface
    [x,y,z] = meshgrid(0:100:500,-400:100:400,zOffset:1:zOffset+1);
    x = x(:);
    y = y(:);
    z = z(:);
    [k2,av1] = convhull(x,y,z);
    S2.faces = k2;
    S2.vertices = [x,y,z];

    % Calculate Intersection between Ground and Workspace Area
    try
        [intersect12, Surf12] = SurfaceIntersection(S1, S2);
    catch
        Res(i,1) = NaN;       % Arm state in Res Array
        Res(i,3) = NaN;  	% missing Length to yMax in Res Array
        Res(i,4) = NaN;
    end
        
    if isempty(Surf12.vertices)
        % no intersection found
        Res(i,1) = 0;       % Arm state in Res Array
        Res(i,3) = NaN;  	% missing Length to yMax in Res Array
        Res(i,4) = NaN;        
    else
        x = Surf12.vertices(:,1);
        y = Surf12.vertices(:,2);
        z = Surf12.vertices(:,3);
        
        % Get right Intersection
        h = find(z==zOffset);
        n = length(h);
        x_0 = zeros(n,1);
        y_0 = zeros(n,1);

        for ii=1:n    
            x_0(ii) = x(h(ii));
            y_0(ii) = y(h(ii));    
        end

        % sort matrices
        h = find(y_0 < 0);
        n = length(h);
        xInter = zeros(n,1);
        yInter = zeros(n,1);
        for ii=1:n    
            xInter(ii) = x_0(h(ii));
            yInter(ii) = y_0(h(ii));    
        end

        h = find(y_0 >= 0);
        k = length(h);
        for ii=1:k-1   
            xInter(ii+n) = x_0(h(k-ii));
            yInter(ii+n) = y_0(h(k-ii));    
        end

        
        try
            FitCircle = CircleFitByPratt([xInter,yInter]);  
            
            [x,y] = getCircleLineIntersection(FitCircle(1),FitCircle(2),FitCircle(3),xOffset);

            yMin = -RovWidth/2+yOffset;
            yMax = RovWidth/2-yOffset;

            % Points in Required Area
            if ((y(1)>=yMax-eps) && (y(2)<=yMin+eps))
                Res(i,1) = 1;           % Arm state in Res Array
            else
                Res(i,1) = 0;           % Arm state in Res Array
            end    

            Res(i,3) = yMax-y(1);    	% missing Length to yMax in Res Array
            Res(i,4) = y(2)-yMin;
        catch
            Res(i,1) = NaN;         % Arm state in Res Array
            Res(i,3) = NaN;         % missing Length to yMax in Res Array
            Res(i,4) = NaN;            
        end
            
        
    end
    
    % Display Progress
    temp = round((i/length(all))*100);
%     rm = rem(temp,10);
    
    if temp ~= tempOld
        clc;
        fprintf('Progress: %i%%\n',temp);
    end    
    tempOld = temp;

end
disp('Auto Calculation has Ended')
save('ResDesign1.mat','Res')

%% Evaluation

stbl = Res(:,1);
posStbl = find(stbl==1);
nStbl = length(posStbl);

if (nStbl ~= 0)
    StblRes = zeros(nStbl,15);
    for i=1:nStbl 
        StblRes(i,:) = Res(posStbl(i),:);
    end
    
    fprintf('%i suitable configurations found.\n\n',nStbl)
    
    [LMin,IL] = min(StblRes(:,2));
    fprintf('Minimal Length at i=%i  with    L = %.1f mm\n',IL,LMin)
    IL = find(StblRes(:,2)==LMin);
    
    
    [YMax,IYMax] = min(abs(StblRes(:,3)));
    fprintf('Minimal YMax   at i=%i with yMax = %.2f mm\n',IYMax,YMax)
    
    printRes(StblRes,[IL; IYMax]);
 
else
    fprintf('No suitable configurations found.');
end

%% Help functions
function printRes(Res,I)
    
    fprintf('\nPos \tSuitable \t\tL \tyMax \tyMin \td1 \td2 \t\td3 \t\t d4 \t d5 \t r3\n');
    fprintf(['----------------------------------------------------',...
        '---------------------------------\n']);
    
    for k=1:length(I)
        i = I(k);    

        if Res(i,1)==1
            stbl = 'Yes';
        else
            stbl = 'No';
        end

        fprintf(['%i\t\t\t',stbl,'\t\t%.1f \t%.1f \t%.1f \t%.0f \t%.0f \t%.0f \t%.0f \t%.0f \t%.0f\n'],...
            i,Res(i,2),Res(i,3),Res(i,4),Res(i,5:9),Res(i,10)); 
    end
    fprintf('\n');

end










