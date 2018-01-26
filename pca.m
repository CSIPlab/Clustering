function [X_low] = pca(X,dims)
    X = X - min(X(:));
    X = X / max(X(:));
    X = bsxfun(@minus, X, mean(X, 1));
    C = X' * X;
    [M, lambda] = eig(C);     
    [lambda, ind] = sort(diag(lambda), 'descend');
    M = M(:,ind(1:dims));
    X_low = X * M;
end
