include macrosGenerales.asm      

burbuja macro reg1 reg2 reg3 asc
    local for1,for2,noMenor,c1,op
    push ax
    push bx
    push cx
    push dx    
        mov cx,contador
        dec cx
        for1:
            push cx
            mov cx,contador
            dec cx 
            mov bx,0                  
            for2: 
                mov si,offset reg1
                mov di,offset reg2
                mov bp,offset reg3        
                add si,bx
                add di,bx 
                add bp,bx
                mov al,[si]
                mov ah,[si+1] 
                push ax
                mov al,asc
                cmp al,0
                pop ax
                je c1
                cmp al,ah 
                jb noMenor
                jmp op
                c1: 
                cmp al,ah
                ja noMenor
                op:
                mov dl,[si+1] 
                mov dh,[si]
                mov [si], dl
                mov [si+1],dh
                
                mov dl,[di+1] 
                mov dh,[di]
                mov [di], dl
                mov [di+1],dh
                
                mov dl,[bp+1] 
                mov dh,[bp]
                mov [bp], dl
                mov [bp+1],dh
                 
                noMenor:
                inc bx
            loop for2
            pop cx
        loop for1 
    pop dx
    pop cx
    pop bx
    pop ax
endm    

readStringAndSaveIn macro reg
    local ciclo,fin
    mov bx,0
    mov si,offset reg
    add si,cx
    ciclo:
    readChar 
    cmp al,13
    je fin 
    cmp bl,0
    jne normal
    mov [si],al
    mov firstChar,al  
    mov posIniNom,cl
    inc bx 
    inc cx
    inc si 
    jmp ciclo
    
    normal:
    mov [si],al
    inc cx
    inc si
    jmp ciclo
    fin:        
    inc cx
endm     

setDato macro reg
        mov si,offset reg
        sub al,30h
        mov bl,al
        mov dl,10
        mov ax,[si]
        mul dl
        add al,bl
        mov [si],ax
endm

org 100h
inicio:
    mov cx,0
cicloMenu:
    newLn
    printLn menu
    newLn 
    readInt 31h 37h
    cmp al,'1'
    je registrar
    cmp al,'2'
    je ordenarAZ
    cmp al,'3'
    je ordenarZA 
    cmp al,'4'
    je ordenarAR
    cmp al,'5'
    je ordenarRA
    cmp al,'6' 
    je mostrar
    jmp fin
registrar:
    newLn
    print msj1
    readStringAndSaveIn nombres 
    newLn
    
    print msj2 
    mov numero,0
    getNum:
    readInt 30h 39h
    cmp al,13
    je wardar
    setDato numero
    jmp getNum
    wardar:
    mov si,offset initialChars
    mov di,offset notas
    mov bp,offset posNombres
    add bp,contador
    add si,contador
    add di,contador 
    push ax
        mov al,firstChar
        mov ah,numero
        mov [si],al
        mov [di],ah
        mov al,posIniNom
        mov [bp],al
    pop ax
    inc contador
    newLn
    jmp cicloMenu  
    
ordenarAZ: 
    newLn  
    burbuja initialChars posNombres notas 1
    jmp cicloMenu
ordenarZA: 
    newLn  
    burbuja initialChars posNombres notas 0
    jmp cicloMenu

ordenarAR:
    newLn
    burbuja notas posNombres initialChars 0
    jmp cicloMenu  
    
ordenarRA:
    newLn
    burbuja notas posNombres initialChars 1
    jmp cicloMenu 
    
mostrar:
    newLn 
    mov di,offset posNombres 
    mov si,offset notas
    push cx
        mov cx,contador
        for:
            push ax
                mov ah,0
                mov al,[di] 
                printInPos nombres ax
                print msj10
                displayBaseRegDB [si] 10 
                newLn
                inc di 
                inc si
            pop ax
        loop for
    pop cx    
    jmp cicloMenu

fin:
    int 20h

menu db "1) Registrar estudiante ",10,13
     db "2) Ordenar por nombre A-Z ",10,13
     db "3) Ordenar por nombre Z-A ",10,13
     db "4) Ordenar por nota Aprob-Reprob",10,13 
     db "5) Ordenar por nota Reprob-Aprob",10,13
     db "6) Mostrar estudiantes",10,13
     db "7) Fin$" 
     
msj1 db "Nombre: $"
msj2 db "Nota: $" 
msj10 db "  $"

contador dw 1 dup (0)
nombres db 200 dup ('$')   

posNombres db 30 dup (0) 
posIniNom db dup(0) 

initialChars db 30 dup(0)
firstChar db dup(0)

notas db 30 dup (0)
numero db dup (0) 

        
