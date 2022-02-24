% generate input stimuli for 2 characters ( to begin with ) 

% preallocate
N_train = 100;
N_test = 20; 
X_train = zeros(N_train, 35);
Y_train = zeros(N_train,1);
X_test = zeros(N_test, 35);
Y_test = zeros(N_test,1);


% generate braille test and train set 
Y_train(1:N_train/2) = 1; 
Y_train(1+N_train/2:end) = 2;
for i = 1:N_train 
    X_train(i,:) = simulateBraille(Y_train(i)); 
end
display('Training set done')
Y_test(1:N_test/2) = 1;
Y_test(1+N_test/2:end) = 2;% 
for i = 1:N_test
    X_test(i,:) = simulateBraille(Y_test(i)); 
end
display('Test set done')
% Input into SVM
SVM_model = fitcsvm(X_train,Y_train);
[label,~] = predict(SVM_model,X_test)

