close all
clc
warning off
disp('El algoritmo de la cadena');
%Alemania 450
x = randi([0 1200],1,300);
y = randi([0 700],1,300);
alemania = cat(1,x,y);

%Colombia 250
x = randi([0 560],1,300);
y = randi([0 360],1,300);
colombia = cat(1,x,y);

%Francia 1600
x = randi([0 3700],1,300);
y = randi([0 2500],1,300);
francia = cat(1,x,y);

forloop = 1;
while forloop == 1
    disp('0 : Francia\n');
    disp('1 : Colombia\n');
    disp('2 : Alemania\n');
    disp('3 : Salir');
    pais = input('Ingresa un país : \n');
    umbral=input('Ingresa un umbral : ');
    if pais == 0
        grupos = crearGrupos(francia,umbral);
    elseif pais == 1
        grupos = crearGrupos(colombia,umbral);
    elseif pais == 2
        grupos = crearGrupos(alemania,umbral);
    else
        forloop = 0;
    end
    if forloop == 1
        plotear(grupos,pais);
    end
end

function plotear(grupos,pais)
    clf;
    axis on;
    if pais == 0
        imshow('Francia.jpg');
    elseif pais == 1 
        imshow('Colombia.jpg');
    else 
        imshow('Alemania.png');
    end
    grid on;
    hold on;
    for k=1:size(grupos,3)
        plotArr = [grupos(1,1,k) ; grupos(2,1,k)];
        for l=2:size(grupos,2)
            if (~isnan(grupos(1,l,k)))
                plotArr = cat(2,plotArr,grupos(:,l,k));
            end
        end
        plot(plotArr(1,:),plotArr(2,:),'LineStyle','none','Marker','h','MarkerSize',8);
    end
end

function grupos = crearGrupos(pais,umbral)
    %Inicializa el primer grupo con el punto 
    grupos=zeros(2,1,1);
    grupos(:,1,1) = pais(:,1);
    for i=2:size(pais,2)
        dists = 0;
        for j=1:size(grupos,3)
            %Media del grupo
            mediaGrupo = mean(grupos(:,:,j),2,'omitnan');
            %Distancia del punto a media del grupo
            dist =  norm(pais(:,i)-mediaGrupo);
            if(j==1)
                dists(1,1) = dist;
            else
                dists = cat(2,dists,dist);
            end
        end
        minDist=min(min(dists));
        numGrupo=find(dists==minDist);
        if(size(numGrupo,2)>1)
            numGrupo=numGrupo(1);
        end
        if(minDist<umbral)
            %Agrega punto a un grupo
            grupos(:,end+1,numGrupo) = pais(:,i);
            for x=1:size(grupos,3)
                if(x ~= numGrupo)
                    grupos(:,end,x)=NaN;
                end
            end
        else
            %Crea un nuevo grupo
            nvoGrupo = zeros(2,1,1);
            nvoGrupo(:,1,1) = pais(:,i);
            grupos(:,1,size(grupos,3)+1) = nvoGrupo;
            for y=2:size(grupos,2)
                grupos(:,y,end)=NaN;
            end
        end
    end
end


