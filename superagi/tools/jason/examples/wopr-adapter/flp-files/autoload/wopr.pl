:- dynamic woprMessage/1.

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
%% 	atom_concat('jaswipl-call wopr ',TmpQueryAtom,QueryAtom),
%% 	view([queryAtom,QueryAtom]),
%% 	atomic_list_concat(['unilang-client -q -r FCMS -c "',QueryAtom,'"'],'',Command),
%% 	shell_command_to_string(Command,Result),
%% 	view([result,Result]),
%% 	%% flp_ask_user(Query,Answer),
%% 	getWOPRMessage(Answer).

%% getWOPRMessage(Answer) :-
%% 	repeat,
%% 	findall(Message,woprMessage(Message),Messages),
%% 	length(Messages,L),
%% 	(   (	L > 0) ->
%% 	    (	Messages = [Answer|_],retractall(woprMessage(_)),!) ;
%% 	    (	sleep(1),
%% 		fail)).

%% wopr_respond_to_jason(List,Result) :-
%% 	correctLists(List,[username,UserName,message,Message]),
%% 	assertz(woprMessage(Message)).

%% hasCannedReplyConcat(Message,Answer) :-
%% 	hasCannedReply(Question,Answer),
%% 	atomic_list_concat(Question,'',Message),
%% 	!.

%% wopr_respond_to_jason_canned(List,Answer) :-
%% 	correctLists(List,[username,UserName,message,Message]),
%% 	view([wopr_respond_to_jason_canned(Question,Answer)]),
%% 	hasCannedReplyConcat(Message,Answer),
%% 	view([wopr_respond_to_jason_canned_answer,Answer]),
%% 	assertz(woprMessage(Answer)).
