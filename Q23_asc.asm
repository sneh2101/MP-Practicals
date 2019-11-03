                data segment
    
    msg1 db 10,13,"Asc Order $"
    msg2 db 10,13,"Enter Elments : $"
    msg3 db,10,13,"Sorted Array is : $"
    

data ends

code segment
assume cs:code,ds:data
start:

mov ax,data
mov ds,ax


mov dx,offset msg1
call displaymsg
call entprc

call ascprc
mov ah,4ch
int 21h



entprc proc
    mov si,1000h
    mov ch,00h
    mov cl,0Ah
    
    enterelements:
    mov dx,offset msg2
    call displaymsg
    
    mov ah,01
    int 21h
    call ipconvert
    rol al,1
    rol al,1
    rol al,1
    rol al,1
    mov bl,al
    mov ah,01
    int 21h
    call ipconvert
    add bl,al
    
    mov [si],bl
    inc si
    loop enterelements
    
    ret
endp

ascprc proc
mov bl,0Ah
    dec bl
    mov dh,00h
    
        loop1:
            mov si,1000h
            mov ch,00h
            mov cl,0Ah
            dec cl
            
            loop2:
            
                mov ah,[si]
                inc si
                mov al,[si]
                
                cmp ah,al
                jc lab0
                
                xchg ah,al
                dec si
                mov [si],ah
                inc si
                mov [si],al
               
                
            lab0:
                loop loop2
                
        inc dh
        cmp dh,bl
        jc loop1
    
    
    mov si,1000h
    mov ch,00h
    mov cl,0Ah  
    print:
    mov dx,offset msg3
    call displaymsg
    
    mov bx,[si]
    and bl,0f0h
    ror bl,1
    ror bl,1
    ror bl,1
    ror bl,1

    call opconvert
    mov bx,[si]
    and bl,0fh
    call opconvert
    inc si
    loop print
    ret
endp

    

displaymsg proc
    mov ah,09
    int 21h
    ret
endp

ipconvert proc
    cmp al,41h
    jc lab1
    sub al,07h
    lab1:
    sub al,30h
    ret
endp

opconvert proc
    cmp bl,0Ah
    jc lab2
    add bl,07h
    lab2:
    add bl,30h
    mov dl,bl
    mov ah,02
    int 21h
    ret
endp


code ends
end start
