;please make sure to add line 31 i.e. mov ch,00h as cx is the counter for the loop and the loop will become an infinite loop if ch has a garbage value





data segment

    msg db 0dh,0ah,"Enter the length of the array : $"
    msg1 db 0dh,0ah,"Enter a number : $"
    msg2 db 0dh,0ah,"The minimum number is : $"
    len db ?
    min db ?
data ends

code segment
assume cs:code, ds:data

start:
mov ax,data
mov ds,ax

mov dx,offset msg
mov ah,09h
int 21h

call input

mov len,bl
mov cl,len
mov ch,00h

mov si,1000h

intake:
    mov dx,offset msg1
    mov ah,09h
    int 21h
    
    call input
    mov [si],bl
    inc si
    loop intake
    
mov si,1000h
mov cl,len
mov ch,00h
mov min,bl

minsearch:
    mov bx,[si]
    cmp min,bl
    jc increment
    mov min,bl
    
    increment:
    inc si
    
    loop minsearch


mov dx,offset msg2
mov ah,09h
int 21h
mov bl,min
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


input proc
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

code ends
end start


    
