function [wavelet tfspectra] = waveletscript(SEGEEG,fb,fc,freqs,tscale);
%runs a wavelet analysis, returns all quantities of interest. 
%SEGEEG - usual SEGEEG structure with artifact editing. 
%fb - decay parameter for wavelet (recommend 0.5) 
%fc - number of cycles parameter  (recommend 2)
%freqs - list of frequencies to get output 
%(recommend)
%freqs = [4 5 6 7 8 9 10 11 12 14 16 18 20 24 28 32 36 40 48];
%tscale = downsampling rate for wavelet output.  
%wavelet - structure containing processed wavelet outputs 
%   has fields power, eppower, coherence
%tfspectra - raw wavelet spectra for each trial. 
%
matlabpool(4)
goodepochs = SEGEEG.artifact.goodepochs;
nepochs = length(goodepochs);
nsamps = size(SEGEEG.data,1);
nfreqs = length(freqs);
nchans = 128;
tfspectra = zeros(nsamps,nfreqs,nchans,nepochs);
for k = 1:nepochs
  tfspectra(:,:,:,k) = slowwavelet(squeeze(SEGEEG.data(:,1:nchans, ...
				goodepochs(k))),SEGEEG.rate,freqs,fb,fc);
end;
wavelet.power = var(tfspectra(tscale:tscale:end,:,:,:),[],4);
wavelet.eppower = abs(mean(tfspectra(tscale:tscale:end,:,:,:),4)).^2;
wavelet.nepochs = nepochs;
wavelet.freqs = freqs;
wavelet.param.fb = fb;
wavelet.param.fc = fc;
wavelet.time = SEGEEG.segwindow(tscale:tscale:end);
ntime = length(wavelet.time);
coherence = zeros(ntime,nfreqs,nchans,nchans);
for j = 1:ntime
  for k = 1:nfreqs
    sf = corrcoef(squeeze(tfspectra(j*tscale,k,1:nchans,:))');
    coherence(j,k,:,:) = abs(sf).^2;
  end; 
end;
wavelet.coherence = coherence;
wavelet.stimchan = SEGEEG.stimchan;
wavelet.filenames = SEGEEG.filenames;
wavelet.goodchans = SEGEEG.artifact.goodchans;
wavelet.environment = SEGEEG.environment;
matlabpool close