unknown(A) :-
    not(A) &
    not(~A).


test(isFileNameP,[atom(var_A),unknown(isa(var_A,existingFilename))],[exists_file(var_A)],[isa(var_A,existingFilename)]).
test(isDirectoryP,[atom(var_A),unknown(isa(var_A,existingDirname))],[exists_directory(var_A)],[isa(var_A,existingDirname)]).
test(executableFilenameP,[isa(var_A,existingFilename),unknown(hasProperty(var_A,executable))],[executable_file(var_A)],[hasProperty(var_A,executable)]).
test(hasExtension,[isa(var_A,existingFilename),unknown(hasExtension(var_A,var_B))],[has_filename_extension(var_A,var_B)],[hasExtension(var_A,var_B)]).
test(hasPDFMIMEType,[hasExtension(var_A,'pdf'),unknown(hasMIMEType(var_A,'pdf'))],[has_mime_type(var_A,'pdf')],[hasMIMEType(var_A,'pdf')]).
test(hasCorrespondingTextFile,[hasMIMEType(var_A,'pdf'),unknown(hasCorrespondingTextFile(var_A,_))],[has_corresponding_text_file(var_A,var_B)],[hasCorrespondingTextFile(var_A,var_B)]).

+?substitute_vars([],Term,NewTerm) <- Term = NewTerm.
+?substitute_vars(List,Term,NewTerm) : lisp(List) <-
    Term =.. [P|Args];
    .print("Args: ",Args);
    .findall(NewArg,
         (
          .member(Arg,Args)
         //  if(Arg == var_A)
         // {
         //  List = [NewArg|RestOfArgs];
         //  } else
         // {
         //  NewArg = Arg;
         //  }
         ),
         NewArgs);
    NewTerm =.. [P|NewArgs].

+!iaec(Item) :
    test(TestName,Preconditions,EdgeFunctions,Effects) &
    .findall(NewPrecondition,
         (   
             .member(Precondition,Preconditions) &
         .print("	Precondition: ",Precondition) &
         substitute_vars([Item],Precondition,NewPrecondition) &
         (   
             .eval(true,NewPrecondition) | NewPrecondition)
         ),
         SuccessfulPreconditions) &
    .length(Preconditions,Length) &
    .length(SuccessfulPreconditions,Length)
    <-
        .print([TestName,' precondions checked']);
        for(.member(EdgeFunction,EdgeFunctions))
        {
         .print("	EdgeFunction: ",EdgeFunction);
         .eval(_Result,EdgeFunction);
         }
        .print([TestName,' edge functions evaled']);
        for(.member(Effect,Effects))
        {
         .print("	Effect: ",Effect);
         +Effect;
         }
        .print([TestName,' effects added to belief base']);
        !iaec(Item).
-!iaec(Item) <-
    .print("Preconditions Failed").

!iaec('/home/andrewdo/morbini-phd-thesis.pdf').
