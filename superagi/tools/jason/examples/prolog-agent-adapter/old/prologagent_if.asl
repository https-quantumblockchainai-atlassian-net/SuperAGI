+!package(systemFn(Name,Version)) <-
    if (existsDirType(binaryDirectory,systemFn(Name,Version))) {
            .print(['Package exists: ',Name,'-',Version]);
        } else {
            .print(['Packaging: ',Name,'-',Version]);
        !sandbox(systemFn(Name,Version));
        }.

+!sandbox(systemFn(Name,Version)) <-
    if (existsDirType(sandboxDirectory,systemFn(Name,Version))) {
           if (existsDirType(sandboxSubdirectory,systemFn(Name,Version))) {
              .print(['Sandbox Directories exists: ',Name,'-',Version]);
           } else {
              .print(['Sandbox Directories do not exist: ',Name,'-',Version]);
              !debian(systemFn(Name,Version));
           }
        } else {
            .print(['Sandbox Directories do not exist: ',Name,'-',Version]);
            !debian(systemFn(Name,Version));
        }.

+!debian(systemFn(Name,Version)) <-
    if (existsDirType(debianDirectory,systemFn(Name,Version))) {
            .print(['Sandbox Debian Directory exists.']);
        } else {
            .print(['Sandbox Debian Directory does not exist.']);
        }.

+!existsDirType(DirType,System) <-
    existsDirType(DirType,System).

!package(systemFn('zenon','0.8.2')).
