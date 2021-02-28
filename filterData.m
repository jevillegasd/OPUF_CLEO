% Downsamples an input dataset, using a sech as a filter.
% Developed by Juan Villegas, (C) NYU 2021, 
% Based on work by A. Bojesomo, S. Patnaik, and J. Knechtel, “Security evaluation 
%   frame- work for peo-PUF,” Design for Excellence Laboratory, New York Univ.
%   Abu Dhabi, Abu Dhabi, United Arab Emirates, 2019. [Online]. 
%   Available: https://github.com/DfX-NYUAD/peo-PUF
% Center for Cybersecurity NYUAD / Photonics Research Lab

function result = filterData(input,dx, w, sample_size)
    norm = min(input);
    scale = max(input);
    N = length(input);
    star = round(N/2);
    
    x = (-dx*(N-1)/2:dx:dx*(N-1)/2);
    filter = sech(2*log(sqrt(2)+1)*(x/w));
    
    y = conv(input,filter); 
    y = y(star:1:star+N-1);
    n = round(N/sample_size);
    
    result = downsample(y,n);
    result = round( result * scale / (max(result))-  norm  );
    result(result<0)=0;