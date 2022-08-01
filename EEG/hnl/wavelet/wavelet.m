function cnorm = wavelet(data,fs,wfc,wfreq)
%just the current lab complex morlet wavelet
%INPUT: 
%data = time x channels 
%fs = sampling rate
%wfc = wavelet parameter - # of cycles to use, typically 1.5
%wfreq = list of frequencies to obtain wavelet coefficients. 
%Output
%cnorm = freq X time x channels wavelet coefficients
wlet = @(z)(pi.^(-1./4).*exp(-(wfc*2*pi-z).^2./2));

scal = hztoscale(wfreq,wlet,fs);
c = fcwt(data,scal,wlet);
%this normalization makes a unit sinewave have a coefficient with magnitude 0.5, similar to FFT 
%Its 0.5 and not 1 because of the ambiguity of positive and negative frequencies.  
for k = 1:size(c,2)
	cnorm(k,:,:) = sqrt(wfc/scal(k))*squeeze(c(:,k,:));
end;
%cnorm2 = sqrt(wfc)*c./(ones(length(x),1)*sqrt(scal));
