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
%introduciendo vector desconocido:
vx=input('dame la coord del vector en x=')
vy=input('dame la coord del vector en y=')
vector=[vx;vy];

%GRAFICANDO LAS CLASES
figure(1)
plot(c1(1,:),c1(2,:),'ro','MarkerFaceColor','r','MarkerSize', 10)
grid on
hold on
plot(c2(1,:),c2(2,:),'bo','MarkerFaceColor','b','MarkerSize', 10)
plot(c3(1,:),c3(2,:),'ko','MarkerFaceColor','k','MarkerSize', 10)
plot(vector(1,:),vector(2,:),'go','MarkerFaceColor','g','MarkerSize', 10)
legend('clase1','clase2','clase3','vector')

%%% obteniendo parámetros de cada clase
media1=mean(c1,2);
media2=mean(c2,2);
media3=mean(c3,2);

matrix_cov1=(c1-media1)*(c1-media1)';
inv_matrix_cov1=inv(matrix_cov1);

matrix_cov2=(c2-media2)*(c2-media2)';
inv_matrix_cov2=inv(matrix_cov2);

matrix_cov3=(c3-media3)*(c3-media3)';
inv_matrix_cov3=inv(matrix_cov3);

dist1=(vector-media1)'*inv_matrix_cov1*(vector-media1);
dist2=(vector-media2)'*inv_matrix_cov2*(vector-media2);
dist3=(vector-media3)'*inv_matrix_cov3*(vector-media3);

dist_total=[dist1 dist2 dist3];
minimo=min(min(dist_total));
dato1=find(minimo==dist_total);

fprintf('el vector desconocido pertenece a la clase%d\n',dato1)

disp('fin de proceso...')