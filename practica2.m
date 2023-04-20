clc % limpiar pantalla
close all %cierra todo
clear all %limpia todo
warning off all 
disp('Welcome to pattern recognition')

%diseño de un clasificador de distancia euclideana

% metiendo las clases de pertenencia
c1=[1 2 3 2 3; 2 2 4 7 9];
c2=[3 4 7 8 9; 5 6 -1 2 3];
c3=[10 10 11 12 13; 1 7 4 -2 9];
c4=[-6 -2 -3 -3 0; 5 8 4 6 4];
c5=[0 -5 -4 -8 -3; -2 1 0 -1 -3];
c6=[2 6 3 0 2; -5 -8 -3 -4 -8];
loop = 1
while loop==1
    fprintf('1 : Clasificador con distancia euclidiana\n');
    fprintf('2 : Clasificador con criterio de Mahalanobis\n');
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
                    % c2(fila,columna)
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
            end 
    
       case 2
            vx=input('dame la coord del vector en x=')
            vy=input('dame la coord del vector en y=')
            vector=[vx;vy];
            
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
            
            %
            matrix_cov1=(c1-media1)*(c1-media1)';
            %inverse matrix
            inv_matrix_cov1=inv(matrix_cov1);
            
            matrix_cov2=(c2-media2)*(c2-media2)';
            inv_matrix_cov2=inv(matrix_cov2);
            
            matrix_cov3=(c3-media3)*(c3-media3)';
            inv_matrix_cov3=inv(matrix_cov3);

            matrix_cov4=(c4-media4)*(c4-media4)';
            inv_matrix_cov4=inv(matrix_cov4);

            matrix_cov5=(c5-media5)*(c5-media5)';
            inv_matrix_cov5=inv(matrix_cov5);

            matrix_cov6=(c6-media6)*(c6-media6)';
            inv_matrix_cov6=inv(matrix_cov6);
            
            dist1=(vector-media1)'*inv_matrix_cov1*(vector-media1)
            dist2=(vector-media2)'*inv_matrix_cov2*(vector-media2)
            dist3=(vector-media3)'*inv_matrix_cov3*(vector-media3)
            dist4=(vector-media4)'*inv_matrix_cov4*(vector-media4)
            dist5=(vector-media5)'*inv_matrix_cov5*(vector-media5)
            dist6=(vector-media6)'*inv_matrix_cov6*(vector-media6)


            dist_total=[dist1 dist2 dist3 dist4 dist5 dist6];
            minimo=min(min(dist_total));
            dato1=find(minimo==dist_total);
            
            fprintf('el vector desconocido pertenece a la clase%d\n',dato1)
       otherwise
          fprintf('Ingresa una práctica válida\n\n')
    end
    loop=input('¿Deseas continuar?(1=Sí, 0=No)')
end  

