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
Fs = 12*khz;
Ts = 1/Fs ;
N = 120;
Resp=Fs/N;

t = (0:N-1)*Ts;

% Eje de frecuencias
f = (0:N-1)*Resp;

% Eje de frecuencia para espectro centrado en cero
f_shift = (-N/2:N/2-1)*Resp;

% Indices para cuando quiero quedarme solo con la mitad del espectro
% Para N par

Index_halfspec=1:((N/2)+1);

%
% Para N impar
%Index_halfspec = 1 : ( ((N-1)/2) + 1 );

% Eje de frecuencia para medio espectro
f_halfspec = f(Index_halfspec);

% Inicio de aplicacion %
%-------------------------------------
% Senoidal 1
%-------------------------------------
Amp=1;
fsig=100*Hz;
ph=0;
x_1 = Amp * sin(2*pi*fsig*t+ph);

%-------------------------------------
% Senoidal 2
%-------------------------------------
Amp=1;
fsig=1550*Hz;
ph=0;
x_2 = Amp * sin(2*pi*fsig*t+ph);

%-------------------------------------
% Senoidal 1
%-------------------------------------
Amp=1;
fsig=3000*Hz;
ph=0;
x_3 = Amp * sin(2*pi*fsig*t+ph);
x_t=x_1+x_2+x_3;

X_f = abs(fft(x_t))./N ;
str = [’Potencia de la seal en el dominio del tiempo: ’ num2str(Func_Potencia_Temporal(x_t))];
disp(str);
str =[’Potencia de la seal en el dominio de la frecuencia: ’ num2str(Func_Potencia_Frecuencial(X_f))];
disp(str);
