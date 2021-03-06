;----------------------------------------------;
;
; The BoneOS Stage 2 Bootloader
; -----------------------------
;
;
; Contributors : @amanuel2
;
;
;----------------------------------------------;



  stage2:

    MOV si, SECONDSTAGEXECUTION
    CALL printfbln  


    ; enable A20 gate
    enable_A20: ; Enabling A20 Line For Full Memory
            cli ; Stop Interupts before doing so

            call    a20wait ; a20wait call
            mov     al,0xAD ; Send 0xAD Command to al register
            out     0x64,al ; Send command 0xad (disable keyboard).

            call    a20wait ; When controller ready for command
            mov     al,0xD0 ; Send 0xD0 Command to al register
            out     0x64,al ; Send command 0xd0 (read from input)

            call    a20wait2 ; When controller ready for command
            in      al,0x60 ; Read input from keyboard
            push    eax ; Save Input by pushing to stack

            call    a20wait ; When controller ready for command
            mov     al,0xD1 ; mov 0xD1 Command to al register
            out     0x64,al ; Set command 0xd1 (write to output)

            call    a20wait ; When controller ready for command
            pop     eax ; Pop Input from Keyboard
            or      al,2 ; Mov 0xD3 to al register
            out     0x60,al ; Set Command 0xD3

            call    a20wait ; When controller ready for command
            mov     al,0xAE ; Mov Command 0xAE To al register
            out     0x64,al ; Write command 0xae (enable keyboard)

            call    a20wait ; When controller ready for command
            sti ; Enable Interrupts after enabling A20 Line


    ;load a GDT
    ; enter pmode
    loadgdt:
        cli             ; disable int
        LGDT [gdt_descriptor]                   ; Load global descriptor table for protected mode

        mov EAX, CR0                            ; Move CR0 to GP register
        or EAX, 0x1                             ; Set first bit to switch to protected mode
        mov CR0, EAX                            ; Update CR0 from GP register to complete switch



        ;JMP gdt_codeSeg:start32                 ; Jump to start of 32-bit code
        jmp 0x08:stage3 ; go to 32-bit code

		%include "boot3.asm"


    times ((0x400) - ($ - $$)) db 0x00
	
	%include "kernel.asm"