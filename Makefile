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
qemu_debug:
	QEMU/qemu -drive format=raw,file=boot1.img,index=0,if=floppy  -s -S

clean: