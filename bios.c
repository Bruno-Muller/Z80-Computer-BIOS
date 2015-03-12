#include "bios.h"

volatile char CONST = CONST_NOT_READY;
volatile char CHAR_BUFFER;
unsigned int DMA, SEC;

volatile void (*clock_fct_ptr)() = NULL;

// Non-maskable interrupt handler
void isr_nmi() __critical __interrupt {
}

// Keyboard interrupt handler
void isr_keyboard() __critical __interrupt(1) {
	CHAR_BUFFER = USART_PORT;
	CONST = CONST_READY;
}

// Clock interrupt handler
void isr_clock() __critical __interrupt(2) {
	if (clock_fct_ptr != NULL) (*clock_fct_ptr)();
}

void isr_timer() __critical __interrupt(3) {
	print("\r\nTMR");
}

void isr_trap() __critical __interrupt(4) {
	print("\r\nINTERRUPT TRAP");
	while(1);
}

void bios_clock_handler(void (*fct_ptr)()) {
	clock_fct_ptr = fct_ptr;
	if (clock_fct_ptr != NULL)
		CLOCK_PORT = CLOCK_INT_ENABLE;
	else
		CLOCK_PORT = CLOCK_INT_DISABLE;
}

void bios_get_datetime() {
	chipset_get_datetime();
}

void bios_set_datetime() {
	chipset_set_datetime();
}



unsigned char bios_seldsk() {
	return chipset_init_sdcard();
}

/* =========================================================================== *
 * WBOOT                                                                       *
 * =========================================================================== *
 * The WBOOT entry point gets control when a warm start occurs.                *
 * A warm start is performed whenever a user program branches to location      *
 * 0000H, or when the CPU is reset from the front panel. The CP/M system must  *
 * be loaded from the first two tracks of drive A up to, but not including,    *
 * the BIOS, or CBIOS, if the user has completed the patch. System parameters  *
 * must be initialized as follows:                                             *
 *                                                                             *
 * location 0,1,2                                                              *
 *     Set to JMP WBOOT for warm starts (000H: JMP 4A03H + b)                  *
 *                                                                             *
 * location 3                                                                  *
 *     Set initial value of IOBYTE, if implemented in the CBIOS                *
 *                                                                             *
 * location 4                                                                  *
 *     High nibble = current user number, low nibble = current drive           *
 *                                                                             *
 * location 5,6,7                                                              *
 *     Set to JMP BDOS, which is the primary entry point to CP/M for transient *
 *     programs. (0005H: JMP 3C06H + b)                                        *
 *                                                                             *
 * Refer to Section 6.9 for complete details of page zero use. Upon completion *
 * of the initialization, the WBOOT program must branch to the CCP at 3400H+b  *
 * to restart the system.                                                      *
 * Upon entry to the CCP, register C is set to thedrive;to select after system *
 * initialization. The WBOOT routine should read location 4 in memory, verify  *
 * that is a legal drive, and pass it to the CCP in register C.                *
 * =========================================================================== */
void bios_wboot() {
}

/* =========================================================================== *
 * CONOUT                                                                      *
 * =========================================================================== *
 * The character is sent from register C to the console output device.         *
 * The character is in ASCII, with high-order parity bit set to zero. You      *
 * might want to include a time-out on a line-feed or carriage return, if the  *
 * console device requires some time interval at the end of the line (such as  *
 * a TI Silent 700 terminal). You can filter out control characters that cause *
 * the console device to react in a strange way (CTRL-Z causes the Lear-       *
 * Siegler terminal to clear the screen, for example).                         *
 * =========================================================================== */
void bios_conout(char c) {
	USART_PORT = c;
}

/* =========================================================================== *
 * CONIN                                                                       *
 * =========================================================================== *
 * The next console character is read into register A, and the parity bit is   *
 * set, high-order bit, to zero. If no console character is ready, wait until  *
 * a character is typed before returning.                                      *
 * =========================================================================== */
char bios_conin() {
	while(CONST == CONST_NOT_READY);
	CONST = CONST_NOT_READY;
	return CHAR_BUFFER;
}

/* =========================================================================== *
 * CONST                                                                       *
 * =========================================================================== *
 * You should sample the status of the currently assigned console device and   *
 * return 0FFH in register A if a character is ready to read and 00H in        *
 * register A if no console characters are ready.                              *
 * =========================================================================== */
char bios_const() {
	return CONST;
}

/* =========================================================================== *
 * SETDMA                                                                      *
 * =========================================================================== *
 * Register BC contains the DMA (Disk Memory Access) address for subsequent    *
 * read or write operations. For example, if B = 00H and C = 80H when SETDMA   *
 * is called, all subsequent read operations read their data into 80H through  *
 * 0FFH and all subsequent write operations get their data from 80H through    *
 * 0FFH, until the next call to SETDMA occurs. The initial DMA address is      *
 * assumed to be 80H. The controller need not actually support Direct Memory   *
 * Access. If, for example, all data transfers are through I/O ports, the      *
 * CBIOS that is constructed uses the 128 byte area starting at the selected   *
 * DMA address for the memory buffer during the subsequent read or write       *
 * operations.                                                                 *
 ; =========================================================================== */
void bios_setdma(unsigned int val) {
	DMA = val;
}

/* =========================================================================== *
 * SETSEC                                                                      *
 * =========================================================================== *
 * Register BC contains the sector number, 1 through 26, for subsequent disk   *
 * accesses on the currently selected drive. The sector number in BC is the    *
 * same as the number returned from the SECTRAN entry point. You can choose to *
 * send this information to the controller at this point or delay sector       *
 * selection until a read or write operation occurs.                           *
 * =========================================================================== */
void bios_setsec(unsigned int val) {
	SEC = val;
}

/* =========================================================================== *
 * READ                                                                        *
 * =========================================================================== *
 * Assuming the drive has been selected, the track has been set, and the DMA   *
 * address has been specified, the READ subroutine attempts to read one sector *
 * based upon these parameters and returns the following error codes in        *
 * register A:                                                                 *
 *                                                                             *
 *     0 - no errors occurred                                                  *
 *     1 - nonrecoverable error condition occurred                             *
 *                                                                             *
 * Currently, CP/M responds only to a zero or nonzero value as the return      *
 * code. That is, if the value in register A is 0, CP/M assumes that the disk  *
 * operation was completed properly. If an error occurs the CBIOS should       *
 * attempt at least 10 retries to see if the error is recoverable. When an     *
 * error is reported the BDOS prints the message BDOS ERR ON x: BAD SECTOR.    *
 * The operator then has the option of pressing a carriage return to ignore    *
 * the error, or CTRL-C to abort.                                              *
 * =========================================================================== */
void bios_read() {
	chipset_load_sector_into_memory((void*) DMA, (unsigned long) SEC);
}


























