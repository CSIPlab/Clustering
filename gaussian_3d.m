close all
clear all
data_pts = 600;
mu1 =[8 8 5]; Sigma1 = [10 0 0; 0 7 0; 0 0 4];
x1 = mvnrnd(mu1, Sigma1, data_pts);
mu2 = [21 20 10]; Sigma2 = [6 0 0; 0 12 0; 0 0 14];
x2 = mvnrnd(mu2, Sigma2, data_pts);
mu3 = [5 22 23]; Sigma3 = [9 0 0; 0 8 0; 0 0 5];
x3 = mvnrnd(mu3, Sigma3, data_pts);
train_labels = [5*ones(data_pts,1); 6*ones(data_pts,1); 7*ones(data_pts,1)];
X = [x1;x2;x3];
U=X;

scatter3(U(:,1), U(:,2), U(:,3),train_labels,train_labels)
axis([0 30 0 30 0 30])
%saveas(gcf,'plot\1.jpeg')

tau=0.05;
beta=2;
eps=0.01;
pause(1)
for i=1:2
    D = squareform(pdist(U,@naneucdist,tau,beta,eps));
    A = diag(1+2*sum(D,2)) - 2*D;
    U = A\X;
    scatter3(U(:,1), U(:,2), U(:,3),train_labels,train_labels)
    axis([0 30 0 30 0 30])
    pause(1)
    %saveas(gcf,['plot\' int2str(i+1) '.jpeg'])
end