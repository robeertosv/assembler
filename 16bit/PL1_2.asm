; PL1 y 2 EOC

.model small
.stack 100h

.data
    ;Operands
    op1 DB 00h  ; 00h = 0 & FFh = 255
    op2 DB 00h     
    
    resultado DW 0000h   
    
    ; UI
    prompt1 DB "Please, input first number (0 - 255)", 13, 10, '$'
    prompt2 DB "Please, input the second number (0 - 255)", 13, 10, '$'
    blank DB 13, 10, '$'   
    
    hex DB '0x0000', '$'
    bin DB 16 DUP('0'), '$'
    
    guion DB ' - ', '$'
    
    choose DB "Choose operation", 13, 10, '$'
    optn1 DB "1 - Add both numbers", 13, 10, '$'
    optn2 DB "2 - Substraction: first - second" ,13, 10, '$'
    optn3 DB "3 - Substraction: second - first" ,13, 10, '$'
    optn4 DB "4 - Multiplication" ,13, 10, '$'
    optn5 DB "5 - Division" ,13, 10, '$'
    optn6 DB "6 - Change sign first number" ,13, 10, '$'
    optn7 DB "7 - Change sign second number" ,13, 10, '$'
    
.code

inicio:
    mov ax, @data
    mov ds, ax
    
    ; Mostrar prompt pedir primer num
    mov ah, 9
    lea dx, prompt1
    int 21h
    
    ; Salto de linea
    mov ah, 9
    lea dx, blank
    int 21h       
    
    ; Leer el primer numero
    read_number:
    
    xor bx, bx ; Almacenar el numero definitivo
    xor dx, dx ; Numero temporal - dh posible centena, dl posible decena
    mov ah, 1 ; Leer teclado    
    mov cl, 10
    
   
        int 21h
        cmp al, 13
        je guardar_op1
        
        sub al, '0'     
        
        mov bl, al      
        
        int 21h
        cmp al, 13
        je guardar_op1 
        
        sub al, '0'
        mov bh, al      
        mov al, bl      
        mul cl          
        add bh, al
        mov bl, bh ; Copia en bl por si acaso se llama al jmp
        
        mov ah, 1
        int 21h
        cmp al, 13
        je guardar_op1
        
        sub al, '0'      
        mov bl, al       
        mov al, bh       
        mul cl           
        add bl, al       
        
    guardar_op1:    
        mov op1, bl    
        
    ; Hacer espacio para el segundo prompt
    mov ah, 9
    lea dx, blank
    int 21h
    
    mov ah, 9
    lea dx, prompt2
    int 21h
    
    mov ah, 9
    lea dx, blank
    int 21h   

    read_number2:
    
    xor bx, bx ; Almacenar el numero definitivo
    xor dx, dx ; Numero temporal - dh posible centena, dl posible decena
    mov ah, 1 ; Leer teclado    
    mov cl, 10
    
   
        int 21h
        cmp al, 13
        je guardar_op2
        
        sub al, '0'     
        
        mov bl, al      
        
        int 21h
        cmp al, 13
        je guardar_op2 
        
        sub al, '0'
        mov bh, al      
        mov al, bl      
        mul cl          
        add bh, al
        mov bl, bh ; Copia en bl por si acaso se llama al jmp
        
        mov ah, 1
        int 21h
        cmp al, 13
        je guardar_op2
        
        sub al, '0'      
        mov bl, al       
        mov al, bh       
        mul cl           
        add bl, al       
        
    guardar_op2:    
        mov op2, bl    
    
    ; Pedir instruccion
    
    mov ah, 9
    lea dx, blank
    int 21h
    
    mov ah, 9
    lea dx, choose
    int 21h
                 
    mov ah, 9
    lea dx, blank
    int 21h
                 
    mov ah, 9
    lea dx, optn1
    int 21h      
    
    mov ah, 9
    lea dx, blank
    int 21h
                 
    mov ah, 9
    lea dx, optn2
    int 21h
    
    mov ah, 9
    lea dx, blank
    int 21h
                 
    mov ah, 9
    lea dx, optn3
    int 21h
    
    mov ah, 9
    lea dx, blank
    int 21h
                 
    mov ah, 9
    lea dx, optn4
    int 21h
    
    mov ah, 9
    lea dx, blank
    int 21h
                 
    mov ah, 9
    lea dx, optn5
    int 21h
    
    mov ah, 9
    lea dx, blank
    int 21h
                 
    mov ah, 9
    lea dx, optn6
    int 21h
    
    mov ah, 9
    lea dx, blank
    int 21h
                 
    mov ah, 9
    lea dx, optn7
    int 21h
    
    mov ah, 9
    lea dx, blank
    int 21h
           
    ; Leer la instruccion
    
    mov ah, 1
    int 21h
    
    sub al, '0'
    
    cmp al, 1
    je suma
    
    cmp al, 2
    je resta1
    
    cmp al, 3
    je resta2
    
    cmp al, 4
    je multiplication
    
    cmp al, 5
    je division
    
    cmp al, 6
    je neg1
    
    cmp al, 7
    je neg2
    
    suma:
        xor ax, ax
        mov al, op1
        add al, op2
        mov resultado, ax
        jmp fin
        
    resta1:
        xor ax, ax    
        mov al, op1
        sub al, op2
        mov resultado, ax
        jmp fin
    
    resta2:  
        xor ax, ax
        mov al, op2
        sub al, op1
        mov resultado, ax 
        jmp fin
        
    multiplication:
        xor ax, ax
        mov cl, op1
        mov al, op2
        mul cl
        mov resultado, ax
        jmp fin
        
    division:
        xor ax, ax
        mov cl, op2     ; Cuanto quiero dividirle
        mov al, op1     ; Al que quiero dividir
        div cl     
        mov ah, 00h     ; Quitar el resto
        mov resultado, ax
        jmp fin
        
    neg1:
        xor ax, ax       
        mov al, op1
        neg ax
        mov resultado, ax
        jmp fin
    
    neg2:        
        xor ax, ax
        mov al, op2
        neg ax
        mov resultado, ax
        jmp fin
        
    fin:
    
        ; El resultado de la operacion esta en la variable resultado
        
        ; Printeo del resultado
        
        mov ah, 9
        lea dx, blank
        int 21h
        
        ; Convertir el resultado a un hex
        
        mov ax, resultado
        mov di, offset hex + 2 ; El +2 es para que empiece detras del 0x
        mov cx, 4
    
    convert_hex:        
        rol ax, 4       ; Ir rotanto AX de 4 en 4 para tener el LSB
        mov bx, ax
        and bx, 000Fh   ; Obtener LSB
        
        cmp bx, 10                   ; Si es menor de 10 sumar '0'
        jl es_digito_hex
        
        add bx, 'A' - 10             ; Si no, 'A' - 10
        jmp guardar_num_hex
        
        es_digito_hex:
            add bx, '0'
        
        guardar_num_hex:             ; Ir guardando en el string
        mov [di], bl
        inc di
        
        loop convert_hex
        
    mov ax, resultado
    mov di, offset bin  + 15
    mov cx, 16    
    convert_bin:
        test ax, 1                   ; Mirar si LSB es 1
        jnz es_uno                   ; Si lo es, poner un '1'
        mov bl, '0'                  ; Si no, poner un '0'
        jmp guardar_bin
        
        es_uno:
            mov bl, '1'
        
        guardar_bin:
            mov [di], bl
            dec di
            shr ax,1    
        
        loop convert_bin   
    
    ; Printeo solucion
    
    mov ah, 9
    lea dx, blank
    int 21h
    
    mov ah, 9
    lea dx, hex
    int 21h
    
    mov ah, 9
    lea dx, guion
    int 21h
    
    mov ah, 9
    lea dx, bin
    int 21h
    
    
    ; FIN               
    mov ah, 4Ch
    int 21h
end inicio        
