function [vectorsoffindingQRS] = detectingQRSbyFS1algor(leadvector,Thresholdparameter,numberofsamples) %FS1 algorithm
    vectorsoffindingQRS = zeros(numberofsamples,1);%same number of samples for each lead
    for numberofsignals = 3:numberofsamples-2
        Y_0(numberofsignals) = abs(leadvector(numberofsignals+1)-leadvector(numberofsignals-1));
        Y_1(numberofsignals) = abs(leadvector(numberofsignals+2)-2*leadvector(numberofsignals)+leadvector(numberofsignals-2));
        Y_2(numberofsignals) = 1.3*Y_0(numberofsignals)+1.1*Y_1(numberofsignals);
    end
    Y_2 = Y_2.';
    Y_2lengthnumsam =length(Y_2);
    zerooronebinary_Y2 = (Y_2>=Thresholdparameter);
    for index = 1:(Y_2lengthnumsam-8)
        if zerooronebinary_Y2(index)>=1
            vectorY2binzaryindex = zerooronebinary_Y2(index+1:index+8);
            if sum(vectorY2binzaryindex)>=6
                y2split = Y_2(index:index+8);
                indexfinding = find(y2split==max(y2split));
                vectorsoffindingQRS(index+indexfinding)=1;
                index=index+9;
            end
        end
    end   