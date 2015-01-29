;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Sun Jan 25 23:44:53 2015
;--------------------------------------------------------
	.module bios
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isr_clock
	.globl _isr_keyboard
	.globl _isr_nmi
	.globl _chipset_init_sdcard
	.globl _chipset_load_sector_into_memory
	.globl _CONST
	.globl _SEC
	.globl _DMA
	.globl _CHAR_BUFFER
	.globl _IO_RET
	.globl _IO_PARAM2
	.globl _IO_PARAM1
	.globl _bios_seldsk
	.globl _bios_wboot
	.globl _bios_conout
	.globl _bios_conin
	.globl _bios_const
	.globl _bios_setdma
	.globl _bios_setsec
	.globl _bios_read
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
_CHAR_BUFFER::
	.ds 1
_DMA::
	.ds 2
_SEC::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_CONST::
	.ds 1
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
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;bios.c:8: void isr_nmi() __critical __interrupt {
;	---------------------------------
; Function isr_nmi
; ---------------------------------
_isr_nmi_start::
_isr_nmi:
	push	af
	push	bc
	push	de
	push	hl
	push	iy
;bios.c:9: }
	pop	iy
	pop	hl
	pop	de
	pop	bc
	pop	af
	retn
_isr_nmi_end::
;bios.c:12: void isr_keyboard() __critical __interrupt(1) {
;	---------------------------------
; Function isr_keyboard
; ---------------------------------
_isr_keyboard_start::
_isr_keyboard:
	di
	push	af
	push	bc
	push	de
	push	hl
	push	iy
;bios.c:13: CHAR_BUFFER = USART_PORT;
	in	a,(_USART_PORT)
	ld	(#_CHAR_BUFFER + 0),a
;bios.c:14: CONST = CONST_READY;
	ld	hl,#_CONST + 0
	ld	(hl), #0xFF
	pop	iy
	pop	hl
	pop	de
	pop	bc
	pop	af
	ei
	reti
_isr_keyboard_end::
;bios.c:18: void isr_clock() __critical __interrupt(2) {
;	---------------------------------
; Function isr_clock
; ---------------------------------
_isr_clock_start::
_isr_clock:
	di
	push	af
	push	bc
	push	de
	push	hl
	push	iy
;bios.c:20: }
	pop	iy
	pop	hl
	pop	de
	pop	bc
	pop	af
	ei
	reti
_isr_clock_end::
;bios.c:22: unsigned char bios_seldsk() {
;	---------------------------------
; Function bios_seldsk
; ---------------------------------
_bios_seldsk_start::
_bios_seldsk:
;bios.c:23: return chipset_init_sdcard();
	jp	_chipset_init_sdcard
_bios_seldsk_end::
;bios.c:56: void bios_wboot() {
;	---------------------------------
; Function bios_wboot
; ---------------------------------
_bios_wboot_start::
_bios_wboot:
;bios.c:57: }
	ret
_bios_wboot_end::
;bios.c:70: void bios_conout(char c) {
;	---------------------------------
; Function bios_conout
; ---------------------------------
_bios_conout_start::
_bios_conout:
;bios.c:71: USART_PORT = c;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	out	(_USART_PORT),a
	ret
_bios_conout_end::
;bios.c:81: char bios_conin() {
;	---------------------------------
; Function bios_conin
; ---------------------------------
_bios_conin_start::
_bios_conin:
;bios.c:82: while(CONST == CONST_NOT_READY);
00101$:
	ld	a,(#_CONST + 0)
	or	a, a
	jr	Z,00101$
;bios.c:83: CONST = CONST_NOT_READY;
	ld	hl,#_CONST + 0
	ld	(hl), #0x00
;bios.c:84: return CHAR_BUFFER;
	ld	iy,#_CHAR_BUFFER
	ld	l,0 (iy)
	ret
_bios_conin_end::
;bios.c:94: char bios_const() {
;	---------------------------------
; Function bios_const
; ---------------------------------
_bios_const_start::
_bios_const:
;bios.c:95: return CONST;
	ld	iy,#_CONST
	ld	l,0 (iy)
	ret
_bios_const_end::
;bios.c:112: void bios_setdma(unsigned int val) {
;	---------------------------------
; Function bios_setdma
; ---------------------------------
_bios_setdma_start::
_bios_setdma:
;bios.c:113: DMA = val;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	ld	(#_DMA + 0),a
	ld	hl, #2+1
	add	hl, sp
	ld	a, (hl)
	ld	(#_DMA + 1),a
	ret
_bios_setdma_end::
;bios.c:125: void bios_setsec(unsigned int val) {
;	---------------------------------
; Function bios_setsec
; ---------------------------------
_bios_setsec_start::
_bios_setsec:
;bios.c:126: SEC = val;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	ld	(#_SEC + 0),a
	ld	hl, #2+1
	add	hl, sp
	ld	a, (hl)
	ld	(#_SEC + 1),a
	ret
_bios_setsec_end::
;bios.c:148: void bios_read() {
;	---------------------------------
; Function bios_read
; ---------------------------------
_bios_read_start::
_bios_read:
;bios.c:149: chipset_load_sector_into_memory((void*) DMA, (unsigned long) SEC);
	ld	hl,#_SEC + 0
	ld	e, (hl)
	ld	hl,#_SEC + 1
	ld	d, (hl)
	ld	bc,#0x0000
	ld	iy,(_DMA)
	push	bc
	push	de
	push	iy
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	ret
_bios_read_end::
	.area _CODE
	.area _INITIALIZER
__xinit__CONST:
	.db #0x00	;  0
	.area _CABS (ABS)
