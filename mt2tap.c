/*  mt2tap - convert siggy format .mt file to simh .tap  */
 

#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define FLPSIZ 65536*2
int main (int argc, char *argv[])
{
    int k, fc, wc, rc;
    
    int pwc;
    
    char pad = 0;
    
    int bin,bout,errorflag = 0;
    unsigned char bc[4] = { 0 };
    unsigned char tapemark[4] = {0};
    unsigned char buf[FLPSIZ];
    char *progname = argv[0];
    char *ppos, oname[256];
    FILE *ifile, *ofile;
    
    if (argc < 2) {
        fprintf (stderr, "Usage:  %s file \n", progname);
        fprintf (stderr, "This will create a simh tap file named file.tap from a Keith Calkins CPV PO image file\n");
        exit (0);
    }
    
    
    strcpy (oname, argv[1]);
    if ((ppos = strrchr (oname, '.')))
        strcpy (ppos, ".tap");
    else
        strcat (oname, ".tap");
    ifile = fopen (argv[1], "rb");
    if (ifile == NULL) {
        printf ("Error opening file: %s\n", argv[1]);
        exit (0);
        
    }
    ofile = fopen (oname, "wb");
    if (ofile == NULL) {
        printf ("Error opening file: %s\n", oname);
        exit (0);
        
    }
    
    printf ("Processing file %s\n", argv[1]);
    fc = 1; rc = 0;
    
    bin = bout = 0;
    
    // skip tape mark on input po tape
    k = fread (bc, sizeof (bc), 1, ifile);
    if (k != 1) {
        printf("error reading bot mark\n");
        exit (1);
    }
    bin += sizeof(bc);
    
    for (;;) {
        // leading record size, or tape mark
        k = fread (bc, sizeof (bc), 1, ifile);
        bin += sizeof(bc);
        
        if (k != 1) {
            printf("error reading next size\n");
            exit (1);
        }
        wc = (bc[3]<<24) + (bc[2]<<16) + (bc[1]<<8) + bc[0];
        
        if (wc <= 0) {
            // just read trailing file size
            // read next file size
            k = fread (bc, sizeof (bc), 1, ifile);
            bin += sizeof(bc);
            if (k != 1) {
                printf("error or EOT reading file size at tape mark \n");
                // write tape mark on output
                fwrite(tapemark,sizeof (char),4,ofile);
                exit (1);
            }
            wc = (bc[3]<<24) + (bc[2]<<16) + (bc[1]<<8) + bc[0];
            printf("file size %x %x\n",bin,wc);
            
            // write tape mark on output
            fwrite(tapemark,sizeof (char),4,ofile);
            // read current record size
            k = fread (bc, sizeof (bc), 1, ifile);
            bin += sizeof(bc);
            
            if (k != 1) {
                printf("error reading current size at tape mark \n");
                exit (1);
            }
            wc = (bc[3]<<24) + (bc[2]<<16) + (bc[1]<<8) + bc[0];
            if (wc == 0) {
                // zero length record, read trailing length (zero)
                k = fread (bc, sizeof (bc), 1, ifile);
                bin += sizeof(bc);
                // read next file mark
                //k = fread (bc, sizeof (bc), 1, ifile);
                // read current record size
                k = fread (bc, sizeof (bc), 1, ifile);
                bin += sizeof(bc);
                wc = (bc[3]<<24) + (bc[2]<<16) + (bc[1]<<8) + bc[0];
            }
        }
        
        if (wc > 0x800)
            printf("BIG %x\n",wc);
        bout += wc;
        fwrite(&wc,1,4,ofile);      // write leading size
        printf("WC  %x %x\n",bin,wc);
        pwc = wc;
        
        if (wc) {
            // copy the record
            k = fread (buf, 1, wc, ifile);
                bin += wc;
            buf[wc] = 0;            // pad just in case
            fwrite (buf, sizeof (char), wc, ofile);
            
            if (wc & 1)
                fwrite (&pad,1,1,ofile);  // force even size
            // read trailing size
            k = fread (bc, sizeof (bc), 1, ifile);
            bin += sizeof(bc);
            if (k != 1) {
                printf("error reading trailing size\n");
                exit (1);
            }
            wc = (bc[3]<<24) + (bc[2]<<16) + (bc[1]<<8) + bc[0];
            if (wc != pwc)
                printf("record size error %x %x\n",pwc,wc);
                       
            fwrite(&wc,1,4,ofile);  // write trailing size
            rc++;
            
        }
        else {
            if (rc)
                printf ("End of file %d, record count = %d\n", fc, rc);
            else
                printf ("End of tape\n");
            fc++;
            rc = 0;
            exit (0);
        }
    }
    fclose (ifile);
    fclose (ofile);
    
    
    return 0;
}
