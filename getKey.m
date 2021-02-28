% Downsamples an input dataset, using a sech as a filter.
% Develloped by on A. Bojesomo, S. Patnaik, and J. Knechtel, “Security evaluation 
%   frame- work for peo-PUF,” Design for Excellence Laboratory, New York Univ.
%   Abu Dhabi, Abu Dhabi, United Arab Emirates, 2019. [Online]. 
%   Available: https://github.com/DfX-NYUAD/peo-PUF

function key = getKey(data,len,spacing,ignoreEndLength)

    if ~exist('len','var')
        len = 6;
    end
    if ~exist('spacing','var')
        spacing = 1;
    end
    if ~exist('ignoreEndLength','var')
        ignoreEndLength = 1;
    end
    data_xor = bitxor(data,bitshift(data,-1)); %Increasing magnitude and abruptibly keeping some features
    gCode = dec2bin(data_xor);
    d = len;

    vend = size(gCode,2);
    stop = vend-ignoreEndLength;
    start = vend-ignoreEndLength-d+1;

    key_t = gCode(:,end-ignoreEndLength:-spacing:end-ignoreEndLength-d+1)'; 
    key = key_t(:)';
end
