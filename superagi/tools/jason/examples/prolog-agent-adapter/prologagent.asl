////////////////////////////////////////////////////////

!package(systemFn('zenon','0.8.2')).

////////////////////////////////////////////////////////

+!existsDirType(DirType,System,Result) <-
    existsDirType(DirType,System);
    Result = true.

-!existsDirType(DirType,System,fail) <-
    .print(['existsDirType/2 failed']).

////////////////////////////////////////////////////////

+!package(systemFn(Name,Version)) <-
    !existsDirType(binaryDirectory,systemFn(Name,Version),Result);
    Result == true;
    .print(['Package exists: ',Name,'-',Version]).

-!package(systemFn(Name,Version)) <-
    .print(['Package does not exist - Packaging: ',Name,'-',Version]);
    !sandbox(systemFn(Name,Version)).

+!sandbox(systemFn(Name,Version)) <-
    !existsDirType(sandboxDirectory,systemFn(Name,Version),Result1);
    .print(['Result1: ',Result1]);
    Result1 == true;
    .print(['Sandbox Directory exists: ',Name,'-',Version]);
    !existsDirType(sandboxSubdirectory,systemFn(Name,Version),Result2);
    Result2 == true;
    .print(['Sandbox Subdirectory exists: ',Name,'-',Version]);
    !debian(systemFn(Name,Version)).

-!sandbox(systemFn(Name,Version)) <-
    .print(['Sandbox Directories do not exist: ',Name,'-',Version]).

+!debian(systemFn(Name,Version)) <-
    !existsDirType(debianDirectory,systemFn(Name,Version),Result);
    Result1 == true;
    .print(['Debian Directory exists.']).

-!debian(systemFn(Name,Version)) <-
    .print(['Debian Directory does not exist.']).

////////////////////////////////////////////////////////
