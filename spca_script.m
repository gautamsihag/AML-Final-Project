%% Standardize and Split into Train and Test
NCOMP = 15;
X = zscore(fcidata);
Y = zscore(gdp);
num_points = size(X,1);
split_point = round(num_points*0.7);
seq = randperm(num_points);
X_train = X(seq(1:split_point), :);
Y_train = Y(seq(1:split_point));
test_yr_seq = sort(seq(split_point+1:end));
X_test = X(test_yr_seq,:);
Y_test = Y(test_yr_seq,:);
year_test = fciyear(test_yr_seq);
% X_test = X(seq(split_point+1:end), :);
% Y_test = Y(seq(split_point+1:end));
% year_test = fciyear(seq(split_point+1:end));
[n_train, p_train] = size(X_train);
[n_test, p_test] = size(X_test);
%%PCR

%% Cross Validate using different stop values
spca_base = zeros(100,1);
spca_err_array = zeros(100,1);
min_base = 0;
min_err = 1e6;
figure();
for step = 1:1:100
    stop = step * 0.3;
    [B SD L D paths] = spca(X_train, X_train'*X_train, NCOMP, Inf, stop);
    SPCATrainScore = X_train * B;
    betaSPCAP = regress(Y_train, SPCATrainScore(:, 1:NCOMP));
%     betaSPCAX = B(:, 1:NCOMP)*betaSPCAP;
%     figure();
%     bar(betaSPCAX);
%     title('Sparse Principal Components Regression Coefficients');
    SPCATestScore = X_test * B;
    yfitPCR = SPCATestScore*betaSPCAP;
    spca_err = norm(Y_test - yfitPCR);
    if spca_err < min_err
        min_err = spca_err;
        min_base = stop;
    end
    spca_err_array(step) = spca_err;
    spca_base(step) = stop;
%     figure();
%     plot(Y_test,yfitPCR,'r^');
%     xlabel('Observed Response');
%     ylabel('Fitted Response');
end 
plot(spca_base, spca_err_array);
title('Test Error vs. Upper bound on the L1-norm of the BETA coeff');
xlabel('Upper Bound');
ylabel('Test Error');
%% Using min_base as stop, plot SPCA Coeff and the fitted Response of test data
[B SD L D paths] = spca(X_train, X_train'*X_train, NCOMP, Inf, min_base);
SPCATrainScore = X_train * B;
PCATrainScore = X_train * L(:,1:NCOMP);
betaSPCAP = regress(Y_train, SPCATrainScore);
betaPCAP = regress(Y_train, PCATrainScore);
betaSPCAX = B * betaSPCAP;
betaPCAX = L(:,1:NCOMP)*betaPCAP;
figure();
bar(betaSPCAP);
title('SPCA Regression Coefficients (Pricipal Components)');
figure();
bar(betaSPCAX);
title('SPCA Regression Coefficients (FCIs)');
figure();
bar(betaPCAP);
title('PCA Coefficients (Pricipal Components)');
figure();
bar(betaPCAX);
title('PCA Coefficients (FCIs)');
SPCATestScore = X_test * B;
PCATestScore = X_test * L(:,1:NCOMP);
yfitSPCA = SPCATestScore*betaSPCAP;
yfitPCA = PCATestScore*betaPCAP;
spca_err = norm(Y_test - yfitSPCA);
pca_err = norm(Y_test- yfitPCA);
figure();
plot(Y_test,yfitSPCA,'r^', Y_test, yfitPCA, 'b^');
axis([-2,2,-2,2]);
legend('SPCA','PCA');
title('Test Data Fitting Comparison');
xlabel('Observed Response');
ylabel('Fitted Response');
figure();
plot(year_test, Y_test, 'b',year_test, yfitSPCA,'r', year_test,yfitPCA, 'g');
title('Real GDP Fitting w/ SPCA and PCA');
legend('Actual', 'SPCA','PCA');