// implement the ability to call Jason/AgentSpeak(L) from AgentSmith websocket interface

+!elicit_ashell_command(Agent,PreviousOutput,Command,Output) <-
	!flp_ask_ws([PreviousOutput,'AShell Command: '],Command);
	.print(process_ashell_command(Agent,Command,Output));
	!process_ashell_command(Agent,Command,Output);
	!elicit_ashell_command(Agent,Output,Command2,Output2).

+!test_it <-
	.print("This is a test baby!").

+!process_ashell_command(Agent,Command,Output) : .concat('+!',Command,Trigger) & .relevant_plans(Trigger,Plans) & .length(Plans,L) & L == 0 <-
	.print([lengthL0,L]);
 	!sys(Command,Output);
	.print(process_ashell_command(Agent,Command,Output)).

+!process_ashell_command(Agent,Command,Output) : .concat('+!',Command,Trigger) & .relevant_plans(Trigger,Plans) & .length(Plans,L) & L > 0 <-
	.print([lengthLN,L]);
	Output = 'Your friendly reminder. ';
	.print([trigger,Trigger]);
	!Command.

/*
  -!process_ashell_command(Agent,Command,Output) <-
	.print(failed(process_ashell_command(Agent,Command,Output))).
*/

/*
  +!process_ashell_command(Agent,Command,Output) <-
 	!sys(Command,Output);
	.print(process_ashell_command(Agent,Command,Output)).
*/
