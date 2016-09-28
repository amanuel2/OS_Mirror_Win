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
 
[  BITS  16  ]; 16 bits real mode
 
 

 JMP main ; Jump to Main Function of the Bootloader

 ;/////////////////////////////////////////////
 ;	Include Files
 ;////////////////////////////////////////////
 
	 ;--------------------------------------
	 ; 		STDIO.h
	 ; I/O Functions. Such as printfb which 
	 ; prints a string to the screen.
	 ; 
	 ; @functions:
	 ;     printfb ARGS: <SI = String>
	 ;	   printfbln ARGS: <SI = String>
	 ;	   clearscreen
	 ;	   print_new_line
	 ;--------------------------------------
	 %include "stdiobios.inc" 
	 
	 ;--------------------------------------
	 ;		load2.asm
	 ;	Loads 2 stage bootloader
	 ;  Which then loads the kernel
	 ; 	in 32 bit protected mode!
	 ;	
	 ;--------------------------------------
	 %include "load2.inc"
 
;-----------------------------------------------
;-----------------------------------------------
;  Label "Function" Main Declarations :)
; 
;	Bone Project
;----------------------------------------------



	
;----------------------------------------------
;  Label "Variable" Main Declaractions :)
;
;  Bone Project
;----------------------------------------------

FirstMessageExecution : db "Stage 1 Bootloader Executing .  .  .", 0
SecondStageBootloaderFinished : db "Finished Loading Second Stage Bootloader !" , 0
SecondStageBootloaderStart : db "Starting to  Loading Second Stage Bootloader !", 0 

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
				CALL printfbln	;Call print string procedure
				MOV SI,SecondStageBootloaderStart
				CALL printfbln
				CALL Load2StageBootloader ; Load 2 stage Bootloader. Code Located at [load2.inc]
				MOV SI, SecondStageBootloaderFinished ;Store string pointer to SI
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