@echo OFF

echo Copying bin file...
copy /y BoneOS.bin ISO\BoneOS.bin

echo Generating ISO9660...
Tools\ISO9660Generator.exe 4 "%CD%\BoneOS.iso" "%CD%\ISO\isolinux-debug.bin" true "%CD%\ISO"

echo Complete.
pause
@echo ON