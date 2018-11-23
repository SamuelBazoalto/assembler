;macros
;salto de linea
newLn macro
    push ax
    push dx
        mov ah,2
        mov dl,10
        int 21h
        mov dl,13
        int 21h
    pop dx
    pop ax
endm

printInPos macro cadena  pos
    push ax
    push dx
    push bx
        mov bx,pos
        mov ah,9
        mov dx,offset cadena
        add dx,bx
        int 21h
    pop bx
    pop dx
    pop ax
endm

print macro cadena
    push ax
    push dx
        mov ah,9
        mov dx,offset cadena
        int 21h
    pop dx
    pop ax
endm

println macro cadena
    print cadena
    newLn
endm




printChar macro n
    push ax
    push dx
        mov ah,2
        mov dl,n
        int 21h
    pop dx
    pop ax
endm



printInt macro n
    push ax
    push dx
    local incrementar ,mnFin
    mov dl,n
    cmp dl,9
    ja incrementar
    add dl,30h
    jmp mnFin
    incrementar:
    add dl,37h
    mnFin:
    printChar dl
    pop dx
    pop ax
endm


displayBaseRegDB macro d b
    push ax
    push bx
    push cx
    push dx
    local c1,mostrarDB,mostrarPN
        mov ah,0
        mov al,d
        mov bx,b
        mov cx,0
        c1:
            cmp ax,b
            jb mostrarDB
            mov dx,0
            div bx
            push dx
            inc cx
            jmp c1
        mostrarDB:
            push ax
            inc cx
        mostrarPN:
            pop dx
            printInt dl
            loop mostrarPN
    pop dx
    pop cx
    pop bx
    pop ax
endm

displayBaseRegDW macro d b
    push ax
    push bx
    push cx
    push dx
    local c1,mostrarDB,mostrarPN
        mov ax,d
        mov bx,b
        mov cx,0
        c1:
            cmp ax,b
            jb mostrarDB
            mov dx,0
            div bx
            push dx
            inc cx
            jmp c1
        mostrarDB:
            push ax
            inc cx
        mostrarPN:
            pop dx
            printInt dl
            loop mostrarPN
    pop dx
    pop cx
    pop bx
    pop ax
endm



;imprime todos los elementos del registro reg
printRegDB macro reg
    local ciclo,fin

    mov si,offset reg
    ciclo:
    mov ax,[si]
    cmp ax,0
    je fin
    displayBaseRegDB al 10
    printChar 45
    inc si
    jmp ciclo
    fin:
endm

printRegDW macro reg
    local ciclo,fin

    mov si,offset reg
    ciclo:
    mov ax,[si]
    cmp ax,0
    je fin
    displayBaseRegDW ax 10
    printChar 45
    inc si
    inc si
    jmp ciclo
    fin:
endm
;lee u numero entre los rangos li ls

readInt macro  li,ls
        local ciclo,fin
        ciclo:
        mov ah,7
        int 21h
        cmp al,13
        je fin
        cmp al,li
        jb ciclo
        cmp al,ls
        ja ciclo
        printChar al
        fin:

endm


readChar macro
        mov ah,1
        int 21h
endm

readCharEco macro
        mov ah,7
        int 21h
endm
