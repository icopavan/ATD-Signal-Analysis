%Exercicio 4

close all;
clear all;
clc

%4.1
disp('4.1');
file = 'saxriff.wav';

info = audioinfo(file);
nbits = info.BitsPerSample;
 
[y, fs] = audioread(file);
sound(y, fs);

pause();

ws= 2 * pi * fs;

size_y = length(y);
x = fftshift(fft(y));

if mod(size_y, 2) == 0
    f = -ws/2 : ws/size_y : (ws/2) - (ws/size_y);
else
    f = -ws/2 + ((ws/2)/size_y): ws/size_y: (ws/2) - ((ws/2)/size_y);
end

figure(1), plot(f, abs(x)), title('Magnitude do espectro do sinal');

