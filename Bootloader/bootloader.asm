[org 0x7C00]

mov [BOOT_DISK], dl

mov bp, 0x7C00
mov sp, bp

mov bx, BOOT_STRING
call PrintStringLN

mov bx, READ_KERNEL_STRING
call PrintStringLN
call ReadDisk

mov bx, LOADING_KERNEL_STRING
call PrintStringLN
jmp PROGRAM_SPACE

BOOT_STRING:           db 'Booting ElectroOS...',             0
READ_KERNEL_STRING:    db 'Reading KernelLoader...',          0
LOADING_KERNEL_STRING: db 'Loading KernelLoader...',          0

%include "Bootloader/print.asm"
%include "Bootloader/disk.asm"

times 510-($-$$) db 0
dw 0xAA55