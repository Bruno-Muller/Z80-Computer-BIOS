#include "flash_tool.h"

void flash_tool_rescue_mode() {
	static unsigned int const addresses[] = {0x1100+512*0,0x1100+512*1,0x1100+512*2,0x1100+512*3,0x1100+512*4,0x1100+512*5,0x1100+512*6,0x1100+512*7};
	unsigned char i;
	
	print("\33[H\33[2JFLASH BIOS\r\nREAD SDCARD Sector 1-8");
	
	for (i=0; i<8; i++) {
		chipset_load_sector_into_memory((void *) addresses[i],i+1);
	}
			
	print("\r\nWRITE EEPROM");
			
	chipset_flash_bios((void *) 0x1100);
}

void flash_tool_fat16() {
	// MBR
	MasterBootRecord* const mbr = malloc(MBR_SIZE);
	PartitionDescriptor* partition;
	unsigned char i, choice;
	
	// BPB
	BiosParameterBlock* const bpb = malloc(FAT16_BPB_SIZE);
	unsigned long FirstDataSector, AbsoluteFirstRootDirSecNum;
	
	// Root Directory
	DirectoryEntry* const rootDirectory = malloc(BYTE_PER_SECTOR);
	unsigned char const RootDirSectors = ((ROOT_ENTRY_COUNT*32) + (BYTE_PER_SECTOR - 1))/BYTE_PER_SECTOR;
	unsigned char sector;
	DirectoryEntry *entry;
	
	// Fat
	unsigned int* fat = malloc(BYTE_PER_SECTOR);
	static unsigned int lastFatSectorLoaded = 0; // long
	unsigned int AbsoluteFirstSectorOfCluster, FatOffset, AbsoluteThisFatSecNum; // long
	unsigned int ThisFatEntryOffset, cluster;
	
	// Bios file
	static DirectoryEntry* bios_file_entry = NULL;
	static unsigned int  bios_root_directory_sector = 0;
	unsigned char* const bios_file = malloc(BIOS_SIZE);
	unsigned char* bios_data = bios_file;
	unsigned int j;

	print("\33[H\33[2JBIOS - FLASH TOOL v1.0\r\n\r\nPrerequisites :\r\n- FAT16 Primary partition\r\n- Must reside in first physical 32 MB\r\n- 512 bytes/sector\r\n- 1 sector/cluster\r\n- 512 entries in root directory");
		
	// Load MBR
	chipset_load_sector_into_memory(mbr, MBR_SECTOR);
	if (mbr->signature != MBR_SIGNATURE) {
		print("\r\nMBR MISSING");
		return;
	}
	
	print("\r\n");
	
	// List partition
	for (i=0; i<4; i++) {
		print("\r\nPartition ");
		print_unsigned_char(i);
		switch (mbr->partitionTable[i].systemID) {
			case (PARTITION_TYPE_EMPTY):
				print(": EMPTY");
				break;
			case (PARTITION_TYPE_FAT16):
				print(": FAT16");
				break;
			default:
				print(": 0x");
				print_hex(mbr->partitionTable[i].systemID);
		}
	}
	
	print("\r\n");

	// Select a partition
	do {
		print("\r\nSelect a partition: ");
		choice = getc();
		putc(choice);
		i = choice - '0';
		
		if (i>3) continue;
		
		if (mbr->partitionTable[i].systemID != PARTITION_TYPE_FAT16) {
			print("\r\nONLY FAT16 !!");
		}
	
	} while (mbr->partitionTable[i].systemID != PARTITION_TYPE_FAT16);
	
	partition = &mbr->partitionTable[i];
	
	// Load BPB
	chipset_load_sector_into_memory(bpb, partition->firstPartitionSector);
	AbsoluteFirstRootDirSecNum = bpb->BPB_RsvSecCnt + bpb->BPB_NumFATs * bpb->BPB_FATs16 + partition->firstPartitionSector;
	FirstDataSector = bpb->BPB_RsvSecCnt + (bpb->BPB_NumFATs * bpb->BPB_FATs16) + RootDirSectors;
	
	if ((bpb->BPB_BytsPerSec != BYTE_PER_SECTOR) ||
		(bpb->BPB_SecPerClus != 1) ||
		(bpb->BPB_RootEntCnt != ROOT_ENTRY_COUNT) ||
		(partition->firstPartitionSector + partition->numberOfSector > 65535)) {
		print("\r\nPrerequisites mismatch !");
		return;
	}
	
	print("\r\n");

	// List Root Directory and Search BIOS.BIN
	for (sector = 0; sector < RootDirSectors; sector++) {
		// Load a root directory sector;
		chipset_load_sector_into_memory(rootDirectory, AbsoluteFirstRootDirSecNum + sector);
		entry = rootDirectory;

		for (i=0; i<16; i++, entry++) {
			if (entry->DIR_Name[0] == 0x00) {sector = RootDirSectors; break;} // end of directory
			if (entry->DIR_Name[0] == 0xE5) continue; // deleted file
			if (entry->DIR_Attr == ATTR_DIRECTORY) continue; // sub directory
			
			print("\r\n");
			fat16_print_file_name(entry->DIR_Name);
			
			if (fat16_compare_file_name(entry->DIR_Name) == TRUE) {
				bios_file_entry = entry;
				bios_root_directory_sector = sector;
			}
		}
	}
	
	// If BIOS not found
	if (bios_file_entry == NULL) {
		print("\r\nBIOS.BIN not found in root directory !");
		return;
	}
	
	chipset_load_sector_into_memory(rootDirectory, AbsoluteFirstRootDirSecNum + bios_root_directory_sector);
	
	// BIOS found
	print("\r\n\r\n");
	fat16_print_file_name(bios_file_entry->DIR_Name);
	print(" found !");

	// Load BIOS.BIN
	print("\r\nREAD FILE");	
	
	// init memory
	for(j=0;j<BIOS_SIZE;j++) {
		bios_file[j] = 0x00;
	}

	cluster = bios_file_entry->DIR_FstClusLO;

	do {
		// Load sector of data (1 cluster = 1 sector)
		AbsoluteFirstSectorOfCluster  = ((cluster-2) * bpb->BPB_SecPerClus) + FirstDataSector + partition->firstPartitionSector;
		chipset_load_sector_into_memory(bios_data, AbsoluteFirstSectorOfCluster);
		bios_data += 512;

		// Load FAT
		FatOffset = cluster * 2; // FAT Entry index
		AbsoluteThisFatSecNum = bpb->BPB_RsvSecCnt + (FatOffset / bpb->BPB_BytsPerSec) + partition->firstPartitionSector; // FAT Entry Sector
		ThisFatEntryOffset = (cluster % bpb->BPB_BytsPerSec); //(FATOffset % bpb->BPB_BytsPerSec);
	
		if (lastFatSectorLoaded != AbsoluteThisFatSecNum) {
			chipset_load_sector_into_memory(fat, AbsoluteThisFatSecNum);
			lastFatSectorLoaded = AbsoluteThisFatSecNum;
		}
		
		cluster = fat[ThisFatEntryOffset];
	} while (cluster < 0xFFF8);

	print("\r\nWRITE EEPROM");
	chipset_flash_bios(bios_file);
}