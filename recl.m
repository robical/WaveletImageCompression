function [app]=recl(Aj,Dhj,Dvj,Ddj,lo,hi)

%Variabili in ingresso:
%
% tra: matrice della decomposizione wavelet completa
% lo: filtro passa basso di ricostruz wavelet
% hi: filtro passa alto di ricostruz wavelet
l1=size(Aj,1);
l2=size(Aj,2);


%ricostruzione approssimazione
%prima parte
Aj=dyadup(Aj,'r',1);  %upsample per righe
Dhj=dyadup(Dhj,'r',1);    %upsample per righe

if(l2==1)
ta=conv(Aj(:,1),lo);
tempap(:,1)=wkeep(ta,size(Aj,1));
th=conv(Dhj(:,1),hi);
tempdh(:,1)=wkeep(th,size(Dhj,1));
else
    
for i=1:l2/2          %filtraggio per colonne
ta=conv(Aj(:,i),lo);
tempap(:,i)=wkeep(ta,size(Aj,1));
th=conv(Dhj(:,i),hi);
tempdh(:,i)=wkeep(th,size(Dhj,1));
end
end
temp=tempap+tempdh;
temp=dyadup(temp,'c',1); %upsample colonne

if(l1==1)
    t1=conv(temp(1,:),lo);
    tnew(1,:)=wkeep(t1,size(temp,2));
else
for i=1:l1/2          %filtraggio per righe
    t1=conv(temp(i,:),lo);
    tnew(i,:)=wkeep(t1,size(temp,2));
end
end

%seconda parte
Dvj=dyadup(Dvj,'r',1);  %upsample righe
Ddj=dyadup(Ddj,'r',1);  %upsample righe

if(l2==1)
    tv=conv(Dvj(:,1),lo);
    tempdv(:,1)=wkeep(tv,size(Dvj,1));
    td=conv(Ddj(:,1),hi);
    tempdd(:,1)=wkeep(td,size(Ddj,1));
else
for i=1:l2/2      %filtraggio per colonne
    tv=conv(Dvj(:,i),lo);
    tempdv(:,i)=wkeep(tv,size(Dvj,1));
    td=conv(Ddj(:,i),hi);
    tempdd(:,i)=wkeep(td,size(Ddj,1));
end
end

temp=tempdv+tempdd;
temp=dyadup(temp,'c',1);  %upsample per colonne

if(l1==1)
    t2=conv(temp(1,:),hi);
    tnew2(1,:)=wkeep(t2,size(temp,2));
else
for i=1:l1/2           %filtraggio per righe
    t2=conv(temp(i,:),hi);
    tnew2(i,:)=wkeep(t2,size(temp,2));
end
end

%Ottengo approssimazione livello (l-1)
app=tnew+tnew2;

