format PE console
include "win32ax.inc"

  start:
	; simplified formula:	a = (500000-1000.b)/(1000-b)
	; max b = 499
	mov ebx, 499
	mov esi, 1000

  .loop:
	mov eax, ebx
	mul esi 		; 1000.b
	mov ecx, eax

	mov eax, 500000
	sub eax, ecx		; 500000-1000.b

	mov ecx, 1000
	sub ecx, ebx		; 1000-b
	xor edx, edx
	div ecx 		; (500000-1000.b)/(1000-b)

	cmp edx, 0		; if there is no remainder, we are done
	je start.done		; ebx = b, eax = a

	sub ebx, 1
	jmp start.loop

  .done:
	mov edx, eax
	mov eax, 1000		; c = 1000-a-b
	sub eax, edx
	sub eax, ebx
	mul edx
	mul ebx 		; a.b.c

	; print sum using printf function of c
	cinvoke printf, formatstring, eax
	invoke	ExitProcess, 0

	formatstring db "%d", 13, 10, 0

section '.idata' import data readable

	library msvcrt, 'msvcrt.dll',\
		kernel32, 'kernel32.dll'

	import msvcrt, printf, 'printf'
	import kernel32, ExitProcess, 'ExitProcess'
