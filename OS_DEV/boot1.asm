;----------------------------------------------;
;
; The BoneOS Bootloader
; ----------------------
;
;
; Contributors : @amanuel2
;
;
;----------------------------------------------;

[ ORG 0x0000 ]   ;We Will Set Registers to point to 0x7C00 Later
 
[  BITS  16     ]; 16 bits real mode
 
 
 ;/////////////////////////////////////////////
 ;	Include Files
 ;////////////////////////////////////////////
 
	 %include "stdiobios.asm"
 
 jmp main ; Jump to Main Function of the Bootloader

;-----------------------------------------------
;-----------------------------------------------
;  Label "Function" Declarations :)
; 
;	Bone Project
;----------------------------------------------



	
;----------------------------------------------
;  Label "Variable" Declaractions :)
;
;  Bone Project
;----------------------------------------------

FirstMessageExecution : db "Stage 1 Bootloader Executing .  .  .", 0

;-----							    -----;
;----- 		Main Function		-----;
;-----							    -----;
               

main:
			   CLI ; Clear Interupts Before Manupulating Segments
				
				;------------------------------
				; Bootloader Repsonsibility To 
				; Setup Registers to point to our 
				; Segments (Except Code Segment)
				;
				;------------------------------
				
				; 0x07C0 : 0x0 
				MOV ax,0x07C0
				MOV ds,ax ; Data Segment
				MOV es,ax ; Extra Segment (E)
				MOV fs,ax ; Extra Extra Segment (F Comes after E)
				MOV gs,ax ; Extra Extra Extra Segment (G Comes after F)
				
				;-------------------------------
				;--Setting Up The Stack
				;--Stack Grows Downwards
				;-------------------------------
				
				MOV ax,0
				MOV ss,ax ; Cant Directly Move to Stack Segment
				MOV sp,0xFFFF ; Start Stackpointer from the top , growing downward
				
				
				STI ; Restore Interupts
			
				MOV     ax, 0x3
				INT     0x10	

				MOV SI, FirstMessageExecution ;Store string pointer to SI
				CALL printfb	;Call print string procedure
				jmp $

;----------------------------------------------;
; Bootloader signature must be located
; at bytes #511 and #512.
; Fill with 0 in between.
; $  = address of the current line
; $$ = address of the 1st instruction
;----------------------------------------------;

times 510 - ($-$$) db 0
dw        0xaa55