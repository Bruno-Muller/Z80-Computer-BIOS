#include "fat16.h"

void fat16_print_file_name(unsigned char *string) {
	static unsigned char i;
	static unsigned char c;
	
	for (i=0; i<8; i++) {
		c = string[i];
		if (c == ' ') break;
		putc(c);
	}
	putc('.');
	
	for (i=8; i<11; i++) {
		c = string[i];
		if (c == ' ') break;
		putc(c);
	}
}

unsigned char fat16_compare_file_name(unsigned char* const name1) {
	static const unsigned char* name2 = "BIOS    BIN";
	unsigned char i;
	for (i=0; i<11; i++) {
		if (name1[i] != name2[i]) {
			return FALSE;
		}
	}
	return TRUE;
}

