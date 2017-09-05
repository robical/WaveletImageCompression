function [dat]=rech1(app,det,lo,hi)

app=dyadup(app,1);
app=conv(app,lo);
det=dyadup(det,1);
det=conv(det,hi);

datp=app+det;
dat(1:length(datp)-2)=datp(2:length(datp)-1);