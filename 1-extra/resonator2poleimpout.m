function y = resonator2poleimpout(F1, B1, F0)
% y = resonator2pole(F1, B1, F0)
% Function that calculates the output of a 2 pole filter(F1, B1) when input
% is an impulse train of frequency F0
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
% Generating the impulse train using the fact that the sampling frquency is
% given to be 16 kHz
t = 0:1/Fs:1;
imptrain = zeros(size(t));
imptrain(1:round(Fs/F0):end) = 1;

yi = zeros(8000,1);
for n=1:8000
    if(n==1)
        yi(n) = imptrain(n);
    elseif(n==2)
        yi(n) = coef1*yi(n-1) + imptrain(n);
    else
        yi(n) = imptrain(n) + coef1*yi(n-1) - coef2*yi(n-2);
    end
end
y = yi(1:8000);