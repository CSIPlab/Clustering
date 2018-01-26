close all
clear all
load mnist_train.mat
num_dt_pts = 5000;
ind = randperm(size(train_X, 1));
train_X = train_X(ind(1:num_dt_pts),:);
train_labels = train_labels(ind(1:num_dt_pts));
X = [];
labels = [];
for i=1:size(train_X, 1)
    if train_labels(i) < 3
        X = [X; train_X(i,:)];
        labels = [labels; train_labels(i)];
    end
end
zeros = find(labels==2);
ones = find(labels==1);

U=X;

% U0 = mean(U(zeros,:));
% U1 = mean(U(ones,:));
% I=vec2mat(U0,28);
% imwrite(I,'original\zero.jpeg')
% I=vec2mat(U1,28);
% imwrite(I,'original\one.jpeg')

% for i=1:size(U,1)
%     I=vec2mat(U(i,:),28);
%     imshow(I);
%     saveas(gcf,['original\' int2str(i) '.jpeg'])
% end

U_2 = pca(U,2);
gscatter(U_2(:,1), U_2(:,2), labels);
axis([-10 10 -8 7])
legend(gca,'off')
saveas(gcf,'plot\1.jpeg')

tau=0.5;
beta=2;
eps=0.01;


for i=1:3
    D = squareform(pdist(U,@naneucdist,tau,beta,eps));
    A = diag(1+2*sum(D,2)) - 2*D;
    U = A\X;
    U_2 = pca(U,2);
    gscatter(U_2(:,1), U_2(:,2), labels);
    axis([-10 10 -8 7])
    legend(gca,'off')
    saveas(gcf,['plot\' int2str(i+1) '.jpeg'])
end

U0 = mean(U(zeros,:));
U1 = mean(U(ones,:));
I=vec2mat(U0,28);
imwrite(I,'transformed\zero.jpeg')
I=vec2mat(U1,28);
imwrite(I,'transformed\one.jpeg')
