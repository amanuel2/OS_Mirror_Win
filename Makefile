all: clean
	 "NASM/nasm.exe" boot1.asm -f bin -o boot1.bin
		"NASM/nasm.exe" kernel.asm -f bin -o kernel.bin
	 "PartyCopy/dd.exe" if=boot1.bin of=boot1.img
	 
	  copy boot1.img cdiso/boot1.img
	  mkisofs -R -b boot1.img -no-emul-boot -boot-load-size 4 -boot-info-table -o boot.iso cdiso
bochs:	 
	 "Bochs-2.6.8/bochsdbg.exe" -q -f bochsrc.bxrc
qemu:
	QEMU/qemu -drive format=raw,file=boot1.img,index=0,if=floppy 
calc:
# "PartyCopy/dd.exe" if=kernel.bin of=boot1.img
	nasm -fwin32 calc.asm
	gcc calc.obj
	a	
qemu_debug:
	QEMU/qemu -drive format=raw,file=boot1.img,index=0,if=floppy  -s -S

	
compile_: 
	ghost-i686-elf-tools/bin/i686-elf-gcc -g -m32 -c -ffreestanding -o kernel.o kernel.c -lgcc
	ghost-i686-elf-tools/bin/i686-elf-ld -melf_i386 -T linker.ld -nostdlib --nmagic -o kernel.elf kernel.o
	ghost-i686-elf-tools/bin/i686-elf-objcopy -O binary kernel.elf kernel.bin
	"NASM/nasm.exe" boot1.asm  -o boot1.o
	ghost-i686-elf-tools/bin/i686-elf-ld -melf_i386 -Ttext=0x7c00 -nostdlib --nmagic -o boot.elf boot.o
	ghost-i686-elf-tools/bin/i686-elf-objcopy -O binary boot.elf boot.bin
	"PartyCopy/dd.exe" if=/dev/zero of=disk.img bs=512 count=2880
	"PartyCopy/dd.exe" if=boot.bin of=disk.img bs=512 conv=notrunc
	"PartyCopy/dd.exe" if=kernel.bin of=disk.img bs=512 seek=1 conv=notrunc
	"PartyCopy/dd.exe" if=boot.bin of=disk.img bs=512 conv=notrunc
	"PartyCopy/dd.exe" if=kernel.bin of=disk.img bs=512 seek=1 conv=notrunc
	QEMU/qemu -fda disk.img
	
compile_c:
	ghost-i686-elf-tools/bin/i686-elf-gcc -g -m32 -c -ffreestanding -o kernel.o kernel.c -lgcc
	ghost-i686-elf-tools/bin/i686-elf-ld -melf_i386 -T linker.ld -nostdlib --nmagic -o kernel.elf kernel.o
	ghost-i686-elf-tools/bin/i686-elf-objcopy -O binary kernel.elf kernel.bin
	
compile_asm:
	nasm -g -f elf32 -F dwarf -o boot.o boot1.asm
	ghost-i686-elf-tools/bin/i686-elf-ld -melf_i386 -Ttext=0x7c00 -nostdlib --nmagic -o boot.elf boot.o
	ghost-i686-elf-tools/bin/i686-elf-objcopy -O binary boot.elf boot.bin
	
image:
	"PartyCopy/dd.exe" if=/dev/zero of=disk.img bs=512 count=2880
	"PartyCopy/dd.exe" if=boot.bin of=disk.img bs=512 conv=notrunc
	"PartyCopy/dd.exe" if=kernel.bin of=disk.img bs=512 seek=1 conv=notrunc
	"PartyCopy/dd.exe" if=boot.bin of=disk.img bs=512 conv=notrunc
	"PartyCopy/dd.exe" if=kernel.bin of=disk.img bs=512 seek=1 conv=notrunc
qemu_c:
	QEMU/qemu -fda disk.img	

clean: