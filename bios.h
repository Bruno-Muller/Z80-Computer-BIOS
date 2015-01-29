#ifndef BIOS_H
#define	BIOS_H

#include "chipset.h"

#define CONST_READY		0xFF
#define CONST_NOT_READY 0x00

// #0 BOOT
void bios_wboot(); // #1 WBOOT
char bios_const(); // #2 CONST
char bios_conin(); // #3 CONIN
void bios_conout(char c); // #4 CONOUT
// #5 LIST
// #6 PUNCH
// #7 READER
// #8 HOME
unsigned char bios_seldsk(); // #9 SELDSK
// #10 SELTRK
void bios_setsec(unsigned int val); // #11 SETSEC
void bios_setdma(unsigned int val); // #12 SETDMA
void bios_read(); // #13 READ
// #14 WRITE
// #15 LISTST
// #16 SECTRAN


#endif /* BIOS_H */