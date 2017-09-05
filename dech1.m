function [app det]=dech1(dat,lo,hi)

l=length(dat);

app=conv(dat,lo);
app=dyaddown(app,2);
det=conv(dat,hi);
det=dyaddown(det,2);