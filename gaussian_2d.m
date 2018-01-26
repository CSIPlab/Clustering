close all
clear all
data_pts = 300;
mu1 =[5 5]; Sigma1 = [4 0; 0 4];
x1 = mvnrnd(mu1, Sigma1, data_pts);
mu2 = [15 15]; Sigma2 = [4 0; 0 4];
x2 = mvnrnd(mu2, Sigma2, data_pts);
train_labels = [ones(300,1); 2*ones(300,1)];
X = [x1;x2];
U=X;
gscatter(U(:,1), U(:,2), train_labels);
axis([0 20 0 20])

%saveas(gcf,'plot\1.jpeg')

tau=0.1;
beta=3;
eps=0.01;
pause(1)
for i=1:50
    D = squareform(pdist(U,@naneucdist,tau,beta,eps));
    A = diag(1+2*sum(D,2)) - 2*D;
    U = A\X;
    gscatter(U(:,1), U(:,2), train_labels);
    axis([0 20 0 20])
    pause(1)
    %saveas(gcf,['plot\' int2str(i+1) '.jpeg'])
end