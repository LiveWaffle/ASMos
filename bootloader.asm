BITS 16 ; set 16bit
ORG 0x7C00 ;

start:
    mov [BOOT_DRIVE], dl
    mov ax, 0x0000
    mov es, ax
    mov ds, ax
    mov bx, 0x8000

    mov ah, 0x02
    mov al, 1
    mov ch, 0x00
    mov cl, 0x02
    mov dh, 0x00
    mov dl, [BOOT_DRIVE] 

    int 0x13

    jmp 0x0000:0x8000

BOOT_DRIVE: db 0

times 510 - ($ - $$) db 0
dw 0xAA55