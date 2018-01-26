function D2 = naneucdist(XI,XJ,tau,beta,eps)  
    norm2=sqrt(sum((repmat(XI,size(XJ,1),1)-XJ).^2,2));
    D2=tau./(norm2.^beta+eps);
end