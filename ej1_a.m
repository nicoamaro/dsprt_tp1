% Inicializacion del entorno
%
clc;
clear; close all; fclose all;
% limpia la consola
% borra workspace
% cierra los graficos % cierra archivos

% En caso de tener dependencias agregarlas en este lugar
addpath(fullfile(pwd,’..’,’export_fig’));

% Unidades %
seg =1;
ms =1e-3*seg us =1e-3*ms ns =1e-3*us
%
Hz =1/seg; khz=1/ms ; Mhz=1/us ; Ghz=1/ns ;
% Inicializacion %
Fs =12*khz; Ts = 1 / Fs ; N =120 ; Resp=Fs/N;
t = (0:N-1)*Ts ;

% Eje de frecuencias
f = (0:N-1)*Resp ;
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
 % Senoidal
 %-------------------------------------
 Amp=1;
 fsig=500*Hz;
 ph=0;
 x_t = Amp * sin(2*pi*fsig*t+ph);

 X_f = abs(fft(x_t))/N ;
 X_f_shift = fftshift(X_f);
 X_f_halfspec = X_f(Index_halfspec) ;
 figure
 subplot(411);
 plot(t,x_t,’.’);
 title(’Senoidal: seal temporal’)
 ylabel(’x_t’);
 xlabel(’tiempo [sec]’)
 subplot(412);
 stem(f,X_f,’.’);
 title(’Senoidal: Modulo del espectro’)
 ylabel(’X_f’);
 xlabel(’frec [Hz]’)
 subplot(413);
 stem(f_shift ,X_f_shift ,’.’);
 title(’Senoidal: Modulo del espectro shifteado’)
 ylabel(’X_f_{shift}’);
 xlabel(’frec [Hz]’)
 subplot(414);

 stem(f_halfspec ,X_f_halfspec ,’.’);
 title(’Senoidal: Medio Espectro’)
 ylabel(’X_f_{half}’);
 xlabel(’frec [Hz]’)
 set(gcf, ’Color’, ’w’);
 export_fig ej1a -sen.png -m4
 %-------------------------------------
 % Cuadrada
 %-------------------------------------
 Amp=1;
 fsig=500*Hz;
 duty = 50 ; % entre 0-100
 x_t = Amp * square(2*pi*fsig*t,duty);
 103
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
 title(’Cuadrada: Medio Espectro’)
 ylabel(’X_f_{half}’);
 xlabel(’frec [Hz]’)
 set(gcf, ’Color’, ’w’);
 export_fig ej1a -sq.png -m4
 %-------------------------------------
 % Diente de sierra
 %-------------------------------------
 Amp=1;
 fsig=500*Hz;
 width = 0.5 ; % entre 0-1
 x_t = Amp * sawtooth(2*pi*fsig*t,width);
 141
 X_f = abs(fft(x_t))/N ;
 X_f_shift = fftshift(X_f);
 X_f_halfspec = X_f(Index_halfspec) ;

 figure
 subplot(411);
 plot(t,x_t,’.’);
 title(’Diente de sierra: seal temporal’)
 ylabel(’x_t’);
 xlabel(’tiempo [sec]’)
 subplot(412);
 stem(f,X_f,’.’);
 title(’Diente de sierra: Modulo del espectro’)
 ylabel(’X_f’);
 xlabel(’frec [Hz]’)
 subplot(413);
 stem(f_shift ,X_f_shift ,’.’);
 title(’Diente de sierra: Modulo del espectro shifteado’)
 ylabel(’X_f_{shift}’);
 xlabel(’frec [Hz]’)
 subplot(414);
 stem(f_halfspec ,X_f_halfspec ,’.’);
 title(’Diente de sierra: Medio Espectro’)
 ylabel(’X_f_{half}’);
 xlabel(’frec [Hz]’)
 set(gcf, ’Color’, ’w’);
 export_fig ej1a -saw.png -m4
