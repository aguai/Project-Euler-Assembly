int64ToStr:
	push ebp
	mov ebp, esp

	mov ebx, [ebp+8]
	mov edx, [ebx+4]
	mov eax, [ebx]

	cmp edx, 0
	jg int64ToStr.20
	mov ebx, 10
	jmp int64ToStr.10

  .20:	mov ebx, 20
	mov edi, 2328306436
	mov esi, 2313682944
	call int64ToStr.cmp
	jc int64ToStr.done
  .19:	mov edi, 232830643
	mov esi, 2808348672
	call int64ToStr.cmp
	jc int64ToStr.done
  .18:	mov edi, 23283064
	mov esi, 1569325056
	call int64ToStr.cmp
	jc int64ToStr.done
  .17:	mov edi, 2328306
	mov esi, 1874919424
	call int64ToStr.cmp
	jc int64ToStr.done
  .16:	mov edi, 232830
	mov esi, 2764472320
	call int64ToStr.cmp
	jc int64ToStr.done
  .15:	mov edi, 23283
	mov esi, 276447232
	call int64ToStr.cmp
	jc int64ToStr.done
  .14:	mov edi, 2328
	mov esi, 1316134912
	call int64ToStr.cmp
	jc int64ToStr.done
  .13:	mov edi, 232
	mov esi, 3567587328
	call int64ToStr.cmp
	jc int64ToStr.done
  .12:	mov edi, 23
	mov esi, 1215752192
	call int64ToStr.cmp
	jc int64ToStr.done
  .11:	mov edi, 2
	mov esi, 1410065408
	call int64ToStr.cmp
	jc int64ToStr.done
  .10:	cmp eax, 1000000000
	jge int64ToStr.done
	dec ebx
  .9:	cmp eax, 100000000
	jge int64ToStr.done
	dec ebx
  .8:	cmp eax, 10000000
	jge int64ToStr.done
	dec ebx
  .7:	cmp eax, 1000000
	jge int64ToStr.done
	dec ebx
  .6:	cmp eax, 100000
	jge int64ToStr.done
	dec ebx
  .5:	cmp eax, 10000
	jge int64ToStr.done
	dec ebx
  .4:	cmp eax, 1000
	jge int64ToStr.done
	dec ebx
  .3:	cmp eax, 100
	jge int64ToStr.done
	dec ebx
  .2:	cmp eax, 10
	jge int64ToStr.done
	dec ebx

  .done:
	inc ebx
	cinvoke malloc, ebx
	mov esi, eax
	add esi, ebx
	dec esi
	xor ecx, ecx
	mov [esi], cl

	mov ebx, [ebp+8]
	mov edx, [ebx+4]
	mov eax, [ebx]

	cmp edx, 0
	jz int64ToStr.32

	mov ecx, 1000000000
	div ecx

	push eax
	mov eax, edx
	call int64ToStr.convertToStr
	pop eax
  .32:
	call int64ToStr.convertToStr
	mov eax, esi

	pop ebp
	ret

  .cmp:
	cmp edx, edi
	ja int64ToStr.cmp.greater
	jb int64ToStr.cmp.lesser
	cmp eax, esi
	jl int64ToStr.cmp.lesser

    .cmp.greater:
	stc
	ret
    .cmp.lesser:
	dec ebx
	clc
	ret


  .convertToStr:
	mov ecx, 10

  .convertToStr.loop:
	xor edx, edx
	div ecx
	add edx, 48
	dec esi
	mov [esi], dl
	cmp eax, 0
	je int64ToStr.convertToStr.done
	jmp int64ToStr.convertToStr.loop

    .convertToStr.done:
	ret
