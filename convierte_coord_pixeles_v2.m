clc
clear all
close all
warning off all

h=imread('figuras.png');
figure(1)
[m,n]=size(h);
imshow(h)
title('imagen original')
% 
dato=imref2d(size(h)); %conv coord de plano a coord pixelares
figure(2)
imshow(h,dato)
title('imagen en coord pixelares')
% 
% %%
   c1x=randi([1,710],1,100);
   c1y=randi([1,150],1,100);
%  
%  
% %   
% %  %c1y=randi(2,100)+74;
% % 
% % %  
 c2x=randi([300,500],1,100);
  c2y=randi([200,300],1,100);
% % %  
% % % %  c2x=randn(2,100)+379;
% % % %  c2y=randn(2,100)+253;
% % %  
   c3x=randi([200,750],2,100);
   c3y=randi([300,450],2,100);
% % %  
% % % %  c3x=randn(2,100)+514;
% % % %  c3y=randn(2,100)+372;
% % %  
  px=input('dame coordenadas del punto en x=')
  py=input('dame coordenadas del punto en y=')
% %   
    P=[px;py];
%    
%    figure(3)
%    impixel(h)
% %   
% %   
% %   
% % %  %%%%
% % % %% GRAFICANDO SOBRE EL PLANO DE IMAGEN
% 
 impixel(h) %extraer inf real de una imagen
       z1=impixel(h,c1x(1,:),c1y(1,:))
       z2=impixel(h,c2x(1,:),c2y(1,:));
       z3=impixel(h,c3x(1,:),c3y(1,:));
       P1=impixel(h,P(1,:),P(2,:));
% %   
   grid on
   hold on
   plot(c1x(1,:),c1y(1,:),'ob','LineWidth',1,'MarkerSize',10)
   plot(c2x(1,:),c2y(1,:),'or','LineWidth',1,'MarkerSize',10)
   plot(c3x(1,:),c3y(1,:),'og','LineWidth',1,'MarkerSize',10)
  plot(P(1,:),P(2,:),'ok','LineWidth',1,'MarkerSize',10,'MarkerFaceColor','y')
  legend('CIELO','ROCA','AGUA','PUNTO')
  title('GRAFICA DE 3 CLASES DE OBJETOS SOBRE UNA IMAGEN')
% %  
% %  
     media1=mean(z1,'omitnan')
     media2=mean(z2,'omitnan')
     media3=mean(z3,'omitnan')
% %   
    dist1=norm(P1'-media1');
   dist2=norm(P1'-media2');
   dist3=norm(P1'-media3');
% %   
   dist_tot=[dist1 dist2 dist3]
   minimo=min(min(dist_tot))
   res=find (dist_tot==minimo)
% % %   if (res==1)
% % %       res='cielo'
% % %   end
% % %   if (res==2)
% % %       res='roca'
% % %   end
% % %   if (res==3)
% % %       res='agua'
% % %   end
% %   
% %   
    fprintf('el pixel desconocido pertenece a la clase %d\n',res)
% %   
% %   
disp('fin')
