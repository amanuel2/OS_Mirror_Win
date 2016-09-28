;####################
;Printf BIOS Function
;####################

printfb: 
	LODSB ; Load Byte <SI Register> -> <AL Register>
	OR al,al ; Check if AL Register is \0 (End Of String)
	JZ printfb_done; If Zero Termination
	MOV ah,0eh ; 0eh Function = Printing. Character is read from <AL REGISTER>
	MOV BH, 0x00	;Page no.
    MOV BL, 0x07	;Text attribute 0x07 is lightgrey font on black background
	INT 0x10 ; 0x10 BIOS CALL
	JMP printfb ; Jump Back to printfb for next character/byte
printfb_done:
	RET ; Return from function
	
;###############
;	Clear Screen Function
;###############
clearscreen:
		MOV     ax, 0x3 ; 03h Function -> Clear Screen BIOS Command
		INT     0x10	; Interupt 10 BIOS 