% Scopo: funzione di decomposizione completa wavelet fino alla scala
% massima possibile
%
% Variabili IN: lena=immagine originale
%               scala=scala massima ottenibile ottenuta dal comando "scal"
%               Lod= filtro passa bassa equivalente alla scaling function
%               Hid= filtro passa alto, la wavelet
%
% Variabili OUT: new=decomposizione wavelet dell'immagine
%
%
function [new]=deco(lena,scala,Lod,Hid)

app=lena; %l'img di partenza è la prima approx
[app dh dv dd]=dech2(app,Lod,Hid);
new=[dh dv dd];
for k=2:scala
    [app dh dv dd]=dech2(app,Lod,Hid);
    if (k==scala)
    new=[new;app dh dv dd zeros(size(dh,1),size(new,2)-size(dh,2)*4)];
    else
        new=[new; dh dv dd zeros(size(dh,1),size(new,2)-size(dh,2)*3)];
    end
end