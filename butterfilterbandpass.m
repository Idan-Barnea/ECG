function[filteredlead]=butterfilterbandpass(Leadsignal,filterorder, freqencyresolution, BegincutoffFS, EndcutoffFS)
FreqNyquist=freqencyresolution/2; %Nyquist Frequency
Wp=[BegincutoffFS  EndcutoffFS]/FreqNyquist; %CUToff freqency 
[firstbandpassspart_,secondbandpasspart_] = butter(filterorder,Wp,'bandpass'); %Bandpass filter 
filteredlead = filter(firstbandpassspart_,secondbandpasspart_,Leadsignal); %filtering Lead
end