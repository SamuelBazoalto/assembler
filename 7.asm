include macrosGenerales.asm
readString macro
    local fin,ciclo
    ciclo:
    readChar
    cmp al,13
    je fin 
    jmp ciclo
    fin:
endm

readStringEco macro
    local ciclo,fin,isNum,isMay
    ciclo:
    readCharEco
    cmp al,13
    je fin 
    printChar 42
    cmp al,'0'
    jb ciclo
    cmp al,'9'
    jbe isNum
    cmp al,'A'
    jb ciclo
    cmp al,'Z'
    jbe isMay
    jmp ciclo
    isNum:
    mov passNum,1
    jmp ciclo
    isMay:
    mov passMay,1
    jmp ciclo
    fin:    
endm

readStringNum macro 
    local ciclo,fin
    ciclo:
    readInt 30h 39h
    cmp al,13
    je fin
    jmp ciclo
    fin:
endm    

readStringAndSaveIn macro reg
    local ciclo,fin
    mov si,offset reg
    ciclo:
    readChar
    cmp al,13
    je fin
    mov [si],al
    inc si  
    inc cx
    jmp ciclo
    fin:
endm        

cmpString macro n reg niv reg1
    push cx 
    local ciclo,noIgual,fin
    mov cx,n 
    cmp cl,niv
    jbe noIgual
    sub cx,niv
    mov si,offset reg 
    mov di,offset reg1
    add si,cx
    mov cx,niv
    ciclo: 
    mov al,[si]
    mov ah,[di]
    cmp al,ah
    jne noIgual
    inc si
    inc di
    loop ciclo
    mov al,1 
    jmp fin
    noIgual:
    mov al,0
    fin: 
    pop cx
endm    
    
org 100h
inicio:
    print msj1
     
    print msj2
    readString
    newLn
    
    print msj3
    readString
    newLn
    
    print msj4
    readStringNum
    newLn
    
    print msj5
    readString
    newLn
    
correo:    
    print msj6  
    mov cx,0
    readStringAndSaveIn email
    cmpString cx email 10 gmail
    cmp al,1
    je contra
    cmpString cx email 12 hmail
    cmp al,1
    je contra
    newLn
    printLn msj7
    jmp correo 
contra:
    newLn
    print msj8
    readStringEco   
    cmp passNum,1
    jne nuevo
    cmp passMay,1
    je fin 
    nuevo:
    newLn
    print msj9
    jmp contra 
    
    
fin:
    newLn
    print msj10
    int 20h        
    
msj1 db "Registro de Facebook",10,13,10,13,"$"
msj2 db "Nombre: $"
msj3 db "Apellido: $"
msj4 db "C.I: $"
msj5 db "Ciudad: $"

msj6 db "Email: $" 
msj7 db "Email incorrecto, intente nuevamente...$" 
email db 50 dup (0) 
gmail db "@gmail.com"
hmail db "@hotmail.com" 

msj8 db "Password: $" 
msj9 db "Password incorrecto, deve incluir almenos un numero y un caracter mayuscala$"
passNum db dup(0)
passMay db dup(0) 

msj10 db "Registro Correcto$"

   