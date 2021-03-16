function Prog = MomentForceProgression(Base,g0,m,mm,l,plot)
%MOMENTFORCEPROGRESSION Calculates the Moment Force Progression inside the
%links
% Only in Max Configuration theta = (0;0;0;90;0)!
div = 10;

Base(6).Nx = Base(6).N(1);
Base(6).Ny = Base(6).N(2);
Base(6).Nz = Base(6).N(3);
for k=1:5
    Nx = Base(k+1).Nx;
    Ny = Base(k+1).Ny;
    Nz = Base(k+1).Nz;
    if Nx==0 && Ny==0
        M = Nz;
    elseif Nx==0 && Nz==0
        M = Ny;
    else
        M = Nx;
    end
    
    F = Base(k+1).F(3)+mm(k)*g0;
    if k==1 % no progession in Link 1
        Prog(k).M = zeros(1,div+1)+M;
        Prog(k).F = zeros(1,div+1)+F;
    elseif k>3 % linear progression between Link 4&5 due to DH convention
        Fmin = Base(k+1).F(3)+mm(k)*g0;
        Fmax = Base(k).F(3);
        Mmin = M;
        Mmax = Base(k).Nz + Base(k).Ny + Base(k).Nx; % only when only 1 moment
        diffF = Fmax-Fmin;
        diffM = Mmax-Mmin;
        for i=1:div
            Prog(k).F(div-i+1) = Fmin + diffF/div*i;
            Prog(k).M(div-i+1) = Mmin + diffM/div*i;
        end        
    else
        for i=1:div % progression for the rest of the links
        x = l(k)/div*i;
        Prog(k).M(div-i+1) = M + x*F + x/2*m(k)*g0;
        Prog(k).F(div-i+1) = F + x/l(k)*m(k)*g0;
        end 
    end      
       
    Prog(k).M(div+1) = M;
    Prog(k).F(div+1) = F;
    Prog(k).x = [0:div]./div;
end

if plot==1 % plot progression
    figure('name','Force/Moment Progression','Position',[-1339 482 618 410]);
    subplot(2,1,1)
    hold on
    for i=1:5
        plot(Prog(i).x,Prog(i).M)
    end
    title('Moment Progression')
    legend('1','2','3','4','5')
    xlabel('norm length')
    ylabel('Moment')

    subplot(2,1,2)
    hold on
    for i=1:5
        plot(Prog(i).x,Prog(i).F)
    end
    title('Force Progression')
    legend('1','2','3','4','5')
    xlabel('norm length')
    ylabel('Force')
end

end

