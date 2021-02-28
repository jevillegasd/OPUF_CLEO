% Developed by Juan Villegas, (C) NYU 2021, 
% Center for Cybersecurity NYUAD / Photonics Research Lab

function data_struct = import_csv(filename, import_columns, names, xaxis, plot_)
    data_struct = struct(); 
    
    if ~exist('plot_','var')
        plot_ = 0;
    end
    
    yt = double(import_columns)-double('A')+1;
    if ~exist('xaxis','var')
        xt = yt - 1;
    else
        xt = xaxis-double('A')+1;
    end
    
    [filepath,name,ext] = fileparts(filename{1});
    if strcmp(ext,'.xlsx')
        mydata = xlsread(filename{1}, filename{2});
    else
        mydata =csvread(filename);
    end
    
    if (plot_)
        if ~ishold, figure; end
    end
        
        
    for ii=1:length(xt)
        temp_x = mydata(:,xt(ii));
        tempData = mydata(:,yt(ii));
        
        temp_x = temp_x(~(temp_x==0));
        tempData = tempData(~(temp_x==0));
        
        data_struct(ii).x = temp_x(~isnan(temp_x));
        data_struct(ii).data = tempData(~isnan(tempData));
        data_struct(ii).name = names{ii};
        
        if plot_ 
            plot(data_struct(ii).x,data_struct(ii).data); hold on; end
    end
    
    if plot_ 
        hold off
        legend(names);
    end
    
end