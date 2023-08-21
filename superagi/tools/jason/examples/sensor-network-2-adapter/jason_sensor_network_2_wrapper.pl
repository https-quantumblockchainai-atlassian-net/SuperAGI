:- dynamic flag/2,isa/2,messageQueue/1.
:- multifile flag/2,isa/2,messageQueue/1.
:- discontiguous flag/2,isa/2,messageQueue/1.

:- ensure_loaded('/var/lib/myfrdcsa/codebases/minor/strads-frdcsa/attempts/9/util.pl').

isa(sensorNetwork2,actor).

flag(jasonIntegration,true).
flag(log,10).

%% :- consult('/var/lib/myfrdcsa/codebases/minor/agentspeak-frdcsa/jason/environments/sensor_network/sensor_network.pl').

prolog_consult(File) :-
	consult(File).

:- consult('/var/lib/myfrdcsa/codebases/minor/formalog-pengines/formalog_pengines.pl').
:- start_agent(jasonSensorNetwork).

%% %% Contacting Prolog from Java

jpl_execute_action(Agent,Action,Result) :-
	log(1,jpl_execute_action(Agent,Action,Result)),
	%% %% jpl_terms_to_array([p(x),p(z)],Arr),
	%% Arr = [p(x),p(z)],
	%% log(1,array(Arr)),
	%% alarm(1,queueMessageToJason(Arr),_ID1,[]),
	%% alarm(2,queueMessageToJason(Arr),_ID2,[]),
	%% alarm(3,queueMessageToJason(Arr),_ID3,[]),
	%% log(1,queueMessageToJason(Arr)),
	(   call(Action) -> Result = true ; Result = fail).

doTest(Arg) :-
	log(1,[arg,Arg]).

%% this seems to work but I think has just created an extra
%% environment, going to commit now and then tweak to see if there's
%% any hope for it.

%% 2022-01-10 19:46:06 <aindilis> is there an easy way to bind to a preexisting
%%       Java object in JPL, instead of constructing one with jpl_new?
%% 2022-01-10 20:10:43 <[relay]_> <dmiles> gotta track the jabva object in a
%%       dictionary of some kind form hjava.. and give prolog access to that
%%       dictionary

jpl_perceive(Agent,Percepts,Result) :-
	Percepts = [],
	Result = true.

%% %% Contacting Java from Prolog

%% jpl_call(+X, +MethodName:atom, +Params:list(datum), -Result:datum) is det.

%% /var/lib/myfrdcsa/codebases/minor/agentspeak-frdcsa/jason/to.do

%% /var/lib/myfrdcsa/collaborative/git/jason/examples/sensor-network-adapter/src/java/SensorNetworkAdapterEnv.java


%% https://www.swi-prolog.org/pldoc/doc/_SWI_/library/jpl.pl

queueMessageToJason(Goal) :-
	log(1,[queueMessageToJason(Goal)]),
	assertz(messageQueue(Goal)).

jpl_poll_messages(_Agent,Goals) :-
	findall(Goal,messageQueue(Goal),Goals),
	(   (	length(Goals,N),N > 0) -> log(1,[goals,Goals]) ; true),
	retractall(messageQueue(_)).
