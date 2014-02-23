function y = resonator2poleout(F1, B1, inp)
% y = resonator2pole(F1, B1, inp)
% Given an input of 8000 samples, this function calculates the output
% signal when it is passed through a single formant filter(F1, B1)
Fs=16000;
r=exp(-pi*B1/Fs);
theta = 2*pi*F1/Fs;
N = 256;

Hw=zeros(N,1);
coef1 = 2*r*cos(theta);
coef2 = r^2;
for j=-N/2:N/2
    w = 2*pi*j/N;
    compl = exp(-1i*w);
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

yi = zeros(8000,1);
for n=1:8000
    if(n==1)
        yi(n) = inp(n);
    elseif(n==2)
        yi(n) = coef1*yi(n-1) + inp(n);
    else
        yi(n) = inp(n) + coef1*yi(n-1) - coef2*yi(n-2);
    end
end
y = yi(1:8000);