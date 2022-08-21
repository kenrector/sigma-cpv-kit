# sigma-cpv-kit
Useful files to boot CP-V on the simh sigma simulator

This repository includes a bootable PO tape and a sigma.ini file that can be used to boot the CP-V system on the simh sigma simulator.

The PO tape and cpcpdoc.txt files were provided by Keith G. Calkins from his archive of CP-V material at https://www.andrews.edu/~calkins/sigma/.

The cpcpdoc.txt file is a description of booting CP-V using siggy, a dos based simulator written by Keith and George Plume in th 90's.  This may help someone new to CP-V to get started.

Note:
The CP-V operator interface was activated by the INTERRUPT button  on the sigma front panel.  The INTERRUPT button is simulated in simh by entering the code 0x10 in the consle window.  On a Mac I installed the Unicode Hex Input keyboard and typed ALT-0010 to enter the 0x10 character.
