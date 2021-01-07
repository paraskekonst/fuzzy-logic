clear 

load waveform.data

NF=16;  %number of featyres
randii=0.612; % fo t NR=12

[ranked, weights] = relieff(waveform(:, 1:40), waveform(:,41), 50 ,'method','classification');

%split data set
training_set=[waveform(1:3000,ranked(1:NF)) waveform(1:3000,41)];
validation_set=[waveform(3001:4000,ranked(1:NF)) waveform(3001:4000,41)];
test_set=[waveform(4001:5000,ranked(1:NF)) waveform(4001:5000,41)];
%normalize input

for i =1:NF
  
   [training_set(:,i),MU,SIGMA] =zscore(training_set(:,i));
   validation_set(:,i)=(validation_set(:,i)-MU)/SIGMA;
   test_set(:,i)=(test_set(:,i)-MU)/SIGMA;
    
end

%initialize intput
 init_fis=genfis2(training_set(:,1:NF),training_set(:,NF+1),randii);

 %train model
 epoch=110;
 input_opt=[epoch,NaN, NaN, NaN, NaN];
 output_opt=[0 0 0 0];
 [FIS,ERROR,STEPSIZE,CHKFIS,CHKERROR] = anfis(training_set,init_fis,input_opt,output_opt,validation_set,1);

%metrics
output=evalfis(test_set(:,1:NF),FIS);
output=round(output);
output(output < 0) = 0;
output(output > 2) = 2;
errormatrix = confusionmat(test_set(:,NF+1),output);
OA=sum(diag(errormatrix))/length(output);
xir=sum(errormatrix,2);
xjc=sum(errormatrix,1);
PA=diag(errormatrix)/xjc';
UA=diag(errormatrix)/xir;
temp1=xjc*xir;
temp2=length(output)*sum(diag(errormatrix));
K=(temp2-temp1)/((length(output)^2)-temp1);

%plots
plot_final 
 