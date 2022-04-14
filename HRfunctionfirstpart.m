function[heartrateleadvector, AverageHeartrate,stderror]=HRfunctionfirstpart(timevector,filteredQRSlead)
heartrateleadvector=timevector.'.*filteredQRSlead;
heartrateleadvector=diff(heartrateleadvector(heartrateleadvector~=0));
heartrateleadvector=60./heartrateleadvector;
AverageHeartrate=mean(heartrateleadvector);
stderror=std(heartrateleadvector);
end