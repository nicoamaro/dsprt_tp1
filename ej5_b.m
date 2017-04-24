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

y_tmy = Func_MyConv(x_t, h_t); 64
Ny = length(x_t) + length(h_t) - 1;
tconv = (0:Ny-1) * Ts;


%LECTURA Y DIFERENCIA
FileName_Result = ’result.txt’;
fid_result = fopen(FileName_Result ,’r’);
result = fread(fid_result ,’double’);
fclose(fid_result);
difference = y_tmy ’ - result;
plot(difference);
set(gcf, ’Color’, ’w’);
export_fig ej5-diff.png -m4

figure;
plot(y_tmy ,’o’);
hold on
plot(result , ’r.’);
legend(’Func\_MyConv’, ’convolucion.c’)
set(gcf, ’Color’, ’w’);
export_fig ej5-comp.png -m4
