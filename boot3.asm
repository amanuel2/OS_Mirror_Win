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

		  push 'Z'
		  call puts32char
		  add esp,4
		  
		  push 'P'
		  call puts32char
		  add esp,4

          cli
          hlt

        X_POS db 0
        Y_POS db 0