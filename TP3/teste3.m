%Exercicio 3

close all;
clear all;
clc

%3.1
[img, map] = imread('lena.bmp', 'bmp');

%3.2
figure(1);
imshow(img, map);
title('lena.bmp representation');

fprintf('Press any key to continue\n');
pause();

%3.3
x_img = fftshift(fft2(img));
[nl, nc] = size(x_img);

if mod(nl, 2) == 0
    xx = -nl/2:nl/2-1;
else
    xx = fix(-nl/2):fix(nl/2);
end

if mod(nc, 2) == 0
    yy = -nc/2:nc/2-1;
else
    yy = fix(-nc/2):fix(nc/2);
end

figure(2);
mesh(xx, yy, 20*log10(abs(x_img)));
axis([xx(1) xx(end) yy(1) yy(end)]);
view([-37.5 30]);
rotate3d;
title('Image Magnitude');

cx = find(xx==0);
cy = find(yy==0);


fprintf('Medium Color'); disp(x_img(cx, cy)/(nl*nc));
fprintf('Press any button to continue\n');
pause();

%3.4 e 3.5

opcao = menu('Tipo de filtro', 'Passa-Baixo', 'Passa-Alto');

mask = zeros(size(x_img));
fc = input('Frequencia do corte = ');

for l = 1:nl
    for c = 1:nc
        if (l-cx)^2 + (c-cy)^2 <= fc^2
            mask(l,c) = 1;
        end
    end
end



if opcao == 2
    mask = ones(size(mask)) - mask;
end

figure(3);
mesh(xx, yy, mask);
rotate3d;
title('Magnitude da mascara');

fprintf('Press any key to continue\n\n');
pause();

%3.6

xfiltro = x_img .* mask;

figure(4);
mesh(xx, yy, 20*log10(abs(xfiltro)));
rotate3d;
title('Magnitude da imagem filtrada');

fprintf('Press any key to continue\n');
pause();

%3.7
imgFiltro = ifft2(ifftshift(xfiltro));

%3.8
figure(5);
imshow(real(imgFiltro), map);
title('Filtered Image');