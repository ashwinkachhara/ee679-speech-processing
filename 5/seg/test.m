wordStr = 'eight';
wordIndex = 4;

S = audioread(strcat(pwd, '\',wordStr,'\',wordStr,num2str(wordIndex),'.wav'));
frames = wincepstrum(S);

load('centroidszero.mat');
load('centroidsone.mat');

centroids =  centroidszero;
dist = zeros(10,1);
for i=1:size(frames,2),
    rep = repmat(frames(:,i),1,size(centroids,2));
    dists = centroids - rep;
    dists = dists.*dists;
    dists = sum(dists,1);
    [mindist, ind] = min(dists);
    dist(1) = dist(1) + mindist;
end

centroids =  centroidsone;
distone = 0;
for i=1:size(frames,2),
    rep = repmat(frames(:,i),1,size(centroids,2));
    dists = centroids - rep;
    dists = dists.*dists;
    dists = sum(dists,1);
    [mindist, ind] = min(dists);
    dist(2) = dist(2) + mindist;
end

centroids =  centroidstwo;
distone = 0;
for i=1:size(frames,2),
    rep = repmat(frames(:,i),1,size(centroids,2));
    dists = centroids - rep;
    dists = dists.*dists;
    dists = sum(dists,1);
    [mindist, ind] = min(dists);
    dist(3) = dist(3) + mindist;
end

centroids =  centroidsthree;
distone = 0;
for i=1:size(frames,2),
    rep = repmat(frames(:,i),1,size(centroids,2));
    dists = centroids - rep;
    dists = dists.*dists;
    dists = sum(dists,1);
    [mindist, ind] = min(dists);
    dist(4) = dist(4) + mindist;
end

centroids =  centroidsfour;
distone = 0;
for i=1:size(frames,2),
    rep = repmat(frames(:,i),1,size(centroids,2));
    dists = centroids - rep;
    dists = dists.*dists;
    dists = sum(dists,1);
    [mindist, ind] = min(dists);
    dist(5) = dist(5) + mindist;
end

centroids =  centroidsfive;
distone = 0;
for i=1:size(frames,2),
    rep = repmat(frames(:,i),1,size(centroids,2));
    dists = centroids - rep;
    dists = dists.*dists;
    dists = sum(dists,1);
    [mindist, ind] = min(dists);
    dist(6) = dist(6) + mindist;
end

centroids =  centroidssix;
distone = 0;
for i=1:size(frames,2),
    rep = repmat(frames(:,i),1,size(centroids,2));
    dists = centroids - rep;
    dists = dists.*dists;
    dists = sum(dists,1);
    [mindist, ind] = min(dists);
    dist(7) = dist(7) + mindist;
end

centroids =  centroidsseven;
distone = 0;
for i=1:size(frames,2),
    rep = repmat(frames(:,i),1,size(centroids,2));
    dists = centroids - rep;
    dists = dists.*dists;
    dists = sum(dists,1);
    [mindist, ind] = min(dists);
    dist(8) = dist(8) + mindist;
end

centroids =  centroidseight;
distone = 0;
for i=1:size(frames,2),
    rep = repmat(frames(:,i),1,size(centroids,2));
    dists = centroids - rep;
    dists = dists.*dists;
    dists = sum(dists,1);
    [mindist, ind] = min(dists);
    dist(9) = dist(9) + mindist;
end

centroids =  centroidsnine;
distone = 0;
for i=1:size(frames,2),
    rep = repmat(frames(:,i),1,size(centroids,2));
    dists = centroids - rep;
    dists = dists.*dists;
    dists = sum(dists,1);
    [mindist, ind] = min(dists);
    dist(10) = dist(10) + mindist;
end

dist = dist/size(frames,2);

[mindist, index] = min(dist);
data = ['zero '; 'one  '; 'two  '; 'three'; 'four '; 'five '; 'six  '; 'seven'; 'eight'; 'nine ';];
num = cellstr(data);

num(index)

