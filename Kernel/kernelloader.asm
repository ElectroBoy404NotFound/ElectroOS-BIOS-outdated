[org 0x7E00]

mov bx, KERNEL_LOADER_LOADED_STRING
call PrintStringLN

mov bx, ENTER_64BIT_MODE_STRING
call PrintStringLN

in al, 0x92
or al, 2
out 0x92, al

cli
lgdt [GDT_DESC]
mov eax, cr0
or eax, 1
mov cr0, eax

jmp codeseg:START_32bit_MODE

[bits 32]
START_32bit_MODE:
  mov ax, dataseg
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
  
  call DetectCPUID
  call DetectLongMode
  call SetUpIdentityPaging
  call EditGDT
  
  jmp codeseg:START_64bit_MODE
  
[bits 64]
START_64bit_MODE:
  mov edi, 0xb8000
	mov rax, 0x1f201f201f201f20
  mov ecx, 500
  rep stosq
  
  mov dx, 0x3D4
  mov al, 0x0F
  out dx, al
  mov dx, 0x3D5
  mov al, 0
  out dx, al
  
  mov dx, 0x3D4
  mov al, 0x0E
  out dx, al
  mov dx, 0x3D5
  mov al, 0
  out dx, al
  
  jmp $

LOADED_KERNEL: db 'Kernel Load Success!', 0
KERNEL_LOADER_LOADED_STRING: db 'Successfully loaded KernelLoader!',     0
ENTER_64BIT_MODE_STRING:     db 'Loading into 64 bit mode...', 0

[bits 16]
%include "Kernel/print.asm"
[bits 32]
%include "Kernel/GDT.asm"
%include "Kernel/CPUID.asm"
%include "Kernel/SimplePaging.asm"
[bits 64]
%include "Kernel/64BitPrint.asm"

times 2048-($-$$) db 0