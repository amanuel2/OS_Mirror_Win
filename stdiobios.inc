;----------------------------------------------;
;
; The BoneOS Bootloader STDIO.h 16
; ------------------------------
;
;
; Contributors : @amanuel2
;
;
;----------------------------------------------;
[BITS 16]

%ifndef STDIO_BIOS_INC
%define STDIO_BIOS_INC 1


;####################
;Printf BIOS Function
;####################

puts16: 
	LODSB ; Load Byte <SI Register> -> <AL Register>
	OR al,al ; Check if AL Register is \0 (End Of String)
	JZ puts16_done; If Zero Termination
	MOV ah,0eh ; 0x0E Function = Printing. Character is read from <AL REGISTER>
	MOV BH, 0x00	;Page no.
    MOV BL, 0x07	;Text attribute 0x07 is lightgrey font on black background
	INT 0x10 ; 0x10 BIOS CALL
	JMP puts16 ; Jump Back to printfb for next character/byte
puts16_done:
	RET ; Return from function
	
puts16ln: ; Print Line Function
	CALL puts16
	CALL puts16_new_line
	
;################
;#Print New Line
;################
puts16_new_line:
	MOV ah, 0x0E ; 0x0E Function for Printing Characters
	MOV al, 0x0D ; 0x0D \0 character
	INT 0x10 ; 0x10 BIOS CALL 
	MOV al, 0x0A ; 0x0A \n character
	INT 0x10 ; 0x10 BIOS CALL
	RET
;FORMAT
;	string_1 db 'test 1', 0x0D, 0x0A, 0x00
;	string_2 db 'test 2', 0x0D, 0x0A, 0x00
;	string_3 db 'test 3', 0x0D, 0x0A, 0x00	

;######################
;Clear Screen Function
;######################

clearscreen:
	MOV ax, 0x3 ; 03h Function -> Clear Screen BIOS Command
	INT 0x10	; Interupt 10 BIOS

			   
 
%endif	