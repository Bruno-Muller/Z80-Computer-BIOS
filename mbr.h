#ifndef MBR_H
#define	MBR_H

#include "bool.h"
#include "chipset.h"
#include "malloc.h"
#include "io.h"

#define IS_BOOTABLE		0x80
#define IS_NOT_BOOTALBE	0x00

#define MBR_SIGNATURE 0xAA55

#define PARTITION_TYPE_EMPTY	0x00
#define PARTITION_TYPE_FAT12	0x01
#define PARTITION_TYPE_FAT16	0x04

#define MBR_SECTOR	0
#define MBR_SIZE	0x200

typedef struct {
	unsigned char bootable;
	unsigned char startingHead;
	unsigned char startingSector;
	unsigned char startingCylinder;
	unsigned char systemID;
	unsigned char endingHead;
	unsigned char endingSector;
	unsigned char endingCylinder;
	unsigned long firstPartitionSector;
	unsigned long numberOfSector;
} PartitionDescriptor;

 typedef struct {
	unsigned char bootPrgm[446];
	PartitionDescriptor partitionTable[4];
	unsigned int signature;
} MasterBootRecord;

#endif /* MBR_H */