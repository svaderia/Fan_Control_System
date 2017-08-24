.model tiny
.data

t_kbrd      dw  0eeh, 0edh, 0ebh, 0e7h, 0deh, 0ddh, 0dbh, 0d7h, 0beh, 0bdh, 0bbh, 0b7h, 7eh, 7dh, 7bh, 77h
t_display   db  3fh, 06h, 5bh, 4fh, 66h, 6dh
speed       dw  00h
started     dw  00h
auto_s      dw  03h
set_time        dw  00h
flag_auto   dw  00h

.code
.startup
    ;setting the 8253a ports

    porta   equ     00h 
    portb   equ     02h
    portc   equ     04h
    creg    equ     06h
    
    ;initializing the ports of 8253a
    mov     al, 88h
    out     creg, al
	
a0: mov     al, 00h
    out     portc, al

a1: in      al, portc
    and     al, 0f0h
    cmp     al, 0f0h    ;check for key release
    jnz     a1
    call    delay20 	  
    mov     al, 00h
    out     portc, al
a2: in      al, portc
    and     al, 0f0h
    cmp     al, 0f0h
    jz      a2
    call    delay20 	
    
    ;validity of key press
    mov     al, 00h
    out     portc, al
    in      al, portc
    and     al, 0f0h
    cmp     al, 0f0h
    jz      a2
    
    ;key press column 1
    mov     al, 0eh
    mov     bl, al
    out     portc, al
    in      al, portc
    and     al, 0f0h
    cmp     al, 0f0h
    jnz     a3
    
    ;press column 2
    mov     al, 0dh
    mov     bl, al
    out     portc, al
    in      al, portc
    and     al, 0f0h
    cmp     al, 0f0h
    jnz     a3
    
    ;key press column 3
    mov     al, 0bh
    mov     bl, al
    out     portc, al
    in      al, portc
    and     al, 0f0h
    cmp     al, 0f0h
    jnz     a3
    
    ;key press column 4
    mov     al, 07h
    mov     bl, al
    out     portc, al
    in      al, portc
    and     al, 0f0h
    cmp     al, 0f0h
    jz      a2
    
    ;decode key
a3: or      al, bl
    mov     cx, 0fh
    mov     di, 00h
    lea     di, ds:t_kbrd
	
a4: cmp     al, [di]
    jz      a5
    inc     di
    loop    a4
    
    ;motor started checks
a5: cmp     started, 01h
    jz     auto
    cmp     al, 0b7h ;button encoding for start
    jz      start
    jmp     a0
    

start:  call sfan
        jmp a0
    
auto:   cmp al, 0b7h
        jz  a0
        cmp     flag_auto, 01h
        jz      time_set
        cmp     al, 77h
        jnz     checkspd
        mov     flag_auto, 01h
        jmp     a0

time_1:     mov     set_time, 01h
			call    time
			call    stop
			jmp     a0

time_2:     mov     set_time, 02h
			call    time
			call    stop
			jmp     a0
    
time_3:     mov     set_time, 03h
			call    time
			call    stop
			jmp     a0
    
time_4:     mov     set_time, 04h
			call    time
			call    stop
			jmp     a0
    
time_5:     mov     set_time, 05h
			call    time
			call    stop
			jmp     a0
    
time_6:     mov     set_time, 06h
			call    time
			call    stop
			jmp     a0
    
time_7:     mov     set_time, 07h
			call    time
			call    stop
			jmp     a0
    
time_8:     mov     set_time, 08h
			call    time
			call    stop
			jmp     a0
    
time_9:     mov     set_time, 09h
			call    time
			call    stop
			jmp     a0
    
time_10:     mov     set_time, 0ah
			call    time
			call    stop
			jmp     a0		
		
time_set:   cmp     al, 0eeh  ; checks speed
		call    stop
		jmp     a0
		cmp     al, 0edh
		jz      time_1
		cmp     al, 0ebh
		jz      time_2
		cmp     al, 0e7h
		jz      time_3
		cmp     al, 0deh
		jz      time_4
		cmp     al, 0ddh
		jz      time_5
		cmp     al, 0dbh
		jz      time_6
		cmp     al, 0d7h
		jz      time_7
		cmp     al, 0beh
		jz      time_8
		cmp     al, 0bdh
		jz      time_9
		cmp     al, 0bbh
		jz      time_10
		jmp     a0
    
;setting the speed.
speedset_0:	mov		speed, 00h
			call 	stop
			mov		al, 3fh
			not		al
			out		portb, al
			jmp		a0

speedset_1:    mov     speed, 01h
			call    speedset
			mov     al, [bx + 01h]
			not		al
			out     portb, al
			jmp     a0
    
speedset_2:    mov     speed, 02h
			call    speedset
			mov     al, [bx + 02h]
			not		al
			out     portb, al
			jmp     a0
    
speedset_3:    mov     speed, 03h
			call    speedset
			mov     al, [bx + 03h]
			not		al
			out     portb, al
			jmp     a0

speedset_4:    mov     speed, 04h
			call    speedset
			mov     al, [bx + 04h]
			not		al
			out     portb, al
			jmp     a0
    
speedset_5:    mov     speed, 05h
			call    speedset
			mov     al, [bx + 05h]
			not		al
			out     portb, al
			jmp     a0
  
  
;Decide speed to set and set it
checkspd:   lea     bx, DS:t_display
			cmp 	al, 0eeh
			jz      speedset_0
			cmp     al, 0edh
			jz      speedset_1
			cmp     al, 0ebh
			jz      speedset_2
			cmp     al, 0e7h
			jz      speedset_3
			cmp     al, 0deh
			jz      speedset_4
			cmp		al, 0ddh
			jz  	speedset_5
			jmp     increase

  
increase:   lea     bx, DS:t_display
			cmp     al, 7dh
			jnz     decrease
			call    incr
			call    speedset
			jmp     a0
    
decrease:   cmp     al, 7bh
			jnz     stop_fan
			call    decr
			call    speedset
			jmp     a0
    
    
stop_fan:  cmp      al, 7eh
			jnz     a0
			call 	stop
			mov		al, 3fh
			not		al
			out		portb, al
			jmp     a0
    
.exit


;Delay of 20ms
delay20 proc near
    mov     cx, 2220
x9: loop    x9
    ret
delay20 endp

;starts the fan and set it's speed to 1
sfan proc near
    mov     speed, 01h
    mov     al, 33h
    out     porta, al
    mov     started, 01h
    ret
sfan endp

;stops the fan
stop proc near
    mov     speed, 00h
    mov     al, 00h
    out     porta, al
    mov     started, 00h
    mov     flag_auto, 00h
    ret
stop endp

;sets the required speed
speedset proc near
    mov     cx, speed
    mov     al, 00h
x:  add     al, 33h
    loop    x
    out     porta, al
    ret
speedset endp

time proc near
    mov     cx, auto_s
    mov     al, 00h
x8: add     al, 33h
    loop    x8
    out     porta, al  
    mov     bx, set_time
loop3:  mov     dx, 50
loop2:  mov     cx, 2220    
loop1:  nop
		dec     cx
		jnz     loop1
		dec     dx
		jnz     loop2
		dec     bx
		jnz     loop3
    
    ret
time endp

incr proc near
    cmp     speed, 05h
    jge     x6
    inc     speed
    mov     cx, speed
    add     bx, cx
    mov     al, [bx]
    not		al
    out     portb, al
x6: ret
incr endp

decr proc near
    cmp     speed, 01h
    jbe     x7
    dec     speed
    mov     cx, speed
    add     bx, cx
    mov     al, [bx]
    not		al
    out     portb, al
x7: ret
decr endp

end