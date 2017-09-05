%Funzione che effettua decomposizione di un immagine con wavelet di
%Haar attraverso algoritmo efficiente a partire dalle sequenze dei filtri
%passa basso e passa alto di decomposizione 1D, e restituisce le matrici
%dei coefficienti del livello (liv)


function [app2]=declivn(img,Lo,Hi)


l1=size(img,1);
l2=size(img,2);
app2=zeros(l1,l2);

%convolvo per le righe
for i=1:size(img,1) 
    app2(i,[1:size(img,2)+1])=conv(double(img(i,:)), double(Lo));
end
%downsampling 2:1 colonne
app2(:,1:l2/2)=app2(:,1:2:l2); %ok se numero colonne è pari

%trovo approssimazione, convolvo per le colonne
for i=1:size(app2,2) 
    app2([1:size(app2,1)+1],i)=conv(double(app2(:,i)), Lo);
end
%downsampling 2:1 righe
app2(1:l1/2,:)=app2(1:2:l1,:);