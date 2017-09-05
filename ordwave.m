% Scopo: Riordina la decomposizione wavelet dell'immagine nello stile 
% di Matlab
% 
% Variabili IN: lena= img originale
%               new= decomposizione wavelet dell'img, disordinata
%               scala= massima scala raggiungibile nella decomp
%               
% Variabili OUT: resh= img decomposta ordinata              

function [resh]=ordwave(lena,new,scala)

lmax=scala;
l1=size(new,1);
l2=size(new,2);
le1=size(lena,1);
le2=size(lena,2);
in=l1-le1/2^lmax+1;
fin=l1;
resh=[new(in:fin, 1:le2/2^lmax) new(in:fin, le2/(2^lmax)+1:2*le2/2^lmax); new(in:fin, 2*le2/(2^lmax)+1:3*le2/2^lmax) new(in:fin, 3*le2/(2^lmax)+1:4*le2/2^lmax)];
for l=(lmax-1):-1:1
    in=in-le1/2^l;
    fin=fin-le1/(2^(l+1));
    resh=[resh new(in:fin, 1:le2/2^l); new(in:fin, le2/2^l+1:2*le2/2^l) new(in:fin, 2*le2/2^l+1:3*le2/2^l)];
end