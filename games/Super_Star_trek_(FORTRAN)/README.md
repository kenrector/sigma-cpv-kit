## Build Issue

Because of an implementation shortfall this code won't compile with CP-V ANSFORT, so it doesn't run on F00.  

Run it on the cpcp Andrews system.

## Building the Super Star Trek executable from Fortran 77 source in CP-V

After booting the SimH Sigma emulator into CP-V, connecting a terminal window via telnet, and logging in, it should be a simple matter of opening the file build_TRTREK in a host system text editor, copying its contents to the host system clipboard, and then selecting the CP-V terminal window and pasting the clipboard contents into the terminal. It will take a while to empty the clipboard into the CP-V terminal window, so be patient. The file build_TRTREK contains: 1) a sequence of Tele-Edit commands to build the 63 F7:TR* Fortran source files in the user's directory; 2) a Tele-Edit command to load the game instructions as text file TX:STARTRK; 3) a sequence of F77 commands to compile 62 of the source files to the corresponding BO:TR* object files (F7:TREKCOM is INCLUDEd by the other source files, and is not itself compiled); 4) a LEMUR (CP-V object librarian) command to build the LB:TRTREK object library from 61 BO:TR* object files (i.e. all the object files except the main routine's object file BO:TRTREK; 5) a LYNX (CP-V linker) command to build the executable TRTREK. from BO:TRTREK and LB:TRTREK; 6) a sequence of DELETE commands to clean up the user directory by removing the F7:TR*, BO:TR*, and LB:TRTREK files. When all this has finished and the CP-V terminal command prompt ("!") has returned, type "L" -- List -- to satisfy yourself that that the TRTREK. Super Star Trek executable and the TX:STARTRK text file have been successfully created.

NOTE: The specific procedure for copying a file from your text editor onto the system clipboard, and then pasting the clipboard contents into your CP-V terminal window depend on the details of the host operating system, text editor, and terminal emulator you're using.

In Windows, just open build_TRTREK in notepad, type "Ctrl A" to select the whole file, and then either right-click on the text and select "Copy" from the context menu, or click Edit->Copy from notepad's menu, to get the text onto the clipboard. Then, if you're using PuTTY as your terminal emulator (for the CP-V terminal window), just putting the mouse in the terminal window and right-clicking will start transferring the text from the clipboard into the terminal window. Other terminal emulators may require a different procedure (e.g., mintty under Msys2 will open a context menu when you right-click in the terminal window, from which you would select "Paste").

In Linux, if you're using vim as your text editor, you must have a version that supports the system clipboard (":version" option list shows "+clipboard"); then ":1,$y+" will copy the entire contents of the file you've got open in the editor onto the clipboard. If your vim ":version" shows "-clipboard", then you'll have to use (or install, if necessary) a different editor (e.g., notepadqq).

In MacOS, the procedure should be pretty much the same as for Linux.


## Running the Super Star Trek program

Just type "TRTREK." at the CP-V terminal command prompt, and the game will start (NOTE: the "." at the end of the file name is required -- it indicates that the executable -- the "load module" -- is to be found in the local directory).


## Some tips

1. Getting output on the lineprinter (i.e., in whatever text file is attached to device "LP" in your SimH configuration file): A) On the SimH CP-V console, after CP-V has booted up (like, just before or after you've typed Ctrl-P, ON 107 <Return>) type Ctrl-P, SLP,I <Return> (to "initiate the lineprinter symbiont"); B) On the logged-in terminal, before starting the game (at the "!" prompt), type SET F:108 LP <Return> (this ensures that output to LUN -- logical unit -- 108 in Fortran is directed to the printer); C) After the game has ended and you're back at the "!" prompt, type PRINT <Return> to flush out the CP-V printer queue; D) Remember that SimH's LP buffer won't actually be flushed out to the attached text file until SimH itself exits.

2. About "TOURNAMENT" games: The idea behind a "tournament" game is that the name or number you type in, to identify the tournament, is then used to seed a random number generator, resulting in an identical sequence of pseudo-random numbers, in turn resulting in identical games for identical actions. So it provides a level playing field for people to compete against each other -- the chance element is held constant. In the original VAX code there are calls to RANF(0), but they are mapped to the standard DEC function RAN(). On the Sigma, it just so happens that, on the Andrews University system, library module RND (in :LIB.:SYS) contains a function RANF() (and also functions named DRANF() and IRANF()), that is apparently "self-seeding" from the M:TIME system call, so that successive calls to RANF(0) will always generate a different sequence of numbers (fractions >=0 and <1) each time the program is run (the argument is ignored). So in order to get a reproducible sequence of random numbers, the following code was cribbed from _The C Programming Language_, Brian W. Kernighan and Dennis M. Ritchie, Second Edition (Prentice Hall, 1988), p. 46 (in Chapter 2, "Types, Operators and Expressions"):

   ####
       unsigned long int next = 1;

       /* rand:  return pseudo-random integer on 0..32767 */
       int rand(void)
       {
           next = next * 1103515243 + 12345;
           return (unsigned int)(next / 65536) % 32768;
       }

       /* srand:  set seed for rand() */
       void srand(unsigned int seed)
       {
           next = seed;
       }

This algorithm was incorporated into the file F7:TRRANF, which contains function RAND() and entry point RANSET (all calls to RANF(0) elsewhere in the code were changed to RAND()). The "granularity" of this generator is based on 16-bit integers rather than 32-bit integers, but that doesn't matter for the purposes here. NOTE: this substitute code is only used for "tournament" games; for "regular" games the seed is set to 0 and calls to RAND() are just passed along to the Andrews library function RANF(), which generates a unique sequence of random numbers for each run of the game. Also NOTE: If you use an alphanumeric string as your tournament name (i.e., anything starting with a letter), then only the first four characters (32 bits worth) are significant. If you use all numbers, they get converted to floating-point and then truncated to integer to form the seed, so anything in the range 1..9999999 will provide a unique sequence of pseudo-random numbers. A negative number is converted to its absolute value; leading 0's are ignored. The first occurrence of a letter in a string of digits terminates the number at the digit before it.

3. About "FROZEN" games: You can use the command "FREEZE" to save the current state of an in-progress game to a file and exit the current game (but not the program). You'll then get the "ENTER FILE NAME:" prompt; just typing the Return key at this point results in the "GAME NOT FROZEN." message followed by the reappearance of the "COMMAND:" prompt. The "freeze file" created contains data about the current state of the game. It gets "TK:" automatically prepended to a user-selected name, which is significant to 7 characters (not including the TK: "extension"), and should be an alphanumeric string which must start with a letter (anything typed beyond the allowed length is ignored; non-alphanumeric characters after the initial letter may be either ignored or result in a file with an unexpected name). After the "FREEZE" command is executed, you'll get the "DO YOU WANT TO PLAY AGAIN?" prompt. The game can be resumed then or at any later time by selecting "FROZEN" as the response to the initial question about the type of game wanted, and responding to the "ENTER FILE NAME:" prompt. The file name typed should omit the "TK:" prepended extension -- that's added automatically. If the file doesn't exist, you'll get the "GAME NOT FROZEN." message followed by a repeat of the question about the type of game wanted.

4. About the "EMEXIT" Emergency Exit command: This performs an automatic "freeze" of the game to a file named TK:EMSAVE (any previously-existing file of that name is overwritten), and then the program itself (not just the current game) is exited. Before exiting, the screen is "cleared" (by calling subroutine GETOUT in F7:TRGETOU which in turn calls SKIP in F7:TRSKIP) by emitting 24 blank lines. The game can later be resumed as with any FROZEN game, by selecting "EMSAVE" as the "freeze file" name. This facility was presumably provided to enable a quick exit in case the boss was about to make an appearance, though in our case the "EXIT" on the terminal just before the "!" Terminal Executive Language (TEL) prompt is a bit of a giveaway.

5. Getting a list of commands: If you type "?" at the "COMMAND:" prompt, you'll get a list of legal commands (this is true if you type anything that's not recognized as a command, as indicated by the "UNRECOGNIZED COMMAND" message). Do **not** type "HELP"! ("HELP" is a long-range transporter command to get out of a tight spot; it can save or destroy the ship.) Most commands can be abbreviated, but a few (TERMINATE, FREEZE, DESTRUCT, DEATHRAY, HELP) must be typed in full in order to be recognized.

6. Exiting the program: TERMINATE and EMEXIT are the "official" ways to get out, but typing "Esc F" will immediately abort the program (as will typing "Ctrl-]" to get the "telnet>" prompt, and then "send break"). ("Esc F" also clears the screen like EMEXIT, but doesn't create a freeze file.)

7. The source file F7:TRDEBUG is an addition to the original VAX complement, and was created in order to add some commands that facilitated testing the game without actually being able to play it very well. In particular, the "DEBUG" command was a generic command that could be attached to any subroutine that needed to be tested. In its final state, it calls the subroutine that generates a commemorative plaque (see the file "plaque.dat" in the "Original_VAX_version" directory), which can appear either on the terminal or on the lineprinter (if the latter has been set up properly). Unlike the VAX version of the plaque, the CP-V version has a hard-coded date (April Fool's Day, 2016).


## History

In early 2016, following a successful attempt to "back-port" Mike Mayfield's HP BASIC version of the Star Trek text-based computer game to CP-V (on the late George Plue's DOS-based "Siggy" Sigma/CP-V emulator), Keith Calkins (Plue's erstwhile colleague at Andrews University) mentioned that students at Andrews had once run a Fortran version of a Star Trek game on the campus Sigma. After some searching, a Fortran Star Trek was discovered on the Web site of one Oleg Uryutin, who had been a student in the early 80s at the Minsk Radiotechnical Institute and had fond memories of discovering a PDP-11 version of Star Trek and who, with the help of a colleague there, had ported the game from RT-11 to RSX-11M on the PDP-11. His site (which is now, alas, defunct and not even archived on the Wayback Machine) had the source code for a VAX Fortran version of the University of Texas "Super Star Trek", which turned out to be possible to port to F77 on CP-V.

The unmodified VAX source code, along with VMS command files to build the executable, are included here in the directory "Original_VAX_version", for reference. (The VAX code builds and runs without a hitch on a SimH VAX-11/780 running VMS 4.7 and VAX Fortran V4.8-276. The top-level build command is "@TREKBLD".)
