close all
clear all
clc
warning off

% Genera puntos al azar
disp('Bienvenido a Reconocimiento de patrones')
disp('¿Como se van a agregar los puntos?')
disp('  1. Manualmente')
disp('  2. Automaticamente')
genera = input('');
n = input('Ingresa el número de puntos: ');
if(genera == 1)
    for i=1:n
        fprintf('Punto %d\n',i)
        cx = input('Valor en x: ');
        cy = input('Valor en y: ');
        cluster(:,i) = [cx;cy];
    end
else
    s1 = [0 0];
    s2 = [0 1];
    while s1(2) ~= s2(2)
        cluster = [randi([1 n],1,n); randi([1 n],1,n)];
        tempCluster = unique(cluster','rows');
        s1 = size(cluster);
        s2 = size(tempCluster');
    end
end
% cluster = [0 0 1 3 1; 0 4 0 0 3];
% n = 5;
cluster
clusterX = cluster(1,:);
clusterY = cluster(2,:);
indices = 1:n;

% Grafica el Cluster
% figure(1)
% plot(clusterX,clusterY,'ko','MarkerFaceColor','k')
% grid on

% Crea la tabla
tabla = zeros(n);
for i=1:n
    for j=1:n
        if i ~= j
            tabla(i,j) = abs(clusterX(i)-clusterX(j)) + abs(clusterY(i)-clusterY(j));
        end
    end
end

% Ciclo
for i=0:n-2
    minimo = min(tabla(tabla>0));
    pos = find(tabla==minimo);
    p1 = mod(pos(1)-1,n-i)+1;
    p2 = floor((pos(1)-1)/(n-i))+1;
    nuevo = min(tabla(p1,:),tabla(p2,:));
    tabla = [tabla ; nuevo];
    nuevo = [nuevo 0];
    tabla = [tabla nuevo'];
    tabla(max(p1,p2),:) = [];
    tabla(:,max(p1,p2)) = [];
    tabla(min(p1,p2),:) = [];
    tabla(:,min(p1,p2)) = [];
    indices(end+1) = n+i+1;
    puntos(i+1,:) = [n+i+1 indices(p1) indices(p2) minimo];
    indices(p1) = [];
    indices(p2) = [];
end

% Grafica el dendrograma
Z = puntos(:,2:end);
figure(2)
dendrogram(Z);
hold on