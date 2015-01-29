#ifndef FAT16_H
#define	FAT16_H

#include "malloc.h"
#include "chipset.h"
#include "io.h"
#include "mbr.h"

#define ATTR_READ_ONLY	0x01
#define ATTR_HIDDEN		0x02
#define ATTR_SYSTEM		0x04
#define ATTR_VOLUME_ID	0x08
#define ATTR_DIRECTORY	0x10
#define ATTR_ARCHIVE	0x20
#define ATTR_LONG_NAME 	ATTR_READ_ONLY | ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME_ID

#define NULL	(void *) 0x00

typedef struct {
	unsigned char BS_jmpBoot[3];
	unsigned char BS_OEMName[8];
	unsigned int BPB_BytsPerSec;
	unsigned char BPB_SecPerClus;
	unsigned int BPB_RsvSecCnt;
	unsigned char BPB_NumFATs;
	unsigned int BPB_RootEntCnt;
	unsigned int BPB_TotSec16;
	unsigned char BPB_Media;
	unsigned int BPB_FATs16;
	unsigned int BPB_SecPerTrk;
	unsigned int BPB_NumHeads;
	unsigned long BPB_HiddSec;
	unsigned long BPB_TotSec32;
	unsigned char BS_DrvNum;
	unsigned char BS_Reserved;
	unsigned char BS_BootSig;
	unsigned long BS_VolID;
	unsigned char BS_VolLab[11];
	unsigned char BS_FilSysType[8];
} BiosParameterBlock;

typedef struct {
	unsigned char DIR_Name[11];
	unsigned char DIR_Attr;
	unsigned char DIR_NTRes;
	unsigned char DIR_CrtTimeTenth;
	unsigned int DIR_CrtTime;
	unsigned int DIR_CrtDate;
	unsigned int DIR_LstAccDate;
	unsigned int DIR_FstClusHI;
	unsigned int DIR_WrtTime;
	unsigned int DIR_WrtDate;
	unsigned int DIR_FstClusLO;
	unsigned long DIR_FileSize;
} DirectoryEntry;

void fat16_print_file_name(unsigned char *string);
unsigned char fat16_compare_file_name(unsigned char* const name1);

#endif /* FAT16_H */