%%%%%%%%%%%%%%%%%EX1
%()   []
G=28;
a1 = -2.1-0.2*mod(G,2);
a2 = 1.43+0.31*mod(G,2);
a3 = -0.315-0.117*mod(G,2);
b2 = 0.9167*mod(1+G,2);
b3 = 0.3137*mod(G,2);
b4 = -0.5867*mod(1+G,2);
b5 = -0.1537*mod(G,2);

%%%%%Ex1.2
b = [0 0 b2 b3 b4 b5];
a = [1 a1 a2 a3 0 0];

zerosa = roots(a);
zerosb = roots(b);
zplane(b,a);

%%%%%Ex1.2.3
syms z
bz = b2*z^-2 + b3*z^-3 + b4*z^-4 + b5*z^-5;
az = 1 + a1*z^-1 + a2*z^-2 + a3*z^-3;
Hz = bz/az;
hn = iztrans(Hz);

bzl = b2 + b3*z^-1 + b4*z^-2 + b5*z^-3;
bl = [b2 b3 b4 b5];
al = [1 a1 a2 a3 ];
[r p k] = residuez(bl,al);
syms n
hres = 0*n;
for k=1:length(r)
    hres = hres + (heaviside(n-2)-0.5*kroneckerDelta(n - 2, 0))*r(k)*(p(k).^(n-2));
end


%%%%%Ex1.2.4
j = 0:70;
hn1 = subs(hn,j);
hn2 = subs(hres,j);
plot(hn1,'o'); hold on
plot(hn2);
hold off
hn2 = impz(b,a,71);
hn3 = dimpulse(b,a,71);
stairs(hn1); hold on
stem(hn2);
stem(hn3,'+');
hold off
%%%%%%Ex1.2.5
Uz = 1/(1-z^-1); %%transformada de un
Yz = Hz * Uz;
yn = iztrans(Yz);

%%%%%Ex1.2.6
yn1 = subs(yn,j);
yn2 = dstep(b,a,71)
stairs(yn1); hold on
stem(yn2,'o');
hold off
%%%%%%Ex1.2.7
xn = 5*(((j-4)>=0)-((j-10)>=0));
%Xz = 5*(z^-4 + z^-5 + z^-6 + z^-7 + z^-8 + z^-9);
Xz = 5*((1/(1-z^-1))*z^-4 - (1/(1-z^-1))*z^-10);
Yz = Hz * Xz;
yn = iztrans(Yz);
%%%%%%Ex1.2.8
yn1 = subs(yn,j);
yn2 = filter(b,a,xn);
yn3 = dlsim(b,a,xn);
stairs(yn1); hold on
stem(yn2,'o');
stem(yn3,'+')
%%%%%%Ex1.2.9
%freqz(b,a)
f=linspace(0,pi,100);
Homega = freqz(b,a,f);
subplot(2,1,1);plot(f,20*log10(abs(Homega)))
subplot(2,1,2);plot(f,unwrap(angle(Homega))*180/pi)
%%%%%%Ex1.2.10
ddcgain(b,a)
Homega(1)
subs(Hz,1) %% no relatório escrever o teorema do valor final

