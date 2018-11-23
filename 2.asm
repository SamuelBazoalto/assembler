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

org 100h
inicio:
    printLn fechaMuestra        
cicloDia:
    mov ah,1
    int 21h
    cmp al,'/'
    je pasoMes    
    setDato dia
    jmp cicloDia
pasoMes:    
cicloMes:
    mov ah,1
    int 21h
    cmp al,'/'
    je pasoAnio    
    setDato mes
    jmp cicloMes
pasoAnio:       
cicloAnio:
    mov ah,1
    int 21h
    cmp al,13
    je display    
    setDato anio
    jmp cicloAnio    
        
display:
    newLn                             
    displayBaseRegDW dia 2
    printChar 47
    displayBaseRegDW mes 2
    printChar 47
    displayBaseRegDW anio 2
    newLn
    displayBaseRegDW dia 16 
    printChar 47
    displayBaseRegDW mes 16
    printChar 47
    displayBaseRegDW anio 16 
fin:
    int 20h  
    
    
dia dw dup (0)
mes dw dup (0)
anio dw dup (0)
fechaMuestra db "Ejemplo: 21/02/1999$"
