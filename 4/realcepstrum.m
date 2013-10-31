function c = realcepstrum(s,N)
    Sw = abs(fft(s, N));
    C1 = log(Sw);
    c = real(ifft(C1));
end