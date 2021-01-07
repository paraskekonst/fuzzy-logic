figure;
x=1:epoch;
plot(x,ERROR,x,CHKERROR);
xlabel('itteration');
ylabel('Error');
legend('training error','checking error');
title('learning curve');
saveas(gcf,'learning_curve.jpg');

figure;
plot(error);
title('prediction error');
ylabel('error');
%saveas(gcf,'pred_error.jpg');

figure;
[x,mf] = plotmf(FIS,'input',1);
plot(x,mf);
title('input 1 after training');
%saveas(gcf,'input_1.jpg');

figure;
[x,mf] = plotmf(FIS,'input',2);
plot(x,mf);
title('input 2 after training');
%saveas(gcf,'input_2.jpg')
figure;
[x,mf] = plotmf(FIS,'input',3);
plot(x,mf);
title('input 3 after training');
%saveas(gcf,'input_3.jpg');

figure;
[x,mf] = plotmf(FIS,'input',4);
plot(x,mf);
title('input 4 after training');
%saveas(gcf,'input_4.jpg');