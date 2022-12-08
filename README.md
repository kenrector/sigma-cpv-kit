# sigma-cpv-kit
Useful files to boot CP-V on the simh sigma simulator

## Introduction
This repository includes a bootable master system tape and a .ini file that can be used to install and execute CP-V using the simh Sigma simulator.  The master system tape (PO) and other files were provided by Keith G. Calkins from his archive of CP-V material at https://www.andrews.edu/~calkins/sigma/.  Keith also contributed his extensive knowlege of CP-V to the effort to get this kit working.

Just now, December 8, 2022, this material has been tested with simh-V4 only.  An Issue has been posted for this subject.

## Files
cpcp.tap is a bootable CP-V PO tape created by Andrews University to support their hardware and C00 release software configuration.

sigma.ini is a simh initialization file containing hardware definition and attach commands to setup the simulator to match the Andrews University CP-V configuration. You may wish to modify this file, particularly the MT and DP attach commands to suit your personal environment.

cpcpdoc.txt file is a description of installing and running CP-V using siggy, a dos based simulator written by Keith and George Plume in th 90's.  Simh procedures will be different to siggy but the CP-V interactions will be the same.  Experience with simh will be valuable.

lcmcpv00.pdf and lcmcpv01.pdf files provide an overview of CP-V.  This material was prepared by Keith to assist the Living Computer Museum install and bring up CP-V on a Sigma 9 computer system.

MTLU00.tap is a bootable diagnostic progam also provided from Keith Calkins' archive.  This doesn't run under CP-V, just boot it from mt0.

## Installation
These instructions describe how to install CP-V from the cpcp.tap PO tape using the sigma.ini configuration file.

Boot from mt0

The window running simh will present the CP-V Operator Console interface.

Following the prompt for media assignments, type FTPI.
Following the query "C/LL/DC ASSIGN OK" type RET.
Following the SENSE SWITCH settings type RET.

CP-V will report the number of patches and list them as they are appplied.

CP-V will report the number of users and some other statistics ending with UPTIME = xx:xx:xx:xx

At this point CP-V is up, but no online or batch users are allowed to login. This allows the operator to perform some tasks as GHOST jobs using the Operator Console (OC) before users log on.

CP-V is now installed on the system swap file devices and may be restarted by booting from the swap device with the simh boot dpb0 command.

Not that the date and time queries were skipped over during the tape initialization.  This causes the single character ':' to be printed every minute following the installation.  A subsequent disc boot will prompt for the current date and time and the date and time will be printed after than.

## Operator Console Interface
The OC interface is activated by the INTERRUPT button  on the Sigma front panel.  This is simulated in simh by entering CTL-P in the console window.

## :SYS Password
The system on this PO tape includes a :USERS file with account names and logon passwords for the system account (:SYS) and a couple of users.  Run the PCL processor as a ghost job and backup and delete the existing :USERS file.  The system will then allow a logon from :SYS,LBE without a password and will create a new :USERS file with only the :SYS,LBE account without a password.  You can create a password for :SYS,LBE later if you wish.

The PCL interchange will look like this:

!GJOB PCL

17:   PCL HERE

COPY :USERS ON :USERSSV

DEL :USERS

17:   .. 1 FILES DELETED, 3 GRANULES

END


## Logging on
Time share logons are enabled by the ON keyin at the Operator Console (OC).  Activate the OC with CTL-P and at the prompt type ON 107 to set the number of online users to 107.  The system is now up and prepared for users to log on.  The number 107 is based on the amount of users supported by the swap device less the number of required ghost jobs started at system boot, (121 - 14). you can choose a lesser value.

This CP-V installation is configured with COC lines 0-5 and 10 configured for particular types of terminals and printers.  The remaining lines are configured as VT-100 type terminals.  The sigma.ini file includes simh V4 attach commands that allow one to select which lines you will connect to based on port number. Simh V3 has a different method of selecting lines.

The COC lines, except 0-5 and 10, are configured as hardwired connections that recquire a BREAK signal to start the LOGON process.  To send a BREAK signal from the telnet application, enter the telnet command mode by typing CTL-] and then the command 'send break'.  To avoid this and set the communication lines to non-hardwired, enter simh and type DEP 114a 0 to store 00000000 in the hardwired line flags.  This will set the first 32 lines to automatic mode and a logon prompt will be issued when they connect.

Use telnet, putty or your favorite telnet client to connect to CP-V on port 4000 and send the break command.  You will be assigned to the next available line and receive the salutation;

HI, TCP-V HERE - ANDREWS C0F
09:55 AUG 23,'80 ON WEST   USER# C     LINE# 6  
LOGON PLEASE: 

## Boot from disc
You can boot CP-V from the swap disc with the simh boot command, boot dpb0.  Each time you reboot you will need to do the ON 107 and other setup keyins.

## SUPER
SUPER is the CP-V tool used to create and maintain user account parameters. The SUPER on the cpcp.tap PO tape is a modified version developed by Andrews University.

It appears to me that SUPER requires the subject account being created or modified to have C0 privilege for batch mode. Set B$PRIV=C0 before completing the create or modify operation.

Failure to do this will result in the error message

BAD BILLING NUMBER IN RECORD

when leaving the create or modify operation. If you get this message set the privilege or use CTL-Y to exit SUPER.

## Batch Jobs
Set the number of batch jobs allowed to 6 with the ONB 6 keyin.

## Symbionts
CP-V sends printer output to the LP device through the Symbiont facility.  It may be necessary to enable the LP symbiont with the SLP,I operator keyin.  The SPLIST program LIST command will list the current symbiont jobs.

The AU system defines a card reader (CRA03) connected to a symbiont device.  There is no simh card reader simulator so do not attempt to initialize the CR symbiont.  If you do the SCR,I keyin the system will respond with CRA03 NOT OPERATIONAL followed by repeated CRA03 PLEASE RESPOND messages.

## Miscellanous
You can find many reference manuals at http://bitsavers.org/pdf/sds/sigma/cp-v/.

Shut down CP-V with the ZAP keyin at the operator console.   Don't quit out of simh while CP-V is up if you can help it.  

Save a backup of the cpvswap and cpvfiles files.  You can restore them if something goes wrong.

