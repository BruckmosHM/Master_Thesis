close all

figure('name','Force/Moment Progression','Position',[-1339 238 850 476]);
subplot(2,1,1)
hold on
for i=2:3
    x = Prog(i).x;
    y = Prog(i).M/1000;
    plot(x,y)
end
title('Moment Progression')
legend('Link 2','Link 3')
xlabel('norm length')
ylabel('Moment [Nm]')

subplot(2,1,2)
hold on
for i=2:3
    plot(Prog(i).x,Prog(i).F)
end
title('Force Progression')
legend('Link 2','Link 3')
xlabel('norm length')
ylabel('Force [N]')