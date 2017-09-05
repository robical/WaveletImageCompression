% Scopo: Determina la scala massima raggiungibile con una decomposizione wavelet
% diadica
% 
% Variabili IN: lena= immagine originale
% 
% Variabili OUT: scala=la max scala raggiungibile

function [scala]=scal(lena)

l1=size(lena,1);
l2=size(lena,2);
lm=min(l1,l2);

i=1;
while(rem(lm,2^i)==0)
    i=i+1;
end


scala=i-1;
