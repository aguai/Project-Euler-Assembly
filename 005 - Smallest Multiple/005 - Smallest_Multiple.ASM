format PE console
include "win32ax.inc"

  start:
	mov ebx, array
	mov esi, 0

  .loopDiv:
	mov edi, esi
	add edi, 4
	mov ecx, [array+esi]

    .loopDivIn:
	xor edx, edx
	mov eax, [array+edi]
	div ecx

	cmp edx, 0
	jne start.loopDivSkip
	mov [array+edi], eax

    .loopDivSkip:
	cmp edi, 18*4
	je start.loopDivInDone
	add edi, 4

	jmp start.loopDivIn

    .loopDivInDone:
	cmp esi, 17*4
	je start.loopDivDone
	add esi, 4
	jmp start.loopDiv

  .loopDivDone:
	mov eax, 1
	mov ecx, 0

  .loopMul:
	xor edx, edx
	mov edx, [array+ecx]
	mul edx

	cmp ecx, 18*4
	je start.loopMulDone

	add ecx, 4
	jmp start.loopMul

  .loopMulDone:

	; print sum using printf function of c
	cinvoke printf, formatstring, eax
	invoke	ExitProcess, 0

	formatstring db "%d", 13, 10, 0
	array dd 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20

section '.idata' import data readable

	library msvcrt, 'msvcrt.dll',\
		kernel32, 'kernel32.dll'

	import msvcrt, printf, 'printf'
	import kernel32, ExitProcess, 'ExitProcess'