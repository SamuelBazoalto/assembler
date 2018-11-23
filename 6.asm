include macrosGenerales.asm
readNumero macro reg
    local ciclo,fin
    ciclo:
    mov bx,0
    readInt 30h 39h
    cmp al,13
    je fin
    sub al,30h
    mov bl,al
    mov dl,10
    mov ax,reg
    mul dl
    add ax,bx 
    mov reg,ax
    jmp ciclo
    fin:
endm  

calcularResultado macro
    local fin 
    mov ax,op1
    mov bx,op2
    cmp operacion,1
    je ciclos
    cmp operacion,2
    je ciclor
    cmp operacion,3
    je ciclom 
    ciclod: 
    div bx
    jmp fin
    ciclom:
    mul bx
    jmp fin
    ciclor:
    sub ax,bx
    jmp fin
    ciclos:
    add ax,bx
    fin:
    mov resultado,ax
endm    
    
    
org 100h

inicio:
ciclo:
    newLn
    printLn msj1
    newLn
    readInt 31h 34h
    cmp al,'1'
    je ingNum
    cmp al,'2'
    je ingOp
    cmp al,'3'
    je sisNum
mosRes:    
    newLn 
    newLn
    print msj5 
    calcularResultado
    displayBaseRegDW  resultado sistemaN
    newLn 
    newLn
    printLn msj6
    print msj7
    newLn 
    newLn
    readInt 31h 32h
    
    cmp al,'1'
    je ciclo
    jmp fin
ingNum:
    newLn
    newLn 
    mov op1,0
    mov op2,0
    print msj12    
    readNumero op1
    newLn
    print msj13
    readNumero op2
    newLn
    jmp ciclo
ingOp:
    newLn
    newLn
    printLn msj10
    newLn
    readInt 31h 34h
    sub al,30h
    mov operacion,al
    newLn
    newLn
    jmp ciclo
sisNum:
    newLn
    newLn
    printLn msj11
    newLn
    readInt 31h 34h
    sub al,30h 
    cmp al,1
    je bin
    cmp al,2
    je oc
    cmp al,3
    je deci
    mov sistemaN,16
    jmp ciclo
    deci:
    mov sistemaN,10
    jmp ciclo
    oc:
    mov sistemaN,8
    jmp ciclo
    bin:
    mov sistemaN,2
    jmp ciclo
    newLn 
    
fin:
    int 20h   

msj1 db "1)Ingresar numeros",10,13
     db "2)Ingresar operacion",10,13
     db "3)Elegir sistema de numeracion",10,13
     db "4)Mostrar resultado$"

msj5 db "Resultado: $"
msj6 db "1)Menu Principal$"
msj7 db "2)Fin$"

msj10 db "1)Suma",10,13
      db "2)Resta",10,13
      db "3)Multiplicacion",10,13
      db "4)Division$" 
      
msj11 db "1)Binario",10,13
      db "2)Octal",10,13
      db "3)Decimal",10,13
      db "4)Hexadecimal$"
      
msj12 db "Operando 1: $" 
msj13 db "Operando 2: $"           
          
resultado dw dup (0) 
op1 dw dup (0)
op2 dw dup (0) 
operacion db dup (0) 
sistemaN dw dup (10)
