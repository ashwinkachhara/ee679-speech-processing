wordStr = 'nine';
S = audioread(strcat(pwd, '\',wordStr,'\',wordStr,'1.wav'));
centroids = wincepstrum(S);

codebook=zeros(size(centroids,1), size(centroids,2), 30);
codebook(:,:,1) = centroids;
filledIndex = ones(size(centroids,2),1)*2;

for fileIndex = 2:16,
    S = audioread(strcat(pwd, '\',wordStr,'\',wordStr,num2str(fileIndex),'.wav'));
    frames = wincepstrum(S);
    for i=1:size(frames,2),
        rep = repmat(frames(:,i),1,size(centroids,2));
        dists = centroids - rep;
        dists = dists.*dists;
        dists = sum(dists,1);
        [mindist, ind] = min(dists);
        codebook(:,ind,filledIndex(ind)) =  frames(:,i);
        filledIndex(ind) = filledIndex(ind)+1;
    end
end

centroids = sum(codebook(:,:,:),3);
for i=1:size(centroids,2),
    centroids(:,i) = centroids(:,i)/filledIndex(i);
    centroids(:,i) = centroids(:,i)/norm(centroids(:,i));
end
save(strcat('centroids',wordStr), 'centroids');