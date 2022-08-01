function hz = scaletohz(sc,y,srx)
%SCALETOHZ Approximate frequency corresponding to scales.
%   HZ = SCALETOHZ(SC,Y,SRX,SRY) estimates HZ, the corresponding frequency
%   according to scale vector SC; Y could be either a string, 
%   e.g. 'MORLET', or a function handle, e.g. output of FTMORLET(5), or a
%   numeric vector. SRX is the sampling rate of analyzed signal vector X in
%   Hz; By default SRX = 1;

% Siyi Deng; 11-24-2009;
if nargin < 3 || isempty(srx), srx = 1; end
f0 = centralfreq(y);
hz = f0.*srx./sc;
end % SCALETOHZ;


