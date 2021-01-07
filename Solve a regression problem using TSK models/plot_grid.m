figure
bar(NF,RMSE_grid);
xlabel('number of features');
ylabel('RMSE');
ylim([0.3 0.55])
legend('NR=5','NR=7','NR=9','NR=11','NR=15');
saveas(gcf,'grid.jpg')

figure
subplot(2,2,1)
plot(NF,RMSE_grid(:,1))
xlabel('number of features');
title('NR=5');
ylabel('RMSE');
grid on;

subplot(2,2,2)
plot(NF,RMSE_grid(:,2))
xlabel('number of features');
title('NR=7');
ylabel('RMSE');
grid on;

subplot(2,2,3)
plot(NF,RMSE_grid(:,3))
xlabel('number of features');
title('NR=9');
ylabel('RMSE');
grid on;

subplot(2,2,4)
plot(NF,RMSE_grid(:,4))
xlabel('number of features');;
title('NR=11');
ylabel('RMSE');
grid on;
saveas(gcf,'errorperf.jpg');


figure;
plot(NF,RMSE_grid(:,5))
xlabel('number of features');
title('NR=15');
ylabel('RMSE');
grid on;
saveas(gcf,'errorperf2.jpg');


figure
subplot(2,2,1)
plot(NR,RMSE_grid(1,:))
xlabel('number of rules');
title('NF=4');
ylabel('RMSE');
grid on;

subplot(2,2,2)
plot(NR,RMSE_grid(2,:))
xlabel('number of rules');
title('NF=7');
ylabel('RMSE');
grid on;

subplot(2,2,3)
plot(NR,RMSE_grid(3,:))
xlabel('number of features');
title('NF=9');
ylabel('RMSE');
grid on;

subplot(2,2,4)
plot(NR,RMSE_grid(4,:))
xlabel('number of rules');
title('NF=11');
ylabel('RMSE');
grid on;
saveas(gcf,'errorperr.jpg');
