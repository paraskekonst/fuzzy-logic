clear; 

load waveform.data

NF=[4 8 12 16];
RANDII= [0.6 0.513 0.304 0.271 ; % f = 4
         0.9 0.7 0.43 0.36  ; % f = 8
         1 0.85 0.51 0.465  ; % f = 12
         1 0.8 0.612 0.552 ]; % f = 16
NR=[3 6 12 18];

%tabulate(waveform(:,41));

training_set=waveform(1:3000,:);
validation_set=waveform(3001:4000,:);
test_set=waveform(4001:5000,:);
% chech if categories are  equally split to each set
%tabulate(waveform(:,41));
%tabulate(training_set(:,41));
%tabulate(validation_set(:,41));
%tabulate(test_set(:,41));
for i =1:40
  
   [training_set(:,i),MU,SIGMA] =zscore(training_set(:,i));
   validation_set(:,i)=(validation_set(:,i)-MU)/SIGMA;
   test_set(:,i)=(test_set(:,i)-MU)/SIGMA;
    
end
[ranked, weights] = relieff(waveform(:, 1:40), waveform(:,41), 50 ,'method','classification');

error_grid=zeros(4,4);
%copmute error for the paremeters with % cross-validation
for i=1:4
    for j=1:4
        
        c= cvpartition(training_set(:,41),'KFold',5);
        error = zeros(c.NumTestSets, 1);
         %initialize model
         init_fis=genfis2(training_set(:,ranked(1:NF(i))),training_set(:,41),RANDII(i,j));
         %rule_grid(i, j) = length(init_fis.rule);
        
        for k=1:c.NumTestSets
         train_id=c.training(k);
         test_id=c.test(k);
         
         epoch=5;
         input_opt=[epoch,NaN, NaN, NaN, NaN];
         output_opt=[0 0 0 0];
         trndata=[training_set(train_id,ranked(1:NF(i))) training_set(train_id,41)];
         vlddata=[training_set(test_id,ranked(1:NF(i))) training_set(test_id,41)];
         a=tabulate(trndata(:,NF(i)+1));
         b=tabulate(vlddata(:,NF(i)+1));
         [FIS,ERROR,STEPSIZE,CHKFIS,CHKERROR] = anfis(trndata,init_fis,input_opt,output_opt,vlddata,1);
         
         output=evalfis(test_set(:,ranked(1:NF(i))),FIS);
         output=round(output);
         output(output < 0) = 0;
         output(output > 2) = 2;
         errormatrix = confusionmat(test_set(:,41),output);
         error(k)=sum(sum(errormatrix))-sum(diag(errormatrix));
        end
        
        error_grid(i,j)=mean(error)/length(output);
    end
end

%plots
plot_grid

