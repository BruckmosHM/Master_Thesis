close all

figure('name','Force/Moment Progression','Position',[-1339 482 618 410]);
subplot(2,1,1)
hold on
for i=1:5
    x = Prog(i).x;
    y = Prog(i).M;
    plot(x,y)
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

