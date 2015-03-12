;--------------------------------------------------------------------------
;  crt0.s - Generic crt0.s for a Z80
;
;  Copyright (C) 2000, Michael Hope
;
;  This library is free software; you can redistribute it and/or modify it
;  under the terms of the GNU General Public License as published by the
;  Free Software Foundation; either version 2, or (at your option) any
;  later version.
;
;  This library is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License 
;  along with this library; see the file COPYING. If not, write to the
;  Free Software Foundation, 51 Franklin Street, Fifth Floor, Boston,
;   MA 02110-1301, USA.
;
;  As a special exception, if you link this library with other files,
;  some of which are compiled with SDCC, to produce an executable,
;  this library does not by itself cause the resulting executable to
;  be covered by the GNU General Public License. This exception does
;  not however invalidate any other reasons why the executable file
;   might be covered by the GNU General Public License.
;--------------------------------------------------------------------------

	.module crt0
	.globl	_main
		
	.globl l__INITIALIZER
	.globl s__INITIALIZER
	.globl s__INITIALIZED
	
	.globl	_isr_keyboard
	.globl	_isr_timer
	.globl	_isr_clock
	.globl	_isr_nmi
	.globl	_isr_trap
	
	.globl 	_bios_clock_handler
	.globl  _bios_get_datetime
	.globl  _bios_set_datetime
	
	;.globl _BOOT    ; COLD START
	.globl _bios_wboot   ; WARM START
	.globl _bios_const   ; CONSOLE STATUS
	.globl _bios_conin   ; CONSOLE CHARACTER IN
	.globl _bios_conout  ; CONSOLE CHARACTER OUT
	;.globl _LIST    ; LIST CHARACTER OUT
	;.globl _PUNCH   ; PUNCH CHARACTER OUT
	;.globl _READER  ; READER CHARACTER OUT
	;.globl _HOME    ; MOVE HEAD TO HOME POSITION
	.globl _bios_seldsk  ; SELECT DISK
	;.globl _SETTRK  ; SET TRACK NUMBER
	.globl _bios_setsec  ; SET SECTOR NUMBER
	.globl _bios_setdma  ; SET DMA ADDRESS
	.globl _bios_read    ; READ DISK
	;.globl _WRITE   ; WRITE DISK
	;.globl _LISTST  ; RETURN LIST STATUS
	;.globl _SECTRAN ; SECTOR TRANSLATE

	.area	_HEADER (ABS)
	.org 	0x000
	
	;; Set stack pointer directly above top of memory.
	LD SP, #0x0000
	
	;; Setup interrupt vectors
	;LD HL, #_isr_keyboard
	;LD (#0x1000), HL
	
	;LD HL, #_isr_timer
	;LD (#0x1002), HL
	
	;LD HL, #_isr_clock
	;LD (#0x1004), HL
	
	;; Set interrupt vector address
	;LD 	A, 	#0x10
	LD	A, #0x0E
	LD 	I, 	A
	IM 2

	;; Initialise global variables
    CALL    gsinit
	
	;; Execute main program
	CALL	_main
	
	JP 0x1100
	
	;; =====================
	;; * Interrupt vectors *
	;; =====================
	.org	0x0E00
	
	.dw	_isr_keyboard
	.dw _isr_timer
	.dw _isr_clock
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	.dw _isr_trap
	
	;; ============================
	;; * Extended Bios Jump Table *
	;; ============================
	.org 0xFC4
	JP _bios_clock_handler
	JP _bios_get_datetime
	JP _bios_set_datetime
	
	;; ===================
	;; * BIOS Jump Table *
	;; ===================
	.org 0x0FCD
	JP 0x0000			; #0 BOOT
	JP _bios_wboot 		; #1 WBOOT
	JP _bios_const		; #2 CONST
	JP _bios_conin		; #3 CONIN
	JP _bios_conout		; #4 CONOUT
	JP 0x0000			; #5 LIST
	JP 0x0000			; #6 PUNCH
	JP 0x0000			; #7 READER
	JP 0x0000			; #8 HOME
	JP _bios_seldsk		; #9 SELDSK
	JP 0x0000			; #10 SELTRK
	JP _bios_setsec		; #11 SETSEC
	JP _bios_setdma		; #12 SETDMA
	JP _bios_read		; #13 READ
	JP 0x0000			; #14 WRITE
	JP 0x0000			; #15 LISTST
	JP 0x0000			; #16 SECTRAN
	
	;; Ordering of segments for the linker.
	.area	_HOME
	.area	_CODE
	.area	_INITIALIZER
	.area   _GSINIT
	.area   _GSFINAL
	
	.area	_DATA
	.area	_INITIALIZED
	.area	_BSEG
	.area   _BSS
	.area   _HEAP

	.area   _GSINIT
gsinit::
	ld	bc, #l__INITIALIZER
	ld	a, b
	or	a, c
	jr	Z, gsinit_next
	ld	de, #s__INITIALIZED
	ld	hl, #s__INITIALIZER
	ldir
	
gsinit_next:
	.area   _GSFINAL
	ret




