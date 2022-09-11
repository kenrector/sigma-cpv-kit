# sigma-cpv-kit
Useful files to boot CP-V on the simh sigma simulator

## Introduction
This repository includes a bootable master system tape and a .ini file that can be used to install and execute CP-V using the simh Sigma simulator.  The master system tape (PO) and other files were provided by Keith G. Calkins from his archive of CP-V material at https://www.andrews.edu/~calkins/sigma/.  Keith also contributed his extensive knowlege of CP-V to the effort to get this kit working.  

## Files
cpcp.tap is a bootable CP-V PO tape that conforms to the Andrews University hardware and C00 release software configuration.

sigma.ini is a simh initialization file containing hardware definition and attach commands to setup the simulator to match the Andrews University CP-V configuration.

cpcpdoc.txt file is a description of installing and running CP-V using siggy, a dos based simulator written by Keith and George Plume in th 90's.  Simh procedures will be different to siggy but the CP-V interactions will be the same.  Experience with simh will be valuable.

lcmcpv00.pdf and lcmcpv01.pdf files provide an overview of CP-V.  This material was prepared by Keith to assist the Living Computer Museum install and bring up CP-V on a Sigma 9 computer system.

## Installation
These instructions describe how to install CP-V from the cpcp.tap PO tape using the sigma.ini configuration file.

Boot from mt0

The window running simh will become the CP-V Operator Console interface.

Following the prompt for device assignment options, type FTPI.

Type RET to ignore the next option request.

CP-V will be quiet for a while and will then produce a lot of output including messages about BAD COC - MEA05 and MEA-0D.  Ignore these messages.

Finally is a message about UPTIME = 0:00:xx:xx

The CP-V Operator Console (OC) interface is activated by the INTERRUPT button  on the sigma front panel.  The INTERRUPT button is simulated in simh by entering the code 0x10 in the consle window.  On a Mac I installed the Unicode Hex Input keyboard and typed OPTION-0010 to enter the 0x10 character.

After the PO tape installation finishes CP-V reports information about MEM SIZE, UP TIME, etc.  At this point CP-V is up and running but there are zero (0) online users allowed.  To allow user logon, activate the OC INTERRPUT and set the number of online users allowed to 107 by typing ON 107 as described in cpcpdoc.txt.

This CP-V installation is configured with hardwired communication lines that recquire a BREAK signal to start the LOGON process.  To send a BREAK signal enter the telnet command mode by typing CTL-] and then the command 'send break'.  To avoid this and set the communication lines to non-hardwired, enter simh and enter DEP 114a 0 to store 00000000 in the hardwired line flags as described in cpcpdoc.txt.  This will set the first 32 lines to automatic mode and a logon prompt will be issued when they connect with telnet.

The system includes a :USERS file with account names and logon passwords.  Follow Keiths instruction to run the PCL processor as a ghost job and backup and delete the :USRS file.  The system will then allow a logon from :SYS,LBE without a password.

Shut down CPV with the ZAP keyin at the opeeator console.   Don't quit out of simh while CP-V is up if you can help it.  

Save a backup of the cpvswap and cpvfiles files.  You can restore them if something goes wrong.

You can boot CP-V from the swap disc with the simh boot command, boot dpb0.  Each time you reboot you will need to do the on 107 keyin and dep 114a 0 commands.

Logon to one of the CP-V terminal lines with telnet.  The sigma.ini file includes mux attach options for the mux lines 0-5, 10 and a mux attach for port 4000.  If you telnet to port 4000 you will be connected to the next available line following line 5, but skipping line 10.  You should be greeted by the salutation,  

HI, TCP-V HERE - ANDREWS C0F
09:55 AUG 23,'80 ON WEST   USER# C     LINE# 6  
LOGON PLEASE: 

Telnet to one of the dedicated lines, 0-5, 10 will get you connected as a non-VT100 terminal.

Check the Issues section of this repository for possible problems and work arounds.
