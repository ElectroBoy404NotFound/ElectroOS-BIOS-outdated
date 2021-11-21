[bits 32]

DetectCPUID:
	pushfd 
	pop eax

	mov ecx, eax

	xor eax, 1 << 21

	push eax
	popfd

	pushfd 
	pop eax

	push ecx 
	popfd

	xor eax,ecx
	jz NoCPUID
	ret

DetectLongMode:
	mov eax, 0x80000001
	cpuid
	test edx, 1 << 29
	jz NoLongMode
	ret

NoLongMode:
  mov [0xb8000], byte 'N'
	mov [0xb8002], byte 'L'
	mov [0xb8004], byte 'M'
	mov [0xb8006], byte 'S'
  
	hlt
NoCPUID:
  mov [0xb8000], byte 'N'
	mov [0xb8002], byte 'C'
	mov [0xb8004], byte 'I'
	mov [0xb8006], byte 'S'
  
	hlt