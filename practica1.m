clc % limpiar pantalla
close all %cierra todo
clear all %limpia todo
warning off all 
disp('Welcome to pattern recognition')

%diseño de un clasificador de distancia euclideana

% metiendo las clases de pertenencia
c1=[1 2 3 2 3; 2 2 4 7 9];%arreglo en dos dimensiones. Puntos (1,2) (2,2) (3,4) (2,7) (3,9) Tamaño filaxcolumna de 2x5
c2=[3 4 7 8 9; 5 6 -1 2 3];
c3=[10 10 11 12 13; 1 7 4 -2 9];
c4=[-6 -2 -3 -3 0; 5 8 4 6 4];
c5=[0 -5 -4 -8 -3; -2 1 0 -1 -3];
c6=[2 6 3 0 2; -5 -8 -3 -4 -8];
loop = 1
while loop==1
    fprintf('1 : Clasificador con distancia euclidiana\n');
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
                if vx > 1000 | vy>1000
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
                    plot(c2(1,:),c2(2,:),'o','MarkerFaceColor','b','MarkerSize', 10) %opcionalmente se puede poner plot(c2(1,:),c2(2,:),'ob')
                    %c3=[10 10 11 12 13; 1 7 4 -2 9];
                    %c3(1,:) toma los valores de [10,10,11,12,13]
                    %c3(2,:) toma los valores de [1,7,4,-2,9]
                    plot(c3(1,:),c3(2,:),'d','MarkerFaceColor','k','MarkerSize', 10)
                    plot(c4(1,:),c4(2,:),'^','MarkerFaceColor','y','MarkerSize', 10)
                    plot(c5(1,:),c5(2,:),'p','MarkerFaceColor','m','MarkerSize', 10)
                    plot(c6(1,:),c6(2,:),'h','MarkerFaceColor','w','MarkerSize', 10)
                    plot(vector(1,:),vector(2,:),'go','MarkerFaceColor','g','MarkerSize', 10)
                    legend('clase1','clase2','clase3','clase4','clase5','clase6','vector')
                    
                    %%% obteniendo parámetros de cada clase
                    %Se obtiene un vector del tipo [x;y]
                    %M = mean(A,dim)
                    %dim = cantidad de filas
                    media1=mean(c1,2);
                    media2=mean(c2,2);
                    media3=mean(c3,2);
                    media4=mean(c4,2);
                    media5=mean(c5,2);
                    media6=mean(c6,2);
                    
                    %Regresa la magnitud del vector 
                    distancia1=norm(media1-vector);
                    distancia2=norm(media2-vector);
                    distancia3=norm(media3-vector);
                    distancia4=norm(media4-vector);
                    distancia5=norm(media5-vector);
                    distancia6=norm(media6-vector);
                    
                    dist_total=[distancia1,distancia2, distancia3,distancia4,distancia5,distancia6]
                    %minima=min(min(dist_total))
                    minima= min(dist_total)
                    %Regresa el indice de la distancia mínima
                    encuentra=find(dist_total==minima)
                    fprintf('el vector desconocido pertenece a la clase %d\n',encuentra)
                end 
                band=input('¿Desea intentar de nuevo(1=sí,0=no)?')
            end 
    
       case 2
          fprintf('Practica 2')
       otherwise
          fprintf('Ingresa una práctica válida\n\n')
    end
    loop=input('¿Deseas continuar?(1=Sí, 0=No)')
end  

