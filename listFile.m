function [fileName,filePath] = listFile(spec,path)
    fileName = {}; filePath = {};
    if nargin==1
        path = uigetdir();
    end
    files = ls(path);
    L = size(files,1);
    if L < 3
        return;
    end
    files = mat2cell(files,ones(1,L));
    fileType = strsplit(spec,'.');
    if strcmp(fileType{1},'*')
        matchName = [];
    else
        matchName = fileType{1};
    end
    fileType = fileType{2};
    if strcmp(fileType,'*')
        matchFormat = [];
    else
        matchFormat = fileType;
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
            try
                tmp = files{m};
                tmp = strtrim(tmp);
                tmp = strsplit(tmp,'.');
                fName = tmp{1};
                fFormat = tmp{2};
                if isempty(matchFormat) || strcmp(matchFormat,fFormat)
                    %if strcmp(name,spec)
                    if regexp(fName,matchName)
                        fileName{end+1} = files{m};
                        filePath{end+1} = strcat(path,'\');
                    end
                end
            catch
            end
        end
    end
end

