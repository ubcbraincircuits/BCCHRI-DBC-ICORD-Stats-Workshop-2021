function [ resamps_out ] = make_resamples( dat,nresamps )
%make_samples function returns nresamps of data stored in dat
%inputs:
% dat: this is the data, should be a 1xn matrix
% nresamps: this is how many resamples we will calculate
% outputs:
% resamps_out: this is an nresamps x n matrix, stores all of our resamples.

resamps_out=zeros(nresamps,numel(dat));

for i=1:nresamps
    %generate random numbers for resample
    ind=randi(numel(dat),1,numel(dat));
    %     index data with new indices
    dat_RS=dat(ind);
    % store in output matrix
    resamps_out(i,:)=dat_RS;
end


end

