clc % limpiar pantalla
close all %cierra todo
clear all %limpia todo
warning off all 
disp('welcome to pattern recognition')

%diseño de un clasificador de distancia euclideana

% metiendo las clases de pertenencia
c1=[1 2 3 2 3; 2 2 4 7 9];
c2=[3 4 7 8 9; 5 6 -1 2 3];
c3=[10 10 11 12 13; 1 7 4 -2 9];
c4=[0 -2 -3 -3 0; 0 2 4 6 4];
c5=[0 -5 -4 2 -3; -2 1 0 -1 -3];
c6=[2 6 3 0 2; -5 0 -3 -4 -1];
loop = 1
while loop==1
    p=input('Ingresa el número de práctica : ')
    switch p
       case 1
            band=1;
            %introduciendo vector desconocido:
            while band == 1
                vx=input('dame la coord del vector en x=')
                vy=input('dame la coord del vector en y=')
                vector=[vx;vy];
                umbral=1;
                if vx > 100 | vy>100
                    fprintf('el vector desconocido no pertenece a ninguna clase\n');
                    umbral=0;
                end 
                if umbral == 1
                    %GRAFICANDO LAS CLASES
                    figure(1)
                    clf
                    plot(c1(1,:),c1(2,:),'s','MarkerFaceColor','r','MarkerSize', 10)
                    grid on
                    hold on
                    plot(c2(1,:),c2(2,:),'o','MarkerFaceColor','b','MarkerSize', 10)
                    plot(c3(1,:),c3(2,:),'d','MarkerFaceColor','k','MarkerSize', 10)
                    plot(c4(1,:),c4(2,:),'^','MarkerFaceColor','y','MarkerSize', 10)
                    plot(c5(1,:),c5(2,:),'p','MarkerFaceColor','m','MarkerSize', 10)
                    plot(c6(1,:),c6(2,:),'h','MarkerFaceColor','w','MarkerSize', 10)
                    plot(vector(1,:),vector(2,:),'go','MarkerFaceColor','g','MarkerSize', 10)
                    legend('clase1','clase2','clase3','clase4','clase5','clase6','vector')
                    
                    %%% obteniendo parámetros de cada clase
                    media1=mean(c1,2);
                    media2=mean(c2,2);
                    media3=mean(c3,2);
                    media4=mean(c4,2);
                    media5=mean(c5,2);
                    media6=mean(c6,2);
                    
                    distancia1=norm(media1-vector);
                    distancia2=norm(media2-vector);
                    distancia3=norm(media3-vector);
                    distancia4=norm(media4-vector);
                    distancia5=norm(media5-vector);
                    distancia6=norm(media6-vector);
                    
                    dist_total=[distancia1,distancia2, distancia3,distancia4,distancia5,distancia6]
                    minima=min(min(dist_total))
                    encuentra=find(dist_total==minima)
                    fprintf('el vector desconocido pertenece a la clase %d\n',encuentra)
                end 
                band=input('¿Desea intentar de nuevo(1=sí,0=no)?')
                %if band == 1
                %    clf
                %end
            end 
    
       case 2
          fprintf('Practica 2')
       otherwise
          fprintf('Ingresa una practica válida')
    end
    loop=input('¿Deseas continuar?(1=Sí,0=No)')
end  

