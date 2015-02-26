#ifndef FLASH_TOOL_H
#define FLASH_TOOL_H

#include "mbr.h"
#include "fat16.h"
#include "chipset.h"
#include "malloc.h"
#include "io.h"

#define ROOT_ENTRY_COUNT	0x200
#define BYTE_PER_SECTOR		0x200
#define FAT16_BPB_SIZE		0x200
#define BIOS_SIZE			0x1000

void flash_tool_rescue_mode();
//void flash_tool_fat16();

#endif /* FLASH_TOOL_H */