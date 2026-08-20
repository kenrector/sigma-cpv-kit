29d0.tap is an FSAVE tape containing source code, JCL and LMN for the XPL/S compiler developed at University of Washington in 1974.

## Documentation

Documentation is two papers from University of Washington library archives describing development of XPL/s and the language.  The documentation files are scanned images from UW and a PDF produced by  LyX of one of them.  The LyX pdf was made to provide a searchable text reference manual.

## Installing XPL/S on CP-V:  

Log on as :SYS,LBE.  
Make sure the account has a 9T resource.  
Attach file 29d0.tap to mtn.  
run FRES   
+VOL   
29d0   
+END  
Mount the tape.  Files will be installed in account .XPLS  
Use $SUPER.XPLS to make a logon for XPLS  
Log on as XPLS,CPV  
A LMN for XPLS was installed from the tape.  You can use it as is, or run $BUILD.XPLS  
to compile and link a load module and generate the .XPLSBO and .XPLSLO files.


## Bootstrapping XPL/s from paper listings.

This C00 version of the XPL/S compiler was developed at the University of Washington between 1972 and 1974.  The compiler source code was submitted to the Xerox Programming Library under catalog number 890923.  This tape is available but has been unreadable with the available equipment.

A paper listing of the compiler source code was found in the Emil Gottwald collection at the Computer History Museum.  The museum scanned these listings to provide .png images of each page.  The scanned images were processed using an OCR program.  Of the 4000 lines of code only about 1000 gave usable text data.  The remaining 3000 were too dimly printed for the OCR process and had to be typed in by hand.  The 1000 lines of OCR output were corrected by hand.

Dan Weaver has written an XPL compiler in C that runs on Unix like systems.  Dan had previously ported the GORDO Sigma 5 XPL compiler to run on Unix like systems.  This XPL compiler was modified to accept the XPL/S syntax and produce the XPL/S output code. The result of this was a cross compiler that is compiled by Dan's C XPL compiler, accepts XPL/S language and produces Sigma Object Code to run on the Sigma.

Each of the nine modules of XPL/S code were compiled with the cross compiler.  Errors were corrected as they appeared.  Error were caused by misreading or mistyping code from the scanned images or OCR.  About a half page of code was missing from the scanned images in one case.  Fortunately this was correctable by reconstructing some fairly simple external reference code.  

Eventually, all nine modules compiled error free and their object code transferred to the CP-V system.

JCL was written to link the object code modules on CP-V and the resulting compiler set to work to compile each of the nine modules.  This uncovered a new set of problems where the compiler trapped or produced incorrect output.  Corrections for these were entered on the Mac, recompiled and the object code again transferred to CP-V. 

Each problem was resolved over time until the compiler reproduced itself over two generations and appears to be error free.

A pair of simple programs were developed on CP-V to read input tar files.  One for object code and the other for source code files. This expedited the process of correcting code on the Mac and transferring the files to CP-V.  

A file of JCL commands was produced on the Mac containing CP-V control commands .  These commands were cut and pasted when required into the CP-V command stream to save typing and promote accuracy.
