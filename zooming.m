% Scopo: Ricostruzione completa immagine originale a partire da decomposizione wavelet
% completa ordinata
% 
% Variabili IN: lena= img originale
%               resh= img decomposta wavelet ordinata
%               scala= massima scala di decomposizione raggiungibile
%               Lor= filtro di ricostruzione passa basso
%               Hir= filtro di ricostruzione passa alto
% 
% Variabili OUT: ap= img ricostruita              
% 

function [ap]=zooming(lena,resh,scala,in,Lor,Hir)

l=scala+1; %test iniziale
if (scala+1-l<in)
le1=size(lena,1);
le2=size(lena,2);
l=scala; %parto dalla massima scala
rit=[resh(1:le1/(2^(l-1)), 1:le2/(2^(l-1)))]; %ritaglio i dettagli più fini e l'approssimazione del livello più alto
ll1=size(rit,1);
ll2=size(rit,2);
app1=rech2(rit(1:ll1/2,1:ll2/2),rit(1:ll1/2,ll2/2+1:ll2),rit(ll1/2+1:ll1,1:ll2/2),rit(ll1/2+1:ll1,ll2/2+1:ll2),Lor,Hir);
ap=app1;

while (scala+1-l<in)
    l=l-1;
    rit=[resh(1:le1/(2^(l-1)), 1:le2/(2^(l-1)))];
    ll1=size(rit,1);
    ll2=size(rit,2);
    ap=rech2(ap,rit(1:ll1/2,ll2/2+1:ll2),rit(ll1/2+1:ll1,1:ll2/2),rit(ll1/2+1:ll1,ll2/2+1:ll2),Lor,Hir);
    
end
end
