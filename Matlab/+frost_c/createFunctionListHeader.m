function createFunctionListHeader(funcs, src_path, include_dir)
    if ~exist(fullfile(include_dir), 'dir')
        mkdir(fullfile(include_dir));
    end
    if ~exist(fullfile(include_dir, 'frost'), 'dir')
        mkdir(fullfile(include_dir, 'frost'));
    end
    if ~exist(fullfile(src_path), 'dir')
        mkdir(fullfile(src_path));
    end
    
    % Generating h
    fileID = fopen(fullfile(include_dir, 'frost', 'functionlist.hh'), 'w');
    
    fprintf(fileID, '#ifndef FUNCTIONLIST_H\n');
    fprintf(fileID, '#define FUNCTIONLIST_H\n\n');
    fprintf(fileID, '#include "frost/allincludes.hh"\n\n');
    fprintf(fileID, 'namespace frost {\n');
    fprintf(fileID, '\ttypedef void (*fn_type)(double *, const double *);\n');
    fprintf(fileID, '\textern const fn_type functions[%d];\n', length(funcs));
    fprintf(fileID, '}\n');
    fprintf(fileID, '\n#endif\n');
    
    fclose(fileID);
    
    % Generating C
    fileID = fopen(fullfile(src_path, 'functionlist.cc'), 'w');
    
    fprintf(fileID, '#include "frost/functionlist.hh"\n\n');
    fprintf(fileID, 'const frost::fn_type frost::functions[%d] = {\n', length(funcs));
    for i = 1:length(funcs)
        if i ~= length(funcs)
            fprintf(fileID, '\tfrost::gen::%s,\n', funcs{i});
        else
            fprintf(fileID, '\tfrost::gen::%s};\n', funcs{i});
        end
    end
    fclose(fileID);
end
