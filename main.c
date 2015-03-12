#include "bios.h"
#include "bool.h"
#include "chipset.h"
#include "fat16.h"
#include "flash_tool.h"
#include "io.h"
#include "malloc.h"
#include "mbr.h"
#include "z80.h"

// Interrupt service routines
void isr_nmi() __critical __interrupt;
void isr_keyboard() __critical __interrupt(1);
void isr_clock() __critical __interrupt(2);
void isr_timer() __critical __interrupt(3);
void isr_trap() __critical __interrupt(4);

static const char * const SDCARD_FAILED = "\r\nSDCARD MISSING OR FAILED!\r\n";
MasterBootRecord* const mbr = BOOT_START_ADDRESS;

void print_datetime() {
	print("\r\n20");
	print_hex(CLOCK.year);
	putc('-');
	print_hex(CLOCK.month);
	putc('-');
	print_hex(CLOCK.date);
	
	putc(' ');
	print_hex(CLOCK.hours);
	putc(':');
	print_hex(CLOCK.min);
	putc(':');
	print_hex(CLOCK.sec);
	print("\r\n");
}

unsigned char get_unsigned_char() {
	unsigned char c1, c2;
	c1 = getc();
	putc(c1);
	c2 = getc();
	putc(c2);
	return ((c1-'0')<<4) | (c2-'0');
}

void test() {
	unsigned char temp;
	print("\r\n20YY-MM-DD hh:mm:nn");
	print("\r\n20");
	CLOCK.year = get_unsigned_char();
	putc('-');
	CLOCK.month = get_unsigned_char();
	putc('-');
	CLOCK.date = get_unsigned_char();
	putc(' ');
	CLOCK.hours = get_unsigned_char();
	putc(':');
	CLOCK.min = get_unsigned_char();
	putc(':');
	CLOCK.sec = get_unsigned_char();
	print_datetime();
	print("Save ? (Y/N) ");
	temp = getc();
	putc(temp);
	if (temp == 'Y') chipset_set_datetime();
	chipset_get_datetime();
	print_datetime();
}

void main() {
	unsigned char byte;
	unsigned char exit = FALSE;
	
	print("\33[H"); // Home
	print("\33[2J"); // VT100 clear screen
	
	// Splash Screen
	print("\r\n  ________   ___   ____                            _\r\n |__  ( _ ) / _ \\ / ___|___  _ __ ___  _ __  _   _| |_ ___ _ __\r\n   / // _ \\| | | | |   / _ \\| '_ ` _ \\| '_ \\| | | | __/ _ \\ '__|\r\n  / /| (_) | |_| | |__| (_) | | | | | | |_) | |_| | ||  __/ |\r\n /____\\___/ \\___/ \\____\\___/|_| |_| |_| .__/ \\__,_|\\__\\___|_|\r\n                                      |_|\r\n\r\n");  
	
	// BIOS screen
	chipset_get_datetime();
	print_datetime();
	print("\r\nBIOS v0.9 - Functions :\r\n");
	
	print("\r\n1 RESTART");
	print("\r\n2 BOOT");
	print("\r\n3 FLASH BIOS (SDCARD Sector 1-8)");
	print("\r\n4 SET DATE/TIME\r\n");
	
	enable_interrupt();	

	while(exit == FALSE) {
		byte = getc();
		putc(byte);

		switch(byte) {
			case '1':
				chipset_restart();
				break;
			case '2':
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
			case '3':
				if (chipset_init_sdcard() == 0) {
					flash_tool_rescue_mode();
					chipset_restart();
				} else {
					print(SDCARD_FAILED);
				}
				break;
			case '4':
				test();
				break;
			default:
				print("\r\nUnknown command\r\n");
		}
	}
}


