
x86_sha_extensions_match_the_instructions.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	$-0x3de0216b, %rcx      # imm = 0xC21FDE95
               	vmovd	%ecx, %xmm0
               	movl	$0x3ead5c56, %edx       # imm = 0x3EAD5C56
               	vpinsrd	$0x1, %edx, %xmm0, %xmm0
               	movq	$-0x32e2fdfb, %rsi      # imm = 0xCD1D0205
               	vpinsrd	$0x2, %esi, %xmm0, %xmm0
               	movabsq	$0x172c4a902, %rdi      # imm = 0x172C4A902
               	vpinsrd	$0x3, %edi, %xmm0, %xmm0
               	vmovd	%ecx, %xmm1
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vpinsrd	$0x2, %esi, %xmm1, %xmm1
               	movl	$0x72c4a902, %ecx       # imm = 0x72C4A902
               	vpinsrd	$0x3, %ecx, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1ec1c7a7, %ecx       # imm = 0x1EC1C7A7
               	vmovd	%ecx, %xmm0
               	movl	$0x85e82f0, %edx        # imm = 0x85E82F0
               	vpinsrd	$0x1, %edx, %xmm0, %xmm0
               	movl	$0x5b90feb, %esi        # imm = 0x5B90FEB
               	vpinsrd	$0x2, %esi, %xmm0, %xmm0
               	movl	$0xaaae1b84, %edi       # imm = 0xAAAE1B84
               	vpinsrd	$0x3, %edi, %xmm0, %xmm0
               	vmovd	%ecx, %xmm1
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vpinsrd	$0x2, %esi, %xmm1, %xmm1
               	movq	$-0x5551e47c, %rcx      # imm = 0xAAAE1B84
               	vpinsrd	$0x3, %ecx, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa567ee2e, %ecx       # imm = 0xA567EE2E
               	vmovd	%ecx, %xmm0
               	movl	$0xca36bc9c, %eax       # imm = 0xCA36BC9C
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	movl	$0xd1912c3f, %eax       # imm = 0xD1912C3F
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	movl	$0x816f32b5, %eax       # imm = 0x816F32B5
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	xorl	%eax, %eax
               	movq	$-0x5a9811d2, %rcx      # imm = 0xA567EE2E
               	vmovd	%ecx, %xmm1
               	movq	$-0x35c94364, %rcx      # imm = 0xCA36BC9C
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movq	$-0x2e6ed3c1, %rcx      # imm = 0xD1912C3F
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	movq	$-0x7e90cd4b, %rcx      # imm = 0x816F32B5
               	vpinsrd	$0x3, %ecx, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xaf5a022b, -0x10(%rbp) # imm = 0xAF5A022B
               	movl	$0xcd1d0205, -0xc(%rbp) # imm = 0xCD1D0205
               	movl	$0x3ead5c56, -0x8(%rbp) # imm = 0x3EAD5C56
               	movl	$0xc21fde95, -0x4(%rbp) # imm = 0xC21FDE95
               	movl	$0xdaa9b5f, %edi        # imm = 0xDAA9B5F
               	movl	$0xd665ca49, %ecx       # imm = 0xD665CA49
               	movl	$0xa70480db, %esi       # imm = 0xA70480DB
               	movl	$0xd3dcc5a2, %edx       # imm = 0xD3DCC5A2
               	movq	%rax, %r8
               	movq	%rcx, %r9
               	andq	%rsi, %r9
               	movq	%rcx, %rbx
               	xorq	$-0x1, %rbx
               	andq	%rdx, %rbx
               	xorq	%rbx, %r9
               	movl	%edi, %ebx
               	rorl	$0x1b, %ebx
               	addq	%rbx, %r9
               	leaq	-0x10(%rbp), %rbx
               	movl	(%rbx,%rax,4), %ebx
               	addq	%rbx, %r9
               	addq	%r9, %r8
               	addq	$0x5a827999, %r8        # imm = 0x5A827999
               	movl	%ecx, %ecx
               	rorl	$0x2, %ecx
               	incq	%rax
               	xchgq	%rdx, %r8
               	xchgq	%rsi, %rdx
               	xchgq	%rcx, %rsi
               	xchgq	%rdi, %rcx
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vmovd	%edx, %xmm0
               	vpinsrd	$0x1, %esi, %xmm0, %xmm0
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
               	vpinsrd	$0x3, %edi, %xmm0, %xmm0
               	movl	$0x11b31b64, %ecx       # imm = 0x11B31B64
               	vmovd	%ecx, %xmm1
               	movq	$-0x60da7e8a, %rax      # imm = 0x9F258176
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	movl	$0x464e48ab, %eax       # imm = 0x464E48AB
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	movq	$-0x10007c93, %rax      # imm = 0xEFFF836D
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xaf5a022b, -0x10(%rbp) # imm = 0xAF5A022B
               	movl	$0xcd1d0205, -0xc(%rbp) # imm = 0xCD1D0205
               	movl	$0x3ead5c56, -0x8(%rbp) # imm = 0x3EAD5C56
               	xorl	%eax, %eax
               	movl	$0xc21fde95, -0x4(%rbp) # imm = 0xC21FDE95
               	movl	$0xdaa9b5f, %edi        # imm = 0xDAA9B5F
               	movl	$0xd665ca49, %esi       # imm = 0xD665CA49
               	movl	$0xa70480db, %edx       # imm = 0xA70480DB
               	movl	$0xd3dcc5a2, %ecx       # imm = 0xD3DCC5A2
               	movq	%rax, %r8
               	movq	%rsi, %r9
               	xorq	%rdx, %r9
               	xorq	%rcx, %r9
               	movl	%edi, %ebx
               	rorl	$0x1b, %ebx
               	addq	%rbx, %r9
               	leaq	-0x10(%rbp), %rbx
               	movl	(%rbx,%rax,4), %ebx
               	addq	%rbx, %r9
               	addq	%r9, %r8
               	addq	$0x6ed9eba1, %r8        # imm = 0x6ED9EBA1
               	movl	%esi, %esi
               	rorl	$0x2, %esi
               	incq	%rax
               	xchgq	%rcx, %r8
               	xchgq	%rdx, %rcx
               	xchgq	%rsi, %rdx
               	xchgq	%rdi, %rsi
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vmovd	%ecx, %xmm0
               	vpinsrd	$0x1, %edx, %xmm0, %xmm0
               	vpinsrd	$0x2, %esi, %xmm0, %xmm0
               	vpinsrd	$0x3, %edi, %xmm0, %xmm0
               	movl	$0x5d913a37, %ecx       # imm = 0x5D913A37
               	vmovd	%ecx, %xmm1
               	movl	$0x2dea0e03, %eax       # imm = 0x2DEA0E03
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	movl	$0xa4a0700, %eax        # imm = 0xA4A0700
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	movl	$0x1927c1b5, %eax       # imm = 0x1927C1B5
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xaf5a022b, -0x10(%rbp) # imm = 0xAF5A022B
               	movl	$0xcd1d0205, -0xc(%rbp) # imm = 0xCD1D0205
               	movl	$0x3ead5c56, -0x8(%rbp) # imm = 0x3EAD5C56
               	xorl	%eax, %eax
               	movl	$0xc21fde95, -0x4(%rbp) # imm = 0xC21FDE95
               	movl	$0xdaa9b5f, %edi        # imm = 0xDAA9B5F
               	movl	$0xd665ca49, %esi       # imm = 0xD665CA49
               	movl	$0xa70480db, %edx       # imm = 0xA70480DB
               	movl	$0xd3dcc5a2, %ecx       # imm = 0xD3DCC5A2
               	movq	%rax, %r8
               	movq	%rsi, %r9
               	andq	%rdx, %r9
               	movq	%rsi, %rbx
               	andq	%rcx, %rbx
               	xorq	%rbx, %r9
               	movq	%rdx, %rbx
               	andq	%rcx, %rbx
               	xorq	%rbx, %r9
               	movl	%edi, %ebx
               	rorl	$0x1b, %ebx
               	addq	%rbx, %r9
               	leaq	-0x10(%rbp), %rbx
               	movl	(%rbx,%rax,4), %ebx
               	addq	%rbx, %r9
               	addq	%r9, %r8
               	movl	$0x8f1bbcdc, %r11d      # imm = 0x8F1BBCDC
               	addq	%r11, %r8
               	movl	%esi, %esi
               	rorl	$0x2, %esi
               	incq	%rax
               	xchgq	%rcx, %r8
               	xchgq	%rdx, %rcx
               	xchgq	%rsi, %rdx
               	xchgq	%rdi, %rsi
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vmovd	%ecx, %xmm0
               	vpinsrd	$0x1, %edx, %xmm0, %xmm0
               	vpinsrd	$0x2, %esi, %xmm0, %xmm0
               	vpinsrd	$0x3, %edi, %xmm0, %xmm0
               	movq	$-0xd3c8514, %rcx       # imm = 0xF2C37AEC
               	vmovd	%ecx, %xmm1
               	movq	$-0x12291c8b, %rax      # imm = 0xEDD6E375
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	movl	$0x23493796, %eax       # imm = 0x23493796
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	movl	$0x2347af9e, %eax       # imm = 0x2347AF9E
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xaf5a022b, -0x10(%rbp) # imm = 0xAF5A022B
               	movl	$0xcd1d0205, -0xc(%rbp) # imm = 0xCD1D0205
               	movl	$0x3ead5c56, -0x8(%rbp) # imm = 0x3EAD5C56
               	xorl	%eax, %eax
               	movl	$0xc21fde95, -0x4(%rbp) # imm = 0xC21FDE95
               	movl	$0xdaa9b5f, %edi        # imm = 0xDAA9B5F
               	movl	$0xd665ca49, %esi       # imm = 0xD665CA49
               	movl	$0xa70480db, %edx       # imm = 0xA70480DB
               	movl	$0xd3dcc5a2, %ecx       # imm = 0xD3DCC5A2
               	movq	%rax, %r8
               	movq	%rsi, %r9
               	xorq	%rdx, %r9
               	xorq	%rcx, %r9
               	movl	%edi, %ebx
               	rorl	$0x1b, %ebx
               	addq	%rbx, %r9
               	leaq	-0x10(%rbp), %rbx
               	movl	(%rbx,%rax,4), %ebx
               	addq	%rbx, %r9
               	addq	%r9, %r8
               	movl	$0xca62c1d6, %r11d      # imm = 0xCA62C1D6
               	addq	%r11, %r8
               	movl	%esi, %esi
               	rorl	$0x2, %esi
               	incq	%rax
               	xchgq	%rcx, %r8
               	xchgq	%rdx, %rcx
               	xchgq	%rsi, %rdx
               	xchgq	%rdi, %rsi
               	cmpl	$0x4, %eax
               	jl	<addr>
               	vmovd	%ecx, %xmm0
               	vpinsrd	$0x1, %edx, %xmm0, %xmm0
               	vpinsrd	$0x2, %esi, %xmm0, %xmm0
               	vpinsrd	$0x3, %edi, %xmm0, %xmm0
               	movq	$-0x4b8c903c, %rcx      # imm = 0xB4736FC4
               	vmovd	%ecx, %xmm1
               	movl	$0x6112f53b, %eax       # imm = 0x6112F53B
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	movq	$-0x5f3257f2, %rax      # imm = 0xA0CDA80E
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	movl	$0xf2332cf, %eax        # imm = 0xF2332CF
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xd2be0fd9, %ecx       # imm = 0xD2BE0FD9
               	vmovd	%ecx, %xmm0
               	movl	$0x3ab9d7d7, %ecx       # imm = 0x3AB9D7D7
               	vpinsrd	$0x1, %ecx, %xmm0, %xmm0
               	movl	$0x1bf59c86, %edx       # imm = 0x1BF59C86
               	vpinsrd	$0x2, %edx, %xmm0, %xmm0
               	movl	$0x712bdf61, %esi       # imm = 0x712BDF61
               	vpinsrd	$0x3, %esi, %xmm0, %xmm0
               	movq	$-0x2d41f027, %rdi      # imm = 0xD2BE0FD9
               	vmovd	%edi, %xmm1
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x2, %edx, %xmm1, %xmm1
               	vpinsrd	$0x3, %esi, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5775367d, %ecx       # imm = 0x5775367D
               	vmovd	%ecx, %xmm0
               	movl	$0xa2f6881f, %edx       # imm = 0xA2F6881F
               	vpinsrd	$0x1, %edx, %xmm0, %xmm0
               	movl	$0xefdf8f80, %edx       # imm = 0xEFDF8F80
               	vpinsrd	$0x2, %edx, %xmm0, %xmm0
               	movl	$0xd20d5047, %edx       # imm = 0xD20D5047
               	vpinsrd	$0x3, %edx, %xmm0, %xmm0
               	vmovd	%ecx, %xmm1
               	movq	$-0x5d0977e1, %rcx      # imm = 0xA2F6881F
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movq	$-0x10207080, %rcx      # imm = 0xEFDF8F80
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	movq	$-0x2df2afb9, %rcx      # imm = 0xD20D5047
               	vpinsrd	$0x3, %ecx, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xf54dde0f, %ecx       # imm = 0xF54DDE0F
               	vmovd	%ecx, %xmm0
               	movl	$0xe87ff5a1, %eax       # imm = 0xE87FF5A1
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	movl	$0x2b6121c1, %ecx       # imm = 0x2B6121C1
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
               	movl	$0x1209722c, %edx       # imm = 0x1209722C
               	vpinsrd	$0x3, %edx, %xmm0, %xmm0
               	xorl	%eax, %eax
               	movq	$-0xab221f1, %rsi       # imm = 0xF54DDE0F
               	vmovd	%esi, %xmm1
               	movq	$-0x17800a5f, %rsi      # imm = 0xE87FF5A1
               	vpinsrd	$0x1, %esi, %xmm1, %xmm1
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x3, %edx, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	popq	%rbx
               	leave
               	retq
