
inline_asm_x64_sse.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movl	$0x13, %r10d
               	movl	$0x17, %r11d
               	movd	%r10d, %xmm0
               	movd	%r11d, %xmm1
               	paddd	%xmm1, %xmm0
               	movd	%xmm0, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x17, %ecx
               	movd	%ecx, %xmm0
               	paddd	<rip>, %xmm0 # <addr>
               	movd	%xmm0, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x2a0000002a, %rax     # imm = 0x2A0000002A
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rcx), %xmm0
               	movdqu	%xmm0, (%rax)
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x15, %r10d
               	movd	%r10d, %xmm0
               	pslld	$0x1, %xmm0
               	movd	%xmm0, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %r10d
               	movl	$0x2a, %r11d
               	movd	%r10d, %xmm0
               	movd	%r11d, %xmm1
               	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
               	pshufd	$0x1, %xmm0, %xmm0      # xmm0 = xmm0[1,0,0,0]
               	movd	%xmm0, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %r10d
               	movq	%r10, %xmm0
               	movq	%xmm0, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movdqu	<rip>, %xmm0 # <addr>
               	cvtdq2ps	%xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	shufps	$0x1b, %xmm0, %xmm0     # xmm0 = xmm0[3,2,1,0]
               	movdqu	%xmm0, (%rax)
               	movl	-0x20(%rbp), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	movdqa	%xmm0, %xmm7
               	paddd	%xmm1, %xmm7
               	movdqa	%xmm7, %xmm0
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ecx, %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	vpaddd	%xmm1, %xmm0, %xmm0
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ecx, %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	vmovdqu	<rip>, %xmm0 # <addr>
               	vmovdqu	%xmm0, (%rax)
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	vpaddd	<rip>, %xmm1, %xmm0 # <addr>
               	movl	-0x10(%rbp), %eax
               	movl	-0x4(%rbp), %ecx
               	addq	%rcx, %rax
               	subq	$0x2a, %rax
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ecx, %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	vpmulld	%xmm1, %xmm0, %xmm0
               	vpshufd	$0x1b, %xmm0, %xmm0     # xmm0 = xmm0[3,2,1,0]
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movq	%rcx, %rsi
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ecx, %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	%esi, %eax
               	shrq	$0xc, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm4
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm5
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm6
               	cvtdq2ps	%xmm4, %xmm0
               	cvtdq2ps	%xmm5, %xmm1
               	cvtdq2ps	%xmm6, %xmm2
               	vfmadd231ps	%xmm0, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm0) + xmm2
               	cvtps2dq	%xmm2, %xmm3
               	vpextrd	$0x3, %xmm3, %eax
               	movslq	%eax, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movq	%rbx, %rsi
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ecx, %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	%esi, %eax
               	shrq	$0x5, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x15, %r10d
               	movd	%r10d, %xmm0
               	vpbroadcastd	%xmm0, %xmm1
               	vpaddd	%xmm1, %xmm1, %xmm2
               	vpextrd	$0x2, %xmm2, %eax
               	movslq	%eax, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movq	%rbx, %rsi
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ecx, %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	%esi, %eax
               	shrq	$0x5, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	vpsllvd	%xmm1, %xmm0, %xmm0
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movq	%rbx, %rsi
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ecx, %eax
               	shrq	$0x1c, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	%esi, %eax
               	shrq	$0x5, %rax
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm1
               	vpblendd	$0x8, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2],xmm1[3]
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	decq	%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
