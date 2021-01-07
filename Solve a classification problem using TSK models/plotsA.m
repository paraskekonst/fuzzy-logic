figure;
x=1:epoch;
plot(x,ERROR,x,CHKERROR);
xlabel('itteration');
ylabel('Error');
legend('training error','checking error');
title('learning curve');
%saveas(gcf,'learning_curve.jpg');

figure;
subplot(3,1,1);
[x,mf] = plotmf(FIS,'input',1);
plot(x,mf);
title('input 1 after training');


subplot(3,1,2);
[x,mf] = plotmf(FIS,'input',2);
plot(x,mf);
title('input 2 after training');


subplot(3,1,3);
[x,mf] = plotmf(FIS,'input',3);
plot(x,mf);
title('input 3 after training');
%saveas(gcf,'1_3inputs.jpg');

figure;
subplot(2,1,1);
[x,mf] = plotmf(FIS,'input',4);
plot(x,mf);
title('input 4 after training');


subplot(2,1,2);
[x,mf] = plotmf(FIS,'input',5);
plot(x,mf);
title('input 5 after training');
%saveas(gcf,'4_5inputs.jpg');

figure;
subplot(2,1,1);
[x,mf] = plotmf(FIS,'input',6);
plot(x,mf);
title('input 6 after training');


subplot(2,1,2);
[x,mf] = plotmf(FIS,'input',7);
plot(x,mf);
title('input 7 after training');
%saveas(gcf,'6_7inputs.jpg');


