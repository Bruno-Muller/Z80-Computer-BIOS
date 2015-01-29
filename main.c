#include "bios.h"
#include "bool.h"
#include "chipset.h"
#include "fat16.h"
#include "io.h"
#include "malloc.h"
#include "mbr.h"
#include "z80.h"
#include "flash_tool.h"

// Interrupt service routines
void isr_nmi() __critical __interrupt;
void isr_keyboard() __critical __interrupt(1);
void isr_clock() __critical __interrupt(2);

static const char * const SDCARD_FAILED = "\r\nSDCARD MISSING OR FAILED!\r\n";
MasterBootRecord* const mbr = BOOT_START_ADDRESS;

void main() {
	unsigned char byte;
	unsigned char exit = FALSE;
	
	print("\33[H"); // Home
	print("\33[2J"); // VT100 clear screen
	
	// Splash Screen
	print("\r\n  ________   ___   ____                            _\r\n |__  ( _ ) / _ \\ / ___|___  _ __ ___  _ __  _   _| |_ ___ _ __\r\n   / // _ \\| | | | |   / _ \\| '_ ` _ \\| '_ \\| | | | __/ _ \\ '__|\r\n  / /| (_) | |_| | |__| (_) | | | | | | |_) | |_| | ||  __/ |\r\n /____\\___/ \\___/ \\____\\___/|_| |_| |_| .__/ \\__,_|\\__\\___|_|\r\n                                      |_|\r\n\r\n");  
	
	// BIOS screen
	print("BIOS v0.9 - Functions :\r\n");
	print("\r\n1 FLASH TOOL");
	print("\r\n2 RESTART");
	print("\r\n3 BOOT");
	print("\r\n4 FLASH BIOS in rescue mode (SDCARD Sector 1-8)\r\n");
	
	enable_interrupt();	

	while(exit == FALSE) {
		byte = getc();
		putc(byte);

		switch(byte) {
			case '1':
				if (chipset_init_sdcard() == 0) {
					flash_tool_fat16();
					chipset_restart();
				} else {
					print(SDCARD_FAILED);
				}
				break;
			case '2':
				chipset_restart();
				break;
			case '3':
				if (chipset_init_sdcard() == 0) {
					chipset_load_sector_into_memory(mbr, MBR_SECTOR);
					if (mbr->signature == MBR_SIGNATURE)
						exit = TRUE;
					else
						print("\r\nNON SYSTEM DISK\r\n");
				} else {
					print(SDCARD_FAILED);
				}
				break;
			case '4':
				if (chipset_init_sdcard() == 0) {
					flash_tool_rescue_mode();
					chipset_restart();
				} else {
					print(SDCARD_FAILED);
				}
				break;
			default:
				print("\r\nUnknown command\r\n");
		}
	}
}


