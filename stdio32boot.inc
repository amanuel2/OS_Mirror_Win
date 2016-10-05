;----------------------------------------------;
;
; The BoneOS Bootloader STDIO.h 32 BITS
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

        X_POS db 0
        Y_POS db 0



puts32char: ;<char Character, void>
     
	  mov BYTE bh,[esp+4]
	 
	  movzx eax, BYTE [X_POS]      ; EAX = column
      movzx ecx, BYTE [Y_POS]      ; ECX = row
	  push eax ; Retain previous info
	  push ecx ; Retain Previous info
	  
	  mov edx, ecx                 ; EDX = row
      imul edx, ecx, COLS          ; EDX = COLS * row
      add edx,ecx                  ; EDX = COLS * row + column

      mov BYTE [VIDMEM+edx*2], bh ; Write 'Z' to memory without
                                       ; overwriting the current attribute
      inc edx                      ; Advance to next video cell
      mov BYTE [VIDMEM+edx*2], 0x00 | ''
	  
	  pop ecx
	  pop eax
	  
	  add eax,1 ; 1 for text and other for color
	  mov [Y_POS] , eax
	  
	 add ecx,1 ; 1 for text and other for color
	 mov [X_POS] , eax
	  
	  RET	
	 
	
