[bits 16]
PrintStringLN:
  mov ah, 0x0E
  .Loop:
  cmp [bx], byte 0
  je .Exit
    mov al, [bx]
    int 0x10
    inc bx
    jmp .Loop
  .Exit:
  
  mov al, 0x0D
  int 0x10
  mov al, 0x0A
  int 0x10
  
  ret
PrintString:
  mov ah, 0x0E
  .Loop:
  cmp [bx], byte 0
  je .Exit
    mov al, [bx]
    int 0x10
    inc bx
    jmp .Loop
  .Exit:
  
  ret
