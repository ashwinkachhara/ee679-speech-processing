function c = realcepstrum(s,N)
% USAGE: c = realcepstrum(s,N)
% Returns the N length real cepstrum of signal s
    Sw = abs(fft(s, N));
    C1 = log(Sw);
    c = real(ifft(C1));
end