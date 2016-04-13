%%%%%%%%%%%%%%%%%EX2
%()   []

T0 = input('Indique o Valor de T0: ');
num_ele = input('Defina o nº de elementos: ');
t = linspace(0,T0-T0/num_ele,num_ele);
escolha = menu('Qual Equação pretende?','Onda Quadrada Periódica','Onda em Dente de Serra','Expressão a Introduzir');
switch escolha
    case 1
        xt = square(2*pi*(t/T0));
    case 2
        xt = sawtooth(2*pi*(t/T0));
    case 3
        xe = input('Indique a expressão a inserir: ','s');
        xt = eval(xe);
end
m_max = 100;   %mudar m_max para comparar os sinais quese irão obter
[Cm,tetam]=SerieFourier(t',xt',T0,m_max);

subplot(2,1,1);plot(0:m_max,Cm,'o');
subplot(2,1,2);plot(0:m_max,tetam,'.');

%%%%%%%Ex2.1.5
w0 = (2*pi)/T0;
x=zeros(size(t));
for k=0:m_max
    x = x + Cm(k+1)*cos((t*k*w0)+tetam(k+1));
end
figure
plot(t,x); hold on
plot(t,xt);

%%%%%%%%Ex2.1.6
cm_0 = Cm(1)*cos(tetam(1));
cm_pos = Cm(2:end).*exp(j*tetam(2:end));
cm_neg = conj(cm_pos(end:-1:1));

cm = [cm_neg',cm_0,cm_pos'];
m=-m_max:m_max;
figure
subplot(2,1,1);plot(m,abs(cm));
subplot(2,1,2);plot(m,angle(cm));


%%%%Ex2.4
syms t
syms m
func = sym(xe) * exp(j*m*w0*t);
cm = 1/T0 * int(func,-T0/2,T0/2);