GDT_NULLDESC:
	dd 0
	dd 0	
GDT_CODEDESC:
	dw 0xFFFF
	dw 0x0000
	db 0x00		
	db 10011010b
	db 11001111b
	db 0x00			
GDT_DATADESC:
	dw 0xFFFF
	dw 0x0000
	db 0x00
	db 10010010b
	db 11001111b
	db 0x00

GDT_END:

GDT_DESC:
	GDT_SIZE: 
		dw GDT_END - GDT_NULLDESC - 1
		dq GDT_NULLDESC

codeseg equ GDT_CODEDESC - GDT_NULLDESC
dataseg equ GDT_DATADESC - GDT_NULLDESC
[bits 32]

EditGDT:
	mov [GDT_CODEDESC + 6], byte 10101111b
	mov [GDT_DATADESC + 6], byte 10101111b
	ret

[bits 16]