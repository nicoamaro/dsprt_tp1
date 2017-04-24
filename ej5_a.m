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

FileName_XT = ’xt.txt’;
fid_xt = fopen(FileName_XT ,’w’);
fwrite(fid_xt,x_t,’double’);
fclose(fid_xt);
FileName_HT = ’ht.txt’;
fid_ht = fopen(FileName_HT ,’w’);
fwrite(fid_ht,h_t,’double’);
fclose(fid_ht);
