% Exercicio 5

close all;
clc

opcao = menu('Escolha o som:', 'piano-phrase.wav', 'sax-phrase-short.wav');
if(opcao == 1)
    file = 'piano-phrase.wav';
elseif(opcao == 2)
    file = 'sax-phrase-short.wav';
end

info = audioinfo(file);
nbits = info.BitsPerSample;

[y, fs] = audioread(file);

if size(y, 2) == 2
    temp = zeros(length(y), 1);
    for i = 1:length(y)
        temp(i) = (y(i, 1) + y(i, 2)) / 2;
    end
    y = temp;
end

sound(y, fs);

pause();

t = 0:seconds(1/fs):seconds(info.Duration);
t = t(1:end-1);

disp(['fs = ' num2str(fs)]);
disp(['Duracao som: ' num2str(info.Duration)]);

ws = 2*pi*fs;

size_y = length(y);
x = fftshift(fft(y));

if mod(size_y, 2) == 0
    f = -ws/2 : ws/size_y : (ws/2) - (ws/size_y);
else
    f = -ws/2 + ((ws/2)/size_y): ws/size_y: (ws/2) - ((ws/2)/size_y);
end

figure(1), plot(y), title(['Sinal de Áudio ' file]), xlabel('Tempo (ms)'), ylabel('Sinal');
figure(2), plot(f, abs(x)), title(['Magnitude do espectro do sinal ', file]), xlabel('Frequencia (Hz)'), ylabel('Magnitude Sinal');

% 5.2
frequencia_notas = [262 277 294 311 330 349 370 392 415 440 466 494];
nome_notas = {'Do   ';'Do#  ';'Re   ';'Re#  ';'Mi   ';'Fa   ';'Fa#  ';'Sol  ';'Sol# ';'La   ';'La#  ';'Si   '};

janela = input('Tamanho da janela = ');
janela = round(janela/1000*fs);

% Janela de 2048 | try metade ou dobro
% balancear passo maior

sobreposicao = round(janela/8);
disp(['Frequencia fs = ' num2str(fs)]);
disp(['janela = ' num2str(janela)]);
N = janela;

if (mod(size_y, 2) == 0)
    f = linspace(-fs/2, fs/2 - fs/N, N);
else
    f = linspace(-fs/2 + fs/(2*N), fs/2 - fs/(2*N), N);
end

matrix_sizeofX = 1: N-sobreposicao: size_y-N;

freqs = zeros(size(matrix_sizeofX));
amps = zeros(size(matrix_sizeofX));

j=1;
indice = find(f >= 100, 1);
for i=1: N-sobreposicao: size_y-N
    janela_x = fftshift(fft(y(i : i+N-1) .* hamming(N), N));
    [x_abs_max, ind] = max(abs(janela_x(indice: end)));
    
    amps(j) = x_abs_max;
    freqs(j) = abs(f(ind + indice - 1));
    j = j + 1;
end

figure(2);
plot(1: janela*1000/fs-sobreposicao*1000/fs : size_y/fs*1000 - janela*1000/fs, freqs, '.');
title(['Frequencias fundamentais ' file]);
xlabel('ms');
ylabel('Hz');
disp('Press any key to continue');
pause();    

fprintf('Resolucao em Frequencia do som %s = %.2f \n', file, fs/N);
disp('Press any key to continue');
pause();

fprintf('Notas do som %s\n', file);
disp(frequencia_notas);
disp(nome_notas);
for i=1 : length(freqs)
    freq = freqs(i);
    if freq ~= 0
        while(freq < frequencia_notas(1))
            freq = freq*2;
        end
        while(freq > frequencia_notas(end))
            freq = freq/2;
        end
        for j=1: length(frequencia_notas)
            if(freq < frequencia_notas(j))
                break;
            end
        end
        if(j ~= 1)
            if(abs(freq-frequencia_notas(j-1)) <= abs(freq - frequencia_notas(j)))
                j = j-1;
            end
        end
        fprintf('%-5s %.2f Hz\n', nome_notas{j}, freqs(i));
    end
end