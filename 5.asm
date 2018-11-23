include macrosGenerales.asm
 
read3Int macro 
push dx        
    local fin
    readInt 30h 39h
    cmp al,13
    je fin
    setDato num
    
    readInt 30h 39h
    cmp al,13
    je fin
    setDato num
     
    readInt 30h 39h
    cmp al,13
    je fin
    setDato num
     
    fin:
pop dx
endm

setDato macro fecha
push dx
push bx
        sub al,30h
        mov bl,al
        mov dl,10
        mov ax,fecha
        mul dl
        add al,bl
        mov fecha,ax
pop bx        
pop dx        
endm


verificarDatoPar macro reg
    push bx
    push dx
        mov dx,0
        mov ax,reg
        mov bx,2
        div bx
        mov al,dl
    pop dx
    pop bx    
    
endm

insertarDato macro reg n
    push cx
    push dx
    mov si,offset reg
    mov ax,[si]
    mov cl,n
    mov ch,0
    add si,cx
    mov [si],bl
    pop dx
    pop cx
    
endm 

insertarDato2 macro reg n
    push cx
    mov si,offset reg
    mov ax,[si]
    mov cl,n
    mov ch,0
    add si,cx
    add si,cx
    mov [si],bx
    pop cx
    
endm

selecionarPrimos macro reg1 reg2 n
    push ax
    push bx
    push cx
    push dx
        local ciclo1,ajustar,salto,ciclo,final,verificar,esDiv,noPrimo,primo
        mov cl,n
        mov si,offset reg1
        mov di,offset reg2
        ajustar:
        cmp [di],0
        je salto
        inc di
        jmp ajustar
        salto:
        ciclo1:
        mov dx,0
        mov ch,[si]
            ciclo:
            cmp cl,0
            je final
            cmp ch,0
            je verificar
            cmp dh,2
            ja  noPrimo
            mov ax,[si]
            mov ah,0
            div ch
            cmp ah,0
            je esDiv
            dec ch 
            jmp ciclo
            esDiv:
            dec ch
            inc dh
            jmp ciclo 
            noPrimo:
            inc si
            dec cl
            jmp ciclo1
            verificar:
            cmp dh,2
            jne noPrimo
            primo:
            mov ax,[si]
            mov [di],al
            inc di
            inc si
            dec cl
            jmp ciclo1
            
        final:
    pop dx
    pop cx
    pop bx
    pop ax      
endm 

selecionarPrimos2 macro reg1 reg2 n
    push ax
    push bx
    push cx
    push dx
        local ciclo,final,verificar,esDiv,noPrimo,primo
        
        mov cl,n
        mov si,offset reg1
        mov di,offset reg2 
        ajustar:
        cmp [di],0
        je salto
        inc di
        jmp ajustar
        salto:
        ciclo1:
        mov ch,0
        mov dx,0
        mov bx,[si]
            ciclo:
            cmp cl,0
            je final
            cmp bx,0
            je verificar
            cmp ch,2
            ja  noPrimo
            mov ax,[si]
            div bx
            cmp dx,0
            je esDiv
            dec bx
            mov dx,0 
            jmp ciclo
            esDiv:
            dec bx
            inc ch
            jmp ciclo 
            noPrimo:
            inc si
            dec cl
            jmp ciclo1
            verificar:
            cmp ch,2
            jne noPrimo
            primo:
            mov ax,[si]
            mov [di],ax
            inc di
            inc di
            inc si
            inc si
            dec cl
            jmp ciclo1
            
        final:
    pop dx
    pop cx
    pop bx
    pop ax      
endm
            
    

org 100h
inicio:
    print msjInicial
    mov cx,0
    mov dx,0
ciclo:
    newLn
    read3Int 
    mov bx,num
    cmp bx,0
    je displayLista
    verificarDatoPar bx
    cmp al,0
    jne impar
    cmp bh,0
    jne par16
    insertarDato pares8 cl
    inc cl
    jmp nuevoCiclo
    par16:
    insertardato2 pares16 dl
    inc dl
    jmp nuevoCiclo  
impar: 
    cmp bh,0
    jne impar16   
    insertarDato impares8 ch
    inc ch
    jmp nuevoCiclo
    impar16:
    insertardato2 impares16 dh
    inc dh
nuevoCiclo:
    mov num,0
    jmp ciclo
displayLista:
    newLn
    print msjPrimos
    selecionarPrimos pares8 primos8 cl
    selecionarPrimos impares8 primos8 ch
    selecionarPrimos2 impares16 primos16 dh
    printRegDB primos8
    printRegDW primos16
    
    
    newLn
    print msjPares
    printRegDB pares8
    printRegDW pares16
    
    newLn 
    print msjImpares
    printRegDB impares8
    printRegDW impares16
fin:
    int 20h    

primos8 db 100 dup(0)
primos16 dw 100 dup(0) 

pares8 db 100 dup (0)
pares16 dw 100 dup (0) 

impares8 db 100 dup (0)
impares16 dw 100 dup (0) 

num dw dup(0)

msjInicial db "Ingrese numeros de 1 a 3 cifras,preione 0 para finalizar$"
msjPrimos db "Primos: $"
msjPares db "Pares: $"
msjImpares db "Impares: $"