function c = ccwt(x,sc,y)
%CCWT Wavelet transform coefficient via time domain convolution.
%   C = CCWT(X,SC,Y) computes the wavelet transform coefficients for matrix
%   X at scales SC, based on prototype vector Y;
%   X must be a [nRow,nChan] column matrix; C is an array of size 
%   [nRow, nScale, nChan];
%
%   Example:
%       x = detrend(cumsum(randn(2000,3)));
%       t = linspace(-10,10,21*10);
%       y = exp(-(t.^2)/2).*cos(5.*t); % Morlet;
%       c = ccwt(x,(1:100)/10,y);
%       figure; imagesc(abs(c(:,:,3)).'); colormap(hot);
%
%   See Also FCWTMORL, FCWT, CWT.

% Siyi Deng; 11-07-2009;
y = zscore(y(:));
% x = bsxfun(@minus,x,mean(x));
[nr,nc] = size(x);
ns = length(sc);
yr = y(end:-1:1);
c = zeros(nr,ns,nc);
for k = 1:ns    
    c(:,k,:) = conv2(x,tscale(yr,sc(k)),'same')./sqrt(sc(k));
end
end % CCWT;

