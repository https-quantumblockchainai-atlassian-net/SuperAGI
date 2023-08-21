+!initializeCommands <-
	.findall([Plan,FailEvent],
		 .belief(method(Command,Executor)) &
		.concat('+!',Command,' <- ?x(',Executor,'); .print("Command Succeeded: ",',Command,').',Plan) &
		.print('Plan: ',Plan,"\n") &
		.add_plan(Plan) &
		.concat('-!',Command,' <- .print("Command Failed: ",',Command,').',FailEvent) &
		.add_plan(FailEvent) &
		.print('Fail Event: ',FailEvent,"\n"),
		 Tuples);
	.print('Plans and Fail Events: ',Tuples).

-!initializeCommands <-
	.print("Plans could not be initialized for all SWI-Prolog methods declared by method/1").

method(pwd(Dir),currentDirectory(Dir)).
method(sys(CLICommand,Result),shell_command_to_string(CLICommand,Result)).
method(chomp(Input,Output),normalize_space(atom(Output),Input)).
method(cd(Dir1,Dir2),cd(Dir2)).
method(flp_ask(Question,Answer),flp_ask_user(Question,Answer)).
method(flp_query(Question,Answer),flp_query_flp(Question,Answer)).
method(flp_ask_ws(Question,Answer),flp_ask_ws_user(Question,Answer)).
