
/* see also:

/var/lib/myfrdcsa/codebases/minor/executive-function-assistant/frdcsa/sys/flp/autoload/executive_function.pl
/var/lib/myfrdcsa/codebases/minor/executive-function-assistant/frdcsa/sys/flp/autoload/executive_function_domain__executive_function.pl
/var/lib/myfrdcsa/codebases/minor/executive-function-assistant/frdcsa/sys/flp/autoload/executive_function_domain__become_counselor.pl
/var/lib/myfrdcsa/codebases/minor/executive-function-assistant/data-git/executive_function.txt

/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/src/asl/to.do
/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/src/asl/agent2.asl
/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/src/asl/executive_function.asl

/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/jason_executive_function_helper.pl
/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/jason_executive_function_wrapper.pl
*/

// Jason Agentspeak	

+!elicit_entry(Agent,Entry,Type) <-
	!flp_ask_ws(['Please state your action/goal: '],Entry);
	.print(classify_entry(Agent,Entry,Type));
	!classify_entry(Agent,Entry,Type);
	.print(add_entry(Agent,Entry,Type));
	!add_entry(Agent,Entry,Type).

+!classify_entry(Agent,Entry,Type) <-
	!flp_ask_ws(['Please review: ',Entry,'. Is it an goal or an action: '],Type);
	.print(type(Type)).

+!add_entry(Agent,Entry,goal) <-
	+hasGoal(Agent,Entry).

+!add_entry(Agent,Entry,action) <-
	.print(hasAction(Agent,Entry));
	+hasAction(Agent,Entry).

+hasGoal(Agent,Goal) : not currentlyObtainableForP(Agent,Goal) & not ~currentlyObtainableForP(Agent,Goal) <-
	!flp_ask_ws(['Consider this goal: ',Goal,'. Is it currently obtainable for: ',Agent,'. yes or no?: '],Answer);
	.print('Answer: ',Answer);
	if (.substring(Answer,'yes')) {
			      .print("Yeha!");
			      +currentlyObtainableForP(Agent,Goal);
			      };
	if (.substring(Answer,'no')) {
				      .print("Boo hoo!");
				      +~currentlyObtainableForP(Agent,Goal);
				      }
	.

+currentlyObtainableForP(Agent,Goal) <-
	.print('Agent: ',Agent,' has currently obtainable goal: ',Goal);
	.print('Do not necessarily want to break down goal: ',Goal,' into subgoals');
	!flp_ask_ws(['Optional: break down: ',Goal,'. into subgoals? yes or no?: '],Answer);
	.print('Answer: ',Answer);
	if (.substring(Answer,'yes')) {
				       .print("Yeha!");
				       !get_subgoals_for_goal(Agent,Goal,Subgoals);
				       };
	if (.substring(Answer,'no')) {
				      .print("Boo hoo!");
				      }
	.


+~currentlyObtainableForP(Agent,Goal) <-
	.print('Agent: ',Agent,' has currently unobtainable goal: ',Goal);
	!does_agent_have_the_necessary_resources_to_accomplish_goal(Agent,Goal);
	!get_subgoals_for_goal(Agent,Goal,SubGoals).

+!get_subgoals_for_goal(Agent,Goal,Subgoals) <-
	.print('Researching subgoals to achieve goal');
	!flp_query(hasSubgoal(Goal,_Subgoal),Subgoals);
	.print('Subgoal: ',Subgoals);
	!convert_from_pengine_list_to_jason_list(Subgoals,List);
	for (.member(hasSubgoal(_,Entry),List)) {
						 // FIXME: do not need to classify this, we already know it is a goal
						 .print('Entry: ',Entry);
						 !classify_entry(Agent,Entry,Type);
						 !add_entry(Agent,Entry,Type);
						 }
	.

+hasAction(Agent,Action) <-
	!get_subactions_for_action(Agent,Action,Subactions).

/*
+!get_subactions_for_action(Agent,Action,Subactions) <-
	.print('Researching subactions to execute action',Action);
	!flp_query(hasSubaction(Action,_Subaction),Subactions);
	.print('Subaction: ',Subactions);
	!convert_from_pengine_list_to_jason_list(Subactions,List);
	for (.member(hasSubaction(_,Entry),List)) {
						 // FIXME: do not need to classify this, we already know it is an action
						 .print('Entry: ',Entry);
						 !classify_entry(Agent,Entry,Type);
						 !add_entry(Agent,Entry,Type);
						 }
	. 
*/

+!does_agent_have_the_necessary_resources_to_accomplish_goal(Agent,Goal) <-
 	!flp_ask_ws(['Does agent ',Agent,' have the necessary resources to accomplish: ',Goal,'. yes or no?: '],Answer);
 	if (.substring(Answer,'yes')) {
 				       .print("Yeha!");
 				       !identify_action_steps(Agent,Goal,ActionSteps);
 				       .print(identify_action_steps(Agent,Goal,ActionSteps));
 				       };
 	if (.substring(Answer,'no')) {
 				      .print("Boo hoo!");
				      !identify_necessary_resources(Agent,Goal,ActionSteps);
				      .print(identify_necessary_resources(Agent,Goal,ActionSteps));
 				      };
 	.

+!identify_action_steps(Agent,Goal,ActionSteps) <-
 	.print('Identifying action steps for goal: ',Goal);
 	!flp_query(hasActionSteps(Agent,Goal,_ActionSteps),ActionSteps);
 	.print('Action Steps: ',ActionSteps).

+!identify_necessary_resources(Agent,Goal,Resources) <-
 	.print('Identifying necessary resources for goal: ',Goal);
 	!flp_query(hasNecessaryResources(Agent,Goal,_Resources),Resources);
 	.print('Necessary Resources: ',Resources).



+!get_subactions_for_action(Agent,Action,Subactions) <-
	.print('Researching subactions to execute action',Action);
	!flp_ask_ws(['List another subaction for action: "',Action,'", or if there are no more enter NULL'],Answer);
	if (.substring('NULL',Answer) & .substring(Answer,'NULL'))
	{
	 .print('No more subactions.');
	 } else
	{
	 .print('Entry:',Answer);
	 !classify_entry(Agent,Answer,Type);
	 !add_entry(Agent,Answer,Type);
	 }
	.