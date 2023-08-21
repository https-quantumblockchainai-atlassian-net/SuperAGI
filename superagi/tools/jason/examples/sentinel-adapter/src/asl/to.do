/*
+!convert_from_pengine_list_to_jason_list(Input,Output) <-
	Input = '[|]'(First,Second);
	.print([second,Second]);
	!convert_from_pengine_list_to_jason_list(Second,Result);
	.print([first,First]);
	if (not .ground(First)) {
			       .concat([NewVar],Result,Output);
			       } else {
				       .concat([First],Result,Output);
				       };
	.print([output,Output]).
*/



(questions
 (how to convert between atoms and strings.)
 (how to atomic_list_concat/2,3)
 (solution
  (How to string comparison)
  (Can do .substring(A,), and maybe and .substring(B,A)))
 )

(todo
 (Have to make a reliable way to query flp safely)
 (Have to fix the [|] -> [] issue)
 
 )
