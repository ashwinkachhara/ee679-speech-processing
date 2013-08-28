function h = resonator2poleh(F1, B1)
% h = resonator2poleh(F1, B1)
%
% Returns the impulse response of a single formant filter of resonant
% frequency F1 and bandwidth B1
Fs=16000;
% Evaluating the location of the poles of the filter using the frequency and
% bandwidth of the filter
r=exp(-pi*B1/Fs);
theta = 2*pi*F1/Fs;
N = 256;

Hw=zeros(N,1);
coef1 = 2*r*cos(theta);
coef2 = r^2;
% Calculating the transfer function of the filter using the difference
% equations
for j=-N/2:N/2
    w = 2*pi*j/N;
    compl = exp(-i*w);
    Hw(j+N/2+1) = 1/(1-coef1*compl+coef2*compl*compl);
end

% To calculate the impulse response of the filter, we use the difference
% equation of the filter and put an impulse x[n] as the input, So we get
% output y[n] which is the impulse response
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