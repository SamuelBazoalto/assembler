include macrosGenerales.asm 
 
almacenarInfo macro cadena1 cadena2
    local caso1,caso2,fin
    mov si,offset cadena1
    mov di,offset cadena2
    add si,cx
    add di,bx
    cmp al,'0'
    jb caso2
    cmp al,'9'
    jbe caso1
    cmp al,'A'
    jb caso2
    cmp al,'Z'
    jbe caso1
    caso2:
        mov [di],al
        inc bx
        jmp fin
    caso1:
        mov [si],al
        inc cx
    fin:
endm 

print2String macro cadena1 cadena2
    push dx
    push ax  
    local caso1,caso2,fin,prepCaso1  
        mov ah,2
        mov si,offset cadena1
        mov di,offset cadena2
        cmp cx,bx
        jb prepCaso1
        caso2:
            printChar [si]
            printChar 9
            printChar [di]
            newLn
            inc si
            inc di
            loop caso2
        jmp fin
        prepCaso1:
        xchg cx,bx
        caso1:
            printChar [si]
            printChar 9
            printChar [di]
            newLn
            inc si
            inc di
            loop caso1
        fin:
    pop ax
    pop dx    
endm                             


org 100h
inicio:
    mov ah,1
    mov cx,0
    mov bx,0
ingresarCaracter:
    int 21h  
    cmp al,13
    je pasoImprimir
    almacenarInfo cadMayNum cadMinusCarEsp
    jmp ingresarCaracter
pasoImprimir:
    newLn
    print2String cadMayNum cadMinusCarEsp
fin:
    int 20h
                  
cadMayNum db 100 dup (?)
cadMinusCarEsp db 100 dup (?)
   