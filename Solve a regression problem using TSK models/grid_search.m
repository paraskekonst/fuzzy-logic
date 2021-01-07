clear

load Bank.data;


%split data
training_set=Bank(1:4915,:);
validation_set=Bank(4916:6554,:);
test_set=Bank(6555:8192,:);

%normalize data with z-score
for i =1:33
  
   [training_set(:,i),MU,SIGMA] =zscore(training_set(:,i));
   validation_set(:,i)=(validation_set(:,i)-MU)/SIGMA;
   test_set(:,i)=(test_set(:,i)-MU)/SIGMA;
    
end


NF=[4 7 9 11];
NR=[5 7 9 11 15];


[ranked,weight] = relieff(Bank(:,1:32),Bank(:,33),50);
RMSE_grid=zeros(4,5);
RMSE_vld_grid=zeros(4,5);
%create models with diffenr parameters andcompute rmse for all the parameters with 5 cross validation 
for i=1:4
    for j=1:5
        
      c= cvpartition(training_set(:,33),'KFold',5);
      error = zeros(c.NumTestSets, 1);
      RMSE =zeros(c.NumTestSets, 1);
      error_vld=zeros(c.NumTestSets, 1);
      %initialize model
      gen3_opt=[NaN, NaN ,NaN, 0];
      init_fis=genfis3(training_set(:,ranked(1:NF(i))),training_set(:,33),'sugeno',NR(j),gen3_opt);
      for k=1:c.NumTestSets
         train_id=c.training(k);
         test_id=c.test(k);
         %train model
         epoch=5;
         input_opt=[epoch,NaN, NaN, NaN, NaN];
         output_opt=[0 0 0 0];
         trndata=[training_set(train_id,ranked(1:NF(i))) training_set(train_id,33)];
         vlddata=[training_set(test_id,ranked(1:NF(i))) training_set(test_id,33)];
         [FIS,ERROR,STEPSIZE,CHKFIS,CHKERROR] = anfis(trndata,init_fis,input_opt,output_opt,vlddata,1);
         
         output=evalfis(test_set(:,ranked(1:NF(i))),FIS);
         
         error(k)= sum((output - test_set(:,33)).^2);
         error_vld(k)=sqrt(sum(CHKERROR.^2)/length(output));
         RMSE(k)=sqrt(error(k)/length(output));
      end
      RMSE_grid(i,j)=mean(RMSE);
     
      RMSE_vld_grid(i,j)=mean(error2);
    end
end

%plot
plot_grid
