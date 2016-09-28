;----------------------------------------------;
;
; Loader of Second Stage Bootloader
; ----------------------
;
;
; Contributors : @amanuel2
;
;
;----------------------------------------------;




	
Load2StageBootloader:
	.Resetflp: ; Reset Floppy Drive
		mov ah,0 ; Function #0 from Interupt 13h. Reset the floppy
		mov dl,0 ; Drive Number #0. Floppy Drive
		int 0x13 ; BIOS Interupt 13h
		jc .Resetflp ; If Any Errors Carry flag set , and redo Resetflp
		ret