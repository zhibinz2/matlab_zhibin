function c = fcwt(x,sc,y)
%FCWT Wavelet transform coefficient via Fourier transform.
%   C = FCWT(X,SC,Y) computes the continuous wavelet transform 
%   coefficients for array X at scales SC, based on Y;
%
%   Y can be either a numeric vector, which is treated as the prototype
%   mother wavelet, or a function handle, which will be used to evaluate
%   the analytical form of wavelet spectrum, or a string about the name of
%   mother wavelet, e.g. 'MORLET'.
%
%   X can be a multi-channel [nRow, nChan] column matrix; in that case C
%   will be a [nRow, nScale, nChan] array;
%
%   Example:
%       x = detrend(cumsum(randn(2000,1)));
%       t = linspace(-10,10,20*10+1);
%       y1 = exp(-(t.^2)/2).*cos(5.*t); % Morlet;
%       y2 = @(z)(pi.^(-1./4).*exp(-(5-z).^2./2));
%       y3 = 'morlet';
%       c1 = fcwt(x,(1:100)/10,y1);
%       c2 = fcwt(x,(1:100),y2);
%       c3 = fcwt(x,(1:100),y3);
%       figure; imagesc(abs(c1).'); colormap(hot);
%       figure; imagesc(abs(c2).'); colormap(hot);
%       figure; imagesc(abs(c3).'); colormap(hot);
%
%   See Also FCWTMORL, CWT, CCWT.

% Siyi Deng; 11-19-2009;
% revised by Bill Winter, 11-21-2009
if isvector(x), x = x(:); end
sc = sc(:).';
[nr,nc] = size(x);
ns = length(sc);
ftx = fft(x);
symm = 'nonsymmetric';
if isnumeric(y)
    y = y(:)-mean(y);
    ny = length(y);
    %nm = max(round(max(sc)*ny),4096);
    nm = ny*8;
    m = ceil((ny-1)/2);
    ftw = interp1(linspace(0,2.*pi.*(1-1/nm),nm).',...
        fft(cat(1,y(m:-1:1),zeros(nm-ny,1),y(ny:-1:m+1))),...
        linspace(0,2.*pi.*(1-1/nr),nr).'*sc,'linear',0);  
    if ~isreal(y) || ~isreal(x)
        symm = 'nonsymmetric';
    end
else
    if isa(y,'char')
        switch upper(y)
            case {'MORL','MORLET'}
                yf = @(z)(pi.^(-1./4).*exp(-(5-z).^2./2));
                symm = 'nonsymmetric';
            otherwise
                error('Currently not implemented.');
        end
    elseif isa(y,'function_handle')
        yf = y;
    else
        error('Unrecognized class of Y.');
    end
    ftw = yf(linspace(0,2.*pi.*(1-1/nr),nr).'*sc);    
end
scq = sqrt(sc);
% c = zeros(nr,ns,nc)+1j;
% for k = 1:nc
%     c(:,:,k) = (ftx(:,k)*scq).*ftw; 
% end
% c = ifft(c,nr,1,symm);
c = zeros(nr,ns,nc);
for k = 1:nc
    c(:,:,k) = ifft((ftx(:,k)*scq).*ftw,nr,1,symm); 
end

end % FCWT;






