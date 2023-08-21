:- dynamic flag/2,isa/2.
:- multifile flag/2,isa/2.
:- discontiguous flag/2,isa/2.

:- ensure_loaded('/var/lib/myfrdcsa/codebases/minor/strads-frdcsa/attempts/9/util.pl').

isa(sensorNetwork,actor).

flag(jasonIntegration,true).
flag(log,10).

%% :- consult('/var/lib/myfrdcsa/codebases/minor/agentspeak-frdcsa/jason/environments/sensor_network/sensor_network.pl').

%% :- consult('/var/lib/myfrdcsa/codebases/minor/formalog-pengines/formalog_pengines.pl').

%% %% Contacting Prolog from Java



jpl_execute_action(JavaObject,Agent,Action,Result) :-
	log(1,jpl_execute_action(Agent,Action,Result)),
	jpl_new('SensorNetworkAdapterEnv',[],JRef),
	jpl_call(JRef,'getEnvironment',[],Env),
	%% jpl_type_to_class(Env,EnvName),
	log(1,[env,Env,envName,EnvName,javaObject,JavaObject]),
	jpl_terms_to_array([p(x),p(z)],Arr),
	T = 2,
	%% nb_setval(jref,Env),
	Callback = jpl_call(Env,'receivePrologCall',[Arr], Res1),
	%% call(Callback),
	log(1,wtf),
	log(1,alarmSet(T,Callback)),nl,
	log(1,[result,Res1]),
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
