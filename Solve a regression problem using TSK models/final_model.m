clear 

load Bank.data

NF=11; %number of feutures 
NR=9; %number of rules

[ranked,weight] = relieff(Bank(:,1:32),Bank(:,33),50);
%split data
training_set=[Bank(1:4915,ranked(1:NF)) Bank(1:4915,33)];
validation_set=[Bank(4916:6554,ranked(1:NF)) Bank(4916:6554,33)];
test_set=[Bank(6555:8192,ranked(1:NF)) Bank(6555:8192,33)];
%normalize with z_score
for i =1:NF+1
   [training_set(:,i),MU,SIGMA] =zscore(training_set(:,i));
   validation_set(:,i)=(validation_set(:,i)-MU)/SIGMA;
   test_set(:,i)=(test_set(:,i)-MU)/SIGMA;

end
%initialize input
gen3_opt=[NaN, NaN ,NaN, 0];
init_fis=genfis3(training_set(:,1:NF),training_set(:,NF+1),'sugeno',NR,gen3_opt);

epoch=110; %numder of iterations
input_opt=[epoch,NaN, NaN, NaN, NaN]; %anfis intput options
output_opt=[0 0 0 0];

%train model
[FIS,ERROR,STEPSIZE,CHKFIS,CHKERROR] = anfis(training_set,init_fis,input_opt,output_opt,validation_set,1);
         
output=evalfis(test_set(:,1:NF),FIS);

%Metrics 
%test set 
error=output-test_set(:,NF+1);
MSE=sum(error.^2)/length(output);
RMSE=sqrt(MSE);
SSres=sum(error.^2);
temp=test_set(:,NF+1)-mean(test_set(:,NF+1));
SStot=sum(temp.^2);
R2=1-(SSres/SStot);
NMSE=(SSres/SStot);
NDEI=sqrt(NMSE);

%for train set 
MSE_train=(sum(ERROR.^2))/length(ERROR);
RMSE_train=sqrt(MSE_train);
SSres=sum(ERROR.^2);
m=mean(training_set(:,NF+1));
temp=training_set(:,NF+1)-m;
SStot=sum(temp.^2);
R2_train=1-(SSres/SStot);
NMSE_train=(SSres/SStot);
NDEI_train=sqrt(NMSE_train);

%for validation set 
MSE_vld=(sum(CHKERROR.^2))/length(CHKERROR);
RMSE_vld=sqrt(MSE_vld);
SSres=sum(CHKERROR.^2);
m=mean(validation_set(:,NF+1));
temp=validation_set(:,NF+1)-m;
SStot=sum(temp.^2);
R2_vld=1-(SSres/SStot);
NMSE_vld=(SSres/SStot);
NDEI_vld=sqrt(NMSE_vld);

%plots
plot_final()

