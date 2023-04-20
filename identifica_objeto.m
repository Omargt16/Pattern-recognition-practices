clc
clear all
close all
warning off all

img=imread('C:\Users\datre\OneDrive\Documentos\PatRec\imagenes\db_image_26.jpg');
bw=im2bw(img);
s=strel('disk',3);
bw=imdilate(bw,s);
[L N] = bwlabel(bw);
figure;
imshow(L);
objetos=regionprops(L,'Perimeter','Area','Extent');

%iniciando conteo de objetos geométricos
for k=1:length(objetos)
    disp(objetos(k));
    caja=objetos(k).BoundingBox;

    if(objetos(k).Area>10000)
        rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','b','Linewidth',2)
    else
        rectangle('Position',[caja(1),caja(2),caja(3),caja(4)],'EdgeColor','r','Linewidth',2)
    end


    if(objetos(k).Perimeter^2/objetos(k).Area>18)

        text(objetos(k).Centroid(1),objetos(k).Centroid(2),'TRIANGULO','Color','r');

    elseif(objetos(k).Perimeter^2/objetos(k).Area<14.3)
        text(objetos(k).Centroid(1),objetos(k).Centroid(2),'CIRCULO','Color','g');
    else
         text(objetos(k).Centroid(1),objetos(k).Centroid(2),'CUADRADO','Color','g');

    
    end
end
hold on
disp('fin de proceso...')