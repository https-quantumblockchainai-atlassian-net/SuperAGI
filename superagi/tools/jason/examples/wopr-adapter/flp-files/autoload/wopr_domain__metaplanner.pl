hasCannedReply(['Please state your action/goal: '],'Finish wopr system').
hasCannedReply(['Please review: ','Finish wopr system','. Is it an goal or an action: '],goal).
hasCannedReply(['Consider this goal: ','Finish wopr system','. Is it currently obtainable for: ','andrewDougherty','. yes or no?: '],no).
hasSubgoal('Finish wopr system','Write down wopr skills').
hasSubgoal('Finish wopr system','Iterate over list of wopr skills, and implement').

hasCannedReply(['Please review: ','Write down wopr skills','. Is it an goal or an action: '],action).
hasCannedReply(['Please review: ','Iterate over list of wopr skills, and implement','. Is it an goal or an action: '],action).

hasSubaction('Write down wopr skills','Obtain source of execution skills information').

hasCannedReply(['Please review: ','Obtain source of execution skills information','. Is it an goal or an action: '],action).

hasCannedReply(['Does agent ','andrewDougherty',' have the necessary resources to accomplish: ','Finish wopr system','. yes or no?: '],no).

hasNecessaryResources('andrewDougherty','Finish wopr system',['']).
