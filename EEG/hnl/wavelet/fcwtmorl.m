function c = fcwtmorl(x,sc)
%FCWTMORL Morlet wavelet transform coefficient via Fourier transform.
%   C = FCWTMORL(X,SC) calculates C, the Morlet wavelet transform 
%   coefficients for vector X at scales SC;
%   C is length(X) by length(SC) matrix;
%
%   Example:
%       x = detrend(cumsum(randn(2000,1)));
%       c = fcwtmorl(x,1:100);
%       figure; imagesc(abs(c).'); colormap(hot);
%
%   See Also FCWT, CCWT, MORLET, CWT.

% Siyi Deng; 11-11-2009;

x = x(:)-mean(x);
sc = sc(:).';
n = size(x,1);
ftmorlet = @(z)(pi^(-1/4).*exp(-(5-z).^2./2));
omega = linspace(0,2*pi-2*pi/n,n).'*sc;
c = ifft(fft(x)*sqrt(sc).*ftmorlet(omega),'symmetric'); 
end % FCWTMORL;






