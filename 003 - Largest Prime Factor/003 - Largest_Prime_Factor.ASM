; using 64 bit executable format. because it is a little hard to work with 64 bit numbers with 32 bit registers
format PE64 console
include "win64ax.inc"

  start:
	fild [num]		; load the number to the FPU ST(0)
	fsqrt			; calculate the square root
	fistp [sqrt]		; store to the memory

	mov ecx, [sqrt] 	; square root of the number is our limit
	mov rbx, 1		; skipping 2 because laziness. for even numbers, we need to do loopDiv for 2 first, then odd numbers

  .loopCount:
	cmp ebx, ecx		; check if we exceeded the square root
	jg start.finish 	; if so, skip to finish

	add rbx, 2		; next odd number

	xor rdx, rdx		; reset rdx, we are not using higher 64 bits
	mov rax, [num]		; prepare for division

  .loopDiv:
	div rbx 		; divide the number with current

	cmp rdx, 0		; check if there is remainder
	jnz start.loopCount	; if so, move to the next odd number

	mov [max], rbx		; if this is a divisor, save it
	mov [num], rax		; and change the divisor with quotient

	jmp start.loopDiv	; move to the next odd number

  .finish:
	; print max using printf function of c
	cinvoke printf, formatstring, [max]
	invoke	ExitProcess, 0

	formatstring dq "%d", 13, 10, 0
	num dq 600851475143
	sqrt dd ?
	max dq 600851475143

section '.idata' import data readable

	library msvcrt, 'msvcrt.dll',\
		kernel32, 'kernel32.dll'

	import msvcrt, printf, 'printf'
	import kernel32, ExitProcess, 'ExitProcess'
