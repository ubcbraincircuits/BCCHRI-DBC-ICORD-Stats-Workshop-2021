function [ resamps_out ] = make_resamples2( dat,nresamps,nsamp )
%make_resamples This function resamples an input data set a specified
%number of times
% inputs:
% dat: 1xn matrix containing the data to resample.
% nresamps: the number of resamples to do.
% nsamp: number of data point in the resample.  
% 
% outputs
%resamps_out: nresamps x nsamp matrix containg the nresamps resamples of dat.
%each resample has nsamp data points.

% ok.  First step is to prep the output matrix, I usually use zeros for
% this.
resamps_out=zeros(nresamps,nsamp);

% Now we can use a loop to create the resmaples using our couple lines of
% code from before.

% loop starts at one and goes to nresamps

for i=1:nresamps
    %     create indices
    ind=randi(numel(dat),1,nsamp);
    %     use them to resample.
    dat_RS=dat(ind);
    % store in output matrix.
    resamps_out(i,:)=dat_RS;
end


end

