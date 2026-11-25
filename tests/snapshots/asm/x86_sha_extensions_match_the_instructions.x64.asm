
x86_sha_extensions_match_the_instructions.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movabsq	$-0x32e2fdfa50a5fdd5, %rax # imm = 0xCD1D0205AF5A022B
               	movq	%rax, 0x10(%rsp)
               	movabsq	$-0x3de0216ac152a3aa, %rcx # imm = 0xC21FDE953EAD5C56
               	xorl	%eax, %eax
               	movq	%rcx, 0x18(%rsp)
               	movl	$0xdaa9b5f, %edi        # imm = 0xDAA9B5F
               	movl	$0xd665ca49, %ecx       # imm = 0xD665CA49
               	movl	$0xa70480db, %esi       # imm = 0xA70480DB
               	movl	$0xd3dcc5a2, %edx       # imm = 0xD3DCC5A2
               	movq	%rax, %rbx
               	movq	%rcx, %r9
               	andq	%rsi, %r9
               	movq	%rcx, %r8
               	xorq	$-0x1, %r8
               	andq	%rdx, %r8
               	xorq	%r8, %r9
               	movl	%edi, %r8d
               	rorl	$0x1b, %r8d
               	addq	%r9, %r8
               	movl	0x10(%rsp,%rax,4), %r9d
               	addq	%r9, %r8
               	addq	%rbx, %r8
               	addq	$0x5a827999, %r8        # imm = 0x5A827999
               	movl	%ecx, %ecx
               	rorl	$0x2, %ecx
               	incq	%rax
               	movq	%rdx, %rbx
               	movq	%rsi, %rdx
               	movq	%rcx, %rsi
               	movq	%rdi, %rcx
               	movq	%r8, %rdi
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
               	addq	$0x20, %rsp
               	retq
               	movabsq	$-0x32e2fdfa50a5fdd5, %rax # imm = 0xCD1D0205AF5A022B
               	movq	%rax, 0x10(%rsp)
               	movabsq	$-0x3de0216ac152a3aa, %rcx # imm = 0xC21FDE953EAD5C56
               	xorl	%eax, %eax
               	movq	%rcx, 0x18(%rsp)
               	movl	$0xdaa9b5f, %edi        # imm = 0xDAA9B5F
               	movl	$0xd665ca49, %esi       # imm = 0xD665CA49
               	movl	$0xa70480db, %edx       # imm = 0xA70480DB
               	movl	$0xd3dcc5a2, %ecx       # imm = 0xD3DCC5A2
               	movq	%rax, %rbx
               	movq	%rsi, %r8
               	xorq	%rdx, %r8
               	xorq	%rcx, %r8
               	movl	%edi, %r9d
               	rorl	$0x1b, %r9d
               	addq	%r9, %r8
               	movl	0x10(%rsp,%rax,4), %r9d
               	addq	%r9, %r8
               	addq	%rbx, %r8
               	addq	$0x6ed9eba1, %r8        # imm = 0x6ED9EBA1
               	movl	%esi, %esi
               	rorl	$0x2, %esi
               	incq	%rax
               	movq	%rcx, %rbx
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	%rdi, %rsi
               	movq	%r8, %rdi
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
               	addq	$0x20, %rsp
               	retq
               	movabsq	$-0x32e2fdfa50a5fdd5, %rax # imm = 0xCD1D0205AF5A022B
               	movq	%rax, 0x10(%rsp)
               	movabsq	$-0x3de0216ac152a3aa, %rcx # imm = 0xC21FDE953EAD5C56
               	xorl	%eax, %eax
               	movq	%rcx, 0x18(%rsp)
               	movl	$0xdaa9b5f, %edi        # imm = 0xDAA9B5F
               	movl	$0xd665ca49, %esi       # imm = 0xD665CA49
               	movl	$0xa70480db, %edx       # imm = 0xA70480DB
               	movl	$0xd3dcc5a2, %ecx       # imm = 0xD3DCC5A2
               	movq	%rax, %rbx
               	movq	%rsi, %r8
               	andq	%rdx, %r8
               	movq	%rsi, %r9
               	andq	%rcx, %r9
               	xorq	%r9, %r8
               	movq	%rdx, %r9
               	andq	%rcx, %r9
               	xorq	%r9, %r8
               	movl	%edi, %r9d
               	rorl	$0x1b, %r9d
               	addq	%r9, %r8
               	movl	0x10(%rsp,%rax,4), %r9d
               	addq	%r9, %r8
               	addq	%rbx, %r8
               	movl	$0x8f1bbcdc, %r11d      # imm = 0x8F1BBCDC
               	addq	%r11, %r8
               	movl	%esi, %esi
               	rorl	$0x2, %esi
               	incq	%rax
               	movq	%rcx, %rbx
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	%rdi, %rsi
               	movq	%r8, %rdi
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
               	addq	$0x20, %rsp
               	retq
               	movabsq	$-0x32e2fdfa50a5fdd5, %rax # imm = 0xCD1D0205AF5A022B
               	movq	%rax, 0x10(%rsp)
               	movabsq	$-0x3de0216ac152a3aa, %rcx # imm = 0xC21FDE953EAD5C56
               	xorl	%eax, %eax
               	movq	%rcx, 0x18(%rsp)
               	movl	$0xdaa9b5f, %edi        # imm = 0xDAA9B5F
               	movl	$0xd665ca49, %esi       # imm = 0xD665CA49
               	movl	$0xa70480db, %edx       # imm = 0xA70480DB
               	movl	$0xd3dcc5a2, %ecx       # imm = 0xD3DCC5A2
               	movq	%rax, %rbx
               	movq	%rsi, %r8
               	xorq	%rdx, %r8
               	xorq	%rcx, %r8
               	movl	%edi, %r9d
               	rorl	$0x1b, %r9d
               	addq	%r9, %r8
               	movl	0x10(%rsp,%rax,4), %r9d
               	addq	%r9, %r8
               	addq	%rbx, %r8
               	movl	$0xca62c1d6, %r11d      # imm = 0xCA62C1D6
               	addq	%r11, %r8
               	movl	%esi, %esi
               	rorl	$0x2, %esi
               	incq	%rax
               	movq	%rcx, %rbx
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	%rdi, %rsi
               	movq	%r8, %rdi
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
               	addq	$0x20, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
