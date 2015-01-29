#include "chipset.h"

void chipset_flash_bios(void* memory) {
	IO_PARAM1 = (unsigned int) memory;
	EEPROM_PORT = EEPROM_FLASH_BIOS;
}

void chipset_restart() {
	RESTART_PORT = RESTART;
}

void chipset_load_sector_into_memory(void* memory, unsigned long sector_address) {
	IO_PARAM1 = (unsigned int) memory;
	IO_PARAM2 = sector_address;
	SDCARD_PORT = SDCARD_READ;
}

unsigned char chipset_init_sdcard() {
	SDCARD_PORT = SDCARD_INIT;
	return IO_RET;
}