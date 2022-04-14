function [smoothedvector,fsvector] =poweringecgsignals(signal,frequency)
LS=length(signal);
Nexthigherpower = 2 ^ nextpow2(LS);%Exponent of next higher power of 2
NHPDFT=fft(double(signal), Nexthigherpower); % Returns the next higher power-point DFT
EachDFT = NHPDFT / length(signal); %Divided by signal`s length
VectorAmplitudes = 2 * abs(EachDFT(1:(Nexthigherpower / 2))); %Corresponding Amplitudes Vector 
fsvector = (double(frequency) / 2 * linspace(0, 1, Nexthigherpower / 2))';  %Frequency [HZ] in a vector after Foriee Transform
smoothedvector=smooth(VectorAmplitudes(:),5); %Amplitudes smoothed- smooths the data in the Vector of the amplitudes by moving average filter. The default span for the moving average is 5
end

