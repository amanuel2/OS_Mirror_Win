;----------------------------------------------;
;
; The BoneOS Stage 1 Bootloader
; -----------------------------
;
;
; Contributors : @amanuel2
;
;
;----------------------------------------------;

[ ORG 0x0000 ]   ;We Will Set Registers to point to 0x7C00 Later
 
[  BITS  16  ]; 16 bits real mode

JMP main_first ; Jump to Main Function of the Bootloader

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
SECONDSTAGEXECUTION : db "Stage 2 Bootloader Executing . . .",0

												;-----							    -----;
												;----- 		Main Function			-----;
												;-----							    -----;


main_first:	 
				CLI ; Clear Interupts Before Manupulating Segments
				
				;------------------------------
				; Bootloader Repsonsibility To 
				; Setup Registers to point to our 
				; Segments (Except Code Segment)
				;
				;------------------------------

SEGMENTS:				
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

STACK:				
				MOV ax,0
				MOV ss,ax ; Cant Directly MOVe to Stack Segment
				MOV sp,0xFFFF ; Start Stackpointer from the top , growing downward
				
				
				STI ; Restore Interupts
				MOV     ax, 0x3
				INT     0x10	
				
SECONDSTAGE:		
				MOV si, FirstMessageExecution
				CALL printfbln		
				
				; Load stage 2 to memory.
				MOV ah, 0x02
				; Number of sectors to read.
				MOV al, 1
				; This may not be necessary as many BIOS set it up as an initial state.
				MOV dl, 0x00
				; Cylinder number.
				MOV ch, 0
				; Head number.
				MOV dh, 0
				; Starting sector number. 2 because 1 was already loaded.
				MOV cl, 2
				; Where to load to.
				MOV bx, stage2
				INT 0x13

				JMP stage2

				; Magic bytes.    
				times ((0x200 - 2) - ($ - $$)) db 0x00
				dw 0xAA55

				
;--------------------------------------
;		load2.asm
;	Second Stage Bootloader
;   Which then loads the kernel
; 	in 32 bit protected mode!
;	
;--------------------------------------
%include "boot2.asm"
