.model small
.stack 100
.data
    fileA db "login.bin",0
    fileb db "menu33.bin",0
    fileC db "cross.bin",0
    fileD db "heart3.bin",0
    fileE db "heart2.bin",0
    fileF db "heart1.bin",0
    fileG db "duck.bin",0
    arr db 200*320 dup (0)
    file dw 2 DUP(0)
    tempPosY dw 0
    tempPosX dw 0
    pos_x dw 0
    pos_y dw 0
    temp_c dw 0
    temp_r dw 0
    color db 0
    rows dw 0
    cols dw 0
    temp dw 0
    temp1 db 0
    bullets dw 0
    counter db 0
    score dw 0
    top_score dw 600
    hearts dw 0

    temp_x dw 158
    temp_y dw 97

    duck_x dw 0
    duck_y dw 150
    temp_duck_x dw 0
    temp_duck_y dw 0
    duck dw 0
    duck2 dw 0
    moves dw 0
    duck_hit2 dw 0
    aim_change dw 0


    duck2_x dw 0
    duck2_y dw 150
    temp_duck2_x dw 0
    temp_duck2_y dw 0
    duck3 dw 0
    duck4 dw 0
    moves2 dw 0
    duck2_hit dw 0

    life dw 0




    msgEnter db "Enter your name: $"
    str1 db '1. Game A 1 Duck$',0
    str2 db '2. Game B 2 Ducks$',0
    str3 db "3. Instructions $"
    str4 db "5. Exit $"

    str6 db "Name: $"
    str7 db "Highest Score:$"
    str8 db "4. Back $"

    str11 db "INSTRUCTIONS $"
    str12 db "> Use Arrow Keys To Move The Crosshair $"
    str13 db "> Hit Space Bar To Fire $"
    str14 db "> Earn Points By Hitting Ducks $"
    str15 db "> Miss Too Many Ducks And The Game Ends $"
    str28 db "> Use All Bullets and The Game Ends $"
    str16 db "> Game A Has One Duck At A Time $"
    str17 db "> Game B Has Two Ducks At A Time $"
    str18 db "1. Back $"
    str19 db "2. Exit $"
    str20 db "> Game Closed < $"

    str21 db "Bullets: $"
    str22 db "Score:$"
    str23 db " $"

    str24 db "> Game Over < $"
    str25 db " Score $"
    str26 db "1. Play Again $"
    str27 db "2. Main Menu $"

    str29 db "> GAME PAUSED < $"
    str30 db " Current Score:$"
    str31 db " Bullets Left:$"
    str32 db " Lives Left:$" 
    str33 db "1. Resume Game $"
    str34 db "2. Main Menu $"

    buffer db 50 DUP(0) 


    frequencies dw 1200,1200,1300,1300,1200,1200,1300,1300,1200,1200,1300,1300,1450,1450,1450
            dw 1450,1450,1450,1200,1200,1100,1100,1000,1000,0900,0900,0900,0900,0900,0900
            dw 1200,1200,0800,0800,0900,0900,1000,1000,1000,1000,1000,1000,1200,1200,0900
            dw 0900,1000,1000,1100,1100,1100,1100,1100,1100,1100,1100,1100,1100,1100,1100
    freq dw 0
    temp2 db 0

.code


SOUND proc

    mov     al, 182         
    out     43h, al        
    mov     ax, freq    
    out     42h, al        
    mov     al, ah         
    out     42h, al 
    in      al, 61h         
    or      al, 00000011b   
    out     61h, al         
    mov     bx, 25         
    pause1:
    mov     cx, 6550
    pause2:
    dec     cx
    jne     pause2
    dec     bx
    jne     pause1
    in      al, 61h         
    and     al, 11111100b   
    out     61h, al       
    RET
SOUND endp

PlaySOUND PROC
    mov temp2,36
    mov si,offset frequencies
    SOUNDER:
    mov ax,[si]
    mov freq,ax
    call SOUND
	add si,2
	dec temp2
    cmp temp2,0
    jne SOUNDER

	RET
PlaySOUND endp

OPEN_FILE proc
    mov ah, 3Dh       
    mov al, 0            
    int 21h 
    mov bx, ax 
    ret
OPEN_FILE endp

READ_FILE proc
    mov ah, 3Fh           
    int 21h   
    ret
READ_FILE endp

CLOSE_FILE proc
    mov ah, 3Eh         
    int 21h  
    ret
CLOSE_FILE endp

LOAD_IMAGE PROC
    mov  dx, file
    call OPEN_FILE    
    mov dx, file+2
    call READ_FILE
    call CLOSE_FILE
    ret
LOAD_IMAGE endp

LOAD_IMAGES proc
    mov file,offset fileA
    mov file+2,offset arr
    mov cx, 43*196 
    call LOAD_IMAGE
    ret
LOAD_IMAGES endp

LOAD_IMAGES2 proc
    mov file,offset fileB
    mov file+2,offset arr
    mov cx, 177 * 320
    call LOAD_IMAGE
    ret
LOAD_IMAGES2 endp

LOAD_IMAGES3 proc
    mov file,offset fileC
    mov file+2,offset arr
    mov cx, 11 * 17
    call LOAD_IMAGE
    ret
LOAD_IMAGES3 endp

LOAD_IMAGES4 proc
    mov file,offset fileD
    mov file+2,offset arr
    mov cx, 12 * 66
    call LOAD_IMAGE
    ret
LOAD_IMAGES4 endp

LOAD_IMAGES5 proc
    mov file,offset fileE
    mov file+2,offset arr
    mov cx, 12 * 66
    call LOAD_IMAGE
    
    ret
LOAD_IMAGES5 endp

LOAD_IMAGES6 proc
    mov file,offset fileF
    mov file+2,offset arr
    mov cx, 12 * 66
    call LOAD_IMAGE
    
    ret
LOAD_IMAGES6 endp

LOAD_IMAGES7 proc
    mov file,offset fileG
    mov file+2,offset arr
    mov cx, 15 * 30
    call LOAD_IMAGE
    ret
LOAD_IMAGES7 endp

RESTORE_POSITION proc
    mov ax,pos_x
    mov tempPosX,ax
    mov ax,pos_y
    mov tempPosY,ax
    mov ax,cols
    mov temp_c,ax
    mov ax,rows
    mov temp_r,ax
    ret
RESTORE_POSITION endp

MOVE_RIGHT_PIXEL PROC 
    mov al,color
    mov ah,0ch
    int 10h
    inc cx
    ret
MOVE_RIGHT_PIXEL ENDP

PRINT_IMAGE proc
    mov dx,tempPosY
    OUTER_LOOP:
    mov cx,tempPosX
    mov ax,temp_c
    mov temp,ax
    INNER_LOOP:
    mov al,[si]
    sub al,30h
    mov color,al
    call MOVE_RIGHT_PIXEL         
    inc si         
    dec temp
    cmp temp,0        
    jne INNER_LOOP 
    dec temp_r         
    mov cx,pos_x     
    inc dx  
    cmp temp_r,0        
    jne OUTER_LOOP   
    ret
PRINT_IMAGE endp

GRAPHIC_MODE proc      
    mov ah, 0
    mov al, 13h  
    int 10h  
    ret
GRAPHIC_MODE endp

ReadString proc
    readChar:
        mov ah, 00h      ; Function to read a key press
        int 16h          ; Keyboard interrupt
        cmp al, 13       ; Check if Enter key was pressed
        je finish        ; If Enter, finish input
        mov [si], al     ; Store the character in the buffer
        inc si           ; Increment the buffer pointer

        ; Echo the character
        mov dl, al
        mov ah, 02h
        int 21h
        jmp readChar     ; Read the next character
    finish:
        mov byte ptr [si], '$'  ; Terminate the string with '$'
        ret
ReadString endp

FIRST_PAGE proc
    call LOAD_IMAGES
    call GRAPHIC_MODE
    mov rows, 43
    mov cols, 196

    ; Center the image horizontally
    mov ax, 320      ; Screen width
    sub ax, 196      ; Image width
    shr ax, 1        ; Divide by 2
    mov pos_x, ax

    ; Center the image vertically
    mov ax, 200      ; Screen height
    sub ax, 43       ; Image height
    shr ax, 1        ; Divide by 2
    mov pos_y, ax

    mov si, offset arr
    call RESTORE_POSITION
    call PRINT_IMAGE


    mov dh, 20
    mov dl, 6
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset msgEnter
    mov ah, 09h
    int 21h

    
    lea si, buffer        
    call ReadString

    ret
FIRST_PAGE endp

SECOND_PAGE proc
    call LOAD_IMAGES
    call GRAPHIC_MODE
    mov rows, 43 
    mov cols, 196

    ; Center the image horizontally
    mov ax, 320      ; Screen width
    sub ax, 140      ; Image width
    shr ax, 1        ; Divide by 2
    shr ax, 1
    add ax, 20
    mov pos_x, ax

    ; Center the image vertically
    mov ax, 200      ; Screen height
    sub ax, 38       ; Image height
    shr ax, 1        ; Divide by 2
    shr ax, 1
    shr ax, 1
    sub ax, 5
    mov pos_y, ax

    mov si, offset arr
    call RESTORE_POSITION
    call PRINT_IMAGE

    mov dh, 9
    mov dl, 6
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str1
    mov ah, 09h
    int 21h

    mov dh, 11
    mov dl, 6
    mov bh, 0
    mov ah, 02h
    int 10h
    
    mov dx, offset str2
    mov ah, 09h
    int 21h

    mov dh, 13
    mov dl, 6
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str3
    mov ah, 09h
    int 21h

    mov dh, 15
    mov dl, 6
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str8
    mov ah, 09h
    int 21h

    mov dh, 17
    mov dl, 6
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str4
    mov ah, 09h
    int 21h

    mov dh, 21
    mov dl, 6
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str6
    mov ah, 09h
    int 21h

    mov dx, offset buffer
    mov ah, 09h
    int 21h

    mov dh, 23
    mov dl, 6
    mov bh, 0
    mov ah, 02h
    int 10h
    
    mov dx, offset str7
    mov ah, 09h
    int 21h

    mov ax, top_score
    call Display_Digits


    ret           
SECOND_PAGE endp

THIRD_PAGE proc
    call GRAPHIC_MODE

    mov dh, 3
    mov dl, 13
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str11
    mov ah, 09h
    int 21h

    mov dh, 6
    mov dl, 1
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str16
    mov ah, 09h
    int 21h

    mov dh, 8
    mov dl, 1
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str17
    mov ah, 09h
    int 21h

    mov dh, 10
    mov dl, 1
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str12
    mov ah, 09h
    int 21h

    mov dh, 12
    mov dl, 1
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str13
    mov ah, 09h
    int 21h

    mov dh, 14
    mov dl, 1
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str14
    mov ah, 09h
    int 21h

    mov dh, 16
    mov dl, 1
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str28
    mov ah, 09h
    int 21h

    mov dh, 18
    mov dl, 1
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str15
    mov ah, 09h
    int 21h

    mov dh, 22
    mov dl, 8
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str18
    mov ah, 09h
    int 21h

    mov dh, 22
    mov dl, 23
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str19
    mov ah, 09h
    int 21h

    ret
THIRD_PAGE endp

Game_Screen proc
    call LOAD_IMAGES2

    mov rows, 177
    mov cols, 320

    mov ax, 0
    mov pos_x, ax

    
    mov ax, 0
    mov pos_y, ax

    mov si,offset arr
    call RESTORE_POSITION
    call PRINT_IMAGE

    ret
Game_Screen endp

Aim_Display proc
    call LOAD_IMAGES3

    mov rows, 11
    mov cols, 17

    mov ax, 0
    mov ax, temp_x
    mov pos_x, ax

    mov ax, 0
    mov ax, temp_y
    mov pos_y, ax



    mov si,offset arr
    call RESTORE_POSITION
    call PRINT_IMAGE

    ret
Aim_Display endp

Lives proc

    .IF hearts == 9 || hearts == 8 || hearts == 7 
        je hearts3
    .ELSEIF hearts == 6 || hearts == 5 || hearts == 4
        je hearts2
    .ELSEIF hearts == 3 || hearts == 2 || hearts == 1
        je heart1
    .ENDIF

    L1: 
        ; Center the image horizontally
        mov ax, 320      ; Screen width
        sub ax, 78      ; Image width
        ;shr ax, 1        ; Divide by 2
        mov pos_x, ax

        ; Center the image vertically
        mov ax, 200      ; Screen height
        sub ax, 18    ; Image height
        mov pos_y, ax


        mov si, offset arr
        call RESTORE_POSITION
        call PRINT_IMAGE
        jmp exit

    hearts3:

        call LOAD_IMAGES4
        mov rows, 12
        mov cols, 66
        jmp L1

    hearts2:
        call LOAD_IMAGES5
        mov rows, 12
        mov cols, 66
        jmp L1


    heart1:
        call LOAD_IMAGES6
        mov rows, 12
        mov cols, 66
        jmp L1

    exit:
        ret
Lives endp

ScoreCard proc

    .IF life == 0
        call Lives
    .ELSEIF life == 1
        call Lives2
    .ENDIF

    mov dh, 23
    mov dl, 1
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str21
    mov ah, 09h
    int 21h

    mov dh, 23
    mov dl, 9
    mov bh, 0
    mov ah, 02h
    int 10h

    mov ax, bullets
    call Display_Digits

    mov dx, offset str23
    mov ah, 09h
    int 21h

    mov dh, 23
    mov dl, 16
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str22
    mov ah, 09h
    int 21h


    mov ax, score
    call Display_Digits  

    exit:
        ret
ScoreCard endp

Display_Digits proc

    cmp ax, 9
    ja OUTPUT
    single:
        mov dx, 0
        mov dx, ax
        add dl, 48        
        mov ah, 02h       
        int 21h
        jmp exit 


    OUTPUT:
        mov dx, 0
        MOV Bx, 10
        L1:
            mov dx, 0
            CMP Ax, 0
            JE DISP
            DIV Bx
            MOV cx, dx
            PUSH CX
            inc counter
            MOV AH, 0
            JMP L1

    DISP:
        CMP counter, 0
        JE EXIT
        POP DX
        ADD DX, 48
        MOV AH, 02H
        INT 21H
        dec counter
        JMP DISP

    EXIT:

        ret
Display_Digits endp

scorebord proc

    call LOAD_IMAGES
    call GRAPHIC_MODE
    mov rows, 43 
    mov cols, 196

    ; Center the image horizontally
    mov ax, 320      ; Screen width
    sub ax, 140      ; Image width
    shr ax, 1        ; Divide by 2
    shr ax, 1
    add ax, 20
    mov pos_x, ax

    ; Center the image vertically
    mov ax, 200      ; Screen height
    sub ax, 38       ; Image height
    shr ax, 1        ; Divide by 2
    shr ax, 1
    shr ax, 1
    ;sub ax, 5
    mov pos_y, ax

    mov si, offset arr
    call RESTORE_POSITION
    call PRINT_IMAGE

    mov dh, 12
    mov dl, 13
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str24
    mov ah, 09h
    int 21h

    mov dh, 14
    mov dl, 14
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str25
    mov ah, 09h
    int 21h

    mov ax, score
    call Display_Digits

    
    mov dh, 20
    mov dl, 5
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str26
    mov ah, 09h
    int 21h

    mov dh, 20
    mov dl, 25
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str27
    mov ah, 09h
    int 21h

    mov ax, 0
    mov ax, score
    cmp ax,top_score
    ja newtop
    jbe exit

    newtop:
        mov ax, 0
        mov ax, score
        mov top_score, ax

    exit:
        ret
scorebord endp

Last_Page Proc
    call GRAPHIC_MODE
    
    mov dh, 12
    mov dl, 13
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str20
    mov ah, 09h
    int 21h


    mov dh, 23
    mov dl, 13
    mov bh, 0
    mov ah, 02h
    int 10h
    
    ret
Last_Page endp


pause_screen proc

    call GRAPHIC_MODE

    mov dh, 4
    mov dl, 12
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str29
    mov ah, 09h
    int 21h

    mov dh, 9
    mov dl, 9
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str30
    mov ah, 09h
    int 21h

    mov ax, score
    call Display_Digits

    mov dh, 11
    mov dl, 9
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str31
    mov ah, 09h
    int 21h

    mov ax, bullets
    call Display_Digits

    mov dh, 13
    mov dl, 9
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str32
    mov ah, 09h
    int 21h

    mov ax, hearts
    call Display_Digits

    mov dh, 18
    mov dl, 4
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str33
    mov ah, 09h
    int 21h

    mov dh, 18
    mov dl, 23
    mov bh, 0
    mov ah, 02h
    int 10h

    mov dx, offset str34
    mov ah, 09h
    int 21h

    ret
pause_screen endp




move_duck proc

    inc moves

    .IF moves == 1 || moves == 2 || moves == 3 || moves == 4 || moves == 5 || moves == 6 || moves == 11 || moves == 12 || moves == 13 || moves == 14 || moves == 15 || moves == 16 || moves == 21 || moves == 22 || moves == 23 || moves == 24 || moves == 25 || moves == 26 || moves == 31 || moves == 32 || moves == 33 || moves == 34 || moves == 35 || moves == 36 
        .IF duck_x<290 && duck_x > 0
            add duck_x, 5
        .ELSE   
            sub duck_x, 5
        .ENDIF
        .IF duck_y > 0
            sub duck_y, 5
        .ENDIF
        jmp exit
    .ENDIF 


    .IF moves == 7 || moves == 8 || moves == 9 || moves == 10 || moves == 17 || moves == 18 || moves == 19 || moves == 20 || moves == 27 || moves == 28 || moves == 29 || moves == 30 || moves == 37 || moves == 38 || moves == 39 || moves == 40 
        .IF duck_x<290 && duck_x > 0
            sub duck_x, 5
        .ENDIF
        .IF duck_y > 0 
            sub duck_y, 5
        .ENDIF
        jmp exit
    .ENDIF 


    exit:
        ret
move_duck endp


display_duck proc

    call LOAD_IMAGES7
    call move_duck

    mov rows, 15
    mov cols, 30

    .IF duck == 0
        add duck_x, 50
        .IF duck_x > 290
            mov duck_x, 50
        .ENDIF
        mov ax, duck_x
        mov pos_x, ax
        mov duck_x, ax
        mov duck2, ax
        
        mov ax, duck_y
        mov pos_y, ax
        inc duck
        mov duck_hit2, 0 
    .ELSE
        mov ax, duck_x
        mov pos_x, ax

        mov ax, duck_y
        mov pos_y, ax
    .ENDIF

    mov si,offset arr
    call RESTORE_POSITION
    call PRINT_IMAGE

        mov ah, 01h
        int 16h
        jz exit
        mov ah, 00h
        int 16h         ; Wait for a key press and read the character into AL
        cmp ah, 48h     ; Up
        je up
        cmp ah, 50h     ; Down
        je down
        cmp ah, 4bh     ; Left    
        je left
        cmp ah, 4dh     ; Right 
        je right
        cmp al, 27      ; ESC
        je pause
        cmp al, 32      ; Space
        je shoot
        jmp exit

    up: 
        .IF temp_y > 7       
            sub temp_y, 15
        .ENDIF
        jmp exit

    down:
        .IF temp_y < 135
            add temp_y, 15
        .ENDIF
        jmp exit

    left:
        .IF temp_x > 10
            sub temp_x, 15
        .ENDIF
        jmp exit

    right:
        .IF temp_x < 290
            add temp_x, 15
        .ENDIF
        jmp exit

    shoot:
        call duck_hit
        dec bullets
        cmp bullets, 0
        je scoreboard
        
        jne exit

    
    exit:
        ret
display_duck endp



duck_hit proc

    mov ax, duck_x
    add ax, 30
    mov temp_duck_x, ax

    mov ax, duck_y
    add ax, 15
    mov temp_duck_y, ax

    mov ax, temp_x
    mov bx, temp_y
    .IF ((ax > duck_x && ax < temp_duck_x) && (bx > duck_y && bx < temp_duck_y))    
        add score, 100
        mov duck_hit2, 1
    .ENDIF

    ret
duck_hit endp


move_duck2 proc

    inc moves2
    .IF moves2 == 1 || moves2 == 2 || moves2 == 3 || moves2 == 4 || moves2 == 8 || moves2 == 9 || moves2 == 10 || moves2 == 11 || moves2 == 15 || moves2 == 16 || moves2 == 17 || moves2 == 18 || moves2 == 22 || moves2 == 23 || moves2 == 24 || moves2 == 25 || moves2 == 29 || moves2 == 30 || moves2 == 31 || moves2 == 32|| moves2 == 36 || moves2 == 37 || moves2 == 38 || moves2 == 39
        .IF duck2_x<290 && duck2_x > 0
            add duck2_x, 10
        .ELSE   
            sub duck2_x, 10
        .ENDIF
        .IF duck2_y > 0
            sub duck2_y, 8
        .ENDIF

         .IF duck_x<290 && duck_x > 0
            add duck_x,10
        .ELSE   
            sub duck_x, 10
        .ENDIF
        .IF duck_y > 0
            sub duck_y, 8
        .ENDIF
        jmp exit
    .ENDIF 


    .IF moves2 == 5 || moves2 == 6 || moves2 == 7 || moves2 == 12 || moves2 == 13 || moves2 == 14 || moves2 == 19 || moves2 == 20 || moves2 == 21 || moves2 == 26 || moves2 == 27 || moves2 == 28 || moves2 == 33 || moves2 == 34 || moves2 == 35 || moves2 == 40   
        .IF duck2_x<290 && duck2_x > 0
            sub duck2_x, 10
        .ENDIF
        .IF duck2_y > 0 
            sub duck2_y, 8
        .ENDIF
        .IF duck_x<290 && duck_x > 0
            sub duck_x, 10
        .ENDIF
        .IF duck_y > 0 
            sub duck_y, 8
        .ENDIF
        jmp exit
    .ENDIF 


    exit:
        ret
move_duck2 endp


display_duck2 proc

    call LOAD_IMAGES7
    call move_duck2

    mov rows, 15
    mov cols, 30

    .IF duck == 0
        add duck_x, 50
        .IF duck_x > 290
            mov duck_x, 50
        .ENDIF
        mov ax, duck_x
        mov pos_x, ax
        mov duck_x, ax
        mov duck2, ax
        
        mov ax, duck_y
        mov pos_y, ax
        inc duck
        mov duck_hit2, 0 
    .ELSE
        mov ax, duck_x
        mov pos_x, ax

        mov ax, duck_y
        mov pos_y, ax
    .ENDIF

    mov si,offset arr
    call RESTORE_POSITION
    call PRINT_IMAGE

    mov rows, 15
    mov cols, 30

    .IF duck3 == 0
        add duck2_x, 50
        .IF duck2_x > 290
            mov duck2_x, 50
        .ENDIF
        mov ax, duck2_x
        mov pos_x, ax
        mov duck2_x, ax
        mov duck4, ax
        
        mov ax, duck2_y
        mov pos_y, ax
        inc duck3
        mov duck2_hit, 0 
    .ELSE
        mov ax, duck2_x
        mov pos_x, ax

        mov ax, duck2_y
        mov pos_y, ax
    .ENDIF

    mov si,offset arr
    call RESTORE_POSITION
    call PRINT_IMAGE



        mov ah, 01h
        int 16h
        jz exit
        mov ah, 00h
        int 16h         ; Wait for a key press and read the character into AL
        cmp ah, 48h     ; Up
        je up
        cmp ah, 50h     ; Down
        je down
        cmp ah, 4bh     ; Left    
        je left
        cmp ah, 4dh     ; Right 
        je right
        cmp al, 27      ; ESC
        je pause2
        cmp al, 32      ; Space
        je shoot
        jmp exit

    up: 
        .IF temp_y > 7       
            sub temp_y, 15
        .ENDIF
        jmp exit

    down:
        .IF temp_y < 135
            add temp_y, 15
        .ENDIF
        jmp exit

    left:
        .IF temp_x > 10
            sub temp_x, 15
        .ENDIF
        jmp exit

    right:
        .IF temp_x < 290
            add temp_x, 15
        .ENDIF
        jmp exit

    shoot:
        call duck_hitt
        dec bullets
        cmp bullets, 0
        je scoreboard2
        jne exit

    
    exit:
        ret
display_duck2 endp



duck_hitt proc

    mov ax, duck_x
    add ax, 30
    mov temp_duck_x, ax

    mov ax, duck_y
    add ax, 15
    mov temp_duck_y, ax

    mov ax, temp_x
    mov bx, temp_y
    
    .IF ((ax > duck_x && ax < temp_duck_x) && (bx > duck_y && bx < temp_duck_y))    
        add score, 100
        mov duck_hit2, 1
    .ENDIF

    mov ax, duck2_x
    add ax, 30
    mov temp_duck2_x, ax
    
    mov ax, duck2_y
    add ax, 15
    mov temp_duck2_y, ax

    mov ax, temp_x
    mov bx, temp_y
    

    .IF ((ax > duck2_x && ax < temp_duck2_x) && (bx > duck2_y && bx < temp_duck2_y))    
        add score, 100
        mov duck2_hit, 1
    .ENDIF

    ret
duck_hitt endp


Lives2 proc

    .IF hearts == 15 || hearts == 14 || hearts == 13|| hearts == 12 || hearts == 11 
        je hearts3
    .ELSEIF hearts == 10 || hearts == 9 || hearts == 8 || hearts == 7 || hearts == 6
        je hearts2
    .ELSEIF hearts == 5 || hearts == 4 || hearts == 3 || hearts == 2 || hearts == 1
        je heart1
    .ENDIF

    L1: 
        ; Center the image horizontally
        mov ax, 320      ; Screen width
        sub ax, 78      ; Image width
        ;shr ax, 1        ; Divide by 2
        mov pos_x, ax

        ; Center the image vertically
        mov ax, 200      ; Screen height
        sub ax, 18    ; Image height
        mov pos_y, ax


        mov si, offset arr
        call RESTORE_POSITION
        call PRINT_IMAGE
        jmp exit

    hearts3:

        call LOAD_IMAGES4
        mov rows, 12
        mov cols, 66
        jmp L1

    hearts2:
        call LOAD_IMAGES5
        mov rows, 12
        mov cols, 66
        jmp L1


    heart1:
        call LOAD_IMAGES6
        mov rows, 12
        mov cols, 66
        jmp L1

    exit:
        ret
Lives2 endp


main proc
    mov ax, @data
    mov ds, ax

L1:
    call FIRST_PAGE
    L2::
        call SECOND_PAGE

        mov ah, 00h
        int 16h         ; Wait for a key press and read the character into AL
        mov temp1, al

        cmp temp1, 34h  ; 4
        je L1
        cmp temp1, 35h  ; 5
        je exit
        cmp temp1, 33h  ; 3
        je L3
        cmp temp1, 32h  ; 2
        je GameB
        cmp temp1, 31h  ; 1
        je L4
        jmp L2
    
    L3:
        call THIRD_PAGE  
        mov ah, 00h
        int 16h         ; Wait for a key press and read the character into AL
        mov temp1, al
        cmp temp1, 31h
        je L2
        cmp temp1, 32h
        je exit
        jmp L3 


    L4:: 
        call GRAPHIC_MODE
        ;call PlaySOUND
        mov ax, 20
        mov bullets, ax

        mov ax, 158
        mov temp_x, ax

        mov ax, 97
        mov temp_y, ax  

        mov score, 0
        mov life, 0

        mov hearts, 9
        mov moves, 0
        mov duck_x, 0
        mov duck, 0
        mov ax, 150
        mov duck_y, ax
        
    L5::
        
        call Game_Screen 
        call display_duck
        call Aim_Display
        call ScoreCard

        .IF duck_y == 0 || duck_hit2 == 1
            mov ax, duck2
            mov duck_x, ax
            .IF duck_y == 0
                dec hearts
                jmp heart
            .ENDIF
        L55:
            mov ax, 0
            mov ax, 150
            mov duck_y, ax
            mov duck, 0
            mov moves, 0
        .ENDIF

        jmp L5
    
    heart::
        cmp hearts, 0
        je scoreboard
        jne L55

    scoreboard::
        call scorebord
        mov ah, 00h
        int 16h
        cmp al, 31h  ; 1
        je L4
        cmp al, 32h  ; 2
        je L2
        jmp scoreboard 

    pause::

        call pause_screen
        mov ah, 00h
        int 16h
        cmp al, 27
        je L5
        cmp al, 31h
        je L5
        cmp al, 32h  ; 2
        je L2
        jmp pause 
    
    GameB::
        call GRAPHIC_MODE
        ;call PlaySOUND
        mov ax, 30
        mov bullets, ax

        mov ax, 158
        mov temp_x, ax

        mov ax, 97
        mov temp_y, ax  

        mov score, 0
        mov life, 1

        mov hearts, 15
        mov moves, 0
        mov moves2, 0
        mov duck_x, 0
        mov duck2_x, 50
        mov duck, 0
        mov duck3, 0
        mov ax, 150
        mov duck_y, ax
        mov duck2_y, ax

        Game::
            call Game_Screen 
            call display_duck2
            call Aim_Display
            call ScoreCard
            
            .IF duck_y == 6 || duck_hit2 == 1 
                mov ax, duck2
                mov duck_x, ax
                .IF duck_y == 6
                    dec hearts
                    .IF hearts == 0
                        jmp scoreboard2
                    .ENDIF
                .ENDIF
                mov ax, 0
                mov ax, 150
                mov duck_y, ax
                mov duck, 0
                mov moves, 0
            .ENDIF

            .IF duck2_y == 6 || duck2_hit == 1 
                mov ax, duck4
                mov duck2_x, ax
                .IF duck2_y == 6
                    dec hearts
                    .IF hearts == 0
                        jmp scoreboard2
                    .ENDIF
                .ENDIF
                mov ax, 0
                mov ax, 150
                mov duck2_y, ax
                mov duck3, 0
                mov moves2, 0
            .ENDIF

        jmp Game

    pause2::

        call pause_screen
        mov ah, 00h
        int 16h
        cmp al, 27
        je Game
        cmp al, 31h
        je Game
        cmp al, 32h  ; 2
        je L2
        jmp pause 

    scoreboard2::
        call scorebord
        mov ah, 00h
        int 16h
        cmp al, 31h  ; 1
        je GameB
        cmp al, 32h  ; 2
        je L2
        jmp scoreboard2 
        

    exit:
        call Last_Page
        mov ah, 4ch           ; Function to exit the program
        int 21h               ; DOS interrupt


main endp
end main