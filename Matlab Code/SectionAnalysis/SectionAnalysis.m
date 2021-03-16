%% Section Analysis
% Jakob Bruckmoser
% 23.11.2020 
% - Analysis of the joint torques and forces
% - Dimension calculation of the Links
% - iterative process with weight as changing variable
% Profiles: Tube, I-Profile

% Gestaltänderungsenergiehypothese s_v = sqrt(s_x^2 + s_y^2 - s_x*s_y + 3*tau^2)
% My(i) = Mb(i)   
% When existing CAD design, MoI integration and max thdd(i) and thd(i)
% determination with RNE.

close all; 
clear;
clc;

% general Matlab Functions
addpath('C:\Users\Jakob\Google Drive\Hochschule München\02 Master\3. Semester\UCF FSI\Pre-Design\MatlabFunctions')

path = 'C:\Users\Jakob\Google Drive\Hochschule München\02 Master\3. Semester\UCF FSI\Pre-Design\2. Iteration\';
diary([path,'SectionAnalysis.txt'])

load([path,'ArmLengths.mat'])   % [mm] length of the links
load([path,'ForceTorque.mat'])

%% variable Parameters
global Re Rm MoS E fmax

Fp = 8*1.2;     % [kg] mass of payload and end effector without motor
MotorM = 0.24;	% [kg] mass of the motors

MoS_norm = 1.2;     % normal minimal Margin of Safety
MoS_3dprint = 2;    % Margin of Safety for 3D print inaccuracies
MoS = MoS_norm * MoS_3dprint;
fmax = 0.5;         % [mm] max displacement at end effector

tmin = 2;           % [mm] min thickness of walls
yOffset = -110-25;

% thetad = zeros(1,5);        % joint rotation velocities
% thetadd = zeros(1,5);       % joint rotation accelerations
% 
% tHalf = [15,0,0,0,0];    % [s] time for half rotation
% tDec = [2,0,0,0,0];      % [s] deceleration time
% for i=1:5
%     thetadd(i) = pi/(tHalf(i)*tDec(i));  % [rad/s^2]
% end



%% constant Parameters
gLun = 1.625;	% [m/s^2] lunar gravity
g0 = 9.81;    	% [m/s^2]

F = [0;0;-Fp]*gLun;	% [N] external force on end effector
N = [0;0;0];      	% [Nmm] external torque on end effector
g = [0;0;-g0];
mm = zeros(1,5)+MotorM;	% [kg] masses of the motors
m = zeros(5,1)+0.1;     % [kg] init mass guess

E = 2.3e3;          % [N/mm^2] Young's Modulus, Emodul
Re = 26.4;          % [N/mm^2] yield strength Re 
Rm = 35.9;          % [N/mm^2] ultimate tensile strength Rm
rho = 1.25e-6;      % [kg/mm^3] density of PLA

MoI = getMomentsOfInertia(path);

options = optimoptions('fmincon','Display','off');

Acon = []; % linear constraints
Bcon = [];
Aeq = [];
Beq = [];

%% get transformation matrices
theta = [0;0;0;90;0];  % [°]
alpha = [90;0;0;90;0];
a = [0;l(2);l(3);0;0];
d = [l(1);0;0;0;l(4)+l(5)];
dh = [theta,alpha,a,d];
T = DHparameters(dh);

%% plot current configuration
plotCurrentConf(T)

%% plot Rover and Current configuration
plotRover(yOffset);


%% I-Profile
% UB = [50;60;50;50]; % max B,H,tb,th
UB = [60;60;50;50];
LB = [5;5;tmin;tmin]; % min B,H,tb,th
x0 = [10;10;2;2];

diff = 1; % stopping criteria
while abs(diff)>1e-4

    [Base,Link] = staticAnalysis(T,dh,l,F,N,g,m,mm);
%     [Base,Link] = RNE(m,mm,l,r1,r2,dh,LinkS,g,thetad,thetadd,T,F,N);
    Prog = MomentForceProgression(Base,g0,m,mm,l,0);
    mOld = m;

    for i=1:5
        k=1;
        for j=1:length(Prog(1).M)
            
            Mb1 = Prog(i).M(j); 
            Mb2 = Mb1 * ForceTorque.Factors(i).fb2;
            Mt = Mb1 * ForceTorque.Factors(i).ft;            
            
            Truss(i).FpMax=Base(i).F(3);
            Truss(i).Mb1(j) = Mb1;
            Truss(i).Mb2(j) = Mb2;
            Truss(i).Mt(j) = Mt;

            sObj = hObj([]);    % exit values of fmincon
            fyObj = hObj([]);
            fzObj = hObj([]);     
            buckObj = hObj([]);

            nonlconFun = @(x)nonlconI(x,Truss(i).FpMax,Mb1,Mb2,Mt,l(i),sObj,fyObj,fzObj,buckObj);
            [x,Truss(i).area(k),flag] = fmincon(@goalFunI,x0,Acon,Bcon,Aeq,Beq,LB,UB,nonlconFun,options);
            if flag>0 
                Truss(i).m = Truss(i).area(1)*l(i)*rho;
                Truss(i).B(k) = x(1);
                Truss(i).H(k) = x(2);
                Truss(i).tb(k) = x(3);
                Truss(i).th(k) = x(4);
                Truss(i).b(k) = Truss(i).B(k)-Truss(i).tb(k);
                Truss(i).h(k) = Truss(i).H(k)-2*Truss(i).th(k);
                Truss(i).sigma(k) = sObj.o;
                Truss(i).fy(k) = fyObj.o;
                Truss(i).fz(k) = fzObj.o;
                Truss(i).buckle(k) = buckObj.o;
            else
                fprintf('Fmincon Error at Link %i, Crosssection %i\n',i,k); 
                m(i) = mOld(i);
            end
            
            k=k+1;
        end
        m(i)=Truss(i).m;
    end
    diff = m-mOld;
end

fprintf('~~~~~~~I-Profile~~~~~~\n')
dispResults(Truss,1,0,1)

figure('name','Profile Sections','Position',[-1339 381 590 511]);
offset = 5;
xmax = max(Truss(2).B)/2;
ymax = max(Truss(2).H)/2;
for i=2:3
    subplot(2,2,i-1)
    axis equal
    Bp = Truss(i).B(1);
    Hp = Truss(i).H(1);
    bp = Truss(i).b(1);
    hp = Truss(i).h(1);
    xlim([-xmax-offset xmax+offset])
    ylim([-ymax-offset ymax+offset])
    rectangle('Position',[-(Bp-bp)/2 -hp/2 Bp-bp hp]);
    rectangle('Position',[-Bp/2 -Hp/2 Bp (Hp-hp)/2]);
    rectangle('Position',[-Bp/2 hp/2 Bp (Hp-hp)/2]);
    
    Bp = Truss(i).B(end);
    Hp = Truss(i).H(end);
    bp = Truss(i).b(end);
    hp = Truss(i).h(end);
    xlim([-xmax-offset xmax+offset])
    ylim([-ymax-offset ymax+offset])
    rectangle('Position',[-(Bp-bp)/2 -hp/2 Bp-bp hp],'LineStyle',':');
    rectangle('Position',[-Bp/2 -Hp/2 Bp (Hp-hp)/2],'LineStyle',':');
    rectangle('Position',[-Bp/2 hp/2 Bp (Hp-hp)/2],'LineStyle',':');
    
    title(['Link ',num2str(i)])
    if i==1
        xlabel('B [mm]')
        ylabel('H [mm]')
    end
end

%% Tube Profile

% boundaries
UB = [30;20];       % max radius and max thickness
LB = [2.1;tmin];	% min radius and min thickness
x0 = [10;1];

diff = 1; % stopping criteria
while abs(diff)>1e-4

    [Base,Link] = staticAnalysis(T,dh,l,F,N,g,m,mm);
%     [Base,Link] = RNE(m,mm,l,r1,r2,dh,LinkS,g,thetad,thetadd,T,F,N);
    Prog = MomentForceProgression(Base,g0,m,mm,l,0);
    mOld = m;

    for i=1:5
        k=1;
        for j=1:length(Prog(1).M)
            
            Mb1 = Prog(i).M(j); 
            Mb2 = Mb1 * ForceTorque.Factors(i).fb2;
            Mt = Mb1 * ForceTorque.Factors(i).ft;            
            
            Tube(i).FpMax=Base(i).F(3);
            Tube(i).Mb1(j) = Mb1;
            Tube(i).Mb2(j) = Mb2;
            Tube(i).Mt(j) = Mt;

            sObj = hObj([]);    % exit values of fmincon
            fyObj = hObj([]);
            buckObj = hObj([]);

            nonlconFun = @(x)nonlconCirc(x,Tube(i).FpMax,Mb1,Mb2,Mt,l(i),sObj,fyObj,buckObj);
            [x,Tube(i).area(k),flag] = fmincon(@goalFunCirc,x0,Acon,Bcon,Aeq,Beq,LB,UB,nonlconFun,options);
            if flag>0                
                Tube(i).m = Tube(i).area(1)*l(i)*rho;
                Tube(i).R(k) = x(1);
                Tube(i).t(k) = x(2);
                Tube(i).sigma(k) = sObj.o;
                Tube(i).fy(k) = fyObj.o;
                Tube(i).buckle(k) = buckObj.o;
            else
                fprintf('Fmincon Error at Link %i, Crosssection %i\n',i,k); 
                m(i) = mOld(i);
            end
        
            k=k+1;
        end
        m(i) = Tube(i).m;
    end

    diff = m-mOld;
end

fprintf('\n~~~~~Tube-Profile~~~~~\n')
dispResults(Tube,2,0,1)

xmax = max(Tube(2).R);
for i=2:3
    subplot(2,2,1+i)
%     subplot(2,5,5+i)
    axis equal
    xlim([-xmax-offset xmax+offset])
    ylim([-xmax-offset xmax+offset])
    Rp = Tube(i).R(1);
    tp = Tube(i).t(1);
    r = Rp-tp;
    rectangle('Position',[-Rp -Rp 2*Rp 2*Rp],'Curvature',[1 1])
    rectangle('Position',[-r -r 2*r 2*r],'Curvature',[1 1])
    
    Rp = Tube(i).R(end);
    tp = Tube(i).t(end);
    r = Rp-tp;
    try
        rectangle('Position',[-Rp -Rp 2*Rp 2*Rp],'Curvature',[1 1],'LineStyle',':')
        rectangle('Position',[-r -r 2*r 2*r],'Curvature',[1 1],'LineStyle',':')
    catch
    end
    
    title(['Link ',num2str(i)])
    if i==1
        xlabel('R [mm]')
        ylabel('R [mm]')
    end
end

for i=2:3
    t = Tube(i).t(1);
    t = ceil(t/0.48)*0.48;
    fprintf('i = %i, \tt = %.2f -> \t %.2f\n',i,Tube(i).t(1),t);
end


%% Export
Section.Truss = Truss;
Section.Tube = Tube;
save([path,'SectionAnalysis.mat'],'Section')


%% Display Results

% Prog = MomentForceProgression(Base,g0,m,mm,l,0);

% for i=1:5 % Results in the base frame
%     BaseRes(i,1) = i;
%     BaseRes(i,2) = Base(i).F(1);    
%     BaseRes(i,3) = Base(i).F(2); 
%     BaseRes(i,4) = Base(i).F(3);
%     TauRes(i,1) = i;
%     TauRes(i,2) = Base(i).Nx;    
%     TauRes(i,3) = Base(i).Ny; 
%     TauRes(i,4) = Base(i).Nz;   
% end
% 
% for i=1:5 % Results in the Link frame
%     LinkRes(i,1) = i;
%     LinkRes(i,2) = Link(i).f(1);    
%     LinkRes(i,3) = Link(i).f(2); 
%     LinkRes(i,4) = Link(i).f(3);   
% end
% 
% % format short
% % format compact
% % fprintf('Solution found.\n\n')
% % fprintf('Masses of the links:\n')
% % disp(m')
% % fprintf('\nForces in [N]: \t\t\tBase Frame \t\t\t\t\t\t\t\t\tLink Frame\n')
% % fprintf('\tJoint \t\tFx \t\t  Fy \t\tFz \t\t\t\t  Joint \t  Fx \t\tFy \t\t  Fz\n')
% % disp([BaseRes,zeros(5,1),LinkRes]);
% % fprintf('\nJoint Torque in [Nmm]:\n\tJoint \t\tNx \t\t  Ny \t\tNz\n')
% % disp(TauRes);
% 
% 
% fprintf('\nDeciding criteria:\n')
% % for i=1:5
% %     if sigmaB(i)*MoS==Re
% %         fprintf('\tLink %i: Bending\n',i)
% %     elseif sigmaZ(i)*MoS==Re
% %         fprintf('\tLink %i: Pressure\n',i)
% %     elseif tauA(i)*MoS==0.6*Rm
% %         fprintf('\tLink %i: Shearing\n',i)
% %     else
% %         fprintf('\tLink %i: max. Displacement\n',i)
% %         fprintf('\t\tSigmab = %.2f \tSigmaz = %.2f \tTauA = %.2f \t\tFcrit = %.2f\n',sigmaB(i),sigmaZ(i),tauA(i),Fcrit(i))
% %         fprintf('\t\tMoS_b = %.1f \tMoS_z = %.1f \tMoS_tau = %.1f \tMoS_Fcrit = %.1f\n',Re/sigmaB(i),Re/sigmaZ(i),0.6*Rm/tauA(i),Fcrit(i)/FpMax(i))
% %     end
% % end
% 
% disp([BaseRes(:,1),sigma',fy',fz'])

%% Force/Momentum over time
% thetaVar = [0:5:180];
% for i=1:length(thetaVar)
%     theta = [thetaVar(i);thetaVar(i);thetaVar(i);thetaVar(i);0];
%     dh = [theta,alpha,a,d];
%     T = DHparameters(dh);    
%     [Base,Link] = staticAnalysis(T,dh,l,F,N,g,m,mm);
%     
%     for j=1:5
%         Mx(i,j) = Base(j).Nx;
%         My(i,j) = Base(j).Ny;
%         Mz(i,j) = Base(j).Nz;
%         
%         Fx(i,j) = Link(j).f(1); 
%         Fy(i,j) = Link(j).f(2);
%         Fz(i,j) = Link(j).f(3);
%     end
% end
% 
% figure('name','Force Momentum over time','Position',[-1105 335 1100 620]);
% subplot(2,3,1)
% hold on; grid on;
% plot(thetaVar,Mx(:,1),thetaVar,Mx(:,2),thetaVar,Mx(:,3),thetaVar,Mx(:,4),thetaVar,Mx(:,5))
% title('M_x')
% legend('J_1','J_2','J_3','J_4','J_5')
% subplot(2,3,2)
% hold on; grid on;
% plot(thetaVar,My(:,1),thetaVar,My(:,2),thetaVar,My(:,3),thetaVar,My(:,4),thetaVar,My(:,5))
% title('M_y')
% subplot(2,3,3)
% hold on; grid on;
% plot(thetaVar,Mz(:,1),thetaVar,Mz(:,2),thetaVar,Mz(:,3),thetaVar,Mz(:,4),thetaVar,Mz(:,5))
% title('M_z')
% 
% subplot(2,3,4)
% hold on; grid on;
% plot(thetaVar,Fx(:,1),thetaVar,Fx(:,2),thetaVar,Fx(:,3),thetaVar,Fx(:,4),thetaVar,Fx(:,5))
% title('F_x')
% subplot(2,3,5)
% hold on; grid on;
% plot(thetaVar,Fy(:,1),thetaVar,Fy(:,2),thetaVar,Fy(:,3),thetaVar,Fy(:,4),thetaVar,Fy(:,5))
% title('F_y')
% subplot(2,3,6)
% hold on; grid on;
% plot(thetaVar,Fz(:,1),thetaVar,Fz(:,2),thetaVar,Fz(:,3),thetaVar,Fz(:,4),thetaVar,Fz(:,5))
% % plot(thetaVar,Fz(:,1)+Fy(:,1)+Fx(:,1))
% title('F_z')
% 
% max(Mz(:,2))
% min(Mz(:,2))


