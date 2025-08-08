ORG 0x8000

init:
    mov ax, 0x0000
    mov ds, ax
    mov es, ax

    mov ah, 0x00
    mov al, 0x03
    int 10h   

    mov si, 0
    mov di, 0

kernelStart:
    mov ah, 0x0E
    mov al, [welcomeMessage + si]
    int 10h

    inc si
    cmp byte [welcomeMessage + si], 0
    jne kernelStart

    call newLine
    mov ah, 0x0E
    mov al, 0x3E
    int 10h

    jmp readInput

newLine:
    mov ah, 0x0E
    mov al, 0x0D
    int 10h
    mov al, 0x0A
    int 10h
    ret

callNewLine:
    call newLine
    mov ah, 0x0E
    mov al, 0x3E
    int 10h
    jmp readInput

deleteLastInput:
    cmp di, 0
    je readInput
    dec di
    mov byte [buffer + di], 0
    mov ah, 0x0E
    mov al, 0x08
    int 10h
    mov al, 0x20
    int 10h
    mov al, 0x08
    int 10h
    jmp readInput

readInput:
    mov ah, 0x00
    int 16h

    cmp al, 0x0D ; enter key 
    je analyzeInput

    cmp al, 0x08 ; backspace key
    je deleteLastInput

    cmp di, 19
    je readInput

    mov [buffer + di], al ; read from buffer
    inc di
    mov ah, 0x0E
    int 10h
    jmp readInput

;command responses
analyzeInput:
    mov byte [buffer + di], 0
    MOV CL, 5
    mov BP, 0
    mov DI, kernelCommands

    L1:
        mov SI, buffer

        L2:
            mov al, [SI]
            mov bl, [DI]
            cmp al, bl
            jne NotEqual
            
            cmp al, 0
            je CheckIfBothEnd
            
            inc SI
            inc DI
            jmp L2

CheckIfBothEnd:
    cmp bl, 0
    je equal
    jmp NotEqual

equal:
    call newLine
    jmp printCommand

NotEqual:
    mov al, [DI]
    cmp al, 0
    je nextCommand
    inc DI
    jmp NotEqual

nextCommand:
    inc DI
    inc BP
    DEC CL
    JNZ L1
    jmp callNewLine

printCommand:
    push si
    mov si, 0
    mov cx, 20
clearBuffer:
    mov byte [buffer + si], 0
    inc si
    loop clearBuffer
    mov di, 0
    mov si, versionResponse
    cmp bp, 0
    je printLoop
    mov si, helpResponse
    cmp bp, 1
    je printLoop
    mov si, launchResponse
    cmp bp, 2
    je printLoop
    mov si, uptimeResponse
    cmp bp, 3
    je printLoop
    cmp bp, 4
    je launchSnake
    jmp donePrinting
    ; for commands just add th e cmp bp, then number of command starting from 0 so 0,1,2,3 etc then je to your function :p
    
printLoop:
    mov ah, 0x0E
    mov al, [si]
    cmp al, 0
    je donePrinting
    int 10h
    inc si
    jmp printLoop

donePrinting:
    pop si
    call newLine
    mov ah, 0x0E        
    mov al, 0x3E
    int 10h
    jmp readInput

welcomeMessage:
    db "Welcome To HackOS", 0

responses:
    versionResponse db "HackOS Version 1.0", 0
    helpResponse db "Available commands: ver, help, launch, uptime", 0
    launchResponse db "Launch command executed", 0
    uptimeResponse db "System uptime: 00:00:01", 0

; command section
kernelCommands:
    db "ver", 0
    db "help", 0
    db "launch", 0
    db "uptime", 0
    db "snake", 0

launchSnake:
    mov [BOOT_DRIVE], dl
    mov ax, 0x0000
    mov es, ax
    mov ds, ax
    mov bx, 0x8500 ; change to snake bin

    mov ah, 0x02
    mov al, 1
    mov ch, 0x00
    mov cl, 0x03 ; load sector 3 
    mov dh, 0x00
    mov dl, [BOOT_DRIVE] 

    int 0x13

    jmp 0x0000:0x8500

BOOT_DRIVE: db 0
buffer:
    times 20 db 0
TIMES 512 - ($ - $$) db 0