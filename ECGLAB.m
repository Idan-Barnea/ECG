%% First Part %%
%% Time Domain- The original ECG signals Unfiltered
clc
clear all
firstpartsignalsimport = importdata('part1.txt'); %%Importing first part
Firstlead = firstpartsignalsimport.data(:,1); %Seperation of first Lead
Thirdlead = firstpartsignalsimport.data(:,2);%Separation of second Lead
BiopacSecondlead = firstpartsignalsimport.data(:,3); %Separation of Third Lead
Numberofsamples = length(Firstlead); %Number of samples by the length of lead
timefirst=50; % time of ECG in seconds
dt = timefirst./Numberofsamples; %dt=time of ecg/ number of samples= sampling period
vectortime = 0:dt:dt*(Numberofsamples-1); %getting vector of the time of each sample
fsfirst=1/dt; %Calculation of frequency 
%LeadI Unfiltered in time domain
figure;
subplot(2,1,1)
plot(vectortime,Firstlead)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Original ECG Signal Lead I - Before Filtering Time Domain')
subplot(2,1,2)
plot(vectortime,Firstlead)
xlim([20 25]) %Zoomed in Signal
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Original ECG Signal Lead I unfiltered in time domain- From 20 to 25 seconds zoomed in')
%LeadIII before filtering in time domain
figure;
subplot(2,1,1)
plot(vectortime,Thirdlead)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Original ECG Signal Lead III unfiltered in Time Domain')
subplot(2,1,2)
plot(vectortime,Thirdlead)
xlim([20 25])
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]]')
title('Original ECG Signal Lead III Unfiltered in time domain- From 20 to 25 seconds zoomed in')
%LeadII unfiltered in time domain
figure;
subplot(2,1,1)
plot(vectortime,BiopacSecondlead)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Original ECG Signal Biopac Lead II unfiltered in Time Domain')
subplot(2,1,2)
plot(vectortime,BiopacSecondlead)
xlim([20 25])
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Original ECG Signal Biopac Lead II unfiltered in time domain- From 20 to 25 seconds zoomed in')
%% Einthoven’s Law Verification
CalculationSecondLead = Firstlead + Thirdlead ; %%Einthoven’s Law
VECTORDifferenceOriginalSecondleadandcalculatedsecondlead = BiopacSecondlead - CalculationSecondLead; %Differences between Biopack signal LeadII and CalculatedSeconedLead
AveragedifferenceVector=mean(VECTORDifferenceOriginalSecondleadandcalculatedsecondlead);
STDAveragedifferenceVector=std(VECTORDifferenceOriginalSecondleadandcalculatedsecondlead);
SumdifferenceEinthovenlaw=sum(VECTORDifferenceOriginalSecondleadandcalculatedsecondlead);
figure;
subplot(3,1,1)
plot(vectortime,BiopacSecondlead)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Biopac Signal of LeadII in Time Domian unfiltered')
subplot(3,1,2)
plot(vectortime,CalculationSecondLead)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Calculated LeadII = LeadI + LeadIII in Time domain unfiltered (calculateed by Einthoven’s Law)')
subplot(3,1,3)
plot(vectortime,VECTORDifferenceOriginalSecondleadandcalculatedsecondlead)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Differences of Biopac signal LeadII and Calculated LeadII in Time domain unfiltered')
%% Graphs of the ECG Signals in the Frequency domain - Unfiltered
clc
%Lead 1 in Frequecny unfiltered
figure;
subplot(3,1,1);
[smoothedLeadI,LeadIfreqencyvector] =poweringecgsignals(Firstlead,fsfirst);
plot(LeadIfreqencyvector,smoothedLeadI);
xlim([0 80]);
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage[mV]')
title('Lead I Unfiltered in Frequency domain')
%Lead 3 in Freqency unfiltered
subplot(3,1,2);
[smoothedLeadIII,LeadIIIfreqencyvector] =poweringecgsignals(Thirdlead, fsfirst);
plot(LeadIIIfreqencyvector,smoothedLeadIII);
xlim([0 80]);
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage[mV]')
title('Lead III Unfiltered in Frequency domain')
%Lead II in Freqency unfiltered
subplot(3,1,3);
[smoothedpiopacleadII,biopacLeadIIfrequencyvector] =poweringecgsignals(BiopacSecondlead,fsfirst);
plot(biopacLeadIIfrequencyvector,smoothedpiopacleadII);
xlim([0 80]);
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage [mV]')
title('Biopac Lead II Unfiltered in Frequency domain')

%Separated graphs
%Lead II in Freqency unfiltered
figure
plot(biopacLeadIIfrequencyvector,smoothedpiopacleadII);
xlim([0 80]);
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage [mV]')
title('Biopac Lead II Unfiltered in Frequency domain')
%Lead 3 in Freqency unfiltered
figure
plot(LeadIIIfreqencyvector,smoothedLeadIII);
xlim([0 80]);
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage[mV]')
title('Lead III Unfiltered in Frequency domain')
%Lead 1 in Frequecny unfiltered
figure;
plot(LeadIfreqencyvector,smoothedLeadI);
xlim([0 80]);
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage[mV]')
title('Lead I Unfiltered in Frequency domain')

%% Time Domain ECG signals filtered vs unfiltered
clc
%CUToff freqency 8HZ and 50HZ
nfirst=1; %filter order
fn=fsfirst/2; %Nyquist Frequency
FirstpartBeginFreqencycutoff=8; %HZ
FirstpartENDFreqencycutoff=50; %HZ
Firstleadfiltered = butterfilterbandpass(Firstlead,nfirst, fsfirst, FirstpartBeginFreqencycutoff, FirstpartENDFreqencycutoff); %filtering first lead
Lead3filtered = butterfilterbandpass(Thirdlead,nfirst, fsfirst, FirstpartBeginFreqencycutoff, FirstpartENDFreqencycutoff); %filtering lead 3
Lead2biopacfiltered = butterfilterbandpass(BiopacSecondlead,nfirst, fsfirst, FirstpartBeginFreqencycutoff, FirstpartENDFreqencycutoff); %filtering lead 2 biopac
%Lead I filtered vs Unfiltered in time domian
figure;
subplot(3,1,1)
plot(vectortime,Firstlead)
hold on
plot(vectortime,Firstleadfiltered)
legend('Lead I Unfiltered','Filtered Lead I')
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Lead I Filtered vs Unfiltered in Time domain')
%Lead III filtered vs Unfiltered in time domian
subplot(3,1,2)
plot(vectortime,Thirdlead)
hold on
plot(vectortime,Lead3filtered)
legend('Lead III Unfiltered','Filtered Lead III')
xlabel('Time[sec]')
ylabel('Amplitude of Voltage [mV]')
title('Filtered Lead III vs Unfiltered in Time domain')
%Lead II filtered vs Unfiltered in time domian
subplot(3,1,3)
plot(vectortime,BiopacSecondlead)
hold on
plot(vectortime,Lead2biopacfiltered)
legend('Biopac Lead II Unfiltered','Biopac Lead II Filtered')
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Biopac Lead II Filtered vs Unfiltered in Time domain')


%Separate Figures
%Lead II filtered vs Unfiltered in time domian
figure
plot(vectortime,BiopacSecondlead)
hold on
plot(vectortime,Lead2biopacfiltered)
legend('Biopac Lead II Unfiltered','Biopac Lead II Filtered')
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Biopac Lead II Filtered vs Unfiltered in Time domain')
%Lead III filtered vs Unfiltered in time domian
figure
plot(vectortime,Thirdlead)
hold on
plot(vectortime,Lead3filtered)
legend('Lead III Unfiltered','Filtered Lead III')
xlabel('Time[sec]')
ylabel('Amplitude of Voltage [mV]')
title('Filtered Lead III vs Unfiltered in Time domain')
%Lead I filtered vs Unfiltered in time domian
figure;
plot(vectortime,Firstlead)
hold on
plot(vectortime,Firstleadfiltered)
legend('Lead I Unfiltered','Filtered Lead I')
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Lead I Filtered vs Unfiltered in Time domain')

%%Graphs of Filtered ECG signals in time domain
%Lead I filtered 
figure;
subplot(3,1,1)
plot(vectortime,Firstleadfiltered)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Lead I Filtered in Time domain')
%Lead III filtered
subplot(3,1,2)
plot(vectortime,Lead3filtered)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage [mV]')
title('Filtered Lead III in Time domain')
%Lead II filtered 
subplot(3,1,3)
plot(vectortime,Lead2biopacfiltered)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Biopac Lead II Filtered in Time domain')


%Separate Figures
%Lead II filtered 
figure
plot(vectortime,Lead2biopacfiltered)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Biopac Lead II Filtered in Time domain')
%Lead III filtered 
figure
plot(vectortime,Lead3filtered)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage [mV]')
title('Filtered Lead III in Time domain')
%Lead I filtered 
figure;
plot(vectortime,Firstleadfiltered)
xlabel('Time[sec]')
ylabel('Amplitude of Voltage[mV]')
title('Lead I Filtered  in Time domain')
%% %% Frequency domian filtered ECG signals
clc
%Lead I ecg signal filtered in frequency domain
figure;
subplot(3,1,1);
[smoothedfilteredlead1,freqency1fil] =poweringecgsignals(Firstleadfiltered,fsfirst);
plot(freqency1fil,smoothedfilteredlead1);
xlim([0 80]);
ylim([0 0.03])
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage[mV]')
title('Lead I Filtered in Frequency Domain')
%Lead III ecg signal filtered in frequency domain
subplot(3,1,2);
[smmoothedfilterlead3,freqency3fil] =poweringecgsignals(Lead3filtered, fsfirst);
plot(freqency3fil,smmoothedfilterlead3);
xlim([0 80]);
ylim([0 0.04])
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage[mV]')
title('Lead III Filtered in Frequency Domain')
%Lead II ecg signal filtered in frequency domain
subplot(3,1,3);
[smoothedfilterlead2biopac,freqency2fil] =poweringecgsignals(Lead2biopacfiltered, fsfirst);
plot(freqency2fil,smoothedfilterlead2biopac);
xlim([0 80]);
ylim([0 0.04])
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage[mV]')
title('Biopac Lead II Filtered in Frequency Domain')

%Separated graphs
%Lead II ecg signal filtered in frequency domain
figure
plot(freqency2fil,smoothedfilterlead2biopac);
xlim([0 80]);
ylim([0 0.04])
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage[mV]')
title('Biopac Lead II Filtered in Frequency Domain')

%Lead III ecg signal filtered in frequency domain
figure
plot(freqency3fil,smmoothedfilterlead3);
xlim([0 80]);
ylim([0 0.04])
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage[mV]')
title('Lead III Filtered in Frequency Domain')

%Lead I ecg signal filtered in frequency domain
figure;
plot(freqency1fil,smoothedfilteredlead1);
xlim([0 80]);
ylim([0 0.03])
xlabel('Frequency [Hz]');
ylabel('Amplitude of Voltage[mV]')
title('Lead I Filtered in Frequency Domain')

%Lead I filtered vs Unfiltered in frequency domian
figure;
subplot(3,1,1)
plot(LeadIfreqencyvector,smoothedLeadI)
hold on
plot(freqency1fil,smoothedfilteredlead1)
legend('Lead I Unfiltered','Filtered Lead I')
xlabel('Frequency [Hz]')
ylabel('Amplitude of Voltage[mV]')
xlim([0 80]);
ylim([0 0.03]);
title('Lead I Filtered vs Unfiltered in Frequency domain')
%Lead III filtered vs Unfiltered in Frequency domian
subplot(3,1,2)
plot(LeadIIIfreqencyvector,smoothedLeadIII)
hold on
plot(freqency3fil,smmoothedfilterlead3)
legend('Lead III Unfiltered','Filtered Lead III')
xlabel('Frequency [Hz]')
ylabel('Amplitude of Voltage [mV]')
xlim([0 80]);
ylim([0 0.03]);
title('Filtered Lead III vs Unfiltered in Frequency domain')
%Lead II filtered vs Unfiltered in time domian
subplot(3,1,3)
plot(biopacLeadIIfrequencyvector,smoothedpiopacleadII)
hold on
plot(freqency2fil,smoothedfilterlead2biopac)
legend('Biopac Lead II Unfiltered','Biopac Lead II Filtered')
xlabel('Frequency [Hz]')
ylabel('Amplitude of Voltage[mV]')
xlim([0 80]);
ylim([0 0.03]);
title('Biopac Lead II Filtered vs Unfiltered in Frequency domain')


%Separate Figures
%Lead I filtered vs Unfiltered in frequency domian
figure;
plot(LeadIfreqencyvector,smoothedLeadI)
hold on
plot(freqency1fil,smoothedfilteredlead1)
legend('Lead I Unfiltered','Filtered Lead I')
xlabel('Frequency [Hz]')
ylabel('Amplitude of Voltage[mV]')
xlim([0 80]);
ylim([0 0.03]);
title('Lead I Filtered vs Unfiltered in Frequency domain')
%Lead III filtered vs Unfiltered in Frequency domian
figure
plot(LeadIIIfreqencyvector,smoothedLeadIII)
hold on
plot(freqency3fil,smmoothedfilterlead3)
legend('Lead III Unfiltered','Filtered Lead III')
xlabel('Frequency [Hz]')
ylabel('Amplitude of Voltage [mV]')
xlim([0 80]);
ylim([0 0.03]);
title('Filtered Lead III vs Unfiltered in Frequency domain')
%Lead II filtered vs Unfiltered in time domian
figure
plot(biopacLeadIIfrequencyvector,smoothedpiopacleadII)
hold on
plot(freqency2fil,smoothedfilterlead2biopac)
legend('Biopac Lead II Unfiltered','Biopac Lead II Filtered')
xlabel('Frequency [Hz]')
ylabel('Amplitude of Voltage[mV]')
xlim([0 80]);
ylim([0 0.03]);
title('Biopac Lead II Filtered vs Unfiltered in Frequency domain')


%% Detecting QRS    
clc
%LEADII
figure;%LeadIIbiopac Filtered
filteredbiopacleadIIQRS = detectingQRSbyFS1algor(Lead2biopacfiltered,0.3,Numberofsamples);
plot(vectortime,Lead2biopacfiltered)
hold on
findingRpeakleadII = 0.8*filteredbiopacleadIIQRS; %Rpeak dots will be higher than actual signal
findingRpeakleadII(findingRpeakleadII==0) = NaN; %Samples that are 0 won`t be counted and considered as NAN
plot(vectortime,findingRpeakleadII,'r*')
ylim([-0.85 0.85])
xlim([0 50])
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
title('QRS Detection of Biopac LeadII Filtered')
figure %LEADIIBIOPAC Original Unfiltered
plot(vectortime,BiopacSecondlead)
hold on
findingRpeakleadII = 2*filteredbiopacleadIIQRS; %Rpeak dots will be higher than actual signal
findingRpeakleadII(findingRpeakleadII==0) = NaN; %Samples that are 0 won`t be counted and considered as NAN
plot(vectortime,findingRpeakleadII,'r*')
ylim([-0.85 2.5])
xlim([0 50])
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
title('QRS Detection of Biopac LeadII Original (Unfiltered)')
figure %LEAD II FILTERED VS UNFILTERED
plot(vectortime,Lead2biopacfiltered)
hold on
plot(vectortime,BiopacSecondlead)
hold on
findingRpeakleadII = 1.3*filteredbiopacleadIIQRS; %Rpeak dots will be higher than actual signal
findingRpeakleadII(findingRpeakleadII==0) = NaN; %Samples that are 0 won`t be counted and considered as NAN
plot(vectortime,findingRpeakleadII,'r*')
legend('Biopac Lead II Filtered','Original Signal Biopac Lead II', 'R-peak');
ylim([-0.85 1.5])
xlim([0 50])
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
title('QRS Detection of Biopac LeadII Filtered VS Original')


%LEADIII
figure;%LEADIII FILTERED
filteredleadIIIQRS = detectingQRSbyFS1algor(Lead3filtered,0.25, Numberofsamples);
plot(vectortime,Lead3filtered)
hold on
findingRpeadkLeadIII = 0.8*filteredleadIIIQRS; %Rpeak dots will be higher than actual signal
findingRpeadkLeadIII(findingRpeadkLeadIII==0) = NaN; %Samples that are 0 won`t be counted and considered as NAN
plot(vectortime,findingRpeadkLeadIII,'r*')
ylim([-0.85 0.85])
xlim([0 50])
xlabel('Time[sec]');
ylabel('Amplitude of Voltage [mV]')
title('QRS Detection of LeadIII Filtered')
figure %LEADIII ORIGINAL UNFILTERED
plot(vectortime,Thirdlead)
hold on
findingRpeadkLeadIII = 2*filteredleadIIIQRS; %Rpeak dots will be higher than actual signal
findingRpeadkLeadIII(findingRpeadkLeadIII==0) = NaN; %Samples that are 0 won`t be counted and considered as NAN
plot(vectortime,findingRpeadkLeadIII,'r*')
ylim([-0.85 2.5])
xlim([0 50])
xlabel('Time[sec]');
ylabel('Amplitude of Voltage [mV]')
title('QRS Detection of LeadIII Original (Unfiltered)')
figure %LEAD III FILTERED VS UNFILTERED
plot(vectortime,Lead3filtered)
hold on
plot(vectortime,Thirdlead)
hold on
findingRpeakleadIII = 1*filteredleadIIIQRS; %Rpeak dots will be higher than actual signal
findingRpeakleadIII(findingRpeakleadIII==0) = NaN; %Samples that are 0 won`t be counted and considered as NAN
plot(vectortime,findingRpeakleadIII,'r*')
legend('Lead III Filtered','Original Signal Lead III', 'R-peak');
ylim([-0.85 1.2])
xlim([0 50])
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
title('QRS Detection of LeadIII Filtered VS Original')
%LEADI
figure; %LEADI FILTERED
filteredleadI = detectingQRSbyFS1algor(Firstleadfiltered,0.07, Numberofsamples); 
plot(vectortime,Firstleadfiltered)
hold on
findingRpeakLEADI = 0.5*filteredleadI; %Rpeak dots will be higher than actual signal
findingRpeakLEADI(findingRpeakLEADI==0) = NaN;%Samples that are 0 won`t be counted and considered as NAN
plot(vectortime,findingRpeakLEADI,'r*')
ylim([-0.6 0.6])
xlim([0 50])
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
title('QRS Detection of LeadI Filtered')
figure %LEAD I ORIGINAL
plot(vectortime,Firstlead)
hold on
findingRpeakLEADI = 0.5*filteredleadI; %Rpeak dots will be higher than actual signal
findingRpeakLEADI(findingRpeakLEADI==0) = NaN;%Samples that are 0 won`t be counted and considered as NAN
plot(vectortime,findingRpeakLEADI,'r*')
ylim([-0.6 0.6])
xlim([0 50])
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
title('QRS Detection of LeadI Original (Unfiltered)')
figure %LEAD I FILTERED VS ORIGINAL
plot(vectortime,Firstleadfiltered)
hold on
plot(vectortime,Firstlead)
hold on
findingRpeakLEADI = 0.5*filteredleadI; %Rpeak dots will be higher than actual signal
findingRpeakLEADI(findingRpeakLEADI==0) = NaN;%Samples that are 0 won`t be counted and considered as NAN
plot(vectortime,findingRpeakLEADI,'r*')
legend('Lead I Filtered','Original Signal Lead I', 'R-peak');
ylim([-0.6 0.6])
xlim([0 50])
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
title('QRS Detection of LeadI Filtered VS Original')

%% Calculating the Heartrate at LeadII 
clc 
%First 30 seconds- Sitting
[Sittingheartrate_LeadII,AverageHeartratesitting,stdsitting]=HRfunctionfirstpart(vectortime(1:15165),filteredbiopacleadIIQRS(1:15165));
%Heartrate when standing at breathing normally 30-40sec
[StandingbreathingnormalyheartrateLeadII,AverageHeartratestandingandbreathingnormaly,stdstandingbreathnormal]=HRfunctionfirstpart(vectortime(15166:20219),filteredbiopacleadIIQRS(15166:20219)); 
%Heartrate when standing at breathing deeply 40-50sec
[StandingbreathdeeplyheartrateLEADII, AverageHeartratebreathingdeeplywhilestanding,stdstandingbreathingdeep]=HRfunctionfirstpart(vectortime(20220:25272),filteredbiopacleadIIQRS(20220:25272)); 
%% T-test for standing  breathing normal compared to standing breathing deep
[hypnotis,pparameter] = ttest(StandingbreathingnormalyheartrateLeadII(1:15),StandingbreathdeeplyheartrateLEADII);

%% Second part
clc
clear all
secondpartfileimport = importdata('part2.txt');
secondpartleadII = secondpartfileimport.data(:,3);
Numberofsamples2 = length(secondpartleadII);
timesecond=77;%total measurment time was 77 second
dtsecondpart = timesecond./Numberofsamples2; 
vectortimesecond = 0:dtsecondpart:dtsecondpart*(Numberofsamples2-1);
fssecond=1/dtsecondpart;%Calculation of frequency
nsecond=1; %filter order
Beginfs=10; %Begin 10hz cutoff
Endfs=50; %End 50hz cutoff
filteredlead2secondpart =butterfilterbandpass(secondpartleadII,nsecond, fssecond, Beginfs, Endfs); %filtering LeadII cutoff frequencies 10hz 50 hz
timevectorsecondpartcutedges = vectortimesecond(919:31213); % only 2-68 seconds- cutting time edges
filteredandcutedgeslead2secondpart = filteredlead2secondpart(919:31213); %cutting signal vector by time
Numberofsamplescutofedgesandfilteredsecondpart=length(filteredandcutedgeslead2secondpart); %number of samples after cut
Thresholdparametersecondpart=0.3;
Lead2QRSsecondpart = detectingQRSbyFS1algor(filteredandcutedgeslead2secondpart,Thresholdparametersecondpart,Numberofsamplescutofedgesandfilteredsecondpart); %Detection of QRS after filtering and cutting edges of Signal
figure
subplot(3,1,1) %Checking the parameters of filter if are optimical
plot(vectortimesecond,secondpartleadII);
title('Original Unfiltered LeadII Signal in Time Domain');
xlabel('Time [sec]'); 
ylabel('Amplitude of Voltage [mV]');
subplot(3,1,2) %Filtered signal with no cuts of edges
plot(vectortimesecond,filteredlead2secondpart);
title('Filtered LeadII In Full Time Domain');
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
subplot(3,1,3) %Filtered signal with cuts of edges of signals from 2 seconds until 68 seconds
plot(timevectorsecondpartcutedges,filteredandcutedgeslead2secondpart);
title('Filtered LeadII with Cut Edges in Time Domain');
xlabel('Time[sec]');
xlim([2,68])
ylabel('Amplitude of Voltage[mV]')
%%Separated Graphs
figure %Original signal with time
plot(vectortimesecond,secondpartleadII);
title('Original Unfiltered LeadII Signal in Time Domain');
xlabel('Time [sec]'); 
ylabel('Amplitude of Voltage [mV]');
figure %Filtered signal with no cuts of edges
plot(vectortimesecond,filteredlead2secondpart);
title('Filtered LeadII In Full Time Domain');
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
figure %Filtered signal with cuts of edges of signals from 2 seconds until 68 seconds
plot(timevectorsecondpartcutedges,filteredandcutedgeslead2secondpart);
title('Filtered LeadII with Cut Edges in Time Domain');
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
xlim([2,68])


[Heartratelead2secondpart,Averageheartratelead2secondpart,stdlead2secondpart]=HRfunctionfirstpart(timevectorsecondpartcutedges,Lead2QRSsecondpart); %Calculating Heart Rate of each pump and Average Heartrate and STD 
Heartrateof15pumps =Heartratelead2secondpart(61:76); %61 till 76 beats
AxisXofpumps = 61:76; %Number of Beats
Vectoronesbeforeputtingmeanheartrate=ones(1,16);
Averageheartratevector61to76 = Averageheartratelead2secondpart*Vectoronesbeforeputtingmeanheartrate; %Average Heartrate
Stdvectorplus = (Averageheartratelead2secondpart+stdlead2secondpart)*Vectoronesbeforeputtingmeanheartrate; %std vector plus
stdvectorminus = (Averageheartratelead2secondpart-stdlead2secondpart)*Vectoronesbeforeputtingmeanheartrate; %std vector minus
figure;
plot(AxisXofpumps,Heartrateof15pumps,'O','MarkerSize',5)
hold on
plot(AxisXofpumps,Averageheartratevector61to76,'g')
hold on
plot(AxisXofpumps,Stdvectorplus,'y-.')
hold on
plot(AxisXofpumps,stdvectorminus,'k-.')
xlabel('Number of Beat')
ylabel('Heart Rate [Beats Per Minute]')
xlim([61,76])
title('Heart Rate as Function of Number of Beat (with Standard Deviation and Average)')
legend('Heart Rate','Average Heart Rate','Heart Rate+SD','Heart Rate-SD')
%% Detection of QRS peaks
clc
Cutlead2second2=filteredlead2secondpart(231:35092);
vectortimecutsecond2 = vectortimesecond(231:35092); %0.5 seconds to 75 seconds
Nlead2second2=length(Cutlead2second2);
detectionQRSofLead2second2 = detectingQRSbyFS1algor(Cutlead2second2,0.3,Nlead2second2);
OriginalnumberofRpeaksCutlead2second2=sum(detectionQRSofLead2second2); %number of peimot 
lengthsofvectorQRSCutlead2second2=length(detectionQRSofLead2second2);
SavercellQRS = cell(1,OriginalnumberofRpeaksCutlead2second2,500); %empty cellarray in order saving each signal QRS
numberofRpeaksinCUTlead2second2forwhileloop=0;
timevectorsignal2 = 0:2:800; %total time for each signal 800[msec]
figure
while numberofRpeaksinCUTlead2second2forwhileloop <= OriginalnumberofRpeaksCutlead2second2
    for indexofdetectQRSlead2second2 = 1:lengthsofvectorQRSCutlead2second2
        if detectionQRSofLead2second2(indexofdetectQRSlead2second2)==1
           numberofRpeaksinCUTlead2second2forwhileloop=numberofRpeaksinCUTlead2second2forwhileloop+1; 
           SavercellQRS{numberofRpeaksinCUTlead2second2forwhileloop}=Cutlead2second2(indexofdetectQRSlead2second2-150:indexofdetectQRSlead2second2+250);
           plot(timevectorsignal2,SavercellQRS{numberofRpeaksinCUTlead2second2forwhileloop});
           title('All Signals of Iterations Plotted')
           xlabel('Time [milisec]');
           ylabel('Amplitude of Voltage [mV]')
           hold on
        end   
    end
end

Averagesignalvector = zeros(401,1); %empty vector to save calculation of average signal
for indexinRpeaksoriginal = 1:OriginalnumberofRpeaksCutlead2second2
    Averagesignalvector = Averagesignalvector + SavercellQRS{indexinRpeaksoriginal};
end
lenaveragesignalvec=length(Averagesignalvector);
Averagesignalvectordivided = Averagesignalvector./OriginalnumberofRpeaksCutlead2second2;
Firstsignalsegemnt=SavercellQRS{1};
Lastsignalsegement=SavercellQRS{103};
figure %part a
plot(timevectorsignal2,Averagesignalvectordivided)
title('Average of ECG signals- one line')
ylim([-1 1])
xlabel('Time [milisec]');
ylabel('Amplitude of Voltage[mV]')
figure %subplot
subplot(3,1,1)
plot(timevectorsignal2,Averagesignalvectordivided)
title('Average of ECG signals- one line')
ylim([-1 1])
xlabel('Time [milisec]');
ylabel('Amplitude of Voltage[mV]')
subplot(3,1,2)
plot(timevectorsignal2,Firstsignalsegemnt)
title('First Single ECG Signal')
xlabel('Time [milisec]');
ylabel('Amplitude of Voltage[mV]')
ylim([-1 1])
subplot(3,1,3)
plot(timevectorsignal2,Lastsignalsegement)
title('Last Single ECG Signal')
xlabel('Time[milisec]');
ylabel('Amplitude of voltage[mV]')
ylim([-1 1])
%Isoelectric line
Beginsegemnettime=370; %milisecond
Finishsegementtime=420; %milisecond
%Isoelectric line for Average Signal
[IsolineforAveragesignal,VoltageAverageavergaeISOsignal,VoltageAveragesignalSTD,AveragesignalRpeak,SNRAveragesignalRpeakdividedSTD,AveragesigsignaldividedSTD]= isoelectric(Averagesignalvectordivided,timevectorsignal2,Beginsegemnettime,Finishsegementtime);
%Isoelectric line for First
[IsoFirst,VoltageFirstsigaverageISO,VoltageFirstisoSTD, FirstsigRpeak, SNRFirstsigRpeakdivSTD,FirstsigsignaldividedSTD]=isoelectric(Firstsignalsegemnt,timevectorsignal2,Beginsegemnettime,Finishsegementtime);
%Isoelctric line for LAST
[IsoLast, VoltageLastsigaverageISO, VoltageLastISOSTD, LastsigRpeak, SNRLastsigRpeakdivSTD, LasdtsigsinaldivSTF]=isoelectric(Firstsignalsegemnt,timevectorsignal2,Beginsegemnettime,Finishsegementtime);
figure
subplot(2,1,1)
plot(timevectorsignal2,Averagesignalvectordivided,'b')
hold on 
plot(timevectorsignal2,Firstsignalsegemnt,'r')
xlabel('Time [msec]');
ylabel('Amplitude of Voltage[mV]')
title('Signals- First and Average')
legend('Average Signal','First Signal')
subplot(2,1,2)
plot(timevectorsignal2,AveragesigsignaldividedSTD,'b')
hold on 
plot(timevectorsignal2,FirstsigsignaldividedSTD,'r')
xlabel('Time[milisec]');
ylabel('SNR')
title('Average and First Signals Divided By STD')
legend('Average Signal','First Signal')
%Separated
figure
plot(timevectorsignal2,Averagesignalvectordivided,'b')
hold on 
plot(timevectorsignal2,Firstsignalsegemnt,'r')
xlabel('Time [milisec]');
ylabel('Amplitude of Voltage[mV]')
title('Signals- First and Average')
legend('Average Signal','First Signal')
figure
plot(timevectorsignal2,AveragesigsignaldividedSTD,'b')
hold on 
plot(timevectorsignal2,FirstsigsignaldividedSTD,'r')
xlabel('Time[milisec]');
ylabel('SNR')
title('Average and First Signals Divided By STD')
legend('Average Signal','First Signal')
%SNR Improvement
AVGSTDminusFIRSTSTD=AveragesigsignaldividedSTD-FirstsigsignaldividedSTD; %Difference betweeen the average and first std
figure
plot(timevectorsignal2,AVGSTDminusFIRSTSTD)
xlabel('Time[milisec]');
ylabel('SNR')
title('Improvement in SNR')
clc; clear all
thirdpartfileimport = importdata('part3.txt');
SoundsfromStethoscope = thirdpartfileimport.data(:,1);
ThirdpartECGsignal = thirdpartfileimport.data(:,2);
Numberofsamplesthirdpart = length(ThirdpartECGsignal);
timerecordingthirsdpart=38.5; %seconds
dt3part =timerecordingthirsdpart./Numberofsamplesthirdpart; 
vectortimethirdpart = 0:dt3part:dt3part*(Numberofsamplesthirdpart-1);
fs3=1/dt3part; %frequency 
LengthofsigStatoscope= length(SoundsfromStethoscope);
%Preprocessing of the Heart Sound Signal
Nexp=fix(log2(LengthofsigStatoscope)); % set Level N less than or equal to fix(log2(length(X))) on function wavedec+ wavelet decomposition vector C and the bookkeeping vector L
MaxLevelDSignal = wmaxlev(LengthofsigStatoscope,'db6'); %returns the maximum level decomposition of signal 
[C,L] = wavedec(SoundsfromStethoscope,5,'db6'); %1-D wavelet decomposition - returns the wavelet decomposition+Heart sound signal is decomposed into atree of 5 levels using db6 wavelet 
FilteringsoundsfromStthoscop = waverec(C,L,'db3'); %multilevel one-dimensional wavelet reconstruction using d3 (100 to 200 Hz)
FilteringsoundsfromStthoscop = waverec(C,L,'db5'); %multilevel one-dimensional wavelet reconstruction using d4(50 to 100 Hz)
FilteringsoundsfromStthoscop = waverec(C,L,'db4'); %multilevel one-dimensional wavelet reconstruction using d5 (25 to 50 Hz)
%Normalizing the Signals
LengthFSFS=length(FilteringsoundsfromStthoscop);
Normalizationfiltersoundsfromstatoscope=zeros(1,LengthFSFS);
Maximumsignal=max(FilteringsoundsfromStthoscop);
for sigindex=1:LengthFSFS
    Normalizationfiltersoundsfromstatoscope(sigindex)=abs(FilteringsoundsfromStthoscop(sigindex)./Maximumsignal);
end

%Extraction of the Heart Sound Envelope
LSS=LengthofsigStatoscope-32;
Eheartsound = zeros(1,LengthofsigStatoscope); %Saving Vector of segmenting results
lengthEhearsound= length(Eheartsound);
for index=1:(LengthofsigStatoscope-32) % continuous 32-sample segments
    LengthoffiltersoundsSTthoscpeallNORMALIZED=length(FilteringsoundsfromStthoscop(index:index+31));
    maxXsegemnt=abs(max(FilteringsoundsfromStthoscop(index:index+31)));
    vectorindexfilter=Normalizationfiltersoundsfromstatoscope(index:index+31);
    Eheartsound(index)=ShannonEnergyFormulaCalculation(vectorindexfilter,LengthoffiltersoundsSTthoscpeallNORMALIZED);
    index=index+16; % 16-sample segment overlapping 
end
SUMHS=sum(Eheartsound);
MeanEheartsound=mean(Eheartsound);
STD_Eheartsound=std(Eheartsound);
Phearta = zeros(1,LengthofsigStatoscope); %whole heart sound signal
for t=1:(length(Eheartsound))
    Phearta(t)=(Eheartsound(t)-MeanEheartsound)./STD_Eheartsound;
    t=t+1;
end
%Phearta(Phearta<0) = 0;
nthird=1; %filter order
Beginthird=10; %Begin 10hz cutoff
Endthird=50; %End 50hz cutoff
filteredthirdpartlead =butterfilterbandpass(ThirdpartECGsignal,nthird, fs3, Beginthird, Endthird); %filtering cutoff frequencies 10hz 50 hz
filtered3QRSWHOLE = detectingQRSbyFS1algor(filteredthirdpartlead,0.3,Numberofsamplesthirdpart); %Lead QRS detection 
f3QRSdots = 2*filtered3QRSWHOLE;
f3QRSdots(f3QRSdots==0) = NaN;
f3QRSEND = detectingQRSbyFS1algor(filteredthirdpartlead(10489:end),0.35,Numberofsamplesthirdpart-10488); %last 18 seconds of recording
f3qrsbegin=detectingQRSbyFS1algor(filteredthirdpartlead(1:10488),0.3,length(filteredthirdpartlead(1:10488))); %first 20 seconds of recording

%Beats Per Minute Heartrate
%Heart Rate Beats Per minute REST
[HeartratesecondleadRESTthirdpart,BeatsperminutevectorRest, AverageBeatsperminuteREST,stdAveragebeatsperminuteREST]=HRfunctionthirdpart(vectortimethirdpart(2623:8391),f3qrsbegin(2623:8391));
%Heart Rate Beats Per minute After Excersize
[HeartratesecondleadExersizethirdpart,BeatsperminutevectorExersize, AverageBeatsperminuteExersize,stdAveragebeatsperminuteExersize]=HRfunctionthirdpart(vectortimethirdpart(10719:13634),f3QRSEND(231:3146));

%Calcualting the Parameters in the table

%%Sound1 Rwave
%Resting Sound 1 Rwave
RestSound1addzeros = zeros(25,1);
RestSound1vectordetect = [RestSound1addzeros; f3qrsbegin];
RestSound1vectordetect = RestSound1vectordetect(1:10488);
lengthRS1V=length(RestSound1vectordetect);
tcstartmiddle= length( vectortimethirdpart(1:10488));
HeartratedetectRESTsound1 = vectortimethirdpart(2623:8391).'.*RestSound1vectordetect(2623:8391); %5 to 16 seconds
HeartrateRestRWAVEsound1 = (HeartratedetectRESTsound1(HeartratedetectRESTsound1~=0))-(HeartratesecondleadRESTthirdpart(HeartratesecondleadRESTthirdpart~=0));
RwavetoSound1intervalRest = mean(HeartrateRestRWAVEsound1);
STDRwavetoSound1intervalRest = std(HeartrateRestRWAVEsound1);
%After Excersize Sound 1 Rwave
ExersizeSound1addzeros = zeros(10,1);
ExcersizeSound1vectordetect = [ExersizeSound1addzeros; f3QRSEND];
ExcersizeSound1vectordetect = ExcersizeSound1vectordetect(1:9699); %10 seconds
tcmiddleend= length(vectortimethirdpart(10719:13634));
lengthf4=length(ExcersizeSound1vectordetect);
HeartratedetectExersizeSound1 = vectortimethirdpart(10719:13634).'.*ExcersizeSound1vectordetect(231:3146);
HeartrateExersizeRwaveSound1 = (HeartratedetectExersizeSound1(HeartratedetectExersizeSound1~=0))-(HeartratesecondleadExersizethirdpart(HeartratesecondleadExersizethirdpart~=0));
RwavetoSound1intervalExersize = mean(HeartrateExersizeRwaveSound1);
STDRwavetoSound1intervalExcersize = std(HeartrateExersizeRwaveSound1);

%SOUND2 Rwave
%Rest Sound2 Rwave
RestSound2addzeros = zeros(190,1);
RestSound2vectorsetect = [RestSound2addzeros;f3qrsbegin];
RestSound2vectorsetect = RestSound2vectorsetect(2623:8391); 
HeartraetdetectRestSound2 = vectortimethirdpart(2623:8391).'.*RestSound2vectorsetect; %20 seconds
lRS2=length(HeartraetdetectRestSound2(HeartraetdetectRestSound2~=0));
LR2=length(HeartratesecondleadRESTthirdpart(HeartratesecondleadRESTthirdpart~=0));
HeartrateRESTRWAVESound2 = (HeartraetdetectRestSound2(HeartraetdetectRestSound2~=0))-(HeartratesecondleadRESTthirdpart(HeartratesecondleadRESTthirdpart~=0));
RwavetoSound2REST = mean(HeartrateRESTRWAVESound2);
STDRwavetoSound2REST = std(HeartrateRESTRWAVESound2);
%After Exersize Sound 2 Rwave 
ExersizeSound2addzeros = zeros(150,1);
ExersizeSound2vectordetect = [ExersizeSound2addzeros; f3QRSEND];
ExersizeSound2vectordetect = ExersizeSound2vectordetect(1:9699); %sizedqrs
HR_LeadII_sound2_ex = vectortimethirdpart(10719:13634).'.*ExersizeSound2vectordetect(231:3146);
L2EXS= length((HR_LeadII_sound2_ex(HR_LeadII_sound2_ex~=0)));
L22=length((HeartratesecondleadExersizethirdpart(HeartratesecondleadExersizethirdpart~=0)));
HeartratetoExersizeRwaveSound2 = (HR_LeadII_sound2_ex(HR_LeadII_sound2_ex~=0))-(HeartratesecondleadExersizethirdpart(HeartratesecondleadExersizethirdpart~=0));
RwavetoSound2Exersize = abs(mean(HeartratetoExersizeRwaveSound2));
STDRwavetoSound2Exersize = std(HeartratetoExersizeRwaveSound2);

%%SOUND 1 to Sound 2 Interval
%Interval Sound1 to Sound2 REST
HeartrateSound1toSound2REST = (HeartraetdetectRestSound2(HeartraetdetectRestSound2~=0))-(HeartratedetectRESTsound1(HeartratedetectRESTsound1~=0));
Sound1toSound2RESTtime = mean(HeartrateSound1toSound2REST);
STDSound1toSound2RESTtime = std(HeartrateSound1toSound2REST);
%Interval Sound1 to Sound2 After EXCERSIZE
ExersizeSound1toSound1 = HeartratedetectExersizeSound1(HeartratedetectExersizeSound1~=0);
ExcersizeSound2toSound2 = HR_LeadII_sound2_ex(HR_LeadII_sound2_ex~=0);
HeartrateSound1toSound2EXcersize = ExcersizeSound2toSound2(2:end)-ExersizeSound1toSound1(1:end-1);
Sound1toSound2EXCERSIZEtime = mean(HeartrateSound1toSound2EXcersize);
STDSound1toSound2EXCERSIZEtime = std(HeartrateSound1toSound2EXcersize);

%%SOUND 2 to Sound 1 Interval
%Interval Sound2 to Sound1 REST
RESTSound1toSound1 = HeartratedetectRESTsound1(HeartratedetectRESTsound1~=0);
RESTSound2toSound2 = HeartraetdetectRestSound2(HeartraetdetectRestSound2~=0);
HeartrateSound2toSound1REST = RESTSound1toSound1(2:end)-RESTSound2toSound2(1:end-1);
Sound2tosound1RESTtime = mean(HeartrateSound2toSound1REST);
STDSound2tosound1RESTtime = std(HeartrateSound2toSound1REST);
%Interval Sound2 to Sound1 After EXCERSIZE
HeartrateSound2toSound1Excersize = ExersizeSound1toSound1-ExcersizeSound2toSound2;
Sound2tosound1Exersize = mean(HeartrateSound2toSound1Excersize);
STDSound2tosound1Exersize = std(HeartrateSound2toSound1Excersize);
%%PLOTS Part C
clc
RestSound1vectordetect(RestSound1vectordetect==0) = NaN;
RestSound2vectorsetect(RestSound2vectorsetect==0) = NaN;
ExcersizeSound1vectordetect(ExcersizeSound1vectordetect==0) = NaN;
ExersizeSound2vectordetect(ExersizeSound2vectordetect==0) = NaN; 
%REST PART
figure
plot(vectortimethirdpart(2623:8391),FilteringsoundsfromStthoscop(2623:8391)+3,'magenta') %SOUNDS VECTOR REST
hold on
plot(vectortimethirdpart(2623:8391),ThirdpartECGsignal(2623:8391),'k') %ECG SIGNAL
hold on 
plot(vectortimethirdpart(2623:8391),RestSound1vectordetect(2623:8391)+1,'r*') %Sound1
hold on
plot(vectortimethirdpart(2623:8391),RestSound2vectorsetect+1,'b*') %SOUND2
legend('Heart Sounds','ECG Signal','Sound 1','Sound 2')
xlabel('Time[sec]');
ylabel('Amplitude of Voltage [mV]')
xlim([vectortimethirdpart(2623) vectortimethirdpart(8391)])
title('Heart Sounds and ECG Signal during Rest')
hold off
%AFTER Exercise Part
figure;
plot(vectortimethirdpart(10719:13634),FilteringsoundsfromStthoscop(10719:13634)+4,'magenta') %Sounds
hold on
plot(vectortimethirdpart(10719:13634),ThirdpartECGsignal(10719:13634),'k') %ECG Signal
hold on 
plot(vectortimethirdpart(10719:13634),ExcersizeSound1vectordetect(231:3146)+1,'r*') %Sound1
hold on
plot(vectortimethirdpart(10719:13634),ExersizeSound2vectordetect(231:3146)+1,'b*') %Sound2
legend('Heart Sounds','ECG Signal','Sound 1','Sound 2')
xlabel('Time[sec]');
ylabel('Amplitude of Voltage [mV]')
xlim([vectortimethirdpart(10719) vectortimethirdpart(13634)])
title('Heart Sounds and ECG Signal After Exercise')
hold off

%% Original Signal SOUNDS
%REST PART
figure
plot(vectortimethirdpart(2623:8391),SoundsfromStethoscope(2623:8391)+3,'magenta') %SOUNDS VECTOR REST
hold on
plot(vectortimethirdpart(2623:8391),ThirdpartECGsignal(2623:8391),'k') %ECG SIGNAL
hold on 
plot(vectortimethirdpart(2623:8391),RestSound1vectordetect(2623:8391)+1,'r*') %Sound1
hold on
plot(vectortimethirdpart(2623:8391),RestSound2vectorsetect+1,'b*') %SOUND2
legend('Heart Sounds','ECG Signal','Sound 1','Sound 2')
xlabel('Time[sec]');
ylabel('Amplitude of Voltage [mV]')
xlim([vectortimethirdpart(2623) vectortimethirdpart(8391)])
title('Original Heart Sounds and ECG Signal during Rest')
hold off
%AFTER Exercise Part
figure;
plot(vectortimethirdpart(10719:13634),SoundsfromStethoscope(10719:13634)+4,'magenta') %Sounds
hold on
plot(vectortimethirdpart(10719:13634),ThirdpartECGsignal(10719:13634),'k') %ECG Signal
hold on 
plot(vectortimethirdpart(10719:13634),ExcersizeSound1vectordetect(231:3146)+1,'r*') %Sound1
hold on
plot(vectortimethirdpart(10719:13634),ExersizeSound2vectordetect(231:3146)+1,'b*') %Sound2
legend('Heart Sounds','ECG Signal','Sound 1','Sound 2')
xlabel('Time[sec]');
ylabel('Amplitude of Voltage [mV]')
xlim([vectortimethirdpart(10719) vectortimethirdpart(13634)])
title('Original Heart Sounds and ECG Signal After Exercise')
hold off
%% Filtered Vector Heart sounds and Detection of Sound1 Sound2 PHS 
figure;
plot(vectortimethirdpart,Phearta)
hold on
plot(vectortimethirdpart(2623:8391),RestSound1vectordetect(2623:8391)+10,'r*') %REST Sound1
hold on
plot(vectortimethirdpart(2623:8391),RestSound2vectorsetect(1:5769)+10,'b*') %REST Sound2
hold on 
plot(vectortimethirdpart(10719:13634),ExcersizeSound1vectordetect(231:3146)+10,'r*') %AFTER EXCERSIZE Sound1
hold on
plot(vectortimethirdpart(10719:13634),ExersizeSound2vectordetect(231:3146)+10,'b*') %AFTER EXCERSIZE Sound2
legend('Heart Sounds','Sound 1','Sound 2')
ylim([-1 12])
title('Filtered Heart Sounds and Detection of Sound 1 and Sound 2')
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
%% REST Filtered Vector Heart sounds and Detection of Sound1 Sound2 PHS 
figure;
plot(vectortimethirdpart(2623:8391),Phearta(2623:8391))
hold on
plot(vectortimethirdpart(2623:8391),RestSound1vectordetect(2623:8391)+4,'r*') %REST Sound1
hold on
plot(vectortimethirdpart(2623:8391),RestSound2vectorsetect(1:5769)+4,'b*') %REST Sound2 
legend('Heart Sounds','Sound 1','Sound 2')
title('Filtered Heart Sounds and Detection of Sound 1 and Sound 2 During REST')
xlim([vectortimethirdpart(2623) vectortimethirdpart(8391)]) 
ylim([-1 6])
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
%%After EXCERSIZE Filtered Vector Heart sounds and Detection of Sound1 Sound2 PHS 
figure;
plot(vectortimethirdpart(10719:13634),Phearta(10719:13634))
hold on
plot(vectortimethirdpart(10719:13634),ExcersizeSound1vectordetect(231:3146)+10,'r*') %AFTER EXCERSIZE Sound1
hold on
plot(vectortimethirdpart(10719:13634),ExersizeSound2vectordetect(231:3146)+10,'b*') %AFTER EXCERSIZE Sound2
legend('Heart Sounds','Sound 1','Sound 2')
xlim([vectortimethirdpart(10719) vectortimethirdpart(13634)]) 
ylim([-1 12])
title('Filtered Heart Sounds and Detection of Sound 1 and Sound 2 After Excersize')
xlabel('Time[sec]');
ylabel('Amplitude of Voltage[mV]')
