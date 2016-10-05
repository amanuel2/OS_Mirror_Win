; ----------------------------------------------------------------------------
; helloworld.asm
;
; This is a Win32 console program that writes "Hello, World" on one line and
; then exits.  It needs to be linked with a C library.
; ----------------------------------------------------------------------------

    global  _main
    extern  _printf
	extern _scanf 

    section .text
_main:
    push    message
    call    _printf
    add     esp, 4
	
	push return ; address of integer1 (second parameter)
	push formatin ; arguments are right to left (first parameter)
	call _scanf
	add esp,8
	
	
	ret
message:
    db  'What do you want to calculate today? :-) (Add,Sub,Mul,Div)', 10, 0
add_message : db "What numbers you want to add? :-)" , 10, 0	
formatin: db "%s", 0
return: db "", 0

ADD_CMP db "Add" , 0