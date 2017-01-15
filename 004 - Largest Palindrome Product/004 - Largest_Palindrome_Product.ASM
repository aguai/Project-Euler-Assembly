format PE console
include "win32ax.inc"

  start:
	mov ebx, [floor]

  .loopOut:
	cmp [count1], ebx
	jl start.loopDone

	sub [count1], 1
	mov [count2], 1000

  .loopIn:
	mov ebx, [floor]
	cmp [count2], ebx
	jl start.loopOut

	sub [count2], 1

	mov eax, [count1]
	mul [count2]
	call isPalindrome
	cmp eax, [max]
	jl start.loopIn

	mov [max], eax

	fild [max]
	fsqrt
	fistp [floor]

	jmp start.loopIn

  .loopDone:

	; print sum using printf function of c
	cinvoke printf, formatstring, [max]
	invoke	ExitProcess, 0

	formatstring db "%d", 13, 10, 0
	count1 dd 1000
	count2 dd ?
	max dd 0
	floor dd 100

section '.idata' import data readable

	library msvcrt, 'msvcrt.dll',\
		kernel32, 'kernel32.dll'

	import msvcrt, printf, 'printf'
	import kernel32, ExitProcess, 'ExitProcess'


  isPalindrome: ; eax holds the number
	cmp eax, 10
	jl isPalindrome.done

	push eax

	mov edi, 1
	mov esi, 10

  .logLoop: ; doing manual floor(log10(eax))
	cmp esi, eax
	jg isPalindrome.logDone

	xor edx, edx
	div esi

	push eax
	mov eax, edi
	mul esi
	mov edi, eax
	pop eax

	jmp isPalindrome.logLoop

  .logDone:
	pop eax
	push eax

  .chkLoop:
	xor edx, edx
	div edi
	mov cl, al

	mov eax, edx
	xor edx, edx
	mov esi, 10
	div esi
	mov ch, dl

	cmp cl, ch
	jne isPalindrome.fail

	xchg eax, edi
	xor edx, edx
	mov esi, 100
	div esi
	xchg eax, edi

	cmp edi, 10
	jl isPalindrome.done

	jmp isPalindrome.chkLoop

  .fail:
	pop eax
	xor eax, eax
	ret
  .done:
	pop eax
	ret