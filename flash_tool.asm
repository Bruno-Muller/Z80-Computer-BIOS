;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Sun Jan 25 23:44:54 2015
;--------------------------------------------------------
	.module flash_tool
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _fat16_compare_file_name
	.globl _fat16_print_file_name
	.globl _malloc
	.globl _chipset_flash_bios
	.globl _chipset_load_sector_into_memory
	.globl _print_unsigned_char
	.globl _print_hex
	.globl _print
	.globl _getc
	.globl _putc
	.globl _IO_RET
	.globl _IO_PARAM2
	.globl _IO_PARAM1
	.globl _flash_tool_rescue_mode
	.globl _flash_tool_fat16
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_USART_PORT	=	0x0000
_TIMER_PORT	=	0x0001
_SDCARD_PORT	=	0x0002
_EEPROM_PORT	=	0x0003
_RESTART_PORT	=	0x0004
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_IO_PARAM1	=	0x0050
_IO_PARAM2	=	0x0052
_IO_RET	=	0x0056
_flash_tool_fat16_lastFatSectorLoaded_1_17:
	.ds 2
_flash_tool_fat16_bios_file_entry_1_17:
	.ds 2
_flash_tool_fat16_bios_root_directory_sector_1_17:
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;flash_tool.c:36: static unsigned int lastFatSectorLoaded = 0; // long
	ld	iy,#_flash_tool_fat16_lastFatSectorLoaded_1_17
	ld	0 (iy),#0x00
	ld	iy,#_flash_tool_fat16_lastFatSectorLoaded_1_17
	ld	1 (iy),#0x00
;flash_tool.c:41: static DirectoryEntry* bios_file_entry = NULL;
	ld	iy,#_flash_tool_fat16_bios_file_entry_1_17
	ld	0 (iy),#0x00
	ld	iy,#_flash_tool_fat16_bios_file_entry_1_17
	ld	1 (iy),#0x00
;flash_tool.c:42: static unsigned int  bios_root_directory_sector = 0;
	ld	iy,#_flash_tool_fat16_bios_root_directory_sector_1_17
	ld	0 (iy),#0x00
	ld	iy,#_flash_tool_fat16_bios_root_directory_sector_1_17
	ld	1 (iy),#0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;flash_tool.c:3: void flash_tool_rescue_mode() {
;	---------------------------------
; Function flash_tool_rescue_mode
; ---------------------------------
_flash_tool_rescue_mode_start::
_flash_tool_rescue_mode:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;flash_tool.c:7: print("\33[H\33[2JFLASH BIOS\r\nREAD SDCARD Sector 1-8");
	ld	hl,#___str_0
	push	hl
	call	_print
	pop	af
;flash_tool.c:9: for (i=0; i<8; i++) {
	ld	-1 (ix),#0x00
00102$:
;flash_tool.c:10: chipset_load_sector_into_memory((void *) addresses[i],i+1);
	ld	l,-1 (ix)
	ld	h,#0x00
	ld	e, l
	ld	d, h
	inc	de
	ld	a,d
	rla
	sbc	a, a
	ld	c,a
	ld	b,a
	add	hl, hl
	ld	a,#<(_flash_tool_rescue_mode_addresses_1_15)
	add	a, l
	ld	l,a
	ld	a,#>(_flash_tool_rescue_mode_addresses_1_15)
	adc	a, h
	ld	h,a
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	pop	iy
	push	bc
	push	de
	push	iy
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;flash_tool.c:9: for (i=0; i<8; i++) {
	inc	-1 (ix)
	ld	a,-1 (ix)
	sub	a, #0x08
	jr	C,00102$
;flash_tool.c:13: print("\r\nWRITE EEPROM");
	ld	hl,#___str_1
	push	hl
	call	_print
;flash_tool.c:15: chipset_flash_bios((void *) 0x1100);
	ld	hl, #0x1100
	ex	(sp),hl
	call	_chipset_flash_bios
	pop	af
	inc	sp
	pop	ix
	ret
_flash_tool_rescue_mode_end::
_flash_tool_rescue_mode_addresses_1_15:
	.dw #0x1100
	.dw #0x1300
	.dw #0x1500
	.dw #0x1700
	.dw #0x1900
	.dw #0x1B00
	.dw #0x1D00
	.dw #0x1F00
___str_0:
	.db 0x1B
	.ascii "[H"
	.db 0x1B
	.ascii "[2JFLASH BIOS"
	.db 0x0D
	.db 0x0A
	.ascii "READ SDCARD Sector 1-8"
	.db 0x00
___str_1:
	.db 0x0D
	.db 0x0A
	.ascii "WRITE EEPROM"
	.db 0x00
;flash_tool.c:18: void flash_tool_fat16() {
;	---------------------------------
; Function flash_tool_fat16
; ---------------------------------
_flash_tool_fat16_start::
_flash_tool_fat16:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-56
	add	hl,sp
	ld	sp,hl
;flash_tool.c:20: MasterBootRecord* const mbr = malloc(MBR_SIZE);
	ld	hl,#0x0200
	push	hl
	call	_malloc
	pop	af
	ld	-50 (ix),l
	ld	-49 (ix),h
;flash_tool.c:25: BiosParameterBlock* const bpb = malloc(FAT16_BPB_SIZE);
	ld	hl,#0x0200
	push	hl
	call	_malloc
	pop	af
	inc	sp
	inc	sp
	push	hl
;flash_tool.c:29: DirectoryEntry* const rootDirectory = malloc(BYTE_PER_SECTOR);
	ld	hl,#0x0200
	push	hl
	call	_malloc
	pop	af
	ld	-33 (ix),l
	ld	-32 (ix),h
;flash_tool.c:35: unsigned int* fat = malloc(BYTE_PER_SECTOR);
	ld	hl,#0x0200
	push	hl
	call	_malloc
	pop	af
	ld	-38 (ix),l
	ld	-37 (ix),h
;flash_tool.c:43: unsigned char* const bios_file = malloc(BIOS_SIZE);
	ld	hl,#0x1000
	push	hl
	call	_malloc
	pop	af
	ld	-44 (ix),l
	ld	-43 (ix),h
;flash_tool.c:44: unsigned char* bios_data = bios_file;
	ld	a,-44 (ix)
	ld	-46 (ix),a
	ld	a,-43 (ix)
	ld	-45 (ix),a
;flash_tool.c:47: print("\33[H\33[2JBIOS - FLASH TOOL v1.0\r\n\r\nPrerequisites :\r\n- FAT16 Primary partition\r\n- Must reside in first physical 32 MB\r\n- 512 bytes/sector\r\n- 1 sector/cluster\r\n- 512 entries in root directory");
	ld	hl,#___str_2
	push	hl
	call	_print
	pop	af
;flash_tool.c:50: chipset_load_sector_into_memory(mbr, MBR_SECTOR);
	ld	e,-50 (ix)
	ld	d,-49 (ix)
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	push	de
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;flash_tool.c:51: if (mbr->signature != MBR_SIGNATURE) {
	ld	a,-50 (ix)
	ld	-2 (ix),a
	ld	a,-49 (ix)
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	de, #0x01FE
	add	hl, de
	ld	a,(hl)
	ld	-2 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-1 (ix),a
	ld	a,-2 (ix)
	sub	a, #0x55
	jr	NZ,00252$
	ld	a,-1 (ix)
	sub	a, #0xAA
	jr	Z,00102$
00252$:
;flash_tool.c:52: print("\r\nMBR MISSING");
	ld	hl,#___str_3
	push	hl
	call	_print
	pop	af
;flash_tool.c:53: return;
	jp	00147$
00102$:
;flash_tool.c:56: print("\r\n");
	ld	hl,#___str_4
	push	hl
	call	_print
	pop	af
;flash_tool.c:59: for (i=0; i<4; i++) {
	ld	a,-50 (ix)
	add	a, #0xBE
	ld	-2 (ix),a
	ld	a,-49 (ix)
	adc	a, #0x01
	ld	-1 (ix),a
	ld	-53 (ix),#0x00
00139$:
;flash_tool.c:60: print("\r\nPartition ");
	ld	hl,#___str_5
	push	hl
	call	_print
	pop	af
;flash_tool.c:61: print_unsigned_char(i);
	ld	a,-53 (ix)
	push	af
	inc	sp
	call	_print_unsigned_char
	inc	sp
;flash_tool.c:62: switch (mbr->partitionTable[i].systemID) {
	ld	a,-53 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0xF0
	ld	e,a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	d,#0x00
	add	hl, de
	ld	a,l
	add	a, #0x04
	ld	-4 (ix),a
	ld	a,h
	adc	a, #0x00
	ld	-3 (ix),a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	a,(hl)
	ld	-5 (ix), a
	or	a, a
	jr	Z,00103$
	ld	a,-5 (ix)
	sub	a, #0x04
	jr	Z,00104$
	jr	00105$
;flash_tool.c:63: case (PARTITION_TYPE_EMPTY):
00103$:
;flash_tool.c:64: print(": EMPTY");
	ld	hl,#___str_6
	push	hl
	call	_print
	pop	af
;flash_tool.c:65: break;
	jr	00140$
;flash_tool.c:66: case (PARTITION_TYPE_FAT16):
00104$:
;flash_tool.c:67: print(": FAT16");
	ld	hl,#___str_7
	push	hl
	call	_print
	pop	af
;flash_tool.c:68: break;
	jr	00140$
;flash_tool.c:69: default:
00105$:
;flash_tool.c:70: print(": 0x");
	ld	hl,#___str_8
	push	hl
	call	_print
	pop	af
;flash_tool.c:71: print_hex(mbr->partitionTable[i].systemID);
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	h,(hl)
	push	hl
	inc	sp
	call	_print_hex
	inc	sp
;flash_tool.c:72: }
00140$:
;flash_tool.c:59: for (i=0; i<4; i++) {
	inc	-53 (ix)
	ld	a,-53 (ix)
	sub	a, #0x04
	jr	C,00139$
;flash_tool.c:75: print("\r\n");
	ld	hl,#___str_4
	push	hl
	call	_print
	pop	af
;flash_tool.c:78: do {
00112$:
;flash_tool.c:79: print("\r\nSelect a partition: ");
	ld	hl,#___str_9
	push	hl
	call	_print
	pop	af
;flash_tool.c:80: choice = getc();
	call	_getc
;flash_tool.c:81: putc(choice);
	ld	-54 (ix), l
	ld	a, l
	push	af
	inc	sp
	call	_putc
	inc	sp
;flash_tool.c:82: i = choice - '0';
	ld	a,-54 (ix)
	ld	-5 (ix), a
	add	a,#0xD0
;flash_tool.c:86: if (mbr->partitionTable[i].systemID != PARTITION_TYPE_FAT16) {
	ld	-53 (ix), a
	rlca
	rlca
	rlca
	rlca
	and	a,#0xF0
	ld	-5 (ix),a
	ld	a,-2 (ix)
	add	a, -5 (ix)
	ld	-4 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
	ld	a,-4 (ix)
	add	a, #0x04
	ld	-7 (ix),a
	ld	a,-3 (ix)
	adc	a, #0x00
	ld	-6 (ix),a
;flash_tool.c:84: if (i>3) continue;
	ld	a,#0x03
	sub	a, -53 (ix)
	jr	C,00113$
;flash_tool.c:86: if (mbr->partitionTable[i].systemID != PARTITION_TYPE_FAT16) {
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	sub	a, #0x04
	jr	Z,00113$
;flash_tool.c:87: print("\r\nONLY FAT16 !!");
	ld	hl,#___str_10
	push	hl
	call	_print
	pop	af
00113$:
;flash_tool.c:90: } while (mbr->partitionTable[i].systemID != PARTITION_TYPE_FAT16);
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	sub	a, #0x04
	jr	NZ,00112$
;flash_tool.c:92: partition = &mbr->partitionTable[i];
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	-52 (ix),l
	ld	-51 (ix),h
;flash_tool.c:95: chipset_load_sector_into_memory(bpb, partition->firstPartitionSector);
	ld	a,-52 (ix)
	add	a, #0x08
	ld	-7 (ix),a
	ld	a,-51 (ix)
	adc	a, #0x00
	ld	-6 (ix),a
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	inc	hl
	ld	a,(hl)
	dec	hl
	ld	l,(hl)
	ld	h,a
	pop	de
	push	de
	push	hl
	push	bc
	push	de
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;flash_tool.c:96: AbsoluteFirstRootDirSecNum = bpb->BPB_RsvSecCnt + bpb->BPB_NumFATs * bpb->BPB_FATs16 + partition->firstPartitionSector;
	ld	a,-56 (ix)
	add	a, #0x0E
	ld	-4 (ix),a
	ld	a,-55 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	pop	hl
	push	hl
	ld	bc, #0x0010
	add	hl, bc
	ld	c,(hl)
	pop	hl
	push	hl
	push	bc
	ld	bc, #0x0016
	add	hl, bc
	pop	bc
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	b,#0x00
	push	de
	push	hl
	push	bc
	call	__mulint_rrx_s
	pop	af
	pop	af
	pop	de
	add	hl,de
	push	hl
	ld	e,-7 (ix)
	ld	d,-6 (ix)
	ld	hl, #0x002F
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	pop	de
	ld	l,e
	ld	h,d
	ld	bc,#0x0000
	ld	a,l
	add	a, -11 (ix)
	ld	l,a
	ld	a,h
	adc	a, -10 (ix)
	ld	h,a
	ld	a,c
	adc	a, -9 (ix)
	ld	c,a
	ld	a,b
	adc	a, -8 (ix)
	ld	b,a
	ld	-31 (ix),l
	ld	-30 (ix),h
	ld	-29 (ix),c
	ld	-28 (ix),b
;flash_tool.c:97: FirstDataSector = bpb->BPB_RsvSecCnt + (bpb->BPB_NumFATs * bpb->BPB_FATs16) + RootDirSectors;
	ld	hl,#0x0020
	add	hl,de
	ld	-27 (ix),l
	ld	-26 (ix),h
	ld	-25 (ix),#0x00
	ld	-24 (ix),#0x00
;flash_tool.c:99: if ((bpb->BPB_BytsPerSec != BYTE_PER_SECTOR) ||
	ld	a,-56 (ix)
	add	a, #0x0B
	ld	-2 (ix),a
	ld	a,-55 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	d,(hl)
	inc	hl
	ld	h,(hl)
	ld	a,d
	or	a, a
	jr	NZ,00115$
	ld	a,h
	sub	a, #0x02
	jr	NZ,00115$
;flash_tool.c:100: (bpb->BPB_SecPerClus != 1) ||
	ld	a,-56 (ix)
	add	a, #0x0D
	ld	-13 (ix),a
	ld	a,-55 (ix)
	adc	a, #0x00
	ld	-12 (ix),a
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	ld	a,(hl)
	dec	a
	jr	NZ,00115$
;flash_tool.c:101: (bpb->BPB_RootEntCnt != ROOT_ENTRY_COUNT) ||
	pop	hl
	push	hl
	ld	de, #0x0011
	add	hl, de
	ld	d,(hl)
	inc	hl
	ld	h,(hl)
	ld	a,d
	or	a, a
	jr	NZ,00115$
	ld	a,h
	sub	a, #0x02
	jr	NZ,00115$
;flash_tool.c:102: (partition->firstPartitionSector + partition->numberOfSector > 65535)) {
	ld	l,-52 (ix)
	ld	h,-51 (ix)
	ld	de, #0x000C
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,-11 (ix)
	add	a, e
	ld	l,a
	ld	a,-10 (ix)
	adc	a, d
	ld	h,a
	ld	a,-9 (ix)
	adc	a, c
	ld	e,a
	ld	a,-8 (ix)
	adc	a, b
	ld	d,a
	ld	a,#0xFF
	cp	a, l
	sbc	a, h
	ld	a,#0x00
	sbc	a, e
	ld	a,#0x00
	sbc	a, d
	jr	NC,00116$
00115$:
;flash_tool.c:103: print("\r\nPrerequisites mismatch !");
	ld	hl,#___str_11
	push	hl
	call	_print
	pop	af
;flash_tool.c:104: return;
	jp	00147$
00116$:
;flash_tool.c:107: print("\r\n");
	ld	hl,#___str_4
	push	hl
	call	_print
	pop	af
;flash_tool.c:110: for (sector = 0; sector < RootDirSectors; sector++) {
	ld	-34 (ix),#0x00
00143$:
;flash_tool.c:112: chipset_load_sector_into_memory(rootDirectory, AbsoluteFirstRootDirSecNum + sector);
	ld	a,-33 (ix)
	ld	-11 (ix),a
	ld	a,-32 (ix)
	ld	-10 (ix),a
;flash_tool.c:110: for (sector = 0; sector < RootDirSectors; sector++) {
	ld	a,-34 (ix)
	sub	a, #0x20
	jp	NC,00130$
;flash_tool.c:112: chipset_load_sector_into_memory(rootDirectory, AbsoluteFirstRootDirSecNum + sector);
	ld	h,-34 (ix)
	ld	l,#0x00
	ld	de,#0x0000
	ld	a,-31 (ix)
	add	a, h
	ld	c,a
	ld	a,-30 (ix)
	adc	a, l
	ld	b,a
	ld	a,-29 (ix)
	adc	a, e
	ld	e,a
	ld	a,-28 (ix)
	adc	a, d
	ld	d,a
	push	de
	push	bc
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;flash_tool.c:115: for (i=0; i<16; i++, entry++) {
	ld	-53 (ix),#0x00
	ld	a,-33 (ix)
	ld	-36 (ix),a
	ld	a,-32 (ix)
	ld	-35 (ix),a
00141$:
;flash_tool.c:116: if (entry->DIR_Name[0] == 0x00) {sector = RootDirSectors; break;} // end of directory
	ld	l,-36 (ix)
	ld	h,-35 (ix)
	ld	a,(hl)
	or	a, a
	jr	NZ,00121$
	ld	-34 (ix),#0x20
	jr	00144$
00121$:
;flash_tool.c:117: if (entry->DIR_Name[0] == 0xE5) continue; // deleted file
	sub	a, #0xE5
	jr	Z,00128$
;flash_tool.c:118: if (entry->DIR_Attr == ATTR_DIRECTORY) continue; // sub directory
	ld	a,-36 (ix)
	ld	-15 (ix),a
	ld	a,-35 (ix)
	ld	-14 (ix),a
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	ld	de, #0x000B
	add	hl, de
	ld	a,(hl)
	sub	a, #0x10
	jr	Z,00128$
;flash_tool.c:120: print("\r\n");
	ld	hl,#___str_4
	push	hl
	call	_print
	pop	af
;flash_tool.c:121: fat16_print_file_name(entry->DIR_Name);
	ld	l,-36 (ix)
	ld	h,-35 (ix)
	push	hl
	call	_fat16_print_file_name
	pop	af
;flash_tool.c:123: if (fat16_compare_file_name(entry->DIR_Name) == TRUE) {
	ld	l,-36 (ix)
	ld	h,-35 (ix)
	push	hl
	call	_fat16_compare_file_name
	pop	af
	dec	l
	jr	NZ,00128$
;flash_tool.c:124: bios_file_entry = entry;
	ld	l,-36 (ix)
	ld	h,-35 (ix)
	ld	(_flash_tool_fat16_bios_file_entry_1_17),hl
;flash_tool.c:125: bios_root_directory_sector = sector;
	ld	a,-34 (ix)
	ld	(#_flash_tool_fat16_bios_root_directory_sector_1_17 + 0),a
	ld	hl,#_flash_tool_fat16_bios_root_directory_sector_1_17 + 1
	ld	(hl), #0x00
00128$:
;flash_tool.c:115: for (i=0; i<16; i++, entry++) {
	inc	-53 (ix)
	ld	a,-36 (ix)
	add	a, #0x20
	ld	-36 (ix),a
	ld	a,-35 (ix)
	adc	a, #0x00
	ld	-35 (ix),a
	ld	a,-53 (ix)
	sub	a, #0x10
	jr	C,00141$
00144$:
;flash_tool.c:110: for (sector = 0; sector < RootDirSectors; sector++) {
	inc	-34 (ix)
	jp	00143$
00130$:
;flash_tool.c:131: if (bios_file_entry == NULL) {
	ld	a,(#_flash_tool_fat16_bios_file_entry_1_17 + 1)
	ld	hl,#_flash_tool_fat16_bios_file_entry_1_17 + 0
	or	a,(hl)
	jr	NZ,00132$
;flash_tool.c:132: print("\r\nBIOS.BIN not found in root directory !");
	ld	hl,#___str_12+0
	push	hl
	call	_print
	pop	af
;flash_tool.c:133: return;
	jp	00147$
00132$:
;flash_tool.c:136: chipset_load_sector_into_memory(rootDirectory, AbsoluteFirstRootDirSecNum + bios_root_directory_sector);
	ld	a,(#_flash_tool_fat16_bios_root_directory_sector_1_17 + 0)
	ld	-19 (ix),a
	ld	a,(#_flash_tool_fat16_bios_root_directory_sector_1_17 + 1)
	ld	-18 (ix),a
	ld	-17 (ix),#0x00
	ld	-16 (ix),#0x00
	ld	a,-31 (ix)
	add	a, -19 (ix)
	ld	-19 (ix),a
	ld	a,-30 (ix)
	adc	a, -18 (ix)
	ld	-18 (ix),a
	ld	a,-29 (ix)
	adc	a, -17 (ix)
	ld	-17 (ix),a
	ld	a,-28 (ix)
	adc	a, -16 (ix)
	ld	-16 (ix),a
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	push	hl
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	push	hl
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;flash_tool.c:139: print("\r\n\r\n");
	ld	hl,#___str_13+0
	push	hl
	call	_print
	pop	af
;flash_tool.c:140: fat16_print_file_name(bios_file_entry->DIR_Name);
	ld	hl,(_flash_tool_fat16_bios_file_entry_1_17)
	push	hl
	call	_fat16_print_file_name
;flash_tool.c:141: print(" found !");
	ld	hl, #___str_14+0
	ex	(sp),hl
	call	_print
;flash_tool.c:144: print("\r\nREAD FILE");	
	ld	hl, #___str_15+0
	ex	(sp),hl
	call	_print
	pop	af
;flash_tool.c:147: for(j=0;j<BIOS_SIZE;j++) {
	ld	-48 (ix),#0x00
	ld	-47 (ix),#0x00
00145$:
;flash_tool.c:148: bios_file[j] = 0x00;
	ld	a,-44 (ix)
	add	a, -48 (ix)
	ld	l,a
	ld	a,-43 (ix)
	adc	a, -47 (ix)
	ld	h,a
	ld	(hl),#0x00
;flash_tool.c:147: for(j=0;j<BIOS_SIZE;j++) {
	inc	-48 (ix)
	jr	NZ,00268$
	inc	-47 (ix)
00268$:
	ld	a,-47 (ix)
	sub	a, #0x10
	jr	C,00145$
;flash_tool.c:151: cluster = bios_file_entry->DIR_FstClusLO;
	ld	iy,(_flash_tool_fat16_bios_file_entry_1_17)
	ld	a,26 (iy)
	ld	-42 (ix),a
	ld	a,27 (iy)
	ld	-41 (ix),a
;flash_tool.c:153: do {
	ld	c,-7 (ix)
	ld	b,-6 (ix)
	ld	a,-46 (ix)
	ld	-19 (ix),a
	ld	a,-45 (ix)
	ld	-18 (ix),a
00136$:
;flash_tool.c:155: AbsoluteFirstSectorOfCluster  = ((cluster-2) * bpb->BPB_SecPerClus) + FirstDataSector + partition->firstPartitionSector;
	ld	e,-42 (ix)
	ld	d,-41 (ix)
	dec	de
	dec	de
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	ld	l,(hl)
	ld	h,#0x00
	push	bc
	push	hl
	push	de
	call	__mulint_rrx_s
	pop	af
	pop	af
	pop	bc
	ld	de,#0x0000
	ld	a,l
	add	a, -27 (ix)
	ld	-11 (ix),a
	ld	a,h
	adc	a, -26 (ix)
	ld	-10 (ix),a
	ld	a,d
	adc	a, -25 (ix)
	ld	-9 (ix),a
	ld	a,e
	adc	a, -24 (ix)
	ld	-8 (ix),a
	ld	l, c
	ld	h, b
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	inc	hl
	ld	a,(hl)
	dec	hl
	ld	h,(hl)
	ld	l,a
	ld	a,-11 (ix)
	add	a, e
	ld	e,a
	ld	a,-10 (ix)
	adc	a, d
	ld	d,a
	ld	a,-9 (ix)
	adc	a, h
	ld	a,-8 (ix)
	adc	a, l
;flash_tool.c:156: chipset_load_sector_into_memory(bios_data, AbsoluteFirstSectorOfCluster);
	ld	hl,#0x0000
	push	hl
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	push	hl
	pop	iy
	pop	hl
	push	bc
	push	hl
	push	de
	push	iy
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	bc
;flash_tool.c:157: bios_data += 512;
	ld	a,-19 (ix)
	add	a, #0x00
	ld	-19 (ix),a
	ld	a,-18 (ix)
	adc	a, #0x02
	ld	-18 (ix),a
;flash_tool.c:160: FatOffset = cluster * 2; // FAT Entry index
	ld	e,-42 (ix)
	ld	d,-41 (ix)
	sla	e
	rl	d
;flash_tool.c:161: AbsoluteThisFatSecNum = bpb->BPB_RsvSecCnt + (FatOffset / bpb->BPB_BytsPerSec) + partition->firstPartitionSector; // FAT Entry Sector
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	a,(hl)
	ld	-15 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-14 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-11 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-10 (ix),a
	push	bc
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	push	de
	call	__divuint_rrx_s
	pop	af
	pop	af
	pop	bc
	ld	a,-15 (ix)
	add	a, l
	ld	e,a
	ld	a,-14 (ix)
	adc	a, h
	ld	d,a
	push	de
	push	bc
	ld	e, c
	ld	d, b
	ld	hl, #0x0025
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	pop	bc
	pop	de
	ld	hl,#0x0000
	ld	a,e
	add	a, -23 (ix)
	ld	e,a
	ld	a,d
	adc	a, -22 (ix)
	ld	d,a
	ld	a,h
	adc	a, -21 (ix)
	ld	a,l
	adc	a, -20 (ix)
;flash_tool.c:162: ThisFatEntryOffset = (cluster % bpb->BPB_BytsPerSec); //(FATOffset % bpb->BPB_BytsPerSec);
	push	bc
	push	de
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	ld	l,-42 (ix)
	ld	h,-41 (ix)
	push	hl
	call	__moduint_rrx_s
	pop	af
	pop	af
	pop	de
	pop	bc
	ld	-40 (ix),l
	ld	-39 (ix),h
;flash_tool.c:164: if (lastFatSectorLoaded != AbsoluteThisFatSecNum) {
	ld	a,(#_flash_tool_fat16_lastFatSectorLoaded_1_17 + 0)
	sub	a, e
	jr	NZ,00271$
	ld	a,(#_flash_tool_fat16_lastFatSectorLoaded_1_17 + 1)
	sub	a, d
	jr	Z,00135$
00271$:
;flash_tool.c:165: chipset_load_sector_into_memory(fat, AbsoluteThisFatSecNum);
	ld	-23 (ix),e
	ld	-22 (ix),d
	ld	-21 (ix),#0x00
	ld	-20 (ix),#0x00
	ld	a,-38 (ix)
	ld	-15 (ix),a
	ld	a,-37 (ix)
	ld	-14 (ix),a
	push	bc
	push	de
	ld	l,-21 (ix)
	ld	h,-20 (ix)
	push	hl
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	push	hl
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	push	hl
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	de
	pop	bc
;flash_tool.c:166: lastFatSectorLoaded = AbsoluteThisFatSecNum;
	ld	(_flash_tool_fat16_lastFatSectorLoaded_1_17),de
00135$:
;flash_tool.c:169: cluster = fat[ThisFatEntryOffset];
	ld	l,-40 (ix)
	ld	h,-39 (ix)
	add	hl, hl
	ld	e,-38 (ix)
	ld	d,-37 (ix)
	add	hl,de
	ld	a,(hl)
	ld	-42 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-41 (ix),a
;flash_tool.c:170: } while (cluster < 0xFFF8);
	ld	a,-42 (ix)
	sub	a, #0xF8
	ld	a,-41 (ix)
	sbc	a, #0xFF
	jp	C,00136$
;flash_tool.c:172: print("\r\nWRITE EEPROM");
	ld	hl,#___str_16+0
	push	hl
	call	_print
	pop	af
;flash_tool.c:173: chipset_flash_bios(bios_file);
	ld	l,-44 (ix)
	ld	h,-43 (ix)
	push	hl
	call	_chipset_flash_bios
	pop	af
00147$:
	ld	sp, ix
	pop	ix
	ret
_flash_tool_fat16_end::
___str_2:
	.db 0x1B
	.ascii "[H"
	.db 0x1B
	.ascii "[2JBIOS - FLASH TOOL v1.0"
	.db 0x0D
	.db 0x0A
	.db 0x0D
	.db 0x0A
	.ascii "Prerequisites :"
	.db 0x0D
	.db 0x0A
	.ascii "- FAT16 Pr"
	.ascii "imary partition"
	.db 0x0D
	.db 0x0A
	.ascii "- Must reside in first physical 32 MB"
	.db 0x0D
	.db 0x0A
	.ascii "- 51"
	.ascii "2 bytes/sector"
	.db 0x0D
	.db 0x0A
	.ascii "- 1 sector/cluster"
	.db 0x0D
	.db 0x0A
	.ascii "- 512 entries in root di"
	.ascii "rectory"
	.db 0x00
___str_3:
	.db 0x0D
	.db 0x0A
	.ascii "MBR MISSING"
	.db 0x00
___str_4:
	.db 0x0D
	.db 0x0A
	.db 0x00
___str_5:
	.db 0x0D
	.db 0x0A
	.ascii "Partition "
	.db 0x00
___str_6:
	.ascii ": EMPTY"
	.db 0x00
___str_7:
	.ascii ": FAT16"
	.db 0x00
___str_8:
	.ascii ": 0x"
	.db 0x00
___str_9:
	.db 0x0D
	.db 0x0A
	.ascii "Select a partition: "
	.db 0x00
___str_10:
	.db 0x0D
	.db 0x0A
	.ascii "ONLY FAT16 !!"
	.db 0x00
___str_11:
	.db 0x0D
	.db 0x0A
	.ascii "Prerequisites mismatch !"
	.db 0x00
___str_12:
	.db 0x0D
	.db 0x0A
	.ascii "BIOS.BIN not found in root directory !"
	.db 0x00
___str_13:
	.db 0x0D
	.db 0x0A
	.db 0x0D
	.db 0x0A
	.db 0x00
___str_14:
	.ascii " found !"
	.db 0x00
___str_15:
	.db 0x0D
	.db 0x0A
	.ascii "READ FILE"
	.db 0x00
___str_16:
	.db 0x0D
	.db 0x0A
	.ascii "WRITE EEPROM"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
