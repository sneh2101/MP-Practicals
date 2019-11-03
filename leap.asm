data segment

    msg db 0dh,0ah,"Enter the year : $"
    msg1 db 0dh,0ah,"Is a leap year : $"
    msg2 db 0dh,0ah,"IS not a leap year $"
    year4 dw 04h
    year100 dw 64h
    year400 dw 190h
    flag4 db 00h
    flag100 db 00h
    flag400 db 00h
    remainder dw 0000h
    flag1 db 01h
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

mov ah,0000h
call asciiconv
mov bx,ax
rol bx,12

mov ah,01h
int 21h
mov ah,0000h
call asciiconv
mov bx,ax
rol bx,8

mov ah,01h
int 21h
mov ah,0000h
call asciiconv
mov bx,ax
rol bx,4

mov ah,01h
int 21h
mov ah,0000h
call asciiconv
add bl,al 




div400:
mov ah,0000h
mov ax,bx
mov cx,year400
div cx

cmp ax,0000h
jz isleap


div100:
mov ah,0000h
mov ax,bx
mov cx,year100
div cx

cmp ax,0000h
jz div4


div4:
mov ah,0000h
mov ax,bx
mov cx,year4
div cx

cmp ax,0000h
jz isleap



isleap proc
mov dx,offset msg1
mov ah,09h
int 21h
ret
endp





mov ah,4ch
int 21h






asciiconv proc
    cmp al,41h
    jc skip
    sub al,07h
    skip: sub al,30h
    ret 
endp




code ends
end start


    
