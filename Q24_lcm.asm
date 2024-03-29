data segment

    msg db 0dh,0ah,"Enter the first no. : $"
    msg1 db 0dh,0ah,"Enter the second no. : $"
    msg2 db 0dh,0ah,"The GCD is :$"
    msg3 db 0dh,0ah,"The LCM is :$"
    gcd db ?
    lcm db ?
    tempb db ?
    tempc db ?
    temp2 dw ?
    
data ends

code segment
assume cs:code, ds:data

start:
mov ax,data
mov ds,ax

mov dx,offset msg
mov ah,09h
int 21h

call inputproc
mov tempb,bl


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

mov tempc,cl  




mov dx,offset msg2
mov ah,09h
int 21h

back:
cmp cl,bl
jc sec

first:
sub cl,bl
jmp check

sec:
sub bl,cl

check:
cmp cl,bl
jnz back
mov gcd,cl




and cl,0f0h
ror cl,4

call asciiconv1

mov dl,cl
mov ah,02h
int 21h

mov cl,gcd
and cl,0fh

call asciiconv1

mov dl,cl
mov ah,02h
int 21h

mov dx,offset msg3
mov ah,09h
int 21h
mov ah,0000h

mov cl,tempc
mov al,tempb
mul cl

mov bl,al
mov cl,bl
and bl,0f0h
ror bl,4
call asciiconv2


mov bl,cl
and bl,0fh
call asciiconv2



mov temp2,ax
mov ah,0000h
div cl

mov lcm,al
mov bl,al
mov cl,bl
and bl,0f0h
ror bl,4
call asciiconv2


mov bl,lcm
and bl,0fh
call asciiconv2


mov ah,4ch
int 21h

inputproc proc
    mov ah,01h
    int 21h

    call asciiconv

    mov bl,al
    rol bl,4

    mov ah,01h
    int 21h

    call asciiconv

    add bl,al 
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

asciiconv2 proc
    cmp bl,0Ah
    jc skip2
    add bl,07h
    skip2: add bl,30h
    mov dl,bl
    mov ah,02h
    int 21h
    ret 
endp


code ends
end start


    
