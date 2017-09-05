% Algoritmo per compressione lossless e lossy di immagini con wavelet (Haar), e
% zooming
%
%
%
% Autore: Roberto Calandrini
%

close all;
clear all;
clc;

% Definizione wavelet di Haar 1D (Filtri di decomposizione e ricostruzione)
Lod=[sqrt(2)/2 sqrt(2)/2];
Hid=[-sqrt(2)/2 sqrt(2)/2];
Lor=Lod;
Hir=-Hid;

%Leggo Immagine in grayscale
lena=double(imread('Lena_grayscale.bmp'));

%Definisco la massima scala di decomposizione raggiungibile (con o senza replicazione dei bordi)
[scala]=scal(lena);


%decomposizione completa diadica con Haar wavelet
[new]=deco(lena,scala,Lod,Hid); 

%riordino la decomposizione nello stile di Matlab
[resh]=ordwave(lena,new,scala);


%definizione di alcuni parametri usati dopo
l1=size(lena,1);
l2=size(lena,2);
in=0; %livello di dettaglio iniziale

%plotta l'immagine alla risoluzione minima (approssimazione di grado più alto interpolata)
imin=resh(1:l1/2^scala,1:l2/2^scala);
imin=imresize(imin,[l1 l2]); 
figure,imagesc(imin),colormap('gray'),title('Immagine bassa risoluzione');

%menu iniziale
sce=-1;
while(sce~=0)
sce=menu('Menu elaborazione Immagine: ',...
         '1 - Compressione immagine',...
         '2 - Zoom',...
         '0- Uscita'...
         )


switch(sce)
    
    case 1
        %%1 - Compressione immagine
        [complos,complles]=compress(resh);
    case 2
        %%2 - Zoom
        sce2=menu('Quale parte dell''immagine si desidera zoomare? ',...
         '0 - Immagine intera',...
         '1 - Regione di interesse'...
         )


        switch(sce2)

        
            case 1
            %%0 - Immagine intera
            zoo=-1;
            while(zoo~=0)
            zoo=menu('Scegliere: ',...
                     '1 - Zoom IN',...
                     '2 - Zoom OUT',...
                     '0 - Uscita'...
                     )


            switch(zoo)
     
                
                
                case 1
                    %%1 - Zoom IN
                        if (in==scala)
                            disp('Massimo livello di dettaglio raggiunto');
                        else
                            in=in+1;
                            [ima]=zooming(lena,resh,scala,in,Lor,Hir);
                            imagesc(ima),colormap('gray')
                        end
                    case 2
                        %%2 - Zoom OUT
                        if (in==0)
                            disp('Operazione non possibile, questo è il livello di dettaglio più basso');
                        else
                            in=in-1; %livello di dettaglio
                            [ima]=dezoom(lena,resh,scala,in,Lor,Hir);
                            imagesc(ima),colormap('gray')
                        end
                case 3
                        %%0 - Uscita
                            disp('Uscita..');
                            
                            break;
                    otherwise,
                            disp('Scelta non valida');
                end
            end
        
            case 2
            %%1 - Regione di interesse
            subim = imcrop(imin); %dà l'immagine ritagliata con il mouse della quale si vuole lo zoom
        otherwise,
            disp('Scelta non valida');
    end
   
    case 3
    %%0- Uscita
        disp('Uscita..');
        close;
        break;
otherwise
        disp('Scelta non valida');
end 
end


%END

%Cose da fare e problemi:
%
% 1) Finire lo zoom su regioni di interesse
% 2) Capire se è sempre possibile sfruttare la sparsità
%    dell'immagine decomposta per compressione lossless
%    (idea: replicare l'immagine ai bordi fino a potenza di 2, di modo che la decomposizione diadica 
%     sia molto spinta e ne aumenti parecchio la sparsità)
%
%
%
%
%
%
%
