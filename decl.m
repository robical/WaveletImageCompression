function [img]=rech2(tra,lo,hi,L)

%devo riottenere le varie approssimazioni a partire dall'ultima e i
%dettagli
%estraggo gli ultimi dettagli e l'approx
l1=size(tra,1)*2;
l2=size(tra,2)*2;

l=L;
in1=1;
in2=1;
while(l>=1)

temp1=l1/2^l;
temp2=l2/2^l;

fin1=temp1/2;
pas1=temp1/2;

pas2=temp2/2;
fin2=temp2;
if (l==L)
app=tra(in1:fin1,in2:fin2); %app livello l
end

in2=in2+pas2;
fin2=fin2+pas2;
dh=tra(in1:fin1,in2:fin2); %dett orizzontale liv l

in1=in1+pas1;
fin1=fin1+pas1;
dd=tra(in1:fin1,in2:fin2); %dettaglio diag liv l

in2=in2-pas2;
fin2=fin2-pas2;
dv=tra(in1:fin1,in2:fin2); %dett verticale liv l

%ricostruzione approssimazione
%prima parte
app=dyadup(app,'r',1);
dh=dyadup(dh,'r',1);

for i=1:l2/2^l
tempap(:,i)=conv(app(:,i),lo);
tempdh(:,i)=conv(dh(:,i),hi);
end

temp=tempap+tempdh;
temp=dyadup(temp,'c',1);

for i=1:l1/2^l
    tnew(i,:)=conv(temp(i,:),lo);
    tnew(i,1:length(temp)-1)=tnew(i,2:length(tnew)-1);
end

%seconda parte
dv=dyadup(dv,'r',1);
dd=dyadup(dd,'r',1);

for i=1:l2/2^l
    tempdv(:,i)=conv(dv(:,i),lo);
    tempdd(:,i)=conv(dd(:,i),hi);
end

temp=tempdv+tempdd;
temp=dyadup(temp,'c',1);

for i=1:l1/2^l
    tnew2(i,:)=conv(temp(i,:),hi);
    tnew2(i,1:length(temp)-1)=tnew2(i,2:length(tnew2)-1);
end

%Ottengo approssimazione livello (l-1)
app=tnew+tnew2;
l=l-1;
end
img=app;