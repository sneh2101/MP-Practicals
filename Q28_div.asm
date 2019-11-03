data segment

    msg db 0dh,0ah,"Enter the first no. : $"
    msg1 db 0dh,0ah,"Enter the second no. : $"
    msg2 db 0dh,0ah,"The quotient is : $"
    msg3 db 0dh,0ah,"The remainder is : $"
    count db ?
    result db ?
    temp db ?
data ends


code segment
assume cs:code, ds:data

start:
mov ax,data
mov ds,ax

mov dx,offset msg
mov ah,09h
int 21h

mov ah,01h
int 21h

call asciiconv

mov bl,al
rol bl,4

mov ah,01h
int 21h

call asciiconv

add bl,al 

mov temp,bl

mov dx,offset msg1
mov ah,09h
int 21h

mov ah,01h
int 21h

call asciiconv

mov cl,al
rol cl,4

mov ah,01h
int 21h

call asciiconv

add cl,al 

mov count,00h


division:
cmp bl,cl
jc remainder
sub bl,cl
inc count
jmp division



remainder:
mov dx,offset msg3
mov ah,09h
int 21h

mov cl,bl
and bl,0f0h
ror bl,4

call asciiconv1

mov dl,bl
mov ah,02h
int 21h

mov bl,cl
and bl,0fh

call asciiconv1

mov dl,bl
mov ah,02h
int 21h




mov dx,offset msg2
mov ah,09h
int 21h

mov bl,count
mov cl,bl
and bl,0f0h
ror bl,4

call asciiconv1

mov dl,bl
mov ah,02h
int 21h

mov bl,cl
and bl,0fh

call asciiconv1

mov dl,bl
mov ah,02h
int 21h




mov ah,4ch
int 21h






asciiconv proc
    cmp al,41h
    jc skip
    sub al,07h
    skip: sub al,30h
    ret 
endp

asciiconv1 proc
    cmp bl,0Ah
    jc skip1
    add bl,07h
    skip1: add bl,30h
    ret 
endp


code ends
end start


    
