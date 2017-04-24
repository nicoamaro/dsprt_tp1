% Inicializacion del entorno
%
clc;        % limpia la consola
clear;      % borra workspace
close all;  % cierra los graficos
fclose all; % cierra archivos

% En caso de tener dependencias agregarlas en este lugar
%
addpath(fullfile(pwd,’..’,’export_fig’));
% Unidades %
seg =1;
ms =1e-3*seg;
us =1e-3*ms;
ns =1e-3*us;
%
Hz =1/seg;
khz=1/ms;
Mhz=1/us;
Ghz=1/ns;

% Inicializacion %
Fs = 1*khz;
Ts = 1/Fs ;
N = 1000;
Resp=Fs/N;

t = (0:N-1)*Ts;

% Eje de frecuencias
f = (0:N-1)*Resp;

% Eje de frecuencia para espectro centrado en cero
f_shift = (-N/2:N/2-1)*Resp ;

% Indices para cuando quiero quedarme solo con la mitad del espectro
% Para N par
Index_halfspec=1:((N/2)+1);
%
% Para N impar
%Index_halfspec = 1 : ( ((N-1)/2) + 1 ) ;

% Eje de frecuencia para medio espectro
f_halfspec = f(Index_halfspec);

% Inicio de aplicacion
%

%-------------------------------------
% Generacin de Seales
%-------------------------------------
Amp=0.125;
x_t = Amp * exp(-t/(100*ms));
h_t = Amp * exp(-t/(200*ms));

y_t = conv(x_t,h_t);
y_tmy = Func_MyConv(x_t, h_t);

Ny = length(x_t) + length(h_t) - 1;
tconv = (0:Ny-1) * Ts;

figure
subplot(311);
plot(t,x_t,’.’);
hold on
plot(t, h_t, ’r.’);
legend(’x(t)’, ’h(t)’);
title(’x(t) y h(t): seal temporal’)
ylabel(’x(t) y h(t)’);
xlabel(’tiempo [sec]’)
subplot(312);
plot(tconv,y_t,’.’);
title(’Convolucin nativa de MATLAB’)
ylabel(’y(t)’);
xlabel(’tiempo [sec]’)
subplot(313);
plot(tconv ,y_tmy ,’.’);
title(’Convolucin con FuncMyConv’)
ylabel(’y(t)’);
xlabel(’tiempo [sec]’)
set(gcf,’Color’,’w’);
export_fig ej4-conv.png -m4 90
diff = 0;
for(i = 1:length(y_t))
diff = diff + (y_t(i) - y_tmy(i)).^2;
end
diff = sqrt(diff);
str = [’Diferencia entre convoluciones ’ num2str(diff)];
disp(str);
