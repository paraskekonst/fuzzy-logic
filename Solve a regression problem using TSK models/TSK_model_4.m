
clear all:
load CCPP.dat

tic
%split data set 

training_set=CCPP(1:5740,:);
validation_set=CCPP(5741:7654,:);
test_set=CCPP(7655:9568,:);

%normalize data set with z-score
for i=1:5

    
   [training_set(:,i),MU,SIGMA] =zscore(training_set(:,i));
   validation_set(:,i)=(validation_set(:,i)-MU)/SIGMA;
   test_set(:,i)=(test_set(:,i)-MU)/SIGMA;
end

%initialize model
init_fis=genfis1(training_set,3,'gbellmf', 'linear' );

%train model
epoch=400;
input_opt=[epoch,NaN, NaN, NaN, NaN];
output_opt=[0 0 0 0];

[FIS,ERROR,STEPSIZE,CHKFIS,CHKERROR] = anfis(training_set,init_fis,input_opt,output_opt,validation_set,1);

output=evalfis(test_set(:,1:4),FIS);
error = output - test_set(:,5);


%METRICS
%for test set 
error = output - test_set(:,5);
MSE_test=(sum(error.^2))/1914;
RMSE_test=sqrt(MSE_test);
SSres=sum(error.^2);
m=mean(test_set(:,5));
temp=test_set(:,5)-m;
SStot=sum(temp.^2);
R2_test=1-(SSres/SStot);
NMSE_test=(SSres/SStot);
NDEI_test=sqrt(NMSE_test);

%for train set 
MSE_train=(sum(ERROR.^2))/1914;
RMSE_train=sqrt(MSE_train);
SSres=sum(ERROR.^2);
m=mean(training_set(:,5));
temp=training_set(:,5)-m;
SStot=sum(temp.^2);
R2_train=1-(SSres/SStot);
NMSE_train=(SSres/SStot);
NDEI_train=sqrt(NMSE_train);

%for validation set 
MSE_vld=(sum(CHKERROR.^2))/1914;
RMSE_vld=sqrt(MSE_vld);
SSres=sum(CHKERROR.^2);
m=mean(validation_set(:,5));
temp=validation_set(:,5)-m;
SStot=sum(temp.^2);
R2_vld=1-(SSres/SStot);
NMSE_vld=(SSres/SStot);
NDEI_vld=sqrt(NMSE_vld);


%plots
plotA()

toc
