+!package(systemFn(Name,Version)) : existsDirType(binaryDirectory,systemFn(Name,Version)) <-
    .print(['Package exists: ',Name,'-',Version]).

+!package(systemFn(Name,Version)) : not existsDirType(binaryDirectory,systemFn(Name,Version)) <-
    .print(['Package does not exist - Packaging: ',Name,'-',Version]);
    !sandbox(systemFn(Name,Version)).

+!sandbox(systemFn(Name,Version)) : existsDirType(sandboxDirectory,systemFn(Name,Version)) & existsDirType(sandboxSubdirectory,systemFn(Name,Version)) <-
    .print(['Sandbox Directories exists: ',Name,'-',Version]);
    !debian(systemFn(Name,Version)).

+!sandbox(systemFn(Name,Version)) : not (existsDirType(sandboxDirectory,systemFn(Name,Version)) & existsDirType(sandboxSubdirectory,systemFn(Name,Version))) <-
    .print(['Sandbox Directories do not exist: ',Name,'-',Version]).

+!debian(systemFn(Name,Version)) : existsDirType(debianDirectory,systemFn(Name,Version)) <-
    .print(['Sandbox Debian Directory exists.']).

+!debian(systemFn(Name,Version)) : not existsDirType(debianDirectory,systemFn(Name,Version)) <-
    .print(['Sandbox Debian Directory does not exist.']).

!package(systemFn('zenon','0.8.2')).
