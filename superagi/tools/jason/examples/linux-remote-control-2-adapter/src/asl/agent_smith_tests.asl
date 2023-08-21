+!run_lrc_tests <-
	true.

+!test(systemCommandsOn(localhost)) <-
	!sys(pwd(CurrentDir));
	.print('Current Dir is: ',CurrentDir).

+!test(systemCommandsOn(remoteHost)) <-
	true.

+!test(systemCommandsOn(virtualMachine)) <-
	true.

