% Reading in the files
S_a = wavread('a.wav');
S_i = wavread('i.wav');
S_n = wavread('n.wav');
S_s = wavread('s.wav');

% 30ms window = 240 samples (8000Hz sampling rate)
Lwin = 240;
w = hamming(Lwin);
% Pre-emphasizing 30ms hamming windowed segments of each phone with a 
% coefficient of 0.975
pre_em_S_a = zeros(length(S_a),1);
pre_em_S_a(1) = S_a(1);
pre_em_S_a(2:end) = S_a(2:end) - 0.975*S_a(1:end-1);
pre_em_Spec_a = abs(fft(pre_em_S_a(1:Lwin).*w, 1024));

pre_em_S_i = zeros(length(S_i),1);
pre_em_S_i(1) = S_i(1);
pre_em_S_i(2:end) = S_i(2:end) - 0.975*S_i(1:end-1);
pre_em_Spec_i = abs(fft(pre_em_S_i(1:Lwin).*w, 1024));

pre_em_S_n = zeros(length(S_n),1);
pre_em_S_n(1) = S_n(1);
pre_em_S_n(2:end) = S_n(2:end) - 0.975*S_n(1:end-1);
pre_em_Spec_n = abs(fft(pre_em_S_n(1:Lwin).*w, 1024));

pre_em_S_s = zeros(length(S_s),1);
pre_em_S_s(1) = S_s(1);
pre_em_S_s(2:end) = S_s(2:end) - 0.975*S_s(1:end-1);
pre_em_Spec_s = abs(fft(pre_em_S_s(1:Lwin).*w, 1024));

% I have created a function realcepstrum that calculates the real part of
% the cepstrum. We will calculate 1024 cepstral coefficients
N = 1024;
c_a = realcepstrum(pre_em_S_a,N);
c_i = realcepstrum(pre_em_S_i,N);
c_n = realcepstrum(pre_em_S_n,N);
c_s = realcepstrum(pre_em_S_s,N);

figure(1)
plot(abs(c_a))
title('Speech Cepstrum \a\')
xlabel('Quefrency(n)')
ylabel('magnitude')

figure(2)
plot(abs(c_i))
title('Speech Cepstrum \i\')
xlabel('Quefrency(n)')
ylabel('magnitude')

figure(3)
plot(abs(c_n))
title('Speech Cepstrum \n\')
xlabel('Quefrency(n)')
ylabel('magnitude')

figure(4)
plot(abs(c_s))
title('Speech Cepstrum \s\')
xlabel('Quefrency(n)')
ylabel('magnitude')

filter = zeros(N,1);

% Now, by using 13, 26 and 40 cepstral coefficients, we will reconstruct
% the spectral envelope of the original signal (i.e. the vocal tract
% magnitude response)
filter(1:13) = 1;
c_a_filt13 = real(fft(c_a.*filter));
c_i_filt13 = real(fft(c_i.*filter));
c_n_filt13 = real(fft(c_n.*filter));
c_s_filt13 = real(fft(c_s.*filter));

filter(1:26) = 1;
c_a_filt26 = real(fft(c_a.*filter));
c_i_filt26 = real(fft(c_i.*filter));
c_n_filt26 = real(fft(c_n.*filter));
c_s_filt26 = real(fft(c_s.*filter));

filter(1:40) = 1;
c_a_filt40 = real(fft(c_a.*filter));
c_i_filt40 = real(fft(c_i.*filter));
c_n_filt40 = real(fft(c_n.*filter));
c_s_filt40 = real(fft(c_s.*filter));
p = 10;

% To compare this envelope with the 10th order LP model, we directly use
% the LPC calculated in the previous assignment
a = [1,-0.420287293299905,-0.0167760932776719,-0.104562761984595,0.689852617695652,-0.361632554947867,0.140248097569097,-0.203610014001556,0.444672696487985,-0.120304813366367,-0.0794124187832130;];
e = sqrt(0.165941469629558);
LPPspec_a = zeros(N,1);
for k=0:N-1,
    w1 = k/1024 * 2 * pi;
    expo = exp(-(0:p)*1i*w1);
    LPPspec_a(k+1) = e/(abs(expo*a')).^2;
end
LPPspec_a = sqrt(LPPspec_a);
figure(5)
plot((1:1:N/2),[20*c_a_filt13(N/2+1:N)-20, 20*c_a_filt26(N/2+1:N)-20, 20*c_a_filt40(N/2+1:N)-20, 20*log(LPPspec_a(N/2+1:N)), 20*log(pre_em_Spec_a(N/2+1:N))])
legend({'Spectral envelope(13 cepstral coeffs)', 'Spectral envelope(26 cepstral coeffs)', 'Spectral envelope(40 cepstral coeffs)', 'LPC Spectrum', 'Actual pre-emphasized spectrum'}, 'Location', 'SouthEast')
title('Spectrum \a\')
xlabel('Frequency(0 to 4000Hz)')
ylabel('Magnitude in dB')

a = [1,0.698317342461645,-0.909861237184334,-1.65274560720659,-0.235382082563609,0.952174308040117,0.937834384933943,-0.135865286890716,-0.412030429797570,-0.0311303168409126,0.188984000693420;];
e = sqrt(0.025784896943841);
LPPspec_i = zeros(N,1);
for k=0:N-1,
    w1 = k/1024 * 2 * pi;
    expo = exp(-(0:p)*1i*w1);
    LPPspec_i(k+1) = e/(abs(expo*a')).^2;
end
LPPspec_i = sqrt(LPPspec_i);
figure(6)
plot((1:1:N/2),[20*c_i_filt13(N/2+1:N)-20, 20*c_i_filt26(N/2+1:N)-20, 20*c_i_filt40(N/2+1:N)-20, 20*log(LPPspec_i(N/2+1:N)), 20*log(pre_em_Spec_i(N/2+1:N))])
legend({'Spectral envelope(13 cepstral coeffs)', 'Spectral envelope(26 cepstral coeffs)', 'Spectral envelope(40 cepstral coeffs)', 'LPC Spectrum', 'Actual pre-emphasized spectrum'}, 'Location', 'SouthEast')
title('Spectrum \i\')
xlabel('Frequency(0 to 4000Hz)')
ylabel('Magnitude in dB')

a = [1,-0.336683172630503,-0.0955401231582948,-1.24594147043500,0.468450686416110,0.0442257434383423,0.618911147611882,-0.269140314973162,0.108207838982659,-0.197305482909666,0.166620298830989;];
e = sqrt(0.004622502872126);
LPPspec_n = zeros(N,1);
for k=0:N-1,
    w1 = k/1024 * 2 * pi;
    expo = exp(-(0:p)*1i*w1);
    LPPspec_n(k+1) = e/(abs(expo*a')).^2;
end
LPPspec_n = sqrt(LPPspec_n);
figure(7)
plot((1:1:N/2),[20*c_n_filt13(N/2+1:N)-20, 20*c_n_filt26(N/2+1:N)-20, 20*c_n_filt40(N/2+1:N)-20, 20*log(LPPspec_n(N/2+1:N)), 20*log(pre_em_Spec_n(N/2+1:N))])
legend({'Spectral envelope(13 cepstral coeffs)', 'Spectral envelope(26 cepstral coeffs', 'Spectral envelope(40 cepstral coeffs)', 'LPC Spectrum', 'Actual pre-emphasized spectrum'}, 'Location', 'SouthEast')
title('Spectrum \n\')
xlabel('Frequency(0 to 4000Hz)')
ylabel('Magnitude in dB')

a = [1,1.63614982448397,0.882745291534022,-0.174884140926944,-0.253039240829985,-0.370752035574149,-0.381388031674158,-0.255543293068461,0.00507731220266254,0.124808255685261,0.134048946480061;];
e = sqrt(0.011294540783375);
LPPspec_s = zeros(N,1);
for k=0:N-1,
    w1 = k/1024 * 2 * pi;
    expo = exp(-(0:p)*1i*w1);
    LPPspec_s(k+1) = e/(abs(expo*a')).^2;
end
LPPspec_s = sqrt(LPPspec_s);
figure(8)
plot((1:1:N/2),[20*c_s_filt13(N/2+1:N)-20, 20*c_s_filt26(N/2+1:N)-20, 20*c_s_filt40(N/2+1:N)-20, 20*log(LPPspec_s(N/2+1:N)), 20*log(pre_em_Spec_s(N/2+1:N))])
legend({'Spectral envelope(13 cepstral coeffs)', 'Spectral envelope(26 cepstral coeffs)', 'Spectral envelope(40 cepstral coeffs)', 'LPC Spectrum', 'Actual pre-emphasized spectrum'}, 'Location', 'SouthEast')
title('Spectrum \s\')
xlabel('Frequency(0 to 4000Hz)')
ylabel('Magnitude in dB')


