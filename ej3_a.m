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

% Parmetros extra para demostracin
N2 = 3600;
t2 = 0:max(t)/(N2-1):max(t);

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
% Senoidal 1 kHz
%-------------------------------------
Amp=1;
fsig1=1*kHz;
fsig2 = 13 * kHz;
ph=0;
x_t1 = Amp * sin(2*pi*fsig1*t+ph);
x_t2 = Amp * sin(2*pi*fsig2*t+ph);
x_t22 = Amp * sin(2*pi*fsig2*t2+ph);


X_f1 = abs(fft(x_t1))/N ;
X_f1_shift = fftshift(X_f1);
X_f1_halfspec = X_f1(Index_halfspec) ;
X_f2 = abs(fft(x_t2))/N ;
X_f2_shift = fftshift(X_f2);
X_f2_halfspec = X_f2(Index_halfspec) ;
figure
subplot(411);
plot(t,x_t1,’.’);
title(’Senoidal 1 kHz: seal temporal’)
ylabel(’x_{t1}’);
xlabel(’tiempo [sec]’)
subplot(412);
%plot(f,X_f);
stem(f,X_f1,’.’);
title(’Senoidal 1 kHz: Modulo del espectro’)

ylabel(’X_{f1}’);
xlabel(’frec [Hz]’)
subplot(413);
%plot(f_shift ,X_f_shift);
stem(f_shift ,X_f1_shift ,’.’);
title(’Senoidal 1 kHz: Modulo del espectro shifteado’)
ylabel(’X_{f1}_{shift}’);
xlabel(’frec [Hz]’)
subplot(414);
%plot(f_halfspec ,X_f_halfspec);
stem(f_halfspec ,X_f1_halfspec ,’.’);
title(’Senoidal 1 kHz: Medio Espectro’)
ylabel(’X_{f1}_{half}’);
xlabel(’frec [Hz]’)
set(gcf, ’Color’, ’w’);
export_fig ej3a-sen1k.png -m4

figure
subplot(411);
plot(t,x_t2,’.’);
title(’Senoidal 13 kHz: seal temporal’)
ylabel(’x_{t2}’);
xlabel(’tiempo [sec]’)
subplot(412);
stem(f,X_f2,’.’);
title(’Senoidal 13 kHz: Modulo del espectro’)
ylabel(’X_{f2}’);
xlabel(’frec [Hz]’)
subplot(413);
stem(f_shift ,X_f2_shift ,’.’);
title(’Senoidal 13 kHz: Modulo del espectro shifteado’)
ylabel(’X_{f2}_{shift}’);
xlabel(’frec [Hz]’)
subplot(414);
stem(f_halfspec ,X_f2_halfspec ,’.’);
title(’Senoidal 13 kHz: Medio Espectro’)
ylabel(’X_{f2}_{half}’);
xlabel(’frec [Hz]’)
set(gcf, ’Color’, ’w’);
export_fig ej3a-sen13k.png -m4
figure;
plot(t2, x_t22, ’r’);
hold on
plot(t,x_t2,’b.’);
title(’Seal de 13 kHz sampleada a distinta Fs’)
ylabel(’x_{t}’);
xlabel(’tiempo [sec]’)
axis([0 0.00175 -1 1]);
legend(’Fs = 360 kHz’,’Fs = 12 kHz’);
set(gcf, ’Color’, ’w’);
export_fig ej3a-comp.png -m4
