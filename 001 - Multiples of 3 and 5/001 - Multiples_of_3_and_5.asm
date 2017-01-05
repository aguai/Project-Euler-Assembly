format PE console
include "win32ax.inc"

  start:
	mov ecx, 999
	
  .loop:
	xor edx, edx
	mov eax, ecx
	mov ebx, 3
	div ebx
	cmp edx, 0
	jz start.success

	xor edx, edx
	mov eax, ecx
	mov ebx, 5
	div ebx
	cmp edx, 0
	jnz start.skip
	
  .success:
	add [sum], ecx

  .skip:
	dec ecx
	jnz start.loop

	cinvoke printf, formatstring, [sum]
	invoke	ExitProcess, 0

	formatstring db "%d", 13, 10, 0
	sum dd 0

section '.idata' import data readable

	library msvcrt, 'msvcrt.dll',\
		kernel32, 'kernel32.dll'

	import msvcrt, printf, 'printf'
	import kernel32, ExitProcess, 'ExitProcess'
