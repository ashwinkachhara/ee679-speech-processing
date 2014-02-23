function frames = wincepstrum(S)
% USAGE: frames = wincepstrum(S)
% Pre-emphasizes and then, computes the feature vectors for the signal by
% windowing with a hamming window.

Lwin = 160; % 20ms window = 160 samples (8000Hz sampling rate)
w = hamming(Lwin);
hop = 160;

pre_em_S = zeros(length(S),1);
pre_em_S(1) = S(1);
pre_em_S(2:end) = S(2:end) - 0.975*S(1:end-1);

features=zeros(39,1);
% features;
for i=1:hop:length(S)-hop,
    C = rceps(pre_em_S(i:Lwin+i-1).*w);
    C1 = C(1:13); % First 13 cepstral coefficients
    delta1(1:14) = C(2:15)-C(1:14); % Next 13 feature vector elements are delta
    delta2(1:13) = delta1(2:14)-delta1(1:13); % Last 13 feature vectors are delta-delta
    newfeature = [C1; delta1(1:13)'; delta2'];
    newfeature =  newfeature/norm(newfeature);
    features = [features newfeature];
end
frames=features(:,2:end); % Omitting the first column, which was all zeroes.
end