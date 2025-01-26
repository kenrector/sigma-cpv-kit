## Loading the BASIC source code into CP-V

After booting the SimH sigma emulator into CP-V, connecting a terminal window via telnet, and logging in, it should be a simple matter of opening the file build_BA.TREK in a host system text editor, copying its contents to the host system clipboard, and then selecting the CP-V terminal window and pasting the clipboard contents into the terminal. It may take a bit of time to empty the clipboard into the CP-V terminal window, so be patient. The file build_BA.TREK contains, in addition to the BASIC source code itself, a CP-V terminal command to start the BASIC interpreter (the first line of the build file) and then at the end of the build file the BASIC commands "SAVE OVER BA:TREK" followed by "SYSTEM" to save the BASIC code as a CP-V file in the logged-on user's directory and then return to the CP-V terminal command prompt ("!"). (Type "L" -- List -- to satisfy yourself that the BA:TREK file has indeed been created.)

NOTE: The specific procedure for copying a file from your text editor onto the system clipboard, and then pasting the clipboard contents into your CP-V terminal window depend on the details of the host operating system, text editor, and terminal emulator you're using.

In Windows, just open build_BA.TREK in notepad, type "Ctrl A" to select the whole file, and then either right-click on the text and select "Copy" from the context menu, or click Edit->Copy from notepad's menu, to get the text onto the clipboard. Then, if you're using PuTTY as your terminal emulator (for the CP-V terminal window), just putting the mouse in the terminal window and right-clicking will start transferring the text from the clipboard into the terminal window. Other terminal emulators may require a different procedure (e.g., mintty under Msys2 will open a context menu when you right-click in the terminal window, from which you would select "Paste").

In Linux, if you're using vim as your text editor, you must have a version that supports the system clipboard (":version" option list shows "+clipboard"); then ":1,$y+" will copy the entire contents of the file you've got open in the editor onto the clipboard. If your vim ":version" shows "-clipboard", then you'll have to use (or install, if necessary) a different editor (e.g., notepadqq).

In MacOS, the procedure should be pretty much the same as for Linux.


## Running the BASIC program

Just type "BASIC BA:TREK" at the CP-V terminal command prompt, and the BASIC interpreter will start and load the game. Then type "RUN" at the BASIC prompt (">") and the game will start.  The game itself doesn't seem to have a command to exit back to the BASIC prompt (">"), but typing "Ctrl ]" to get the "telnet>" prompt in the terminal window and then typing "send break" followed by a <return> will do so (typing "Esc F" will also do so).


## History

In early 2016, almost 7 years before a fully-functional SimH-based Xerox Sigma emulator existed, a certain retrocomputing enthusiast, who had (in 2011) obtained a working copy of George Plue's DOS-based "Siggy" Sigma/CP-V emulator following its author's death (via Plue's colleague Keith Calkins, both formerly of Andrews University), decided he wanted to do "something useful" with the emulator. He had learned that the earliest version of what became the "Star Trek" text-based computer game had in fact been developed by its original author Mike Mayfield on a Sigma 7 ( https://en.wikipedia.org/wiki/Star_Trek_(1971_video_game) ), and that a subsequent port (by Mayfield himself, in 1972-73) to HP BASIC was at that time available on the Web (from Pete Turnbull's Star Trek Web site http://www.dunnington.u-net.com/public/startrek/ , which now only exists on the Wayback Machine).

So he thought he'd try back-porting that HP version to CP-V running on Siggy (running on a Windows XP machine in an NTVDM window).  It wasn't possible to simply copy/paste into Siggy, but "typing" into it via AutoHotkey did the job.

The unmodified HP BASIC version (downloaded from Pete Turnbull's erstwhile Star Trek Web site) is included here in the directory "Original_HP_version", for reference.

