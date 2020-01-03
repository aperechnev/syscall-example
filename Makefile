CC = arm-none-eabi-gcc
AR = arm-none-eabi-ar
LD = arm-none-eabi-ld
AS = arm-none-eabi-as

COMMON_GCC_FLAGS = -nostdlib -nostdinc -ffreestanding -lc $(INCLUDE) -O0

CFLAGS = $(COMMON_GCC_FLAGS) -mcpu=arm926ej-s -g -D TARGET_ARM

all:
	${CC} ${CFLAGS} -c -g code.c -o code.o
	${AS} -mcpu=arm926ej-s -g ivt.s -o ivt.o
	${LD} -o syscall.elf -T arm.ld ivt.o code.o libgcc.a
	arm-none-eabi-objcopy -O binary syscall.elf syscall.bin

debug:
	qemu-system-arm -s -S -M versatilepb -m 128M -kernel syscall.bin -serial stdio

clean:
	rm -rf *.o
	rm syscall.elf
	rm syscall.bin
