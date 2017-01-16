format PE console
include "win32ax.inc"

  start:
	; sum's square: ((n*(n+1))/2)^2
	; sum of squares: (n*(n+1)*(2n+1))/6   https://trans4mind.com/personal_development/mathematics/series/sumNaturalSquares.htm

	mov eax, 100
	mov ebx, eax
	add ebx, 1
	mov ecx, eax
	add ecx, eax
	add ecx, 1
	mul ebx
	mul ecx
	mov ebx, 6
	div ebx
	mov ecx, eax

	mov eax, 100
	mov ebx, eax
	add ebx, 1
	mul ebx
	xor edx, edx
	mov ebx, 2
	div ebx
	mul eax

	sub eax, ecx

	; print sum using printf function of c
	cinvoke printf, formatstring, eax
	invoke	ExitProcess, 0

	formatstring db "%d", 13, 10, 0

section '.idata' import data readable

	library msvcrt, 'msvcrt.dll',\
		kernel32, 'kernel32.dll'

	import msvcrt, printf, 'printf'
	import kernel32, ExitProcess, 'ExitProcess'
