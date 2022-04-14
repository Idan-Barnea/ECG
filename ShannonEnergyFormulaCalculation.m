function Extractionhearsound = ShannonEnergyFormulaCalculation(X,N)
%implemented by calculating the normalized average three-order Shannon energy
%%N is Number of Samples 32-sample segment meaning Length of sample
%%X is the signal sample normalized to the maximum absolute value of the signal
    for indexsample=1:N 
        X(indexsample) = (abs(X(indexsample))).^3.*(log((abs(X(indexsample))).^3)); 
    end
    XSummarize=sum(X);
    Extractionhearsound = (-1./N)*XSummarize;
end
