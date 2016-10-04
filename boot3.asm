;----------------------------------------------;
;
; The BoneOS Bootloader Third Stage Bootloader
; ------------------------------
;
;
; Contributors : @amanuel2
;
;
;----------------------------------------------;

%include "stdio32boot.inc"

[BITS 32]
        stage3:
          ; set segment registers
          mov ax, 0x10
          mov ds, ax
          mov ss, ax

          mov esp, 0x090000 ; set up stack pointer

		  
		  mov al,'X'
		  mov ah,0x6F
		  call puts32
          ;call dword 0x08:0x01000 ; go to C code


          jmp $