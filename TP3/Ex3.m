%%% EX 3

close all;
clc;

% 3.1
[img, color_map, transparency] = imread('Peppers.bmp');
figure(1);
imshow(img, color_map);
title('Representacao de Peppers.bmp');

[linhas, colunas] = size(img); % 512 x 512

% 3.3
F = fftshift(fft2(double(img)));

xx = -linhas/2:linhas/2-1;
yy = -colunas/2:colunas/2-1;

cx = find(xx==0);
cy = find(yy==0);

disp(F(cx, cy)/(linhas*colunas));


figure(2);
mesh(xx, yy, 20*log10(abs(F)));
axis([xx(1) xx(end) yy(1) yy(end)]);
view([-37.5 30]);
rotate3d;
title('Magnitude da Imagem');

[X,Y] = meshgrid(1:linhas, 1:colunas);

option = menu('Escolher Filtro','Passa-Baixo','Passa-Alto');
fc = input('Frequencia de corte = ');
figure(3);
if option == 1
    mask = zeros(linhas);
    mask((linhas/2)-fc:(linhas/2)+fc, (colunas/2)-fc:(colunas/2)+fc) = 1;
    mask = double(mask);
    mesh(mask);
    title(['Magnitude Mascara Passa-Baixo Frequencia ' num2str(fc)]);
    ft = 'Passa-Baixo';
else
    mask = ones(linhas);
    mask((linhas/2)-fc:(linhas/2)+fc, (colunas/2)-fc:(colunas/2)+fc) = 0;
    mask = double(mask);
    mesh(mask);
    title(['Magnitude Mascara Passa-Alto Frequencia ' num2str(fc)]);
    ft = 'Passa-Alto';
end
rotate3d on;

figure(4);
imshow(mask);
title(['Imagem Máscara do filtro ' ft ' Frequencia ' num2str(fc)]);

filtro = mask.*F;
D = uint8(ifft2(filtro));

figure(5);
mesh(xx, yy, 20*log10(abs(filtro)));
rotate3d;
title(['Magnitude do Filtro ' ft ' | Frequencia ' num2str(fc)]);

figure(6)
imshow(D);
rotate3d on;
title(['Peppers.bmp com Filtro ' ft ' frequencia ' num2str(fc)]);