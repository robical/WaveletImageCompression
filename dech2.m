function [app dh dv dd]=dech2(img,lo,hi)

l1=size(img,1);
l2=size(img,2);

%parte filtrata passa basso e decimata 2:1 x colonne
for i=1:l1
    
    st1l(i,:)=conv(img(i,:),lo);
    st1l(i,1:l2/2)=dyaddown(st1l(i,:),2);
end

%parte filtrata passa alto e decimata 2:1 per colonne

for i=1:l1
   
    st1h(i,:)=conv(img(i,:),hi);
    st1h(i,1:l2/2)=dyaddown(st1h(i,:),2);
end

%filtro ancora passa basso (x colonne) per approx e passa alto per dettagli
%orizzontali, poi decimo 2:1 per righe

%approssimazione
for i=1:size(st1l,2)
    
    st2l(:,i)=conv(st1l(:,i),lo);
    st2l(1:l1/2,i)=dyaddown(st2l(:,i),2);
end
app=st2l(1:l1/2,1:l2/2);

%dettaglio orizzontale
for i=1:size(st1l,2)
    
    st2l(:,i)=conv(st1l(:,i),hi);
    st2l(1:l1/2,i)=dyaddown(st2l(:,i),2);
end
dh=st2l(1:l1/2,1:l2/2);

%filtro passa basso e passa alto per dettaglio verticale e diagonale (x
%colonne), stavolta in ingresso c'è il filtraggio passa alto precedente,
%poi decimo 2:1 per righe

%dettaglio verticale
for i=1:size(st1h,2)
    
    st2h(:,i)=conv(st1h(:,i),lo);
    st2h(1:l1/2,i)=dyaddown(st2h(:,i),2);
end
dv=st2h(1:l1/2,1:l2/2);

%dettaglio diagonale
for i=1:size(st1h,2)
    
    st2h(:,i)=conv(st1h(:,i),hi);
    st2h(1:l1/2,i)=dyaddown(st2h(:,i),2);
end
dd=st2h(1:l1/2,1:l2/2);
