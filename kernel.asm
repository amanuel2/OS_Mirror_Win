;ORG 0x9000
BITS 32

;extern kernel_main_c

k_main:
	mov byte [0xB8000], 88
	mov byte [0xB8000+1], 0x1B
		
;		call kernel_main_c

	mov byte [0xB8000+4], 89
	mov byte [0xB8000+5], 0x1B
	cli
	hlt