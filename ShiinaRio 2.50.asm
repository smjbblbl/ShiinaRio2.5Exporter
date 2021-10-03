
[ENABLE]
GlobalAlloc(inject,1024)
label(path)

// var_2C          = dword ptr -2Ch
// var_28          = dword ptr -28h
// var_24          = dword ptr -24h
// var_20          = dword ptr -20h
// filehandle      = dword ptr -1Ch
// var_18          = dword ptr -18h
// newname         = dword ptr -14h
// var_10          = dword ptr -10h
// var_C           = dword ptr -0Ch
// var_8           = dword ptr -8
// var_3           = byte ptr -3
// var_2           = byte ptr -2
// var_1           = byte ptr -1
// name            = dword ptr  8
// data            = dword ptr  0Ch
// length          = dword ptr  10h
//bx cx bp
inject:
				
				cmp byte ptr [esi],0x53
				je callDump
				jmp owari
owari:
				mov eax,esi   
				pop edi       
				pop esi       
				pop ebx       
				mov esp,ebp   
				pop ebp
				ret
callDump:
				cmp [esi-10],0
				jng owari
				mov eax,esi  
				mov ebx,[eax-10]
				sub ebx,20
				push ebx	//length
				push eax	//data
				mov edi,[esp+8]
				push edi	//name
				call dump
				jmp owari
dump:
                push    ebp
                mov     ebp, esp
                sub     esp, 0x2C
                push    esi
                push    edi
                mov     eax, [ebp+8]
                mov     [ebp-8], eax
                mov     ecx, [ebp-8]
                add     ecx, 1
                mov     [ebp-20], ecx

loc_40102C:                             //CODE XREF: _main+3C↓j
                mov     edx, [ebp-8]
                mov     al, [edx]
                mov     [ebp-1], al
                add     [ebp-8], 1
                cmp     byte ptr [ebp-1], 0
                jnz     short loc_40102C
                mov     ecx, [ebp-8]
                sub     ecx, [ebp-20]
                mov     [ebp-24], ecx
                mov     edx, [ebp-24]
                add     edx, 9
                push    edx             //Size
                call    malloc
                add     esp, 4
                mov     [ebp-14], eax
                mov     eax, [ebp-14]
                mov     ecx, [path]
                mov     [eax], ecx
                mov     edx, [path+0x4]
                mov     [eax+4], edx
                mov     cl, [path+0x8]
                mov     [eax+8], cl
                mov     edx, [ebp+8]
                mov     [ebp-C], edx
                mov     eax, [ebp-C]
                mov     [ebp-18], eax

loc_401083:                             //CODE XREF: _main+93↓j
                mov     ecx, [ebp-C]
                mov     dl, [ecx]
                mov     [ebp-2], dl
                add     [ebp-C], 1
                cmp     byte ptr [ebp-2], 0
                jnz     short loc_401083
                mov     eax, [ebp-C]
                sub     eax, [ebp-18]
                mov     ecx, [ebp-18]
                mov     [ebp-28], ecx
                mov     [ebp-2C], eax
                mov     edx, [ebp-14]
                add     edx, 0FFFFFFFF
                mov     [ebp-10], edx

loc_4010AD:                             //CODE XREF: _main+BE↓j
                mov     eax, [ebp-10]
                mov     cl, [eax+1]
                mov     [ebp-3], cl
                add     [ebp-10], 1
                cmp     byte ptr [ebp-3], 0
                jnz     short loc_4010AD
                mov     edi, [ebp-10]
                mov     esi, [ebp-28]
                mov     edx, [ebp-2C]
                mov     ecx, edx
                shr     ecx, 2
                rep movsd
                mov     ecx, edx
                and     ecx, 3
                rep movsb
                push    0               //iAttribute
                mov     eax, [ebp-14]
                push    eax             //lpPathName
                call    lcreat //_lcreat(x,x)
                mov     [ebp-1C], eax
                mov     ecx, [ebp+10]
                push    ecx             //uBytes
                mov     edx, [ebp+C]
                push    edx             //lpBuffer
                mov     eax, [ebp-1C]
                push    eax             //hFile
                call    lwrite //_lwrite(x,x,x)
                mov     ecx, [ebp-1C]
                push    ecx             //hFile
                call    lclose //_lclose(x)
                mov     eax, [ebp+C]
                pop     edi
                pop     esi
                mov     esp, ebp
                pop     ebp
                retn

path:
db 'E:\Dump\',0


[DISABLE]
dealloc(inject)
