include macrosGenerales.asm 
calcularProm macro 
    local ciclo
        mov si,offset listaNum
        mov ax,0
        mov dx,0
        mov bx,0
        mov cx,contOnlyNum 
        ciclo: 
        add al,[si] 
        inc si
        loop ciclo
        mov bx,contOnlyNum
        div bx
        mov promedio,al      
endm

getFecha macro
    mov si,offset listaNum
    add si,contOnlyNum
    local fin 
    mov ah,1
    cicloDia:
        int 21h
        cmp al,'/'
        je cicloMes 
        sub al,30h
        mov [si],al 
        inc si
        inc contador 
        inc contOnlyNum
        jmp cicloDia        
    cicloMes:
        mov ah,1
        int 21h
        cmp al,'/'
        je cicloAnio
        sub al,30h 
        mov [si],al 
        inc si
        inc contador
        inc contOnlyNum
        jmp cicloMes          
    cicloAnio:
        mov ah,1
        int 21h
        cmp al,13
        je fin 
        sub al,30h
        mov [si],al
        inc si
        inc contador
        inc contOnlyNum   
        jmp cicloAnio
    fin:
    inc contador
    inc contador    
endm                
        
getNumero macro
    local ciclo,fin
    mov si,offset listaNum
    add si,contOnlyNum
    ciclo:
    readInt 30h 39h 
    cmp al,13
    je fin
    sub al,30h
    mov [si],al
    inc si
    inc contador
    inc contOnlyNum
    jmp ciclo
    fin:
endm    
    
readString macro
    local ciclo,fin
    ciclo:
    readCharEco
    cmp al,13 
    je fin
    cmp al,'0'
    jb char
    cmp al,'9'
    ja char
    jmp ciclo
    char:
    printChar al
    inc contador
    jmp ciclo
    fin:
endm    
     
org 100h
inicio:
    printLn msj1      
    
    print msj2
    getNumero
    newLn
    
    print msj3
    getNumero
    newLn 
    
    print msj4 
    getNumero
    newLn
    
    print msj5
    readString
    newLn
    
    print msj6
    getNumero
    newLn
    
    print msj7
    getFecha
    newLn 
    
    print msj8 
    calcularProm
    displayBaseRegDB promedio 10
    printChar contador
    newLn

fin:
    int 20h
msj1 db "Generar Factura$"
msj2 db "Nit: $"
msj3 db "Numero Factura: $"
msj4 db "Numero Autorizacion: $"
msj5 db "Cliente: $"
msj6 db "Monto: $"
msj7 db "Fecha: $"

msj8 db "Codigo de Control: $" 

contador db dup (0)
contOnlyNum dw dup (0)
listaNum db 100 dup(0)
promedio db dup (0)  