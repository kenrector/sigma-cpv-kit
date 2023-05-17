# sigma-cpv-kit
Useful files to run CP-V on the simh sigma simulator

## Introduction
This repository contains support documentation and files that can be used to install and execute CP-V using the simh Sigma simulator.  Two CP-V versions are included, cpcp and f00.  The cpcp version was provided by Keith G. Calkins from his archive of CP-V material at https://www.andrews.edu/~calkins/sigma/.  Keith also contributed his extensive knowlege of CP-V to the effort to get the system running on simh.  The cpcp system is based on the Xerox C00 release and includes additional software developed by Andrews University to support their requirements.

The f00 version is Honeywell Release F00 from September 28, 1978.  There are two f00 system configurations, a disk swapper and a rad swapper.

These CP-V systems will run on any of the released simh versions, Classic simh V3.12, simh V4 and Open simh V4.1.  Note that there is a difference in the command control language between the three simh versions.

## Files

File | Description
---- | ----
cpcp/ | is a folder to contain files to support the CP-V cpcp release from Andrews University.
cpcp/cpcp.tap | is a bootable CP-V PO tape configured for Andrews University Computer Center.
cpcp/sigma.ini | is a simh V4 initialization file containing hardware definition and attach commands to setup the simulator to match the Andrews University CP-V configuration. You may wish to modify this file, particularly the MT and DP attach commands to suit your personal environment.
cpcp/sigma-v3.ini | is a simh V3.12 initialization file.
f00/ | is a folder to contain files to support the CP-V F00 release. There are two subfolders, a Disc Pack swapper system and a RAD swapper system.
f00/cpf0/
f00/f00rad/
cpcpdoc.txt | is a description of installing and running CP-V using siggy, a dos based simulator written by Keith and George Plume in th 90's.  Simh procedures will be different to siggy but the CP-V interactions will be the same.
lcmcpv00.pdf, lcmcpv01.pdf | provide an overview of CP-V.  This material was prepared by Keith to assist the Living Computer Museum install and bring up CP-V on a Sigma 9 computer system.
MTLU00.tap | is a bootable diagnostic progam also provided from Keith Calkins' archive.  This doesn't run under CP-V, just boot it from mt0.
mt2tap.c | is a program to translate .mt files to .tap.  Developed on a Mac.
## Installation
These instructions describe how to install CP-V from the cpcp.tap PO tape in the cpcp folder using the sigma.ini or sigma-v3.ini configuration file.  They also apply to the F00 releasees found in the f00 folders.

Start simh using the appropriate .ini file for your system.

Boot from mt0

The window running simh will present the CP-V Operator Console interface.

Following the prompt for media assignments, type FTPI.
Following the query "C/LL/DC ASSIGN OK" type RET.
Following the SENSE SWITCH settings type RET.

CP-V will report the number of patches and list them on the LP device as they are appplied.

CP-V will report the number of users and some other statistics ending with UPTIME = xx:xx:xx:xx

CP-V is now installed on the system swap and file devices and may be restarted by booting from the swap device with the simh boot dpb0 command.

At this point CP-V is up, but no online or batch users are allowed to login. This allows the operator to perform some tasks as GHOST jobs using the Operator Console (OC) before users log on.

Note that the date and time queries were skipped over during the tape initialization.  This causes the single character ':' to be printed every minute following the installation.  A subsequent disc boot will prompt for the current date and time and the time will then be printed on the OC each minute.

## Operator Console Interface
The OC interface is activated by the INTERRUPT button on the Sigma front panel.  This is simulated in simh by entering CTL-P in the console window.

## :SYS Password
The system on the cpcp PO tape includes a :USERS file with account names and logon passwords for the system account (:SYS) and a couple of users.  Run the PCL processor as a ghost job and backup and delete the existing :USERS file as described in Keith's writeup.  The system will then allow a logon from :SYS,LBE without a password and will create a new :USERS file with only the :SYS,LBE account without a password.  You can create a password for :SYS,LBE later if you wish.

The PCL interchange will look like this:

!GJOB PCL

17:   PCL HERE

COPY :USERS ON :USERSSV

DEL :USERS

17:   .. 1 FILES DELETED, 3 GRANULES

END

The f00 systems do not include a :USERS file and will thus create a default file with only the :SYS,LBE account without a password.

## Logging on
Time share logons are enabled by the ON keyin at the Operator Console (OC).  Activate the OC with CTL-P and at the prompt type ON 107 to set the number of online users to 107.

The system is now up and prepared for users to log on.  The number 107 is based on the number of users supported by the swap device less the number of required ghost jobs started at system boot, (121 - 14). You can choose a lesser value.

The cpcp system is generated with COC lines 0-5 and 10 configured for particular types of terminals and printers.  The remaining lines are configured as VT-100 type terminals.  The cpcp/sigma.ini file includes simh V4 mux attach commands that allow one to select which lines you will connect to based on port number.

The COC lines, except 0-5 and 10, are configured as hardwired connections that recquire a BREAK signal to start the LOGON process.  To send a BREAK signal from the telnet application, enter the telnet command mode by typing CTL-] and then the command 'send break'.  To avoid this and set the communication lines to non-hardwired, enter simh and type DEP 114a 0 to store 00000000 in the hardwired line flags.  This will set the first 32 lines to automatic mode and a logon prompt will be issued when they connect.

Use telnet, putty or your favorite telnet client to connect to CP-V on port 4000 and send the break command.  You will be assigned to the next available line and receive the salutation;

HI, TCP-V HERE - ANDREWS C0F
09:55 AUG 23,'80 ON WEST   USER# C     LINE# 6  
LOGON PLEASE: 

The f00 systems are generated with non-hardwired terminals attached to mux port 4003 and will present the logon salutation when they connect.

## Boot from disc
You can boot CP-V from the swap disc with the simh boot command addressed to the attached swap device.  Each time you reboot you will need to do the ON 107 and other setup keyins.

## SUPER
SUPER is the CP-V tool used to create and maintain user account parameters. The SUPER on the cpcp system is a modified version developed by Andrews University.

It appears to me that SUPER requires the subject account being created or modified to have C0 privilege for batch mode. Set B$PRIV=C0 before completing the create or modify operation.  Failure to do this will result in the error message

BAD BILLING NUMBER IN RECORD

when leaving the create or modify operation. If you get this message set the privilege or use CTL-Y to exit SUPER.

## Batch Jobs
Set the number of batch jobs allowed to 6 with the ONB 6 keyin.

## Symbionts
CP-V sends printer output to the LP device through the Symbiont facility.  It may be necessary to enable the LP symbiont with the SLP,I operator keyin.  The SPLIST program LIST command will list the current symbiont jobs.

These systems defines a card reader (CRA03) connected to a symbiont device.  There is no simh card reader simulator so do not attempt to initialize the CR symbiont.  If you do the SCR,I keyin the system will respond with CRA03 NOT OPERATIONAL followed by repeated CRA03 PLEASE RESPOND messages.

## Miscellanous
You can find many reference manuals at http://bitsavers.org/pdf/sds/sigma/cp-v/.

Shut down CP-V with the ZAP keyin at the operator console.   Don't quit out of simh while CP-V is up if you can help it.  

Save a backup of the cpvswap and cpvfiles files.  You can restore them if something goes wrong.

