function[heartrateleadvector,heartrateleadvector1, AverageHeartrate,stderror]=HRfunctionthirdpart(timevector,filteredQRSlead)
heartrateleadvector=timevector.'.*filteredQRSlead;
heartrateleadvector1=diff(heartrateleadvector(heartrateleadvector~=0));
heartrateleadvector1=60./heartrateleadvector1;
AverageHeartrate=mean(heartrateleadvector1);
stderror=std(heartrateleadvector1);
end