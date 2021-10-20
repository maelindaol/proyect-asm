;***************************************************************************
; Guardar como ExamenU3.asm
;                       MTI. MA. ELENA PARRA URÍAS
;***************************************************************************
;   NL 3     Martha Elizabeth Inda Olvera       VERANO2020        
; 
;*****************************************************************                                    
; PARA INGRESAR:
; LOGIN: Elizabeth
; PASSWORD: 1234 
; IMPRIME TICKET CON PRINTER.EXE
.model small
.stack
.data 
    p1      db 223
    p2      db 219
    p3      db 220 
    vlg     db 80 dup(176)  
    titulo  db 'C O N S T R U C C I O N E S$' 
    bor     db 9 dup(' ')
    lg      db 'LOGIN$'  
    cadlg   db 10,0,10 dup('$')
    lgcor   db 'Elizabeth'
    passcor db '1234'
    cadpass db 10,0,10 dup('$')
    pass    db 'PASSWORD$'
    lgerr   db 'Usuario incorrecto'
    lgerr2  db 'Contrase',164,'a incorrecta'  
    menu    db 'MENU PRINCIPAL'
    capem   db '1. Ingresar nuevos empleados'
    cappro  db '2. Ingresar nuevos servicios'
    regresa db '3. Regresar a la ventana de login'
    salir   db '4. Salir'  
    op      db 'Opci',162,'n:'
    erromen db 'Error: Ingrese una de las opciones del 1 al 4'
    OPC     db 0  
    msjop   db 'Elige una de las siguientes'
    msjop2  db 'opciones:'
    msjop3  db 4,' Regresar al men',163,' anterior'   
    emple   db 'EMPLEADOS' 
    msjemp1 db 4,' Ingresar un empleado'
    msjemp2 db 4,' Leer datos empleado'
    msjemp3 db 4,' Borrar datos empleado'
    msjemp4 db 4,' Guardar datos del empleado'
    msjrmn  db 4,' Regresar al men',163,' principal'
    nombemp db 'Nombre:'
    edademp db 'Edad:' 
    geneemp db 'G',130,'nero:' 
    genfem  db 3,'Femenino    ',3,'Masculino$' 
    teleemp db 'Tel',130,'fono:'
    cnomemp db 20,0,20 dup(' ') 
    cedaemp db 4,0,4 dup(' ') 
    feme    db 'Femenino ' 
    mascu   db 'Masculino'
    ctelemp db 11,0,11 dup(' ')  
    borr    db 100 dup(' ') 
    col     db 16  
    ren     db 17 
    bandf   db 0
    bandm   db 0
    bandc   db 0
    bandd   db 0
    bandi   db 0
    rutaex  db 'C:\EXAMEN U3',0   
    rutaemp db 'C:\EXAMEN U3\EMPLEADOS.txt',0
    produ   db 'SERVICIOS'
    nomcli  db 'Cliente:'
    totser  db 'Costo:'
    ivaser  db 'IVA:' 
    tiposer db 'Tipo:'
    total   db 'Total:'
    tipser  db 3,' Casa habitaci',162,'n     ',3,' Departamento$'
    cas     db 'Casa habitaci',162,'n'
    dep     db 'Departamento   '   
    clieser db 20,0,20 dup(' ')
    costser db 4,0,4 dup(' ')
    ivaserv db 2,0,2 dup(' ')
    msjpro1 db 4,' Ingresar un servicio'
    msjpro2 db 4,' Leer datos servicio'
    msjpro3 db 4,' Borrar datos servicio'
    msjpro4 db 4,' Guardar datos del servicio'
    msjpro5 db 4,' Imprimir ticket servicio'
    rutapro db 'C:\EXAMEN U3\SERVICIOS.txt',0  
    guardar db 'Se ha guardado el dato!'
    borrar  db 'Se ha borrado el dato!' 
    espacio db 200 dup(' ')
    dato    db 60 dup(' ')
    guion   db 10 dup('_') 
    R       db 0,0,'$'
    mane    dw 0
;***************** ESPACIO MACRO *********************************
    impCol MACRO msj,long,ren,col,pag,modo,color 
        MOV AH,19     ;IMPRESIÓN CON COLOR
        LEA BP,msj    ;CADENA
        MOV CX,long   ;LONGITUD
        MOV DH,ren    ;REN
        MOV DL,col    ;COL
        MOV BH,pag    ;PAG
        MOV AL,modo   ;MODO
        MOV BL,color  ;ATRIBUTO O COLOR
        INT 10H
    impCol ENDM 
    impSC MACRO cad 
        MOV AH,9 
        LEA DX,cad
        INT 21H
    impSC ENDM
    Cursor MACRO ren,col,pag
        MOV AH,2
        MOV DH,ren
        MOV DL,col
        MOV BH,pag
        INT 10H
    Cursor ENDM 
    Marco MACRO ren,col,pag,carac,noc,color
        MOV AH,2
        MOV DH,ren
        MOV DL,col
        MOV BH,pag
        INT 10H
    
        MOV AH,9 
        MOV AL,carac
        MOV CX,noc  ;número de carácteres
        MOV BH,pag  ;PÁG
        MOV BL,color
        INT 10H   
    Marco ENDM 
    ImpCar MACRO car,num,pag 
        MOV AH,10  ;Imprimir caracter -SIN COLOR-
        MOV AL,car ;Caracter a imprimir
        MOV CX,num   ;Número de caracteres
        MOV BH,pag   ;Página
        INT 10H
    ImpCar ENDM  
    LeerCadLogin MACRO cad
        MOV AH,0AH
        LEA DX,cad
        INT 21H
    LeerCadLogin ENDM
    vlog MACRO cor,cad,long
        LEA SI,cor
        LEA DI,cad+2
        MOV CX,long  
    vlog ENDM 
    Pag MACRO pag
        MOV AH,5
        MOV AL,pag ; CAMBIAR A LA PÁGINA
        INT 10H
    Pag ENDM 
    Direc MACRO ruta 
        MOV AH,39H
        LEA DX,ruta
        INT 21H     
    Direc ENDM
    Creararc MACRO ruta
        MOV AH,3CH
        LEA DX,ruta
        INT 21H
    Creararc ENDM 
    Abrir MACRO ruta
        MOV AH,3DH
        LEA DX,ruta
        MOV AL,2 ;ABRIR LECTURA/ESCRITURA
        INT 21H 
    Abrir ENDM
    Cerrar MACRO Manejador
        MOV AH,3EH
        MOV BX,Manejador
        INT 21H
    Cerrar ENDM
    Escribir MACRO manejador,long,dato
        MOV AH,40H
        MOV BX,manejador
        MOV CL,long
        LEA DX,dato
        INT 21H
    Escribir ENDM  
    Leer MACRO manejador,long,dato
        MOV AH,3FH
        MOV BX,manejador
        MOV CL,long
        LEA DX,dato
        INT 21H
    Leer ENDM 
    impCol1 MACRO msj,long,ren,col,pag,modo,color 
        MOV AH,19     ;IMPRESIÓN CON COLOR
        LEA BP,msj    ;CADENA
        MOV CL,long   ;LONGITUD
        MOV DH,ren    ;REN
        MOV DL,col    ;COL
        MOV BH,pag    ;PAG
        MOV AL,modo   ;MODO
        MOV BL,color  ;ATRIBUTO O COLOR
        INT 10H
    impCol1 ENDM
    Print MACRO long,datoprint,cad,imp 
        MOV DI,cad
        MOV SI,long 
            imp:
            MOV AL,datoprint
            MOV DX,130D
            OUT DX,AL 
            CALL DELAY 
            MOV CX,SI
            INC DI  
            DEC SI
            LOOP imp     
    Print ENDM long 
;******************************************************************
.code
    mov ax,@data
    mov ds,ax
    mov es,ax
    MOV SI,0 
    MOV DI,0     
    JMP impri 

leeremps:  
    Abrir rutapro
    MOV mane,AX  
    Leer mane,56,dato   
    impCol dato,19,14,28,3,0,0FH ;CLIENTE
    impCol vlg,13,14,4,3,0,0BH 
    impCol dato[19],3,15,28,3,0,0FH ;COSTO
    impCol vlg,3,15,4,3,0,0BH
    impCol dato[22],1,16,28,3,0,0FH ;IVA
    impCol vlg,3,16,4,3,0,0BH
    impCol dato[23],15,18,28,3,0,0FH ;TIPO
    Cerrar mane  
    CMP bandi,1
    JE imp
    JMP mmls  
    mmls:
boremps:    
    impCol vlg,27,14,48,3,0,0BH 
    impCol vlg,9,15,48,3,0,0BH
    impCol vlg,22,17,47,3,0,0BH  
    impCol vlg,21,18,47,3,0,0BH
    impCol vlg,23,19,47,3,0,0BH
    impCol vlg,28,20,47,3,0,0BH 
    impCol vlg,28,21,47,3,0,0BH  
    Abrir rutapro
    MOV mane,AX
    Escribir mane,100,borr   
    Cerrar mane 
    impCol borrar,22,18,47,3,0,0FH
    CALL DELAY
    JMP minimenus
    minimenus:
impri:    
    MOV bandi,1
    JMP leeremps 
imp:         
    XOR AX,AX   
    XOR BX,BX     
    ;ASIGNAMOS LOS DATOS A SUMAR
        MOV AL,dato[21]
        MOV BL,dato[22] 
        ADD AL,BL;REALIZA LA SUMA 
        AAA;AJUSTE ASCII PARA LA SUMA 
        ADD AX,3030H;AJUSTE ASCII
          
    ;ASIGNAMOS EL RESULTADO 
        MOV R[0],AH
        MOV R[1],AL 

     ;SERVICIOS
     Print 13,espacio[DI],0,imp0
     Print 9,produ[DI],0,imp1
     Print 37,espacio[DI],0,imp2
     
     ;CLIENTE
     Print 8,nomcli[DI],0,imp3
     Print 3,espacio[DI],0,imp4
     Print 19,dato[DI],0,imp5
     Print 25,espacio[DI],0,imp6
     
     ;TIPO
     Print 5,tiposer[DI],0,imp7
     Print 7,espacio[DI],0,imp8
     Print 15,dato[DI],23,imp9
     Print 97,espacio[DI],0,imp10
     
     ;COSTO
     Print 6,totser[DI],0,imp11
     Print 5,espacio[DI],0,imp12
     Print 3,dato[DI],19,imp13
     Print 47,espacio[DI],0,imp14 
     
     ;IVA
     Print 4,ivaser[DI],0,imp15        
     Print 12,espacio[DI],0,imp16
     Print 1,dato[DI],22,imp17
     Print 60,espacio[DI],0,imp18
     Print 6,guion[DI],0,imp19   
     Print 49,espacio[DI],0,imp20
     ;TOTAL
     Print 6,total[DI],0,imp21
     Print 7,espacio[DI],0,imp22
     Print 1,dato[DI],19,imp23
       
     MOV AH,R[0]
     MOV AL,dato[20]
     ADD AL,AH
     AAA 
     ADD AX,3030H
     MOV dato[20],AL   
        
     Print 1,dato[DI],20,imp24
     Print 1,R[DI],1,imp25
     JMP mmls
fin:    
    mov ax,4c00h
    int 21h      
;****************** ESPACIO PROCEDIMIENTO **************************************
    Leerdig PROC
        MOV AH,1 ;RECUPERAR EL CARÁCTER 
        INT 21H
        MOV OPC,AL
      RET
    ENDP
    espera PROC
        MOV AH,0
        INT 16H
      RET
    ENDP 
    re PROC
        REPE CMPSB
      RET
    ENDP 
    DELAY PROC  ;PAUSA
      MOV CX,1AH
      cicloD: loop cicloD
      RET
    ENDP 
    BAND PROC
        MOV bandf,0
        MOV bandm,0
        MOV ren,17
        MOV bandc,0
        MOV bandd,0
        MOV bandi,0
      RET
    ENDP  
;*******************************************************************************
end