.586P
.MODEL FLAT, C
;------------------------------------
_TEXT SEGMENT
DLLENTRY PROC hInstDLL:DWORD, reason:DWORD, reserved:DWORD		;dll-init procedure
    mov  EAX, -1
    ret
DLLENTRY endp

modul3 PROC
;[EBP+ 8] var X
;[EBP+12] var Y
;[EBP+16] var Z
	push EBP
	mov  EBP, ESP
	;------------
	sub ESP, 24
;[EBP- 4] X EAX
;[EBP- 8] X EDX
;[EBP-12] Y EAX
;[EBP-16] Y EDX
;[EBP-20] Z EAX
;[EBP-24] Z EDX
	mov  EAX, 0
	mov  EDX, 0
;--------------------------------
	FINIT			;initialise coprocessor
;--------------------------------
	mov EAX, DWORD ptr[EBP+ 8]	;вычисление X^2
	mul EAX
	mov DWORD ptr[EBP-8], EDX
	mov DWORD ptr[EBP-4], EAX
;--------------------------------
	mov EAX, DWORD ptr[EBP+12]	;вычисление Y^2
	mul EAX
	mov DWORD ptr[EBP-16], EDX
	mov DWORD ptr[EBP-12], EAX
;--------------------------------
	mov EAX, DWORD ptr[EBP+16]	 ;вычисление Z^2
	mul EAX
	mov DWORD ptr[EBP-24], EDX
	mov DWORD ptr[EBP-20], EAX
;--------------------------------;сложение членов подкоренного выражения
	mov EAX, DWORD ptr[EBP- 4]  ;X
	add EAX, DWORD ptr[EBP-12]  ;Y
	add EAX, DWORD ptr[EBP-20]  ;Z

	mov DWORD ptr[EBP- 8], EDX	 ;Сохранение результата 64-битного результата в [EBP-8]
	mov DWORD ptr[EBP- 4], EAX
;--------------------------------
	FILD DWORD ptr[EBP- 4]		;вычисление корня подкоренного выражения
	FSQRT
	FIST DWORD ptr[EBP- 4]		;сохранение результата в переменной x
;--------------------------------
;	mov  EDX, DWORD ptr[EBP- 8] ;вывод результата в EDX
	mov  EAX, DWORD ptr[EBP- 4] ;вывод результата в EAX
;--------------------------------
	mov ESP, EBP
	pop EBP
	
	RET 12
modul3 ENDP

_TEXT ENDS
END DLLENTRY