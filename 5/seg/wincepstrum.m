function frames = wincepstrum(S)
% Pre-emphasizes and then, computes the sequence of cepstra by windowing;
% 20ms window = 160 samples (8000Hz sampling rate)
Lwin = 160;
w = hamming(Lwin);
hop = 160;

pre_em_S = zeros(length(S),1);
pre_em_S(1) = S(1);
pre_em_S(2:end) = S(2:end) - 0.975*S(1:end-1);

features=zeros(39,1);
% features;
for i=1:hop:length(S)-hop,
    C = rceps(pre_em_S(i:Lwin+i-1).*w);
    C1 = C(1:13);
    delta1(1:14) = C(2:15)-C(1:14);
    delta2(1:13) = delta1(2:14)-delta1(1:13);
    newfeature = [C1; delta1(1:13)'; delta2'];
    newfeature =  newfeature/norm(newfeature);
    features = [features newfeature];
end
frames=features(:,2:end);
end