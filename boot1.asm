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

[ORG 0x7c00]   ;We Will Set Registers to point to 0x7C00 Later

[  BITS  16  ]; 16 bits real mode

JMP main_first ; Jump to Main Function of the Bootloader

 ;/////////////////////////////////////////////
 ;  Include Files
 ;////////////////////////////////////////////

     ;--------------------------------------
     ;      STDIO.h
     ; I/O Functions. Such as printfb which 
     ; prints a string to the screen.
     ; 
     ; @functions:
     ;     printfb ARGS: <SI = String>
     ;     printfbln ARGS: <SI = String>
     ;     clearscreen
     ;     print_new_line
     ;--------------------------------------
     %include "stdiobios.inc" 

;-----------------------------------------------
;-----------------------------------------------
;  Label "Function" Main Declarations :)
; 
;   Bone Project
;----------------------------------------------




;----------------------------------------------
;  Label "Variable" Main Declaractions :)
;
;  Bone Project
;----------------------------------------------

FirstMessageExecution : db "Stage 1 Bootloader Executing .  .  .", 0
SECONDSTAGEXECUTION : db "Stage 2 Bootloader Executing . . .",0

;align 4
gdt_start:                              ; Start of global descriptor table
    gdt_null:                           ; Null descriptor chunk
        dd 0x00
        dd 0x00
    gdt_code:                           ; Code descriptor chunk
        dw 0xFFFF
        dw 0x0000
        db 0x00
        db 0x9A
        db 0xCF
        db 0x00
    gdt_data:                           ; Data descriptor chunk
        dw 0xFFFF
        dw 0x0000
        db 0x00
        db 0x92
        db 0xCF
        db 0x00
    gdt_end:                            ; Bottom of table
gdt_descriptor:                         ; Table descriptor
    dw gdt_end - gdt_start - 1          ; Size of table
    dd gdt_start                        ; Start point of table

gdt_codeSeg equ gdt_code - gdt_start    ; Offset of code segment from start
gdt_dataSeg equ gdt_data - gdt_start    ; Offset of data segment from start

    a20wait:
        in   al,0x64 ; input from 0x64 port, goes to al register
        test    al,2 ; compares al register with 2
        jnz     a20wait ; If it is zero loop again
        ret


    a20wait2:
        in      al,0x64 ; input from 0x64 port, goes to al register
        test    al,1 ; compares al register with 2
        jz      a20wait2 ; If it is zero loop again
        ret 

                                                ;-----                              -----;
                                                ;-----      Main Function           -----;
                                                ;-----                              -----;


main_first:  
                CLI ; Clear Interupts Before Manupulating Segments

                ;------------------------------
                ; Bootloader Repsonsibility To 
                ; Setup Registers to point to our 
                ; Segments (Except Code Segment)
                ;
                ;------------------------------

SEGMENTS:               
                ; 0x0000 : 0x7c00 
                xor ax,ax ; 0x0000
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
                MOV sp,0xFFFE ; Start Stackpointer from the top, growing downward


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
                ; Starting sector number 2 because 1 was already loaded.
                MOV cl, 2
                ; Where to load to.
                MOV bx, stage2
                INT 0x13

                JMP stage2

                ; Magic bytes.    
                times ((0x200 - 2) - ($ - $$)) db 0x00
                dw 0xAA55


;--------------------------------------
;       load2.asm
;   Second Stage Bootloader
;   Which then loads the kernel
;   in 32 bit protected mode!
;   
;--------------------------------------
%include "boot2.asm"
