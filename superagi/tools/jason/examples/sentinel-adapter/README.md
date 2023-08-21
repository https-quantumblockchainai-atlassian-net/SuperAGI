I have just copied and search and replaced this from the
executive-function-adapter at [2022-11-04,10:02:49].  The point of
this will be to reimplement sentinel, which is our current system for
monitoring the file system and performing actions on files, most
notably things like downloaded research papers.  I am going to udpate
it to integrate with FLP and to store everything in Prolog data
structures, whereas previously sentinel was not storing everything.
Moreover, I plan to expand the operations it can perform. So for
instance, today I thought that when it extracts authors' emails, it
should attempt to locate their github accounts, using a google search
for "<NAME> github", "<EMAIL> github", etc.  Then it can offer to
download their repositories using github-spider, etc.  I'll have to
work on a useful dialog manager for all of our Jason systems.  I also
need to fix the fact that it pegs processor at 200% due to aggressive
looping.
