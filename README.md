# sigma-cpv-kit
Useful files to boot CP-V on the simh sigma simulator

This repository includes a bootable PO tape and a sigma.ini file that can be used to boot the CP-V system on the simh sigma simulator.

The PO tape and cpcpdoc.txt files were provided by Keith G. Calkins from his archive of CP-V material at https://www.andrews.edu/~calkins/sigma/.

The cpcpdoc.txt file is a description of installing running CP-V from the PO tape using siggy, a dos based simulator written by Keith and George Plume in th 90's.  This may help someone new to CP-V to get started.  One sh

The CP-V operator interface was activated by the INTERRUPT button  on the sigma front panel.  The INTERRUPT button is simulated in simh by entering the code 0x10 in the consle window.  On a Mac I installed the Unicode Hex Input keyboard and typed ALT-0010 to enter the 0x10 character.

After the PO tape installation finishes and reports information about MEM SIZE, UP TIME, etc CPV is up and running but here are zero (0) online users allowed.  To allow user logon, activate the OC INTERRPUT with the ALT-0010 keyin and set the number of online users allowed to 107 with ON 107.

This system is configured with hardwired lines that recquire a BREAK key to start the LOGON process.  To avoid, this enter simh and enter DEP 114a 0 to store 00000000 in the hardwired line flags.

The system includes a :USERS file with account names and logon passwords.  Follow Keiths instruction to run the PCL processor as a ghost job and backup and delete the :USRS file.  The system will allow a logon from :SYS,LBE without a password if there is no :USERS file.

Shut down CPV with the ZAP keyin at the opeeator console.   Don't quit out of simh if you can help it.  

Save a backup of the cpvswap file.

You can boot CP-V from the swapper with the simh boot command, boot dpb0.  Each time you reboot you will need to do the on 107 keyin and dep 114a 0 command.

