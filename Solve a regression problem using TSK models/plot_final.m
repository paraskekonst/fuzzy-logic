figure;
x=1:epoch;
plot(x,ERROR,x,CHKERROR);
xlabel('itteration');
ylabel('Error');
legend('training error','checking error');
title('learning curve');
saveas(gcf,'final_learning_curve.jpg');

figure;
plot(error);
title('prediction error')
ylabel('error')
saveas(gcf,'final_pred_error.jpg');


figure;
subplot(2,1,1);
plot(1:length(output),output);
title('predicted values.jpg')

subplot(2,1,2);
plot(test_set(:,NF+1));
title('real values');
saveas(gcf,'pred-real_val.jpg');

figure;
subplot(2,1,1);
[x,mf] = plotmf(init_fis,'input',1);
plot(x,mf);
title('input 1 before training');

subplot(2,1,2);
[x,mf] = plotmf(CHKFIS,'input',1);
plot(x,mf);
title('input 1 after training');
saveas(gcf,'final_input1.jpg');

figure;
subplot(2,1,1);
[x,mf] = plotmf(init_fis,'input',3);
plot(x,mf);
title('input 3 before training');

subplot(2,1,2);
[x,mf] = plotmf(CHKFIS,'input',3);
plot(x,mf);
title('input 3 after training');
saveas(gcf,'final_input3.jpg');

figure;
subplot(2,1,1);
[x,mf] = plotmf(init_fis,'input',5);
plot(x,mf);
title('input 5 before training');

subplot(2,1,2);
[x,mf] = plotmf(CHKFIS,'input',5);
plot(x,mf);
title('input 5 after training');
saveas(gcf,'final_input5.jpg');

figure;
subplot(2,1,1);
[x,mf] = plotmf(init_fis,'input',7);
plot(x,mf);
title('input 7 before training');

subplot(2,1,2);
[x,mf] = plotmf(CHKFIS,'input',7);
plot(x,mf);
title('input 7 after training');
saveas(gcf,'final_input7.jpg');

