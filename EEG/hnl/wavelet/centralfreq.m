function f0 = centralfreq(y)
%CENTRALFREQ Central frequency of a mother wavelet.
%   F = CENTRALFREQ(Y) estimates the central frequency of mother wavelet Y.
%   Y could be either a string, e.g. 'MORLET', or a function handle, 
%   e.g. output of FTMORLET(5), or a numeric vector.

if isnumeric(y)
    n = length(y);
    py = abs(fft(detrend(y(:))));
    [dum,loc] = max(py(1:ceil(n/2)));
    fx = linspace(0,(1-1/n),n);
    f0 = fx(loc);
elseif isa(y,'char')
    switch upper(y)
        case {'MORL','MORLET'}
            % yf = @(z)(pi.^(-1./4).*exp(-(5-z).^2./2));
            f0 = 5/2/pi;
        case {'MEXHAT','MEXICANHAT','MEXIHAT','MEXI','RICKER'}
            f0 = 1/2/pi;           
        otherwise
            error('Currently not implemented.');
    end
elseif isa(y,'function_handle')
    yf = @(x)(-y(x));
    f0 = fminsearch(yf,0)/2/pi;
else
    error('Unrecognized class of Y.');
end

end % CENTRALFREQ;


