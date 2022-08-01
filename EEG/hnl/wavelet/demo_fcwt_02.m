% Ramesh's testing script;


wfreq = 1:80; % frequency(s) of interest
wfb = 0.5; % bandwidth in time
wfc = 1.5; % center frequency parameter (broadens in frequency space)
t = 0:1:1000; % TimeSamples
f = 60; % InputSignalFrequency
noise = .1; % amp of randn noise
fs = 1000; % SamplingFrequency
x = cos(2*pi*0.25*t/fs).*sin(2*pi*f/fs*t); % GenerateSineWave
x = x+noise*randn(size(x));


% complex morelet wavelet
figure(1), clf;
wvname = strcat('cmor',num2str(wfb),'-',num2str(wfc));    
scales = 1000*(wfreq/wfc).^-1; 
tmp = cwt(x,scales,wvname);
imagesc(abs(tmp));
axis tight;
colorbar


% calling using Siyi's FCWT default morlet;
scal = hztoscale(wfreq,'morlet',fs);
c = fcwt(x,scal,'morlet');
figure(2), clf;
imagesc(abs(c)'); 
axis tight;
colorbar


% calling using FCWT wavelet spectra function handle;
wlet = @(z)(pi.^(-1./4).*exp(-(wfc*2*pi-z).^2./2));
scal = hztoscale(wfreq,wlet,fs);
c = fcwt(x,scal,wlet);
figure(3), clf
imagesc(abs(c)');
axis tight
colorbar 
%DEFAULT MORLET DEFINITION IN SIYI's fcwt
%@(z)(pi.^(-1./4).*exp(-(5-z).^2./2));

%correct for scales error intrinsic to wavelets. 

cnorm = sqrt(wfc)*c./(ones(length(x),1)*sqrt(scal));
figure(4), clf
imagesc(abs(cnorm'));
axis tight
colorbar

% calling using Bill's CWTF
[spec,freq,time] = cwtf(x',wfreq/fs,1:1001);
figure(5), clf
imagesc(time/fs,freq*fs,abs(spec)')
xlabel('time (s)')
ylabel('frequency (Hz)');
axis tight
colorbar





