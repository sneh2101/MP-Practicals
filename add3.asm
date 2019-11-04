data segment 
    first dd 12345678h
    second dd 12345678h
    res dd ?
    msg db 0dh,0ah,"The addition is : $"
data ends

code segment
    assume cs:code , ds:data
    start:
    mov ax,data
    mov ds,ax
    
    mov dx,offset msg
    mov ah,09h
    int 21h
    
    mov ah,0000
    mov al,0000
    
    mov bx,word ptr first
    add bx,word ptr second
    mov word ptr res,bx
    call output
    
    
    mov cx,word ptr first+2
    adc cx,word ptr second+2
    mov word ptr res+2,cx
    mov bx,cx
    call output
    
    
output proc
   and bx,0f000h
    ror bl,12
    call asciiconv1

    and bx,0f00h
    ror bl,8
    call asciiconv1

    and bx,00f0h
    ror bl,4
    call asciiconv1

    and bx,000fh
    call asciiconv1    
    ret
endp
    
asciiconv1 proc
    cmp bl,0Ah
    jc skip1
    add bl,07h
    skip1: add bl,30h
    mov dl,bl
    mov ah,02h
    int 21h
    ret 
endp    
    
    
code ends
end start
    