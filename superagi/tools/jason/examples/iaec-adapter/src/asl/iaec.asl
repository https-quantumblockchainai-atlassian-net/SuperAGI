unknown(A) :-
	not(A) &
	not(~A).


test(isFileNameP,[atom(Item),unknown(isa(Item,existingFilename))],[exists_file(Item)],[isa(Item,existingFilename)]).
test(isDirectoryP,[atom(Item),unknown(isa(Item,existingDirname))],[exists_directory(Item)],[isa(Item,existingDirname)]).
test(executableFilenameP,[isa(Item,existingFilename),unknown(hasProperty(Item,executable))],[executable_file(Item)],[hasProperty(Item,executable)]).
test(hasExtension,[isa(Item,existingFilename),unknown(hasExtension(Item,B))],[has_filename_extension(Item,B)],[hasExtension(Item,B)]).
test(hasPDFMIMEType,[hasExtension(Item,'pdf'),unknown(hasMIMEType(Item,'pdf'))],[has_mime_type(Item,'pdf')],[hasMIMEType(Item,'pdf')]).
test(hasCorrespondingTextFile,[hasMIMEType(Item,'pdf'),unknown(hasCorrespondingTextFile(Item,_))],[has_corresponding_text_file(Item,B)],[hasCorrespondingTextFile(Item,B)]).

+!iaec(Item) :
	test(TestName,Preconditions,EdgeFunctions,Effects) &
	.findall(Precondition,
		 (   
		     .member(Precondition,Preconditions) &
		 .print("	Precondition: ",Precondition) &
		 (   
		     .eval(true,Precondition) | Precondition)
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
