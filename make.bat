cls
cd %1
D:
sdasz80 -o crt0.s
sdcc -mz80 -c bios.c
sdcc -mz80 -c chipset.c
sdcc -mz80 -c fat16.c
sdcc -mz80 -c flash_tool.c
sdcc -mz80 -c io.c
sdcc -mz80 -c main.c
sdcc -mz80 -c malloc.c
sdcc -mz80 --code-loc 0x100 --data-loc 0x70 --no-std-crt0 -o bios.ihx main.rel crt0.rel io.rel malloc.rel fat16.rel flash_tool.rel bios.rel chipset.rel
makebin -p bios.ihx bios.bin
pause