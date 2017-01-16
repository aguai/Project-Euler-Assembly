format PE console
include "win32ax.inc"

  start:
	mov esi, 1		; next prime index
	mov [primes], 3 	; initial prime item
	mov ecx, 3		; initial try value

  .loopOut:
	add ecx, 2

	cmp esi, 10000
	je start.loopDone

	mov edi, 0

  .loopIn:
	xor edx, edx
	mov eax, ecx
	mov ebx, [primes+(edi*4)]
	div ebx

	cmp edx, 0
	je start.loopOut

	add edi, 1
	cmp esi, edi
	jne start.loopIn

	mov [primes+(esi*4)], ecx
	add esi, 1
	jmp start.loopOut

  .loopDone:
	; print sum using printf function of c
	cinvoke printf, formatstring, [primes+(9999*4)]
	invoke	ExitProcess, 0

	formatstring db "%d", 13, 10, 0
	primes dd 10000 dup(0)

section '.idata' import data readable

	library msvcrt, 'msvcrt.dll',\
		kernel32, 'kernel32.dll'

	import msvcrt, printf, 'printf'
	import kernel32, ExitProcess, 'ExitProcess'
