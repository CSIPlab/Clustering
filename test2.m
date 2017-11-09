%Generate two 2-dimensional Gaussians 
mu1 = [1 1]; Sigma1 = [10 0; 0 10];
x1 = mvnrnd(mu1, Sigma1, 5000);
mu2 = [20 20]; Sigma2 = [20 0; 0 20];
x2 = mvnrnd(mu2, Sigma2, 5000);
X = [x1;x2];
subplot(2,1,1); plot(x1(:,1),x1(:,2),'.',x2(:,1),x2(:,2),'*');
title('Original')

lambda = 5;
N = length(X);

M = (1+2*lambda*N)*eye(N) - 2*lambda*ones(N);

tic
U = X/(1+2*lambda*N) - repmat(sum(X)*2*lambda/(1+2*lambda*N),N,1);
%U = inv(M)*X;
toc

u1 = U(1:5000,:);
u2 = U(5001:10000,:);

subplot(2,1,2); plot(u1(:,1),u1(:,2),'.',u2(:,1),u2(:,2),'*');
title('Processed')
