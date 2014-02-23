% Generating the codebooks for each digit from the given training data
% We will be using the bag of frames model

data = ['zero '; 'one  '; 'two  '; 'three'; 'four '; 'five '; 'six  '; 'seven'; 'eight'; 'nine ';];
num = cellstr(data);
for wordIndex=1:size(num,1),
    wordStr = num{wordIndex};
    % So, for each digit, we will use the first training instance to be the
    % initial centroid
    S = audioread(strcat(pwd, '\',wordStr,'\',wordStr,'1.wav'));
    centroids = wincepstrum(S);
    % We extract the frames for each other training data in the form of 
    % cepstral coefficients (normalized)
    codebook=zeros(size(centroids,1), size(centroids,2), 30);
    codebook(:,:,1) = centroids;
    filledIndex = ones(size(centroids,2),1)*2;
    
    for fileIndex = 2:16,
        S = audioread(strcat(pwd, '\',wordStr,'\',wordStr,num2str(fileIndex),'.wav'));
        frames = wincepstrum(S); % extracting frames
        for i=1:size(frames,2),
            rep = repmat(frames(:,i),1,size(centroids,2));
            % we calculate the distance of each frame from the centroid
            % vectors. The minimum of these (nearest neighbor) is appended 
            % to the appropriate column in variable codebook. Further we 
            % will use these grouped vectors to compute the true centroid 
            % of the corresponding frame.
            dists = centroids - rep;
            dists = dists.*dists;
            dists = sum(dists,1);
            [mindist, ind] = min(dists);
            codebook(:,ind,filledIndex(ind)) =  frames(:,i);
            % Incrementing the index that indicates how many nearest neighbors
            % does the frame have. Needed later for averaging purposes
            filledIndex(ind) = filledIndex(ind)+1;
        end
    end
    
    % Now that we have done a grouping in the frames, we compute the true
    % centroids
    centroids = sum(codebook(:,:,:),3);
    for i=1:size(centroids,2),
        centroids(:,i) = centroids(:,i)/filledIndex(i);
        % normalizing the centroids
        centroids(:,i) = centroids(:,i)/norm(centroids(:,i));
    end
    % Save the codebooks
    save(strcat('centroids',wordStr), 'centroids');
end