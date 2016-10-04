;----------------------------------------------;
;
; The BoneOS Bootloader STDIO.h 32
; ------------------------------
;
;
; Contributors : @amanuel2
;
;
;----------------------------------------------;

[BITS 32]

%define		VIDMEM	0xB8000			; video memory
%define		COLS	80			; width and height of screen
%define		LINES	25
%define		CHAR_ATTRIB 14			; character attribute (White text on black background)

	
puts32:
	 MOV BYTE [0xB8000], al
	 MOV BYTE [0xB8000+1], ah
	 RET