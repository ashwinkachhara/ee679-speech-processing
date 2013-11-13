% Select which of the utterance you want to use to test the digit
% recognition system
wordStr = 'nine';
wordIndex = 4;

data = ['zero '; 'one  '; 'two  '; 'three'; 'four '; 'five '; 'six  '; 'seven'; 'eight'; 'nine ';];
num = cellstr(data);

S = audioread(strcat(pwd, '\',wordStr,'\',wordStr,num2str(wordIndex),'.wav'));
% Extracting the cepstral coefficients
frames = wincepstrum(S);
dist = zeros(10,1);

for wordInd=1:size(num,1),
    load(strcat('centroids',num{wordInd},'.mat'));
    for i=1:size(frames,2),
        rep = repmat(frames(:,i),1,size(centroids,2));
        dists = centroids - rep;
        dists = dists.*dists;
        dists = sum(dists,1);
        [mindist, ind] = min(dists);
        % Computing the distance to the nearest neighbor
        dist(wordInd) = dist(wordInd) + mindist;
        % In this case, we hypothesize that, the one codebook whose
        % NN centroids give minimum average distance from the test data, is
        % the correct answer
    end
end

dist = dist/size(frames,2);

[mindist, index] = min(dist);
num(index)


