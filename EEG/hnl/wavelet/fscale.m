function y = fscale(x,sc)
%FSCALE Time domain scaling by zero-padding in Fourier domain.
%   Y = FSCALE(X,SC) scales vector X by scalar SC;
%
%   Example:
%       x = detrend(cumsum(randn(2000,1)));
%       y1 = fscale(x,1.5);
%       y2 = fscale(x,0.6);
%       figure; plot(x,'b'); hold on; plot(y1,'r'); plot(y2,'g');

% Siyi Deng; 11-18-2009;
z = fft(x(:)-mean(x));
ny = round(sc*length(x));
z(end:ny) = 0;
z(ny+1:end) = [];
y = sc.*real(ifft(z,'symmetric'));
if size(x,2) > 1, y = y.'; end
end % FSCALE;





