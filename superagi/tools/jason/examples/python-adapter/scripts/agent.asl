!start.

// +!start <-
// 	.custom_action(3, X);
// 	.print("X =", X);
//  	.print("I LOVE THIS!").

+!start <-
	+goal(solveUserProblem(andrewDougherty,problem1),3).

+goal(X,Y) <-
 	.call_java_agentspeak(Y,Z);
	.print("I LOVE THIS!: ",X,Z).

// +!call_language_model(Model