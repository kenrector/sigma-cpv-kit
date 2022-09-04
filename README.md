# sigma-cpv-kit
Useful files to boot CP-V on the simh sigma simulator

This repository includes a bootable system (PO) tape and a sigma.ini file that can be used to install CP-V using the simh sigma simulator.  The PO tape and cpcpdoc.txt files were provided by Keith G. Calkins from his archive of CP-V material at https://www.andrews.edu/~calkins/sigma/.  The CP-V system on the PO tape conforms to the Andrews University hardware and software configuration.

The included cpcpdoc.txt file is a description of installing and running CP-V using siggy, a dos based simulator written by Keith and George Plume in th 90's.  This procedure is similar to the simh installation.

The CP-V operator interface is activated by the INTERRUPT button  on the sigma front panel.  The INTERRUPT button is simulated in simh by entering the code 0x10 in the consle window.  On a Mac I installed the Unicode Hex Input keyboard and typed OPTION-0010 to enter the 0x10 character.

After the PO tape installation finishes and reports information about MEM SIZE, UP TIME, etc CPV is up and running but here are zero (0) online users allowed.  To allow user logon, activate the OC INTERRPUT with the ALT-0010 keyin and set the number of online users allowed to 107 with ON 107.

This system is configured with hardwired lines that recquire a BREAK key to start the LOGON process.  To avoid, this enter simh and enter DEP 114a 0 to store 00000000 in the hardwired line flags.

The system includes a :USERS file with account names and logon passwords.  Follow Keiths instruction to run the PCL processor as a ghost job and backup and delete the :USRS file.  The system will allow a logon from :SYS,LBE without a password if there is no :USERS file.

Shut down CPV with the ZAP keyin at the opeeator console.   Don't quit out of simh if you can help it.  

Save a backup of the cpvswap file.

You can boot CP-V from the swapper with the simh boot command, boot dpb0.  Each time you reboot you will need to do the on 107 keyin and dep 114a 0 command.

Logon to one of the CP-V terminal lines with telnet.  The sigma.ini file includes mux attach options for the mux lines 0-5, 10 and a mux attach for port 4000.  If you telnet to port 4000 you will be connected to the next available line following line 5, but skipping line 10.  You should be greeted by the salutation,  

HI, TCP-V HERE - ANDREWS C0F
09:55 AUG 23,'80 ON WEST   USER# C     LINE# 6  
LOGON PLEASE: 

Telnet to one of the dedicated lines, 0-5, 10 will get you connected as a non-VT100 terminal.
