function [isoline,averageisolineVoltage,std_isoline,Rpeak,SNRRpeakdividedstd,SignaldividedSTD]= isoelectric(signalvector,timevector,beginsegment,finishsegment)
isoline = signalvector((find(timevector==beginsegment)):(find(timevector==finishsegment))); %finding the parameters of isoelectric
averageisolineVoltage = mean(isoline); %average isoelctric
std_isoline = std(isoline); %std isoelectric
Rpeak=max(signalvector); % R peak
SNRRpeakdividedstd=Rpeak./std_isoline; %R peak divided by std
SignaldividedSTD=signalvector./std_isoline; %Signal divided by std
end