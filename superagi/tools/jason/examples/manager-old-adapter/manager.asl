emergencyContactFor(person1,person2).

!acknowledged(person1,"Do Task 1").

+!acknowledged(Agent,Message) <-
    contactViaAbout(Agent,headphones,Message).

-!acknowledged(Agent,Message) <-
    .wait(1000);
    contactViaAbout(Agent,loudSpeakers,Message).

-!acknowledged(Agent,Message) <-
    .wait(1000);
    contactViaAbout(Agent,textMessage,Message).

-!acknowledged(Agent,Message) <-
    .wait(1000);
    contactViaAbout(Agent,phoneCall,Message).

-!acknowledged(Agent,Message) <-
    ?emergencyContactFor(Agent,EmergencyContact);
    .wait(1000);
    contactViaAbout(EmergencyContact,textMessage,Message).

-!acknowledged(Agent,Message) <-
    ?emergencyContactFor(Agent,EmergencyContact);
    .wait(1000);
    contactViaAbout(EmergencyContact,phoneCall,Message).
