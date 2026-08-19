29d0.tap is an FSAVE tape containing source code, JCL and LMN for the XPL/S compiler developed at University of Washington in 1974.

The source code was reconstructed from paper listings in the Irwin Gotwald collection at the Computer History Museum.

Documentation is two papers from University of Washington library archives describing development of XPL/s and the language.  The documentation files are scanned images from UW and a PDF produced by a LYX transliteration of one of them.  The LYX transliteration was made to provide a searchable text and attempts to be accurate.

Installing XPL/S on CP-V:  
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
