# INSTALLATION

These are steps to install the Telefile C system on F00. They
include rebuilding :PC and :PCC libraries to correct a bug that 
causes a MEMORY PROTECTION VIOLATION during initialization of
the C program.

1.  Bring up a CP-V F00 system.
Make sure that :SYS account has an online 9T resource and
online C0 privilege.

!SUPER\
SUPER HERE\
 M :SYS,LBE\
 B$PR=C0;O$PR=C0\
 OMCO=64;BMCO=64\
 BM9T=1;OM9T=1\
 BMPDIS=32000;OMPDIS=32000\
 END

Log off and back on to setup the SYS account.

2.  Restore the compiler and .CLIB accounts from the FRES tapes.
These will be 30b0.tap and 81b0-2.tap files.

FRES\
+VOL\
30B0\
+END

FRES\
+VOL\
81B0\
+END

4.  Make copies of DRSP, LYNX and LOADER IN :SYS to a scratch account
and patch them to allow use of the library name :PC and :PCC.  This will
avoid the :Pnn name restriction of F00.

If DRSP complains about the name format even after the patch, do a 
GENMD LIST to be sure the patch is installed.  If that looks good,
perhaps DRSP is being run from the shared processor version 
on the swapper.  Try DRSP  DROP DRSP and then run DRSP.:SYS to get the 
patched version.

C DRSP TO DRSP.KEN\
GENMD DRSP.:SYS\
,+AE74,6800AE7C\
END

C LYNX TO LYNX.KEN\
GENMD LYNX.:SYS\
,+A7AB,6800A865\
END

C LOADER OVER LOADER.KEN\
GENMD LOADER.:SYS\
PS1, +AB70,227FFF00\
END

5. Install CCX and :PCC in the shared processor tables.
See J:INSTALL.CCXA00JC script.

DRSP\
        DROP CCX,PERM\
        ENTER CCX FROM SP:CCX.CCXA00SP,M\
        DROP :PCC,PERM\
	ENTER :PCC FROM :PCC.CCLA00SP,S,P\
        END

6. Copy the compiler and other programs to :SYS.
 
PCL\
         COPY :PC.CCLA00SP    OVER :PC.:SYS(RD(ALL))\
         COPY SP:CC.CCXA00SP  OVER CC.:SYS(EX(ALL))\
         COPY SP:CCX.CCXA00SP OVER CCX.:SYS(EX(ALL))\
         COPY SP:CPP.CCXA00SP OVER CPP.:SYS(EX(ALL))\
         COPY SP:CCA.CCXA00SP OVER CCA.:SYS(EX(ALL))\
         COPY SP:CMP.CCXA00SP OVER CMP.:SYS(EX(ALL))\
         COPY SP:CHK.CCXA00SP OVER CHK.:SYS(EX(ALL))\
         COPY SP:YACC.CCXA00SP OVER YACC.:SYS(EX(ALL))\
         COPY SP:UPDATE.CCXA00SP OVER UPDATE.:SYS(EX(ALL))\
         END



7.  The C library on the 30b0 tape was built incorrectly
and does not define the correct size for the type 00 DATA section
of :PC.  This problem causes a MEMORY PROTECTION VIOLATION
when initializing C programs.

To correct this problem rebuild the :PC module with 
BOR:PCDATA.CCLA00BO, instead of BO:PCDATA.CCLA00BO using the
following scripts.  This will build both :PCC and :PC 
modules but we won't use the :PCC module.

Note the intermediate output from these links is saved in the .KEN scratch 
account.

And, also be sure you are using the patched versions of LYNX.

LYNX     BOR:PCDATA.CCLA00BO;\
         	OVER :PCCDATA.KEN;\
         (RD,NONE),(EX,NONE),;\
         (NL),(NTCB),(SL,F),(SS),(MN)\
SET M:EI /:PCCDATA.KEN\
SET M:EO /:PCDATA.KEN\
DEFCOM


LYNX    :J0.:SYS,;\
         :PCDATA.KEN,;\
         BO:CTYPE.CCLA00BO,;\
         BO:LIB.CCLA00BO,;\
         BO:CMAIN1.CCLA00BO,;\
         BO:DOPRINT.CCLA00BO,;\
         BO:ECVT.CCLA00BO,;\
         BO:FGETS.CCLA00BO,;\
         BO:FILBUF.CCLA00BO,;\
         BO:FINDIOP.CCLA00BO,;\
         BO:FLSBUF.CCLA00BO,;\
         BO:FOPEN.CCLA00BO,;\
         BO:FPRINTF.CCLA00BO,;\
         BO:FPUTS.CCLA00BO,;\
         BO:FREAD.CCLA00BO,;\
         BO:FWRITE.CCLA00BO,;\
         BO:GETS.CCLA00BO,;\
         BO:IO.CCLA00BO,;\
         BO:ISATTY.CCLA00BO,;\
         BO:MALLOC.CCLA00BO,;\
         BO:PRINTF.CCLA00BO,;\
         BO:SBRK.CCLA00BO,;\
         BO:SETBUF.CCLA00BO,;\
         BO:SPRINTF.CCLA00BO,;\
         BO:SCANF.CCLA00BO,;\
         BO:DOSCAN.CCLA00BO,;\
         BO:ATOF.CCLA00BO,;\
         BO:UNGETC.CCLA00BO,;\
         BO:F2I.CCLA00BO,;\
         BO:PROFILE.CCLA00BO,;\
         BO:STR.CCLA00BO,;\
         BO:ATOI.CCLA00BO,;\
         BO:CALLOC.CCLA00BO,;\
         BO:PROPRIN.CCLA00BO ;\
                                    OVER :PCC.KEN ;\
         (RD,NONE),(EX,ALL),;\
         (LB,1C200),(NL),(NTCB),;\
         (SL,F),(SS)\
SET M:EI /:PCC.KEN\
SET M:EO /:PC.KEN\
DEFCOM\
C :PC.KEN OVER :PC.:SYS

8.  Compile the sample HELLO WORLD program.  The :PCC library
must be installed as a shared library to run the complier
and the run unit.

CC HELLO-C.CCXA00XX BO:HELLO.KEN

 If you get the message

  AA00 WHAT PUBLIC LIBRARY?

from CC it indicates the :PCC library was not installed during
step 5.  Go back and do that again.

10. Link the rom with the :PC library and produce a load map.

LYNX (PC)BO:HELLO.KEN OVER LMN.KEN;.CLIB (M)

The load map for LMN.KEN should show size 3B4 for the 00 DATA
section.

 ************ PROTECTION TYPES **********\
      00 DATA  01 PROCEDURE  10 STATIC\
      -------  ------------  ---------\
 HIGH:  A3B3        A635        A5FF\
 LOW :  A000        A600        A400\
 SIZE:   3B4          36         200

10.  Run the program and check the output.\
!LMN.KEN\
 hello world

# USAGE NOTES

## Interface to CP-V.
### Lower Case
Be aware that F00 AP does not accept lower case characters.  Don't write assembly language
code with lower case characters.

### Inline Asembly Code
There seems to be a bug in the compiler ca module that causes it to abort when the
asm() feature is used.


