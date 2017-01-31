format PE console
include "win32ax.inc"

  start:
	mov [num], 5
	mov ebx, 5
	xor esi, esi

  .loop:
	call isPrime

	add ebx, eax
	jnc start.noCarry
	inc esi

  .noCarry:
	add [num], 2

	cmp [num], 2000000
	jl start.loop

	mov eax, sum
	mov [eax], ebx
	mov [eax+4], esi

	push sum
	call int64ToStr

	cinvoke printf, eax
	invoke	ExitProcess, 0

	num dd ?
	sqrt dd ?
	sum dq 0


  isPrime:
	test [num], 1
	jnz isPrime.odd

	jmp isPrime.fail

  .odd:
	fild [num]
	fsqrt
	fistp [sqrt]
	inc [sqrt]

	mov ecx, 3

  .loop:
	xor edx, edx
	mov eax, [num]
	div ecx

	cmp edx, 0
	je isPrime.fail

	add ecx, 2
	cmp ecx, [sqrt]
	jl isPrime.loop

	mov eax, [num]
	ret

  .fail:
	xor eax, eax
	ret


include '..\_Shared\Int64ToStr.asm'


section '.idata' import data readable

	library msvcrt, 'msvcrt.dll',\
		kernel32, 'kernel32.dll'

	import msvcrt, printf, 'printf', malloc, 'malloc'
	import kernel32, ExitProcess, 'ExitProcess'
