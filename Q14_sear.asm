;please make sure to add line 31 i.e. mov ch,00h as cx is the counter for the loop and the loop will become an infinite loop if ch has a garbage value





data segment

    msg db 0dh,0ah,"Enter the length of the array : $"
    msg3 db 0dh,0ah,"Enter the number to be searched : $"
    msg1 db 0dh,0ah,"Enter a number : $"
    msg2 db 0dh,0ah,"The number has been found at location : $"
    msg4 db 0dh,0ah,"The number was not found :"
    len db ?
    s db ?
    count dw ?
    flag db ?
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

mov si,1000h
mov cl,len
mov ch,00h
intake:
    mov dx,offset msg1
    mov ah,09h
    int 21h
    
    call input
    mov [si],bl
    inc si
    loop intake
 
mov dx,offset msg3
mov ah,09h
int 21h

call input

mov s,bl   
    



mov flag,00h
mov count,00h
mov si,1000h
mov cl,len
mov ch,00h


searching:
    mov bx,[si]
    cmp s,bl
    jnz increment
    mov s,bl
    mov count,si
   
    increment:
    inc si
    
    loop searching
    

mov dx,offset msg2
mov ah,09h
int 21h
mov bx,count
mov bh,0000h
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


    
