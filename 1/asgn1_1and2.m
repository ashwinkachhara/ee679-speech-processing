%1
F1=1000;
B1=200;
Fs=16000;
r=exp(-pi*B1/Fs);
theta = 2*pi*F1/Fs;
N = 256;

Hw=zeros(N,1);
coef1 = 2*r*cos(theta);
coef2 = r^2;
for j=-N/2:N/2
    w = 2*pi*j/N;
    compl = exp(-i*w);
    Hw(j+N/2+1) = 1/(1-coef1*compl+coef2*compl*compl);
end

x = zeros(N,1);
x(N/2) = 1;
y = zeros(N,1);
for n=1:N
    if(n==1)
        y(n) = x(n);
    elseif(n==2)
        y(n) = coef1*y(n-1) + x(n);
    else
        y(n) = x(n) + coef1*y(n-1) - coef2*y(n-2);
    end
end

h = y;
figure(1);
subplot(2,1,1);
plot(h);
title('Impulse Response of 2-pole resonator');
xlabel('n+128');
subplot(2,1,2);
plot(20*log10(abs(Hw)));
title('Magnitude Response of 2-pole resonator | log scale');
ylabel('20log(|H(w)|)');
xlabel('frequency');

%2
F0 = 150;
T0 = round(1/F0);
t = 0:1/Fs:1;
imptrain = zeros(size(t));
imptrain(1:Fs/F0:end) = 1;

y = conv(h, imptrain);
figure(2);
plot(y(1:8000));
xlabel('n');
title('Filter response to impulse train');
