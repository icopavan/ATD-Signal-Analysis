%%% EX 3

% 3.1
[img, color_map, transparency] = imread('Peppers.bmp');
[linhas, colunas] = size(img);

% 3.3
F = fftshift(fft2(double(img)));
% mesh(20*log10(abs(F)));

[X,Y] = meshgrid(1:linhas, 1:colunas);

fc = input('Frequencia de corte = ');
option = menu('Escolher Filtro','Passa-Baixo','Passa-Alto');
if option == 1
    mask = zeros(linhas);
    mask((linhas/2)-fc:(linhas/2)+fc, (colunas/2)-fc:(colunas/2)+fc) = 1;
    mask = double(mask);
    mesh(mask);
    title('Magnitude Mascara Passa-Baixo');
else
    mask = ones(linhas);
    mask((linhas/2)-fc:(linhas/2)+fc, (colunas/2)-fc:(colunas/2)+fc) = 0;
    mask = double(mask);
    mesh(mask);
    title('Magnitude Mascara Passa-Alto');
end
rotate3d on;

C = mask.*F;
D = ifft2(C);
D = uint8(D);
figure
imshow(D);
rotate3d on;