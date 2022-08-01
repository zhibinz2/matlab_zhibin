function y = tscale(x,sc)
%TSCALE Time domain scaling via interpolation.
%   Y = FSCALE(X,SC) scales vector X by scalar SC;
%
%   Example:
%       x = detrend(cumsum(randn(2000,1)));
%       y1 = tscale(x,1.5);
%       y2 = tscale(x,0.6);
%       figure; plot(x,'b'); hold on; plot(y1,'r'); plot(y2,'g');

% Siyi Deng; 11-08-2009;
nx = numel(x);
ny = round(nx.*sc);
if sc == 1, y = x; return; end;
y = interp1q(linspace(0,1,nx).',x(:),linspace(0,1,ny).');
end % TSCALE;
