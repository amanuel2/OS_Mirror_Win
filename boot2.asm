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

    cli
    hlt
	
    times ((0x400) - ($ - $$)) db 0x00