// a nonsensical attempt, to be improved upon

// /var/lib/myfrdcsa/codebases/minor/free-softbot/domains/domains.lisp

+findFileInSearchDirectoryByBaseNameRecursively(BaseName,SearchDirectory) : .basenameP(BaseName) & .directoryP(SearchDirectory) & directoryExists(SearchDirectory) <-
    directory_files(SearchDirectory,Files);
    .member(File,Files);
    if (basename(File,BaseName))
    {
     .addPercept(foundFile(File));
     .addPercept(basename(File,BaseName));
     .addPercept(containingDirectory(File,SearchDirectory));
     .succeed_goal(findFileInSearchDirectoryByBaseNameRecursively(BaseName,SearchDirectory));
     }
    elsif (.directoryP(File))
    {
         +findFileInSearchDirectoryByBaseNameRecursively(BaseName,File);
    }.

+findFileInSearchDirectoryByBaseNameRecursively(BaseName,SearchDirectory,FoundFile) : .basenameP(BaseName) & .directoryP(SearchDirectory) & directoryExists(SearchDirectory) <-
    directory_files(SearchDirectory,Files);
    .member(File,Files);
    if (basename(File,BaseName))
    {
     FoundFile = File;
     .succeed_goal(findFileInSearchDirectoryByBaseNameRecursively(BaseName,SearchDirectory,FoundFile));
     }
    elsif (.directoryP(File))
    {
         +findFileInSearchDirectoryByBaseNameRecursively(BaseName,File);
     } else
    {
     .fail;
     }.

// +atLocation(File,Dir).

// active.on
// animation.document
// character.count
// copy.of
// creation.date
// current.directory
// current.domain
// current.host
// current.machine.type
// current.path
// current.path.reset
// current.shell
// current.userid
// derived.from
// display.color
// document.job
// domain.machine.name
// domain.name.nickname
// dvi.document
// dvitps.path
// file.type
// finger.record
// first.initial
// ftp.directory
// ftp.file
// group.protection
// home.phone
// http.text
// idle.time
// image.document
// job.name
// job.number
// job.printer
// job.status
// job.user
// latexed.path
// line.count
// located.at
// logged.on
// machine.admin
// machine.alive
// machine.color
// machine.domain
// machine.model
// machine.name
// machine.netfind.server
// machine.nickname
// machine.op.sys
// machine.room
// machine.room.number
// machine.unfingerable
// machine.unrshable
// machine.xterm
// mpeg.play
// mpeg.play-error
// netfind.exp
// office.phone
// office.room
// op.sys
// parent.directory
// person.domain
// person.title
// phone.number
// points.to
// postscript.document
// printer.name
// printer.status
// print.job
// print.queue.status
// room.number
// same.length
// server.busy
// simple.file
// staffdir.record
// staff.member
// string.in.file
// tex.document
// text.document
// userid.login.machine
// userid.room
// web.page
// word.count

// (defoperator CD ((directory ?d) (path ?n))
//  (declare ((directory ?old) (path ?oldpath)))
//  (documentation "Change the current working directory")
//  (precond (satisfy (pathname ?d ?n)))
//  (undo-cond (and (satisfy (current.directory ?old))
//       (satisfy (pathname ?old ?oldpath))))
//  (interface ((exec-func execute-unix-command)
//       (translation ("cd " ?n))
//       (undo-trans ("cd " ?oldpath))
//       (error-func default-unix-error?)
//       (terminate-detect read-unix-prompt)))
//  (effect (cause (current.directory ?d))))

// Change the current working directory
+!cd(Directory,Path) : pathname(Directory,Path)
    <-
        effects([cd(Path)]);
        .addBelief(currentDirectory(Directory)).

// (defoperator FIND-FILE ((path ?pathname) (file !file))
//  (precond (satisfy (current.shell csh)))
//  (effect (observe (pathname !file ?pathname)))
//  (interface ((exec-func execute-unix-command)
//       (sense-func ( (!file) (find-file-sense :new)))
//       (translation ("ls -dF " ?pathname))
//       (sensor-bind-func ucpop::my-get-sense-bindings)
//       (error-func no-error))))

+!findFile(PathName,File) : currentShell(csh)
    <-
        ?pathname(File,Pathname).

// (defoperator LS ((directory ?d) (path ?dp))
//  (precond (and (satisfy (current.shell csh))
//     (satisfy (pathname ?d ?dp))))
//  (effect (forall ((file !f))
//    (exists ((path !p) (filename !n))
//     (when (parent.directory !f ?d)
//      (and (observe (parent.directory !f ?d))
//       (observe (pathname !f !p))
//       (observe (filename !f !n)))))))
//  (interface ((exec-func execute-unix-command)
//       (translation ("ls -F " ?dp))
//       (sense-func ((!f !n !p) (ls-sense ?dp :new)))
//       (sensor-bind-func ucpop::my-get-sense-bindings)
//       (error-func default-unix-error?)
//       (terminate-detect read-unix-prompt))))

+!ls(Directory,Path) : currentShell(cs) & pathname(Directory,Path)
    <-
        parentDirectory().

// (defoperator PWD ((directory !dir))
//  (declare ((path !path)
//     (filename !name)))
//  (precond (satisfy (current.shell csh)))
//  (effect (when (current.directory !dir)
//    (and (observe (current.directory !dir))
//     (observe (pathname !dir !path))
//     (observe (filename !dir !name)))))
//  (interface ((exec-func execute-unix-command)
//       (sensor-bind-func ucpop::my-get-sense-bindings)
//       (sense-func ((!path !name !dir) (pwd-sense :new)))
//       (translation ("pwd")))))

+!pwd(Dir) : currentShell(csh)
    <-
        if(currentDirectory(Dir))
        {
         ?currentDirectory(Dir);
         ?pathName(Dir,Path);
         ?filename(Dir,Name);
         }.

// (defoperator WC ((simple.file ?x) (number !char) (number !word)
//       (number !line) (directory ?dir))
//  (declare ((filename ?name)))
//  (precond (and (satisfy (current.shell csh))
//     (satisfy (current.directory ?dir))
//     (satisfy (parent.directory ?x ?dir))
//     (satisfy (filename ?x ?name))))
//  (effect (and (observe (character.count ?x !char))
//    (observe (word.count ?x !word))
//    (observe (line.count ?x !line))))
//  (interface ((exec-func execute-unix-command)
//       (sensor-bind-func ucpop::my-get-sense-bindings)
//       (sense-func ((!char !word !line) (wc-sense)))
// 
//       (error-func default-unix-error?)
//       (translation ("wc \"" ?name "\"")))))

+!wc(SimpleFile,Char,Word,Line,Dir) :
    currentShell(csh) & currentDirectory(Dir) & parentDirectory(SimpleFile,Dir) & filename(SimpleFile,Name)
    <-
        ?characterCount(SimpleFile,Char);
        ?wordCount(SimpleFile,Word);
        ?lineCount(SimpleFile,Line).

// (defoperator GREP ((string ?string) (simple.file ?x) (bool !grep-t))
//  (declare ((filename ?nm) (directory ?d)))
//  (precond (and (satisfy (current.shell csh))
//     (satisfy (current.directory ?d))
//     (satisfy (filename ?x ?nm))
//     (satisfy (parent.directory ?x ?d))))
//  (effect (observe (string.in.file ?string ?x) !grep-t))
//  (interface ((exec-func execute-unix-command)
//       (sense-func ((!grep-t) grep-sense))
//       (error-func no-error)
//       (translation ("grep " ?string " " ?nm)))))

+!grep(String,SimpleFile,GrepT) :
    currentShell(csh) & currentDirectory(Dir) & filename(SimpleFile,Name) & parentDirectory(SimpleFile,Dir)
    <-
        ?stringInFile(String,SimpleFile).

// (defoperator OWNER-OF-FILE ((file ?x) (userid !owner))
//  (declare ((filename ?nm) (directory ?d)))
//  (precond (and (satisfy (current.shell csh))
//     (satisfy (current.directory ?d))
//     (satisfy (parent.directory ?x ?d))
//     (satisfy (filename ?x ?nm))))
//  (effect (and (observe (owner ?x !owner))))
//  (interface ((exec-func execute-unix-command)
//       (sensor-bind-func ucpop::my-get-sense-bindings)
//       (sense-func ((!owner) owner-of-file-sense))
//       (translation ("ls -lLd " ?nm )))))


