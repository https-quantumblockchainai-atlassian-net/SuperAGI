hasCannedReply(['Please state your action/goal: '],'Finish executive function system').
hasCannedReply(['Please review: ','Finish executive function system','. Is it an goal or an action: '],goal).
hasCannedReply(['Consider this goal: ','Finish executive function system','. Is it currently obtainable for: ','andrewDougherty','. yes or no?: '],no).
hasSubgoal('Finish executive function system','Write down executive function skills').
hasSubgoal('Finish executive function system','Iterate over list of executive function skills, and implement').

hasCannedReply(['Please review: ','Write down executive function skills','. Is it an goal or an action: '],action).
hasCannedReply(['Please review: ','Iterate over list of executive function skills, and implement','. Is it an goal or an action: '],action).

hasSubaction('Write down executive function skills','Obtain source of execution skills information').

hasCannedReply(['Please review: ','Obtain source of execution skills information','. Is it an goal or an action: '],action).

hasCannedReply(['Does agent ','andrewDougherty',' have the necessary resources to accomplish: ','Finish executive function system','. yes or no?: '],no).

hasNecessaryResources('andrewDougherty','Finish executive function system',['']).
