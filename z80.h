#ifndef Z80_H
#define	Z80_H

#define enable_interrupt() __asm__("EI")
#define disable_interrupt() __asm__("DI")

#define BOOT_START_ADDRESS (void *) 0x1100

#endif /* Z80_H */