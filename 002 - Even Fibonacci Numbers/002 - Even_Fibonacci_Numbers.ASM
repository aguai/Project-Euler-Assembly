format PE console
include "win32ax.inc"

  start:
	mov eax, 1
	mov ebx, 1
	mov edx, 0

  .loop:
	mov ecx, ebx
	add ebx, eax
	mov eax, ecx

	cmp ebx, 4000000
	jg start.finish

	test ebx, 1
	jnz start.loop
	add edx, ebx
	jmp start.loop

  .finish:
	cinvoke printf, formatstring, edx
	invoke ExitProcess, 0

	formatstring db "%d", 13, 10, 0

section '.idata' import data readable

	library msvcrt, 'msvcrt.dll',\
		kernel32, 'kernel32.dll'

	import msvcrt,printf, 'printf'
	import kernel32, ExitProcess, 'ExitProcess'
