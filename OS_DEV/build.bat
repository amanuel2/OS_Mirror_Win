
rm boot1.bin
rm boot1.img
 "NASM/nasm.exe" boot1.asm -f bin -o boot1.bin
 "PartyCopy/dd.exe" if=boot1.bin of=boot1.img
set /p DUMMY=Hit ENTER to continue...
 "Bochs-2.6.8/bochsdbg.exe" -q -f bochsrc.bxrc
