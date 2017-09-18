function [fileName,filePath] = listFile(spec,path)
    fileName = {}; filePath = {};
    if nargin==1
        path = pwd;
    end
    files = ls(path);
    L = size(files,1);
    if L < 3
        return;
    end
    files = mat2cell(files,ones(1,L));
    fileType = strsplit(spec,'.');
    fileType = fileType{2};
    if strcmp(fileType,'*')
        isSpec = 0;
    else
        isSpec = 1;
    end
    for m = 3:1:L
        if isdir(strcat(path,'\',files{m}))
            [fn,fp] = listFile(spec,strcat(path,'\',files{m}));
            len = size(fn,1);
            if len > 0
                fileName = [fileName,fn{:}];
                filePath = [filePath,fp{:}];
            end
        else
            if isSpec
                name = files{m};
                name = strtrim(name);
                nameSpec = strsplit(name,'.');
                nameSpec = nameSpec{2};
                if strcmp(nameSpec,fileType)
                    fileName{end+1} = name;
                    filePath{end+1} = strcat(path,'\');
                end
            end
        end
    end
end

