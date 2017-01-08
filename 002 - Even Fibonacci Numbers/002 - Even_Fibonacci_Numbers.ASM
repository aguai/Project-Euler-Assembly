format PE console
include "win32ax.inc"

  start:
	mov eax, 1		; first fibonacci number
	mov ebx, 1		; second fibonacci number
	mov edx, 0		; sum variable

  .loop:
	mov ecx, ebx		; keep the second
	add ebx, eax		; add second to first and get next fibonacci
	mov eax, ecx		; move second to first fibonacci

	cmp ebx, 4000000	; check if we exceeded the limit
	jg start.finish 	; if so, skip to end

	test ebx, 1		; check if last fibonacci is odd
	jnz start.loop		; if so, skip to start
	add edx, ebx		; if it's even, add to edx
	jmp start.loop		; go to start

  .finish:
	; print sum using printf function of c
	cinvoke printf, formatstring, edx
	invoke ExitProcess, 0

	formatstring db "%d", 13, 10, 0

section '.idata' import data readable

	library msvcrt, 'msvcrt.dll',\
		kernel32, 'kernel32.dll'

	import msvcrt,printf, 'printf'
	import kernel32, ExitProcess, 'ExitProcess'
