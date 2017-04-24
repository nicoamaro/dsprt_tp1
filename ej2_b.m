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
Fs = 1001*khz;
Ts = 1/Fs ;
N = 1001;
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
% Cuadrada
%-------------------------------------
Amp=0.5;
fsig=10*Hz;
ph=0;
duty = 50;
x_t=Amp*square(2*pi*fsig*t+ph, duty) + Amp;

X_f = abs(fft(x_t))/N ;
X_f_shift = fftshift(X_f);
X_f_halfspec = X_f(Index_halfspec) ;
figure
subplot(411);
plot(t,x_t,’.’);
title(’Cuadrada: seal temporal’)
ylabel(’x_t’);
xlabel(’tiempo [sec]’)
subplot(412);
stem(f,X_f,’.’);
title(’Cuadrada: Modulo del espectro’)
ylabel(’X_f’);
xlabel(’frec [Hz]’)
subplot(413);
stem(f_shift ,X_f_shift ,’.’);
title(’Cuadrada: Modulo del espectro shifteado’)
ylabel(’X_f_{shift}’);
xlabel(’frec [Hz]’)
subplot(414);
stem(f_halfspec ,X_f_halfspec ,’.’);
title(’Cuadrada: Medio Espectro’);
ylabel(’X_f_{half}’);
xlabel(’frec [Hz]’)
set(gcf, ’Color’, ’w’);
export_fig ej2b -sq.png -m4
