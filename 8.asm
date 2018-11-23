include macrosGenerales.asm
org 100h
inicio:
    print msj1
    readChar
    mov charDet,al
    mov charMenor,al
    mov charMayor,al
    newLn
    printLn msj2
    ciclo: 
    readChar 
    cmp al,13
    je mostrarRes 
    mov bx,0
    mov bl,al
    mov si,offset charList 
    mov di,offset charList
    add si,bx
    inc [si] 
    mov bx,0
    mov bl,charMenor
    add di,bx
    mov bl,[si]
    mov bh,[di]
    cmp bl,bh
    jb cambiarMenor
    
    mov di,offset charList
    mov bx,0
    mov bl,charMayor
    add di,bx
    mov bl,[si]
    mov bh,[di]
    cmp bl,bh
    ja cambiarMayor
    jmp ciclo
    
    cambiarMayor:
    mov charMayor,al
    jmp ciclo
    
    cambiarMenor: 
    mov charMenor,al
    jmp ciclo
   
mostrarRes:
    newLn
    print msj3
    printChar charDet
    print msj4  
    mov si,offset charList
    mov ax,0
    mov al,charDet
    add si,ax
    mov al,[si]
    displayBaseRegDB al 10
     
    newLn
    print msj5
    printChar charMenor
    print msj6  
    mov si,offset charList
    mov ax,0
    mov al,charMenor
    add si,ax
    mov al,[si]
    displayBaseRegDB al 10 
    
    newLn
    print msj7
    printChar charMayor
    print msj6  
    mov si,offset charList
    mov ax,0
    mov al,charMayor
    add si,ax
    mov al,[si]
    displayBaseRegDB al 10
fin:
    int 20h
charDet db dup (0)
charMenor db dup (0)
charMayor db dup (0)

charList db 255 dup (0) 

msj1 db "Determine un caracter: $" 
msj2 db "Ingrese caracteres, presione enter para finalizar$"       
msj3 db "El caracter: $"
msj4 db " se repitio $"
msj5 db "El caracter menos repetido: $"
msj6 db " $" 
msj7 db "El caracter mas repetido: $"