
# Adventure

## Introduction:

Adventure is a text-based exploration game originally developed in the 1970's for the PDP-10 mainframe.  There were many different iterations of the game for different platforms over the years.  The source code isn't necessarily portable from one machine type to another due to differing word lengths, FORTRAN or BASIC language syntax quirks and text characters (ASCII? EBCDIC? BCD?).

Dave Platt at the Honeywell LADC created and released CP-V Adventure in 1979.  This version, distributed on the monthly CP-V SST patch tapes, was written in CP-V ANS Fortran.  If your implementation of CP-V doesn't have the ANS FORTRAN compiler, it is relatively simple to install from the release tapes - see Note 0 below.

## Install Adventure Files From Tape Images:

The Adventure files are available on the November, 1981 SST tape available in the sigma-cpv-kit directory.  Installation consists of copying 37 files from the SST tape down to your CP-V directory and then running 3 batch jobs to build the Adventure Translator (ADVT) and Interpreter (ADVI) programs.

The SST tape is file SST1181.tap.zip in sigma-cpv-kit/f00.  Unzip the file using your utility of choice to produce file ptch1181.tap.  You will need to move this file to your CP-V directory so that it can be mounted as a Xerox labeled tape.

Log on to CP-V and copy the following 37 files from the SST tape to your user account directory:


|                      |                     |                     |                     |
|----------------------|---------------------|---------------------|---------------------|
|$::ADV |ADV:C |ADVINFO|
|ADVJOB | ADVLYNX| ADVSI|
|BREAKSI |CACHESI|D:ACTION|
|D:BITS|D:DEFINE|COMPILE_AND_LIST_CAVE |
|D:INIT|D:LABELS|COMPILE_CAVE|
|D:MOVES|D:NULLS|D:OBJECTS|
|D:OBJSYN|D:PLACE|D:REPEAT|
|D:TEXT|D:VARS|D:VERBS|
|DECSI|ENCSI|FASTREADSI|
|GETACCTSI|MASHSI|MUNGE:C|
|MUNGEJOB|MUNGELYNX|MUNGESI|
|OUTSWPSI|PRIMESI|REGMETA|
|SVARSI|


You can either copy the files one at a time with the PCL COPY command or build a file containing all the commands that is assigned to M:SI prior to starting PCL.

Assuming you are entering the copy commands manually and want the files in your current directory, the command would be:

COPY LT#PTCH/filename.SST TO filename          [where filename is from the above list]

When the COPY is entered, CP-V will issue a MOUNT request for labeled tape LT#PTCH on the console.  You'll need to note which device is being requested (typically either 9TA80 or 9TA81) and then enter [ctl/e] on the console to escape to SIMH.  Attach the .tap file to device mt0 (for 9TA80) or mt1 (for 9TA81) and then enter continue.  Now that you are back to the CP-V console, enter a CP-V mount command to tell CP-V that a tape is available at A80 or A81.  See example below:

<pre>
63:OWLNET                 MOUNT 9TA80,PTCH     [CP-V console requests mount in response to PCL]
[ctl/E]                                        [interrupt CP-V with ctl/E to connect to SIMH]
Simulation stopped, PC: 024F0 (B 24A7)
sim> attach mt0 ptch1181.tap                   ["attach" the SST tape file to the SIMH device]
%SIM-INFO: MT0: Tape Image 'ptch1181.tap' scanned as SIMH format
sim> continue                                  [enter "continue" to return to CP-V]
[ctl/P]                                        [enter a console interrupt request to CP-V]
!MOUNT A80                                     [and tell CP-V the tape is mounted and ready]
</pre>

After all the files are loaded, you are ready to begin the compile and assemble process that will eventually create ADVT and ADVI, the actual program modules that make up Adventure.

## Compile Adventure:
The version of Adventure that is distributed on the SST tape contains a module to prevent running Adventure during prime-shift hours -- in university settings this was a real concern due to processor load.  As you will likely want to explore Colossal Cave as soon as possible, you should modify line 100 of file PRIMESI before running the batch jobs.

In PRIMESI, change the value of ENABLED on line 100 as follows:
<pre>
Before: ENABLED  DATA     0                 * SET TO NONZERO FOR PRIME-TIME USE  100.000  
After:  ENABLED  DATA     1                 * SET TO NONZERO FOR PRIME-TIME USE  100.000
</pre>
Three of the files that you downloaded are batch JCL that will be used to execute the ANS FORTRAN compiler and AP assembler.  

Warning, before you start running these you should be aware that the LIMIT command CO option in ADVJOB and MUNGEJOB is too low and will cause those jobs to abort.  You can avoid this by setting CO to 64 in each job.  Also look ahead here to note 2 below, that describes the requirement for the FLIBMODE module.

Then, in the following order, run ...
<pre> 
!BATCH ADVJOB  
!BATCH MUNGEJOB  
!BATCH COMPILE_CAVE  (or !BATCH COMPILE_AND_LIST_CAVE if you want lots of output)
</pre>
Once all of the jobs have completed without errors. sit back, relax and type in ADV.account (unless you installed it in :SYS for which only ADV is needed).

## Notes:

**Note 0:** If you don't have the ANS FORTRAN compiler installed on your CP-V system, you'll need to copy the ANSFORT module from the .CPVPROC account on the release tape to your :SYS account.  Use the 00f0.tap SIMH tape file unzipped from F00-00F0.tap.zip (located in sigma-cpv-kit/f00) and enter the following PCL commands: 

COPY LT#00F0/ANSFORT TO DC/ANSFORT.:SYS   [restart CP-V after this change]


**Note 1:** If you receive the error "AA00 What Public Library?" from ANS FORTRAN, you need to copy the :P00 and :P11 library modules from the .CPVPROC account on the release tape to your :SYS account.  Use the 00f0.tap SIMH tape file unzipped from F00-00F0.tap.zip (located in sigma-cpv-kit/f00) and enter the following PCL commands: 

COPY LT#00F0/:P00 TO DC/:P00.:SYS
COPY LT#00F0/:P11 TO DC/:P11.:SYS


**Note 2:** If you receive the error "UNABLE TO FIND SYSTEM- FLIBMODE" from the AP assembler, you need to copy the FLIBMODE system def module from the 29F0.tap.zip archive tape (located in sigma-cpv-kit/f00).  Unzip the file to produce 29F0.tap and then enter the following PCL commands:

COPY LT#29F0/FLIBMODE TO DC/FLIBMODE.:SYS 


**Note 3:** References and documentation of interest:

[Wikipedia History of Adventure Game Genre](https://en.wikipedia.org/wiki/Adventure_game)  
[Wikipedia Colossal Cave Adventure](https://en.wikipedia.org/wiki/Colossal_Cave_Adventure)  
[The Colossal Cave Adventure Page](https://rickadams.org/adventure/)  

   




 

