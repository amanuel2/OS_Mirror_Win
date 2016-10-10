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
			
		  push 'A'
		  call puts32char
		  add esp, 4
			 jmp 0x08:k_main
			cli
			loopend:                ;Infinite loop when finished
				hlt
		  jmp loopend

          cli
          hlt
