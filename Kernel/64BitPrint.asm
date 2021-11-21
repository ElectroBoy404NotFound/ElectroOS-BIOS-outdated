[bits 64]

VGA_MEMORY equ 0xB8000
VGA_WIDTH  equ 80

PrintString64bit:
  mov ah, 0x0E
  .Loop:
  cmp [bx], byte 0
  je .Exit
    ; bx = pointer to the current char
    inc bx
    jmp .Loop
  .Exit: