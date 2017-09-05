% Funzione: ricostruzione diadica con wavelet Haar di un immagine dati gli
% IN: A=approssimaz livello precedente
%     Dh=dettaglio orizz
%     Dv=verticale
%     Dd= diagonale
%     lo=filtro di ricostruzione passa basso
%     hi=filtro ricostruzione passa alto


function [app]=rech2(A,Dh,Dv,Dd,lo,hi)

s1=size(A,1);
s2=size(A,2);
l=length(lo);
h=length(hi);

A=dyadup(A,'r',1);
Dh=dyadup(Dh,'r',1);
%è cambiato il numero di righe

tempap=zeros(size(A,1)+l-1,s2);
tempdh=zeros(size(Dh,1)+l-1,s2);
for v=1:s2
    tempap(:,v)=conv(A(:,v),lo);
    tempdh(:,v)=conv(Dh(:,v),hi);
end

%è cambiato il numero delle righe di interesse, dopo l'upsample

temp1=tempap+tempdh;
temp1=dyadup(temp1,'c',1); %ora è cambiato anche il numero di colonne
temp4=zeros(size(temp1,1),size(temp1,2)+l-1);
for i=1:size(temp1,1) %per ogni riga
    temp4(i,:)=conv(temp1(i,:),lo);
end
%temp4 è pronta

%ora i dettagli verticali e diagonali
Dv=dyadup(Dv,'r',1);
Dd=dyadup(Dd,'r',1);
tempdv=zeros(size(Dv,1)+l-1,s2);
tempdd=zeros(size(Dd,1)+l-1,s2);
for v=1:s2
    tempdv(:,v)=conv(Dv(:,v),lo);
    tempdd(:,v)=conv(Dd(:,v),hi);
end

temp2=tempdv+tempdd;
temp2=dyadup(temp2,'c',1);
temp3=zeros(size(temp2,1),size(temp2,2)+h-1);
for i=1:size(temp2,1) %per ogni riga
    temp3(i,:)=conv(temp2(i,:),hi);
end
%ho anche temp3
temp5=temp3+temp4;
%ritaglio
app=wkeep(temp5,[s1*2,s2*2]);
        