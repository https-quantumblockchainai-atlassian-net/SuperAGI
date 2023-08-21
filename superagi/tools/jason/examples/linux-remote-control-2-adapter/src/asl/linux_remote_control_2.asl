+p(X) <-
	.print("YAY!",X).

+Prolog[source(percept)] <-
	+Prolog[source(self)].

+?x(Term) <-
	.concat('+',Term,Trigger);
	.relevant_plans(Trigger,RelevantPlans);
	.length(RelevantPlans,L1);
	if (L1 == 0) {
		      .concat("+",Term," : true <- .print(",Term,").",Plan);
		      .print('Generated Plan: ',Plan);
		      .add_plan(Plan);
		     };
	Term;
	!waitOn(Term);
	?Term[source(self)];
	-Term[source(self)].

-?x(Term) <-
	.print('wah wah').

+!waitOn(Term) <-
	if (not .belief(Term)) {
				.wait(10);
				.print('.');
				!waitOn(Term)
			       }.

+!run1 <-
	!x(directory_files('/var/lib/myfrdcsa/collaborative/git/jason',X));
	.print('MY FILES: ',X).

+!run2 <-
	!x(member(X,[a,b,c]));
	.print('MY MEMBERS: ',Persons).

+!run3 <-
	!x(flp([Persons],allInstances(person,Persons)));
	.print('MY PERSONS: ',Persons).

+!run4 <-
	// !x(flp([Persons],allInstances(person,Persons)));
	flp([Persons],allInstances(person,Persons));
	.wait(2000);
	?flp([Persons],allInstances(person,Persons));
	.print('MY PERSONS: ',Persons).

+query_agent_bindings(flp, localhost, _, allInstances(person, _), Persons) <-
	.print('THE PERSONS: ',Persons).

+!run5 <-
	query_agent_bindings(flp,'localhost',[Persons],allInstances(person,Persons),Results);
	.print('IS THIS ALREADY ANSWERED?: ',Results).

// !run1.

// !run2.

// !run3.

// !run4.

// !run5.

!initializeCommands.
// !pwd(Dir).
// !cd(Dir,'/tmp').

// +!test <-
// 	!sys(pwd,Result);
// 	.print('Result: ',Result);
// 	!chomp(Result,Chomped);
// 	.print('Chomped: ',Chomped);
// 	!cd(Chomped,'/tmp');
// 	!sys(pwd,NewResult);
// 	.print('NewResult: ',NewResult);
// 	!chomp(NewResult,NewChomped);
// 	.print('NewChomped: ',NewChomped).

// +!test(I) <-
// 	.print('I: ',I);
// 	!sys(pwd,Result);
// 	.print('Result: ',Result);
// 	!chomp(Result,Chomped);
// 	.print('Chomped: ',Chomped);
// 	!cd(Chomped,'/tmp');
// 	!sys(pwd,NewResult);
// 	.print('NewResult: ',NewResult);
// 	!chomp(NewResult,NewChomped);
// 	.print('NewChomped: ',NewChomped);
// 	if (I < 100) {
// 		     !test(I + 1);
//         }.

+!test(I) <-
	.print('I: ',I);
	!sys(pwd,Result);
	.print('Result: ',Result);
	!chomp(Result,Chomped);
	.print('Chomped: ',Chomped);
	if (I < 100) {
		      .wait(200);
		     !test(I + 1);
        }.

-!test(_) <-
	true.

!test(1).

////////////////////////////////////////////////////////////////////////////////////

// Should probably have an action that asserts into FreeKBS2 for long
// time storage.  need to finish query/retractall.

// +Prolog[source(percept)] : Prolog =.. [Pred|_] & member(Pred,[directory_files]) <-
// 	+Prolog[source(self)].

{ include("/var/lib/myfrdcsa/codebases/minor/agentspeak-frdcsa/jason/environments/linux-remote-control-2/agent2.asl") }