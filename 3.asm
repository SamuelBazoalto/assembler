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
    je cicloMes    
    setDato dia
    jmp cicloDia    
cicloMes:
    mov ah,1
    int 21h
    cmp al,'/'
    je cicloAnio    
    setDato mes
    jmp cicloMes      
cicloAnio:
    mov ah,1
    int 21h
    cmp al,13
    je pasoCP    
    setDato anio
    jmp cicloAnio

pasoCP:
    newLn
    printLn menu
     
checkPoint:
    readInt 31h,32h
    setDato cPoint
    newLn
display:
    cmp cPoint,2
    je displayNum
    displayBaseRegDW dia 2
    printChar 47    
    mov ax,mes
    dec ax
    mov di,offset posMes
    add di,ax
    mov bx,0 
    mov bl,[di]        
    printInPos meses bx
    printChar 47
    displayBaseRegDW anio 2
    jmp fin

displayNum:
    displayBaseRegDW dia 2
    printChar 47
    displayBaseRegDW mes 2 
    printChar 47 
    displayBaseRegDW anio 2
           
fin:
    int 20h      
    
dia dw  dup (0)
mes dw  dup(0)
anio dw  dup (0)  
cPoint dw dup(0) 

fechaMuestra db "Ejemplo: 21/2/1999$"
menu db "Como quiere ver el mes?",10,13
     db "1) Literal",10,13
     db "2) Numeral$"  
     
meses db "enero$febrero$marzo$abril$mayo$junio$julio$agosto$septiembre$octubre$noviembre$diciembre$"
posMes db 0d,6,14,20,26,31,37,43,50,61,69,79        
