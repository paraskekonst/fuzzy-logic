clear 

load wifi-localization.dat;


NR=4;%number of rules
%split data set 
training_set=wifi_localization([1:300,501:800,1001:1300,1501:1800],:);
validation_set=wifi_localization([301:400,801:900,1301:1400,1801:1900],:);
test_set=wifi_localization([401:500,901:1000,1401:1500,1901:2000],:);

% chech if categories are  equally split to each set
a=tabulate(wifi_localization(:,8));
b=tabulate(training_set(:,8));
c=tabulate(validation_set(:,8));
d=tabulate(test_set(:,8));

%normalize data
for i =1:7
  
   [training_set(:,i),MU,SIGMA] =zscore(training_set(:,i));
   validation_set(:,i)=(validation_set(:,i)-MU)/SIGMA;
   test_set(:,i)=(test_set(:,i)-MU)/SIGMA;
    
end

%initialize model
gen3_opt=[NaN, NaN ,NaN, 0];
init_fis=genfis3(training_set(:,1:7),training_set(:,8),'sugeno',NR,gen3_opt);
for i=1:NR
        init_fis.output.mf(i).type = 'constant';
        init_fis.output.mf(i).params=i;
end
%mfedit(init_fis)

%train model
epoch=300;
input_opt=[epoch,NaN, NaN, NaN, NaN];
output_opt=[0 0 0 0];


[FIS,ERROR,STEPSIZE,CHKFIS,CHKERROR] = anfis(training_set,init_fis,input_opt,output_opt,validation_set,1);
         
output=evalfis(test_set(:,1:7),FIS);
output=round(output);
output(output < 1) = 1;
output(output > 4) = 4;
%metrics
errormatrix = confusionmat(test_set(:,8),output);
OA=sum(diag(errormatrix))/length(output);
xir=sum(errormatrix,2);
xjc=sum(errormatrix,1);
PA=diag(errormatrix)/xjc';
UA=diag(errormatrix)/xir;
temp1=xjc*xir;
temp2=length(output)*sum(diag(errormatrix));
K=(temp2-temp1)/((length(output)^2)-temp1);

%plots

plotsA

