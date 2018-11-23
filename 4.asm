
include macrosGenerales.asm
setDato macro fecha
        sub al,30h
        mov bl,al
        mov dl,10
        mov ax,fecha
        mul dl
        add al,bl
        mov fecha,ax
endm

setDatoInPos macro fecha pos
    push cx
    push bx    
        mov si,offset fecha
        mov bx,pos
        add si,bx
        mov cx,[si]
        inc cx
        mov [si],cx
    pop bx
    pop cx    
endm  

read2Int macro
    local fin
    readInt 30h 39h
    cmp al,13
    je fin
    setDato num
    readInt 30h 39h
    cmp al,13
    je fin
    setDato num
    fin:
endm    
    
calcularProm macro cadena resultados 
    push cx 
    local ciclo
        mov si,offset cadena
        mov di,offset resultados
        mov ax,0
        mov dx,0
        mov cx,100
        mov bx,0
        ciclo:
        cmp [si],0
        je Zero 
        mov ax,[si]
        mul bl
        add [di],ax          
        Zero:
        inc bx
        inc si 
        loop ciclo
        pop cx
        push cx
        mov ax,[di]
        div cl
        mov [di],al
        mov [di+1],ah
    pop cx    
endm

calcularModa macro cadena resultado
    local nada
    push cx
    mov ax,0
    mov bx,0
    mov dx,0
    local ciclo
    mov cx,100
    mov si,offset cadena
    mov di,offset resultado
    ciclo: 
        mov dx,[si]
        cmp ah,dl
        ja nada
        mov ah,dl
        mov al,bl
        nada:
        inc si
        inc bx
        loop ciclo
    mov [di],al
    mov ax,0
    pop cx    
endm

calcularMediana macro numeros mediana
    local ciclo,nada,final
    mov dx,0
    mov ax,cx
    mov cl,2
    div cl
    mov ah,0
    inc al
    mov cx,100  
    mov si,offset numeros
    mov di,offset mediana
    ciclo:
    mov bx,[si]
    cmp bl,0
    je nada
    cmp al,0h
    jbe nada
    cmp al,200
    ja nada
    mov ah,dl
    sub al,bl
    nada:
    inc si
    inc dl
    loop ciclo
    mov [di],ah
endm            
        
org 100h       
inicio:
    print formato
    mov si,offset numeros
    mov cx,0    
ciclo:
    newLn
    read2Int
    cmp num,0
    je calcProm
    setDatoInPos numeros num
    inc cx
    mov num,0
    jmp ciclo

calcProm:
    newLn
    print msjPromedio
    calcularProm numeros promedio
    mov si,offset promedio
    mov al,[si]
    displayBaseRegDB al 10
    printChar 44
    mov al,[si+1]
    displayBaseRegDB al 10 
    
calcModa:    
    newLn
    print msjModa
    calcularModa numeros moda
    mov si,offset moda
    mov al,[si]
    displayBaseRegDB al 10
    

calcMediana:
    newLn
    print msjMediana
    calcularMediana numeros mediana 
    mov si,offset mediana
    mov al,[si]
    displayBaseRegDB al 10
fin:
    int 20h
    
formato db "Ingresar datos apartir del 1, pulse 0 para terminar$"        
numeros db 100 dup (?)  
  
msjPromedio db "--Promedio: $" 
promedio db 2 dup (0)

msjModa db "--Moda: $"
moda db dup (0)

msjMediana db "--Mediana: $" 
mediana db dup (0) 

num dw dup (0)
        
