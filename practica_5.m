close all
clc
warning off

% banderas
a = 's';
f = false;

%Bucle principal
while (strcmp(a,'s'))
    disp('Bienvenido a criterios de evaluación con clases intersectadas')
    disp('Selecciona clasificador a evaluar')
    disp('  1. Distancia Euclidiana')
    disp('  2. Distancia de Mahalanobis')
    disp('  3. Máxima Probabilidad')
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
    %vx=input('Introduce el valor del vector x: ');
    %vy=input('Introduce el valor del vector y: ');
    %vector=[vx;vy];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Se inicia el calculo requerido
    %if (clasificador==1)
    %    nclase = practica1(clases,nclases,vector);
    %elseif (clasificador==2)
    %    nclase = practica2(clases,nclases,vector);
    %else
    %    nclase = practica4(clases,nclases,vector);
    %end
    %fprintf('\nEl vector desconocido pertenece a la clase %d\n',nclase);
    eficienciaRes=criterio1(clases,nclases,nrepresentantes,clasificador);
    eficienciaCrossValidation = crossValidation(clases,nclases,nrepresentantes,clasificador);
    eficienciaHoldOne = holdOne(clases,nclases,nrepresentantes,clasificador);
    fprintf('\nEficiencia de Resustitución %0.2f%%\n',eficienciaRes);
    fprintf("\nEficiencia de Cross Validation %0.2f%%", eficienciaCrossValidation);
    fprintf("\nEficiencia de Hold on One %0.2f%%", eficienciaHoldOne);
    X = categorical({'Resustitución','Cross Validation','Hold on One'});
    res = [eficienciaRes eficienciaCrossValidation eficienciaHoldOne];
    figure('Name','Eficiencias')
    bar(X,res)
    %vplot = plot(vx,vy,'LineStyle','none','Marker','h','MarkerSize',8);
    disp('¿Quieres volver a probar? s/n')
    %cadLegend = strcat('Clase ',num2str((1:nclases)'));
    %cadLegend(nclases+1,:) = 'vector';
    %legend(cadLegend);
    a = input('','s');
    %delete(vplot);
end
disp('El programa finalizo')


% Practica 1
function noclase = practica1(clases,nclases,vector)
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
    noclase=encuentra;
    %fprintf('\nEl vector desconocido pertenece a la clase %d\n',encuentra)
end

%Practica 2
function noclase = practica2(clases,nclases,vector)
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
    noclase = encuentra;
    %fprintf('\nEl vector desconocido pertenece a la clase %d\n',encuentra)
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
        cx=input('  Ingrese el valor en x del centroide: ');
        cy=input('  Ingrese el valor en y del centroide: ');
        dx=input('  Ingrese el valor en x de la dispersión: ');
        dy=input('  Ingrese el valor en y de la dispersión: ');
        clases(1,:,i) = clases(1,:,i)*dx + cx;
        clases(2,:,i) = clases(2,:,i)*dy + cy;
        plot(clases(1,:,i),clases(2,:,i),'LineStyle','none','Marker',all_marks{mod(i,13)},'MarkerSize',8);
    end
    cadLegend = strcat('Clase ',num2str((1:nclases)'));
    legend(cadLegend);
end

% Practica 4
function noclase = practica4(clases,nclases,vector)
    % Calcula la media de las n-clases
    for i=1:nclases
        M(:,i) = mean(clases(:,:,i),2);
    end

    % Calcula la matriz de covarianza
    for i=1:nclases
        Matrix_cov(:,:,i) = (clases(:,:,i)-M(:,i))*(clases(:,:,i)-M(:,i))';
    end

    % Calcula la inversa de la matriz de covarianza
    for i=1:nclases
        Inv_Matrix_cov(:,:,i) = inv(Matrix_cov(:,:,i));
    end

    % Calcula los parámetros de cada clase
    for i=1:nclases
        ac(:,i) = 1/((2*pi)*det(Matrix_cov(:,:,i))^0.5);
        bc(:,i) = exp((-0.5)*(vector-M(:,i))'*(Inv_Matrix_cov(:,:,i))*(vector-M(:,i)));
        pc(:,i) = ac(:,i)*bc(:,i);
    end

    % Normaliza las probabilidades
    sumap = sum (pc);
    for i=1:nclases
        pnorm(:,i) = (pc(:,i)/(sumap))*100;
    end

    maximo = max(max(pnorm));
    valor=find(pnorm==maximo);
    noclase = valor;
    %fprintf('el vector desconocido pertenece a la clase%d\n',valor)
end


%Criterio de efectividad de resustitución
function efectividad = criterio1(clases,nclases,nrepresentantes,clasificador)
    matrizConf = zeros(nclases);
    noClaseReal = 0;
    noClaseClas = 0;
    for i=1:nclases
        noClaseReal = i;
        for j=1:nrepresentantes
            if (clasificador==1)
                noClaseClas = practica1(clases,nclases,clases(:,j,i));
            elseif (clasificador==2)
                noClaseClas = practica2(clases,nclases,clases(:,j,i));
            else
                noClaseClas = practica4(clases,nclases,clases(:,j,i));
            end
            matrizConf(noClaseReal,noClaseClas)=matrizConf(noClaseReal,noClaseClas)+1;
        end
    end
    matrizConfPorc = matrizConf./nrepresentantes;
    sumDiagonal = 0;

    v_eficiencia=1:nclases;
    for i=1:nclases
        v_eficiencia(i) = matrizConfPorc(i,i);
        sumDiagonal = sumDiagonal + matrizConfPorc(i,i);
    end
    efectividad = (sumDiagonal/nclases)*100;

%     figure('Name','Resustitución');
%     bar(v_eficiencia);
    %cadLegend = strcat('Clase ',num2str((1:nclases)'));
    %legend(cadLegend);
end

% Criterio de evaluación de cross validation
function eficienciaCrossValidation = crossValidation(clases,nclases,nrepresentantes,clasificador);
    
    for w=2:21
        % Creo vectores con 0s
        v_train=zeros(2,floor(nrepresentantes/2),nclases);
        v_test=zeros(2,ceil(nrepresentantes/2),nclases);
    
        % Separo en Train y Test
        r = randi([1 2],1,nrepresentantes);
        count_train = 0;
        count_test = 0;
        ultimo = 0;
        bandera = 0;
        for i=1:nrepresentantes
            if (r(i) == 1 & count_train <= (nrepresentantes/2)) 
               count_train = count_train+1; 
            end
            if (r(i) == 2 & count_test <= (nrepresentantes/2))
               count_test = count_test+1; 
            end
            if ( count_train == (nrepresentantes/2) )
                bandera = 1;
                ultimo = i+1;
                break
            end
            if ( count_test == (nrepresentantes/2))
                bandera = 2;
                ultimo = i+1;
                break
            end
            
        end
    
        for j=ultimo:nrepresentantes
            if (bandera == 1)
                r(j) = 2;
            end
            if (bandera == 2)
                r(j) = 1;
            end
        end
    
        for i=1:nclases
            count_train = 1;
            count_test = 1;
            for j=1:(nrepresentantes)
                if (r(j)==1)
                    v_train(1,count_train,i) = clases (1,j,i);
                    v_train(2,count_train,i) = clases (2,j,i);
                    count_train = count_train + 1;
                end
            end
    
            for j=1:(nrepresentantes)
                if (r(j)==2)
                    v_test(1,count_test,i) = clases (1,j,i);
                    v_test(2,count_test,i) = clases (2,j,i);
                    count_test = count_test +1;
                end
            end
    
            %plot(v_train(1,:,i),v_train(2,:,i),'LineStyle','none','Marker','diamond','MarkerSize',14);
            %plot(v_test(1,:,i),v_test(2,:,i),'LineStyle','none','Marker','square','MarkerSize',14);
        end
        vector_train = v_train;
        vector_test = v_test;
        % Creo matriz de la diagonal
        m_diag = zeros(nclases);
        
        %Clasifica y guarda en el matriz
        for i=1:nclases
            for j=1:(nrepresentantes/2)
                if (clasificador==1)
                    clasifico_en = practica1(v_train,nclases,v_test(:,j,i));
                elseif (clasificador==2)
                    clasifico_en = practica2(v_train,nclases,v_test(:,j,i));
                else
                    clasifico_en = practica4(v_train,nclases,v_test(:,j,i));
                end
                m_diag(i,clasifico_en) = m_diag(i,clasifico_en) + 1;
            end
        end
    
        acumulado = 0;
        v_eficiencia=1:nclases;
        %Saca el promedio de cada clase y el general
        for i=1:nclases
            v_eficiencia(i) = m_diag(i,i)/(nrepresentantes/2);
            acumulado = acumulado + v_eficiencia(i);
        end
    
        eficienciaCrossValidation = (acumulado / nclases)*100;
        
        %fprintf("Eficiencia de Cross Validation %0.2f%%", eficienciaCrossValidation);
        MatrizDiagonal = m_diag
    end
%     figure('Name','Cross validation');
%     bar(v_eficiencia);
    %cadLegend = strcat('Clase ',num2str((1:nclases)'));
    %legend(cadLegend);
end

% Criterio de Hold on One
function efectividad = holdOne(clases,nclases,nrepresentantes,clasificador)
    eficiencia = 0;
    for i=1:nrepresentantes*nclases
        %Divide las clases en dos conuntos: uno para entrenamiento y otro para
        %prueba
        matrizConfTemp = zeros(nclases);
        diagonal = 0;
        for j=0:i-1
            k = floor(j/nclases);
            %clasesP(:,k+1,mod(j,nclases)+1) = clasesE(:,nrepresentantes-k,mod(j,nclases)+1);
            vector = clases(:,nrepresentantes-k,mod(j,nclases)+1);

            %Llama al clasificador deseado con las clases de entremaniento
            if(clasificador == 1)
                noclase = practica1(clases,nclases,vector);
            elseif(clasificador==2)
                noclase = practica2(clases,nclases,vector);
            else
                noclase = practica4(clases,nclases,vector);
            end

            %
            matrizConfTemp(mod(j,nclases)+1,noclase) = matrizConfTemp(mod(j,nclases)+1,noclase) + 1;
        end
        
        % Calcula la diagonal
        suma = sum(matrizConfTemp,2);
        for j = 1:nclases
            if(suma(j)==0) 
                continue
            end
            matrizConfTemp(j,:) = (matrizConfTemp(j,:)/suma(j))*100;
            diagonal = diagonal + matrizConfTemp(j,j);
        end
        eficiencia = eficiencia + (diagonal/nclases);
    end
    % Regresa la efectividad 
    efectividad = eficiencia / (nrepresentantes*nclases);
end