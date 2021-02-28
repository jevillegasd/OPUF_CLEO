% This script process data form the insertion loss characterization of
% Optical Physically Uncloinable Functions. All measurements were carried
% between 1560 and 1600 nm.  The exact same data processing can be utilized
% at any other band, but it needs to be consistent between comapred files.

% Developed by Juan Villegas, (C) NYU 2021, 
% Center for Cybersecurity NYUAD / Photonics Research Lab
% Based on work by A. Bojesomo, S. Patnaik, and J. Knechtel, �Security evaluation frame- work for peo-PUF,�

clear cell_key
for file = 1:4
    filename = {".\files\dev"+num2str(file)+"_0dB.xlsx","IL"}; % IL is the name of the sheet with the data
    comment = {'r=30um, 0.8 chamfer and etched holes'};

    var = [0 -3 -6 -10 -13 -16 -20]; %in dBm
    names = arrayfun(@num2str, var, 'UniformOutput', 0);

    cmp = 1; %Reference measurement for HD computation

    cols = 'B'; %Column to read from the excel file 
    xaxis = 'A';

    sample_size = 1001; %Input gets remmaped to this number of points

    figure(1); subplot(4,1,file);  hold on;
    processed_raw = zeros(sample_size, length(var));
    for it = 1:length(var)
        loss = var(it);
        
        filename = {".\files\dev"+num2str(file)+"_"+num2str(loss)+"dB.xlsx","IL"};
        raw_data = import_csv(filename, cols, names(it),xaxis,0);
        
        dx = raw_data.x(2)-raw_data.x(1);
        lambda = linspace(min(raw_data.x),max(raw_data.x),sample_size);
        
        w = 0.05e-9;  %Width of the sech filtering function in nm
        processed_raw(:,it) = filterData(raw_data.data, dx, w , sample_size);
        plot(lambda, processed_raw(:,it));

        binary = getKey(processed_raw(:,it),3,1,1);
        cell_key(it,:) = cell2mat({binary}); %Not necessary when single variables
    end
    legend(names)
    hold off;

%% Apply random challenges to each  
    len = 3;
    num = size(cell_key,2)/len; % Same as the length of the raw data if no cropping or subsampling is done
    grp = ceil(128/len);        % 
    num_tests = 1e3;            % Number of tests to be carried
    
    % These are the pair of samples that we will compare
    figure('Name',"Hamming distance file "+file);
     
    for it = 2:length(var)
        data_ref = reshape(cell_key(cmp,:),len,[]); % Same as data_ref = reshape(cell_key(1,:),len,[]);
        data_sam = reshape(cell_key(it,:),len,[]); 
        
        for itt=1:num_tests
            pos = randperm(num,grp); % random position
            subset{1,itt} = reshape(data_ref(:,pos),1,[]);
            subset{2,itt} = reshape(data_sam(:,pos),1,[]);
            HDdata(itt) = pdist(double(cell2mat(subset(:,itt)))-double('0'),'Hamming');
        end
        HD(it-1).mean = mean(HDdata); 
        HD(it-1).sigma = std(HDdata);
        HD(it-1).comment = strcat(names(cmp), " / " , names(it));

        subplot(ceil((length(var)-1)/3),3,it-1);
        
        [xd,pd] = plotHD(HDdata); grid on;
        title(HD(it-1).comment);
        text(max(xd),0.7*max(pd),['\mu = ',num2str(HD(it-1).mean)],'color','red')
        text(max(xd),0.6*max(pd),['\sigma = ',num2str(HD(it-1).sigma)],'color','red')
        text(max(xd),0.4*max(pd),HD(it-1).comment,'color','red') 
        
        if and(file == 2, it == 3)
            savedData = HDdata;
            HD_info = HD;
        end
    end
    results{file} = HD;
    
end




