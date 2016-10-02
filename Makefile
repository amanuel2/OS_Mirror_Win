all: clean
	 "NASM/nasm.exe" boot1.asm -f bin -o boot1.bin
	 "PartyCopy/dd.exe" if=boot1.bin of=boot1.img
bochs:	 
	 "Bochs-2.6.8/bochsdbg.exe" -q -f bochsrc.bxrc
qemu:
	QEMU/qemu -drive format=raw,file=boot1.img,index=0,if=floppy  
qemu_debug:
	QEMU/qemu -drive format=raw,file=boot1.img,index=0,if=floppy  -s -S

clean:
	del boot1.bin
	del boot1.img