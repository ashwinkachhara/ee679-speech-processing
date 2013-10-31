Sa = wavread('s16.wav');
Ls = length(Sa);
Sa(1:1:Ls/2) = Sa(1:2:Ls);
S = zeros(Ls,1);
S(1) = Sa(1);
S(2:end) = Sa(2:end) - 0.975*Sa(1:end-1);

N = 1024;
c_s = realcepstrum(Sa,2048);
figure(1)
plot(abs(c_s))
filter = zeros(N,1);
% We will take 5ms spectrum for getting the vocal tract freq response
% 5ms = 40 samples

filter(1:40) = 1;
c_s_filt = abs(fft(c_s(1:N).*filter));

%30ms window, sampling rate of 8k
Lw = 0.03 * 8000;
w = hamming(Lw);

Sw = zeros(Lw,1);
strt = floor(Ls/2-Lw/2);
Sw(1:end) = S(strt:strt+Lw-1).*w;
spect_a = mag2db(abs(fft(Sw, 1024)));

p = 20;
r=zeros(p+1, 1);
for i=0:p,
    r(i+1) = Sw(1:Lw-i)'*Sw(i+1:Lw);
end

[a18 e18] = levinson(r, 18);
a = a18;
e = e18;
Pspec_s = zeros(N,1);
for k=0:N-1,
    w1 = k/1024 * 2 * pi;
    expo = exp(-(0:18)*1i*w1);
    Pspec_s(k+1) = e/(abs(expo*a')).^2;
end
Pspec_s = sqrt(Pspec_s);
figure(2)
plot((1:1:N),[10*c_s_filt, 10*log10(Pspec_s)])