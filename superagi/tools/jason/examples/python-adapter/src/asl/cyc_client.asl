// query_agent_bindings(flp,'localhost',[X],cycQuery(isa(X,'Dog'),'BaseKB',X),Results);
// !sys(flp_query_cyc(isa(X,'Dog'),Results));

// +!queryCycTest <-
// 	!sys(flp_query_cyc(['',member(X,[a,b,c,d])],Results));
// 	.print('Cyc Query Results: ',Results).

// Fails because: Alarm
// !queryCycTest1.

// !flp_query(cycQuery(isa(X,'Dog'),'BaseKB',Res1),Results).
// !flp_query_cyc(['',isa(X,'Dog')],Results).

+!queryCycTest2 <-
	!initializeCommands;
	.wait(1000);
	!flp_query(member(X,[1,2]),Results);
	.print('Results: ',Results).

+!queryCycTest1 <-
	!initializeCommands;
	.wait(1000);
	// !flp_query_cyc([[X],member(X,[a,b,c,d])],Results);
	!flp_query_cyc([[X],isa(X,'Dog')],Results);
	.print('Results: ',Results).

