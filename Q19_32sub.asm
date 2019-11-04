data segment 
    first dd 12345678h
    second dd 11111111h
    res dd ?
    msg db 0dh,0ah,"The subtraction is : $"
data ends

code segment
    assume cs:code , ds:data
    start:
    mov ax,data
    mov ds,ax
    
    mov dx,offset msg
    mov ah,09h
    int 21h
    
      
    mov bx,word ptr first+2
    sbb bx,word ptr second+2
    mov word ptr res+2,bx
    
    call output2
    
    mov bx,word ptr first
    sub bx,word ptr second
    mov word ptr res,bx
    
    call output
  
    
    
    
    
    
output proc
    mov bh,byte ptr res+1
    and bh,0f0h
    ror bh,4
    call asciiconv2

    mov bh,byte ptr res+1
    and bh,0fh
    call asciiconv2    
    
    
    mov bl,byte ptr res
    and bl,0f0h
    ror bl,4
    call asciiconv1

    mov bl,byte ptr res
    and bl,0fh
    call asciiconv1    
    ret
endp
    
output2 proc
    mov bh,byte ptr res+3
    and bh,0f0h
    ror bh,4
    call asciiconv2

    mov bh,byte ptr res+3
    and bh,0fh
    call asciiconv2    
    
    
    mov bl,byte ptr res+2
    and bl,0f0h
    ror bl,4
    call asciiconv1

    mov bl,byte ptr res+2
    and bl,0fh
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

asciiconv2 proc
    cmp bh,0Ah
    jc skip2
    add bh,07h
    skip2: add bh,30h
    mov dl,bh
    mov ah,02h
    int 21h
    ret 
endp    

    
    
code ends
end start
    