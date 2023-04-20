close all
clc
warning off

disp('Bienvenido a Pattern Recognition')
disp('Perceptrón del cubo')

%declaración de variables
r=1;
matriz=[0,1,0,1,0,1,0,1;%z
        0,0,1,1,0,0,1,1;%x
        0,0,0,0,1,1,1,1;%y
        1,1,1,1,1,1,1,1];%x0
clase=[1,1,1,2,1,2,2,2];
ws=[1,1,1,1];
iteraciones=1
contador_num_no_cambio=1

while iteraciones > 0
    contador_num_no_cambio=1;
    for i=1:8
        if contador_num_no_cambio == 8
            iteraciones = -1;
        end

        fsal=dot(matriz(:,i).',ws);

        if (clase(i) == 1 )
            if fsal >= 0 %se actualiza
                ws(1)=ws(1)-r*matriz(1,i);
                ws(2)=ws(2)-r*matriz(2,i);
                ws(3)=ws(3)-r*matriz(3,i);
                ws(4)=ws(4)-r*matriz(4,i);
            else
                contador_num_no_cambio= contador_num_no_cambio + 1;
            end
        end
        if (clase(i) == 2 )
            if (fsal <= 0 )
                ws(1)=ws(1)+r*matriz(1,i);
                ws(2)=ws(2)+r*matriz(2,i);
                ws(3)=ws(3)+r*matriz(3,i);
                ws(4)=ws(4)+r*matriz(4,i);
            else
                contador_num_no_cambio= contador_num_no_cambio + 1;
            end
        end
        iteraciones = iteraciones + 1
        salida_ws = ws
    end 
end

%ws=[-2,2,2,-3]

%pinta los puntos y el plano
plot3(matriz(1,8),matriz(2,8),matriz(3,8),'RO')
hold on
plot3(matriz(1,7),matriz(2,7),matriz(3,7),'RO')
plot3(matriz(1,6),matriz(2,6),matriz(3,6),'RO')
plot3(matriz(1,4),matriz(2,4),matriz(3,4),'RO')
plot3(matriz(1,:),matriz(2,:),matriz(3,:),'k+')

[x,y]=meshgrid(-1:1:1)
%surf(x,y,ws(2)/ws(1)*y + ws(3)/ws(1)*x +ws(4)/ws(1), 'facecolor','#77AC30')
surf(x,y,(-ws(2)/ws(1))*x - (ws(3)/ws(1))*y -ws(4)/ws(1) , 'facecolor','#77AC30')
