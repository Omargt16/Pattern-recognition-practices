close all
clc
warning off

% Mensaje de bienvenida
disp('Bienvenido a Pattern Recognition')

% banderas
a = 's';
f = false;

%Bucle principal
while (strcmp(a,'s'))
    disp('Selecciona el criterio de tu clasificador:')
    disp('  1. Distancia Euclidiana')
    disp('  2. Distancia de Mahalanobis')
    clasificador = input('');
    % Se generan las clases
    if f==false
        disp('Generando las clases')
        nclases = input('   Ingrese el número de clases: ');
        nrepresentantes = input('   Ingrese el número de representantes: ');
        clases = generaClases(nclases,nrepresentantes);
        f = true;
    end
    % El usario ingresa el vector desconocido
    vx=input('Introduce el valor del vector x: ');
    vy=input('Introduce el valor del vector y: ');
    vector=[vx;vy];

    % Se inicia el calculo requerido
    if (clasificador==1)
        practica1(clases,nclases,vector)
    else
        practica2(clases,nclases,vector)
    end
    vplot = plot(vx,vy,'LineStyle','none','Marker','h','MarkerSize',8);
    disp('\nQuieres volver a probar? s/n')
    cadLegend = strcat('Clase ',num2str((1:nclases)'));
    cadLegend(nclases+1,:) = 'vector';
    legend(cadLegend)
    a = input('','s');
    delete(vplot)
end
disp('El programa finalizo')


% Practica 1
function practica1(clases,nclases,vector)
    % Calcula la media de las 6 clases
    for i=1:nclases
        M(:,i) = mean(clases(:,:,i),2);
    end
    
    % Calcula la distancia entre las medias y el vector
    for i=1:nclases
        Distancia(i) = norm(vector-M(:,i));
    end
    
    % Imprime a que clase corresponde el vector
    minima=min(min(Distancia));
    encuentra=find(Distancia==minima);
    fprintf('\nEl vector desconocido pertenece a la clase %d\n',encuentra)
end

%Practica 2
function practica2(clases,nclases,vector)
    % Calcula la media de las 6 clases
    for i=1:nclases
        M(:,i) = mean(clases(:,:,i),2);
    end
    
    % Calculo de la matriz de varianza covarianza
    for i=1:nclases
        Matrix_cov(:,:,i) = (clases(:,:,i)-M(:,i))*(clases(:,:,i)-M(:,i))';
    end

    for i=1:nclases
        Inv_Matrix_cov(:,:,i) = inv(Matrix_cov(:,:,i));
    end
    
    for i=1:nclases
        Distancia(i) = (vector-M(:,i))'*Inv_Matrix_cov(:,:,i)*(vector-M(:,i));
    end
 
    
    %Imprime a que clase corresponde el vector
    minima=min(min(Distancia));
    encuentra=find(Distancia==minima);
    fprintf('\nEl vector desconocido pertenece a la clase %d\n',encuentra)
end

% Practica 3
function clases = generaClases(nclases, nrepresentantes)
    clases=randn(2,nrepresentantes,nclases);
    all_marks = {'o','+','*','.','x','s','d','^','v','>','<','p','h'};
    A = 1:nclases;
    grid on
    hold on
    for i=A
        fprintf('Para la Clase %d\n', i)
        cx=input('  Ingrese el valor en x del centoide: ');
        cy=input('  Ingrese el valor en y del centoide: ');
        dx=input('  Ingrese el valor en x de la dispersión: ');
        dy=input('  Ingrese el valor en y de la dispersión: ');
        clases(1,:,i) = clases(1,:,i)*dx + cx;
        clases(2,:,i) = clases(2,:,i)*dy + cy;
        disp(clases(1,:,i));
        plot(clases(1,:,i),clases(2,:,i),'LineStyle','none','Marker',all_marks{mod(i,13)},'MarkerSize',8)
    end
end