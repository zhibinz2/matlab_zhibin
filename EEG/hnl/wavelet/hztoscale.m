function sc = hztoscale(hz,y,srx)
%HZTOSCALE Approximate scale corresponding to frequency.
%   SC = HZTOSCALE(HZ,Y,SRX) estimates scale SC, from the corresponding
%   frequency vector HZ; Y could be either a string, 
%   e.g. 'MORLET', or a function handle, e.g. output of FTMORLET(5), or a
%   numeric vector. SRX is the sampling rate of analyzed signal vector X in
%   Hz; By default SRX = 1;

% Siyi Deng; 11-24-2009;
if nargin < 3 || isempty(srx), srx = 1; end
f0 = centralfreq(y);
sc = f0.*srx./hz;
end % HZTOSCALE;