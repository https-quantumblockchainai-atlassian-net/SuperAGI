hasCannedReply(['Please state your action/goal: '],'Finish metaplanner system').
hasCannedReply(['Please review: ','Finish metaplanner system','. Is it an goal or an action: '],goal).
hasCannedReply(['Consider this goal: ','Finish metaplanner system','. Is it currently obtainable for: ','andrewDougherty','. yes or no?: '],no).
hasSubgoal('Finish metaplanner system','Write down metaplanner skills').
hasSubgoal('Finish metaplanner system','Iterate over list of metaplanner skills, and implement').

hasCannedReply(['Please review: ','Write down metaplanner skills','. Is it an goal or an action: '],action).
hasCannedReply(['Please review: ','Iterate over list of metaplanner skills, and implement','. Is it an goal or an action: '],action).

hasSubaction('Write down metaplanner skills','Obtain source of execution skills information').

hasCannedReply(['Please review: ','Obtain source of execution skills information','. Is it an goal or an action: '],action).

hasCannedReply(['Does agent ','andrewDougherty',' have the necessary resources to accomplish: ','Finish metaplanner system','. yes or no?: '],no).

hasNecessaryResources('andrewDougherty','Finish metaplanner system',['']).
