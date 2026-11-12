
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
               	movq	$-0x3de0216b, %rax      # imm = 0xC21FDE95
               	vmovd	%eax, %xmm0
               	movl	$0x3ead5c56, %eax       # imm = 0x3EAD5C56
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	movq	$-0x32e2fdfb, %rcx      # imm = 0xCD1D0205
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
               	movabsq	$0x172c4a902, %rcx      # imm = 0x172C4A902
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	movabsq	$0x3ead5c56c21fde95, %r11 # imm = 0x3EAD5C56C21FDE95
               	vmovq	%r11, %xmm1
               	vpbroadcastq	%xmm1, %xmm1
               	movabsq	$0x72c4a902cd1d0205, %r11 # imm = 0x72C4A902CD1D0205
               	vmovq	%r11, %xmm2
               	vunpcklpd	%xmm2, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm2[0]
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	pmovmskb	%xmm0, %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x85e82f01ec1c7a7, %r11 # imm = 0x85E82F01EC1C7A7
               	vmovq	%r11, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	movabsq	$-0x5551e47bfa46f015, %r11 # imm = 0xAAAE1B8405B90FEB
               	vmovq	%r11, %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm2 # xmm2 = xmm0[0],xmm1[0]
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	vpcmpeqd	%xmm0, %xmm2, %xmm0
               	pmovmskb	%xmm0, %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x35c943635a9811d2, %r11 # imm = 0xCA36BC9CA567EE2E
               	vmovq	%r11, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	movabsq	$-0x7e90cd4a2e6ed3c1, %r11 # imm = 0x816F32B5D1912C3F
               	vmovq	%r11, %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm2 # xmm2 = xmm0[0],xmm1[0]
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	vpcmpeqd	%xmm0, %xmm2, %xmm0
               	pmovmskb	%xmm0, %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xaf5a022b, -0x10(%rbp) # imm = 0xAF5A022B
               	movl	$0xcd1d0205, -0xc(%rbp) # imm = 0xCD1D0205
               	movl	%eax, -0x8(%rbp)
               	xorl	%eax, %eax
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
               	movabsq	$-0x60da7e89ee4ce49c, %r11 # imm = 0x9F25817611B31B64
               	vmovq	%r11, %xmm1
               	vpbroadcastq	%xmm1, %xmm1
               	movabsq	$-0x10007c92b9b1b755, %r11 # imm = 0xEFFF836D464E48AB
               	vmovq	%r11, %xmm2
               	vunpcklpd	%xmm2, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm2[0]
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
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
               	movabsq	$0x2dea0e035d913a37, %r11 # imm = 0x2DEA0E035D913A37
               	vmovq	%r11, %xmm1
               	vpbroadcastq	%xmm1, %xmm1
               	movabsq	$0x1927c1b50a4a0700, %r11 # imm = 0x1927C1B50A4A0700
               	vmovq	%r11, %xmm2
               	vunpcklpd	%xmm2, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm2[0]
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
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
               	movabsq	$-0x12291c8a0d3c8514, %r11 # imm = 0xEDD6E375F2C37AEC
               	vmovq	%r11, %xmm1
               	vpbroadcastq	%xmm1, %xmm1
               	movabsq	$0x2347af9e23493796, %r11 # imm = 0x2347AF9E23493796
               	vmovq	%r11, %xmm2
               	vunpcklpd	%xmm2, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm2[0]
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
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
               	movabsq	$0x6112f53bb4736fc4, %r11 # imm = 0x6112F53BB4736FC4
               	vmovq	%r11, %xmm1
               	vpbroadcastq	%xmm1, %xmm1
               	movabsq	$0xf2332cfa0cda80e, %r11 # imm = 0xF2332CFA0CDA80E
               	vmovq	%r11, %xmm2
               	vunpcklpd	%xmm2, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm2[0]
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x3ab9d7d7d2be0fd9, %r11 # imm = 0x3AB9D7D7D2BE0FD9
               	vmovq	%r11, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	movabsq	$0x712bdf611bf59c86, %r11 # imm = 0x712BDF611BF59C86
               	vmovq	%r11, %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm2 # xmm2 = xmm0[0],xmm1[0]
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	vpcmpeqd	%xmm0, %xmm2, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x5d0977e0a88ac983, %r11 # imm = 0xA2F6881F5775367D
               	vmovq	%r11, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	movabsq	$-0x2df2afb810207080, %r11 # imm = 0xD20D5047EFDF8F80
               	vmovq	%r11, %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm2 # xmm2 = xmm0[0],xmm1[0]
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	vpcmpeqd	%xmm0, %xmm2, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x17800a5e0ab221f1, %r11 # imm = 0xE87FF5A1F54DDE0F
               	vmovq	%r11, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	movabsq	$0x1209722c2b6121c1, %r11 # imm = 0x1209722C2B6121C1
               	vmovq	%r11, %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm2 # xmm2 = xmm0[0],xmm1[0]
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	vpcmpeqd	%xmm0, %xmm2, %xmm0
               	pmovmskb	%xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
