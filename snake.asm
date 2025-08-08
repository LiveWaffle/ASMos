BITS 16
ORG 0x8500

start:
    mov ah, 0x00
    mov al, 0x13
    int 0x10

    mov ax, 0xA000
    mov es, ax
    xor di, di

    mov cx, 64000 ; fill bg w/ blue
    mov al, 1

fill_loop:
    stosb
    loop fill_loop

hang:
    jmp hang

; start:
;     mov ah, 0x00
;     mov al, 0x13
;     int 10h

;     mov ax, 0xA000
;     mov es, ax
;     xor di, di

;     mov al, 0
;     mov cx, 64000
;     rep stosb

;     mov cx, 160 
;     mov dx, 100 
;     call snakeLoop

; snakeLoop:
    
;     call snakeInput
;     jmp snakeLoop

; snakeInput:
;     mov ah, 0x00
;     int 16h

;     cmp al, 0x77              ; w key
;     je wInput
;     cmp al, 0x73              ; s key
;     je sInput
;     cmp al, 0x61             ; a key  
;     je aInput
;     cmp al, 0x64             ; d key
;     je dInput

;     jmp snakeInput

; deletePixel:
;     mov ah, 0x0C
;     mov al, 0
;     mov bh, 0
;     int 10h
;     ret

; wInput:
;     call deletePixel
;     dec dx
;     call drawPixel
;     jmp snakeInput

; sInput:
;     call deletePixel
;     inc dx
;     call drawPixel
;     jmp snakeInput

; aInput:
;     call deletePixel
;     dec cx
;     call drawPixel
;     jmp snakeInput


; dInput:
;     call deletePixel
;     inc cx
;     call drawPixel
;     jmp snakeInput

; randomApple:
   



; drawPixel:
;     mov ah, 0x0C
;     mov al, 3
;     mov bh, 0
;     int 10h
;     ret

; drawApplePixel:
;     mov ah, 0x0C
;     mov al, 4
;     mov bh, 0
;     int 10h
;     ret


seed dw 0