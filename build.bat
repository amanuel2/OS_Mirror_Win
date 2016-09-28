
del boot1.bin
del cdiso/boot1.img
del boot1.img
"NASM/nasm.exe" boot1.asm -f bin -o boot1.bin
"PartyCopy/dd.exe" if=boot1.bin of=boot1.img
copy boot1.img cdiso/boot1.img
"Mkisofs/Binary/Sample/mkisofs.exe" -o boot1.iso -b boot1.img  cdiso/
set /p DUMMY=Hit ENTER to continue...
 "Bochs-2.6.8/bochsdbg.exe" -q -f bochsrc.bxrc
