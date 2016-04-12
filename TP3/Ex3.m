%%% EX 3

% 3.1
[img, color_map, transparency] = imread('Peppers.bmp');
[linhas, colunas] = size(img);

% 3.3
F = fftshift(fft2(double(img)));
% mesh(20*log10(abs(F)));

%%% Fazer menu
fc = 50;

[X,Y] = meshgrid(1:linhas, 1:colunas);
mask((linhas/2)-fc:(linhas/2)+fc, (colunas/2)-fc:(colunas/2)+fc) = 1;
mask = double(mask);
mesh(mask);

C = mask.*F;
D = ifft2(C);
D = uint8(D);
figure
imshow(D);