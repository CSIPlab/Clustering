close all
clear all
load mnist_train.mat
num_dt_pts = 1000;
ind = randperm(size(train_X, 1));
train_X = train_X(ind(1:num_dt_pts),:);
train_labels = train_labels(ind(1:num_dt_pts));

U=train_X;
U_2 = pca(U,2);
gscatter(U_2(:,1), U_2(:,2), train_labels);
legend(gca,'off')
%saveas(gcf,'1.jpeg')

tau=0.1;
beta=2;
eps=0.01;

for i=1:10
    D = squareform(pdist(U,@naneucdist,tau,beta,eps));
    A = diag(1+2*sum(D,2)) - 2*D;
    U = A\train_X;
    U_2 = pca(U,2);
    gscatter(U_2(:,1), U_2(:,2), train_labels);
    legend(gca,'off')
    %saveas(gcf,[int2str(i+1) '.jpeg'])
end