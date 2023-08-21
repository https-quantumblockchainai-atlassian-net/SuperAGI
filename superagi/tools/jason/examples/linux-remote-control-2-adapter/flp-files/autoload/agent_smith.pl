:- dynamic lrcMessage/1.

%% %% %% flp_query_cyc_user(Question,Answer) :-
%% %% %% 	view([flp_query_cyc_user(Question,Answer)]),
%% %% %% 	Question = ['',SubL],
%% %% %% 	%% cycQuery(SubL,'EverythingPSC',Answer),
%% %% %% 	Answer = 'kmax-not-yet-implemented',
%% %% %% 	view([answer,Answer]).

%% %% %% flp_query_cyc_user(Question,Response) :-
%% %% %% 	view([flp_query_cyc_user(Question,Response)]),
%% %% %% 	Question = ['',Query],
%% %% %% 	findall(Query,call(Query),Response).

%% %% flp_query_cyc_user(Question,Response) :-
%% %% 	view([flp_query_cyc_user(Question,Response)]),
%% %% 	Question = [Vars,Query],
%% %% 	findall(Vars,call(Query),Response).

%% test_flp_query(Response) :-
%% 	flp_query_cyc_user([[X],isa(X,'Dog')],Response).

%% %% cyc-client -q -r Org-FRDCSA-System-Cyc -c "(isa ?X Dog)"
%% %% shell_command_to_string('cyc-client -q -r Org-FRDCSA-System-Cyc -c "(isa ?X Dog)"',Result),

%% flp_query_cyc_user(Question,Response) :-
%% 	view([flp_query_cyc_user(Question,Result)]),
%%  	Question = [Vars,PrologQuery],
%% 	cyc_client:convertToSubLString(PrologQuery,SubLQueryString),
%% 	atomic_list_concat(['cyc-client -q -r Org-FRDCSA-System-Cyc -c "',SubLQueryString,'"'],'',Command),
%% 	view([command,Command]),
%% 	shell_command_to_string(Command,Result),
%% 	view([result,Result]).

%% 	view([result,Result]).

%% flp_ask_user(Question,Answer) :-
%% 	view([flp_ask_user(Question,Answer)]),
%% 	hasCannedReply(Question,Answer),
%% 	view([answer,Answer]).
%% 	%% sleep(1).

%% flp_query_flp(Query,Response) :-
%% 	view([flp_query_flp(Query,Response)]),
%% 	findall(Query,call(Query),Response),
%% 	view([responses,Response]).

%% flp_ask_ws_user(Query,Answer) :-
%% 	correctLists(Query,QueryCorrected),
%% 	view([flp_ask_ws_user(QueryCorrected,Response)]),
%% 	atomic_list_concat(Query,'',TmpQueryAtom),
%% 	atom_concat('jaswipl-call as ',TmpQueryAtom,QueryAtom),
%% 	view([queryAtom,QueryAtom]),
%% 	atomic_list_concat(['unilang-client -q -r FCMS -c "',QueryAtom,'"'],'',Command),
%% 	shell_command_to_string(Command,Result),
%% 	view([result,Result]),
%% 	%% flp_ask_user(Query,Answer),
%% 	getLrcMessage(Answer).

%% %% getLrcMessage(Answer) :-
%% %% 	repeat,
%% %% 	findall(Message,lrcMessage(Message),Messages),
%% %% 	length(Messages,L),
%% %% 	(   (	L > 0) ->
%% %% 	    (	view([messages,Messages]),Messages = [Answer|_],retractall(lrcMessage(_)),!) ;
%% %% 	    (	sleep(1),
%% %% 		fail)).

%% getLrcMessage(Answer) :-
%% 	repeat,
%% 	findall(Message,lrcMessage(Message),Messages),
%% 	length(Messages,L),
%% 	(   (	L > 0) ->
%% 	    (	view([lrcMessages,Messages]),(Messages = [Answer|_] -> true ; true),retract(lrcMessage(Answer)),!) ;
%% 	    (	sleep(1),
%% 		fail)).

%% lrc_respond_to_jason(List,Result) :-
%% 	correctLists(List,[username,UserName,message,Message]),
%% 	assertz(lrcMessage(Message)).

%% hasCannedReplyConcat(Message,Answer) :-
%% 	hasCannedReply(Question,Answer),
%% 	atomic_list_concat(Question,'',Message),
%% 	!.

%% lrc_respond_to_jason_canned(List,Answer) :-
%% 	correctLists(List,[username,UserName,message,Message]),
%% 	view([lrc_respond_to_jason_canned(Question,Answer)]),
%% 	hasCannedReplyConcat(Message,Answer),
%% 	view([lrc_respond_to_jason_canned_answer,Answer]),
%% 	assertz(lrcMessage(Answer)).

%% cleanLrcMessages :-
%% 	retractall(lrcMessage(_)).