

figure
bar(NF,error_grid);
xlabel('number of features');
ylabel('error');
legend('NR=3','NR=6','NR=12','NR=18');
saveas(gcf,'grid.jpg')

figure
subplot(2,2,1)
plot(NF,error_grid(:,1))
xlabel('number of features');
title('NR=5');
ylabel('error');
grid on;

subplot(2,2,2)
plot(NF,error_grid(:,2))
xlabel('number of features');
title('NR=7');
ylabel('error');
grid on;

subplot(2,2,3)
plot(NF,error_grid(:,3))
xlabel('number of features');
title('NR=9');
ylabel('error');
grid on;

subplot(2,2,4)
plot(NF,error_grid(:,4))
xlabel('number of features');;
title('NR=11');
ylabel('error');
grid on;
saveas(gcf,'errorperf.jpg');




figure
subplot(2,2,1)
plot(NR,error_grid(1,:))
xlabel('number of rules');
title('NF=4');
ylabel('error');
grid on;

subplot(2,2,2)
plot(NR,error_grid(2,:))
xlabel('number of rules');
title('NF=7');
ylabel('error');
grid on;

subplot(2,2,3)
plot(NR,error_grid(3,:))
xlabel('number of features');
title('NF=9');
ylabel('error');
grid on;

subplot(2,2,4)
plot(NR,error_grid(4,:))
xlabel('number of rules');
title('NF=11');
ylabel('error');
grid on;
saveas(gcf,'errorperr.jpg');
