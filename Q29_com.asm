data segment
    msg db 0dh,0ah,"Enter the number : $"
    msg1 db 0dh,0ah,"2's Complement is : $"
    result db ?
data ends

code segment
    assume cs:code,ds:data
    start:
    mov ax,data
    mov ds,ax
    
    mov dx,offset msg
    mov ah,09h
    int 21h
   
    call inputproc
    
  
    mov al,bl
    neg al
    mov cl,al
    mov result,al
    
    mov dx,offset msg1
    mov ah,09h
    int 21h
    call output
    
    
    
    mov ah,4ch
    int 21h
    
    
output proc
    mov cl,result
    and cl,0f0h
    ror cl,4
    call asciiconv1
    mov dl,cl
    mov ah,02h
    int 21h
    
    mov cl,result
    and cl,0fh
    call asciiconv1
    mov dl,cl
    mov ah,02h
    int 21h
    ret
endp
    
inputproc proc
    mov ah,01h
    int 21h

    call asciiconv

    mov bl,al
    rol bl,4
   
   mov ah,01h
    int 21h

    call asciiconv

    mov bl,al 
    ret
endp



asciiconv proc
    cmp al,41h
    jc skip
    sub al,07h
    skip: sub al,30h
    ret 
endp

asciiconv1 proc
    cmp cl,0Ah
    jc skip1
    add cl,07h
    skip1: add cl,30h
    ret 
endp


code ends
end start


