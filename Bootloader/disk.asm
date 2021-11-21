PROGRAM_SPACE equ 0x7E00

ReadDisk:
  mov ah, 0x02
  mov bx, PROGRAM_SPACE
  mov al, 32
  mov dl, [BOOT_DISK]
  mov ch, 0x00
  mov dh, 0x00
  mov cl, 0x02
  
  int 0x13
  jc DISK_READ_ERROR
  
  call DISK_READ_SUCCESS
  
  ret

BOOT_DISK: db 0

STRING_ERROR:   db 'Disk read failed!', 0
STRING_SUCCESS: db 'Disk read successfully!', 0

DISK_READ_ERROR:
  mov bx, STRING_ERROR
  call PrintStringLN
  jmp $
  
DISK_READ_SUCCESS:
  mov bx, STRING_SUCCESS
  call PrintStringLN
  ret