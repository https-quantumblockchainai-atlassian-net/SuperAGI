+p(X) <-
	.print("YAY!",X).

// FIXME: Do we need this vvv ?  If we enable it, it does not generate
// plans. if we disable it, then it might not input beliefs correctly

+Prolog[source(percept)] <-
 	+Prolog[source(self)].

+?x(Term) <-
	.concat('+',Term,Trigger);
	.relevant_plans(Trigger,RelevantPlans);
	.print('Relevant Plans: ',RelevantPlans);
	.length(RelevantPlans,L1);

	/* FIXME: originally L1 == 0, but the above source(percept)
	   code was messing it up, could not get it to do 0 or 1
	*/

	if (L1 == 1) {
		      .concat("+",Term," : true <- .print(\"x/1: \",",Term,").",Plan);
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
				// .print('.');
				!waitOn(Term)
			       }.

///////////////// 

+query_agent_bindings(flp, localhost, _, flp_ask_user(Question, _), Results) <-
	+flp_ask_user(Question,Results).

+flp_ask_user('[|]'(A,B),Answer) <-
	PengineList = '[|]'(A,B);
	.print([pengineList,PengineList]);
	!convert_from_pengine_list_to_jason_list(PengineList,JasonList);
	.print([jasonList,JasonList]);
	-flp_ask_user(PengineList,Answer);
	+flp_ask_user(JasonList,Answer);
	.print('Converted: ',flp_ask_user(JasonList,Answer)).

-flp_ask_user('[|]'(_,_),Answer)[source(percept)] <-
	.print('Converting...').

///////////////// 

+query_agent_bindings(flp, localhost, _, flp_ask_ws_user(Question, _), Results) <-
	+flp_ask_ws_user(Question,_Results).

+flp_ask_ws_user('[|]'(A,B),Answer) <-
	PengineList = '[|]'(A,B);
	.print([pengineList,PengineList]);
	!convert_from_pengine_list_to_jason_list(PengineList,JasonList);
	.print([jasonList,JasonList]);
	-flp_ask_ws_user(PengineList,Answer);
	+flp_ask_ws_user(JasonList,Answer);
	.print('Converted: ',flp_ask_ws_user(JasonList,Answer)).

-flp_ask_ws_user('[|]'(_,_),Answer)[source(percept)] <-
	.print('Converting...').

///////////////// 

+query_agent_bindings(flp, localhost, _, flp_query_flp(Query, _), Results) <-
	+flp_query_flp(Query,Results).

+flp_query_flp('[|]'(A,B),Answer) <-
	PengineList = '[|]'(A,B);
	.print([pengineList,PengineList]);
	!convert_from_pengine_list_to_jason_list(PengineList,JasonList);
	.print([jasonList,JasonList]);
	-flp_query_flp(PengineList,Answer);
	+flp_query_flp(JasonList,Answer);
	.print('Converted: ',flp_query_flp(JasonList,Answer)).

-flp_query_flp('[|]'(_,_),Answer)[source(percept)] <-
	.print('Converting...').

///////////////// 

+!convert_from_pengine_list_to_jason_list('[]',Output) <-
	Output = [].

+!convert_from_pengine_list_to_jason_list(Input,Output) <-
	Input = '[|]'(First,Second);
	!convert_from_pengine_list_to_jason_list(Second,Result);
	.concat([First],Result,Output).

+!run6 <-
	!initializeCommands;
	.wait(1000);
	!elicit_entry(andrewDougherty,Entry,Type).

{ include("/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/src/asl/agent2.asl") }
{ include("/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/src/asl/ef_agent.asl") }

!run6.