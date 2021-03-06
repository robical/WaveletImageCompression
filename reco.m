% Scopo: Ricostruzione completa immagine originale a partire da decomposizione wavelet
% completa ordinata
% 
% Variabili IN: lena= img originale
%               resh= img decomposta wavelet ordinata
%               scala= massima scala di decomposizione raggiungibile
%               Lor= filtro di ricostruzione passa basso
%               Hir= filtro di ricostruzione passa alto
%               le1= numero righe dell'img originale
%               le2= numero colonne dell'img originale
% Variabili OUT: ap= img ricostruita              
% 

function [ap]=reco(le1,le2,resh,scala,Lor,Hir)


lmax=scala;
rit=[resh(1:2*le1/(2^lmax), 1:2*le2/(2^lmax))];
ll1=size(rit,1);
ll2=size(rit,2);
app1=rech2(rit(1:ll1/2,1:ll2/2),rit(1:ll1/2,ll2/2+1:ll2),rit(ll1/2+1:ll1,1:ll2/2),rit(ll1/2+1:ll1,ll2/2+1:ll2),Lor,Hir);
ap=app1;
for l=(lmax-1):-1:1
    rit=[resh(1:2*le1/(2^l), 1:2*le2/(2^l))];
    ll1=size(rit,1);
    ll2=size(rit,2);
    ap=rech2(ap,rit(1:ll1/2,ll2/2+1:ll2),rit(ll1/2+1:ll1,1:ll2/2),rit(ll1/2+1:ll1,ll2/2+1:ll2),Lor,Hir);
end

