
bool_bitfield_assign_normalizes.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x20(%rbp,%riz)
               	movb	%cl, (%rax)
               	movl	$0x2, %ecx
               	movb	%cl, (%rax)
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	movl	$0x1, %edx
               	movb	%dl, (%rax)
               	movb	%cl, (%rax)
               	movb	%cl, (%rax)
               	movb	%dl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	movb	%cl, (%rax)
               	movl	$0x2, %edx
               	movb	%dl, (%rax)
               	movb	%cl, (%rax)
               	movsd	-0x20(%rbp,%riz), %xmm0
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	andq	$0x1, %rcx
               	shlq	%rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	sarq	%rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movq	%rcx, %xmm14
               	cvttsd2si	%xmm14, %rcx
               	andq	$0x7, %rcx
               	movl	(%rax), %edx
               	andq	$-0x1d, %rdx
               	shlq	$0x2, %rcx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	sarq	$0x2, %rsi
               	andq	$0x7, %rsi
               	xorq	$0x2, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rsi # imm = 0x3FF8000000000000
               	movq	%rsi, %xmm14
               	cvttsd2si	%xmm14, %rsi
               	andq	$0xf, %rsi
               	movq	%rdx, %rcx
               	andq	$-0x1e1, %rcx           # imm = 0xFE1F
               	movq	%rsi, %rdx
               	shlq	$0x5, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	sarq	$0x5, %rsi
               	andq	$0xf, %rsi
               	shlq	$0x3c, %rsi
               	sarq	$0x3c, %rsi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rcx
               	andq	$-0x1d, %rcx
               	orq	$0x0, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	sarq	$0x2, %rsi
               	andq	$0x7, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rcx
               	andq	$-0x1d, %rcx
               	orq	$0x4, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %edx
               	movq	%rdx, %rax
               	sarq	$0x2, %rax
               	andq	$0x7, %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rdx, %rcx
               	andq	$-0x1e1, %rcx           # imm = 0xFE1F
               	orq	$0x120, %rcx            # imm = 0x120
               	movl	%ecx, (%rax)
               	movl	%ecx, %ecx
               	sarq	$0x5, %rcx
               	andq	$0xf, %rcx
               	shlq	$0x3c, %rcx
               	sarq	$0x3c, %rcx
               	cmpq	$-0x7, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	sarq	%rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	sarq	$0x2, %rcx
               	andq	$0x7, %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	sarq	$0x5, %rcx
               	andq	$0xf, %rcx
               	shlq	$0x3c, %rcx
               	sarq	$0x3c, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	movl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movzbq	0x1(%rcx), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movzbq	0x2(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1b, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	0x1(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	0x2(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	sarq	%rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movb	%cl, (%rax)
               	movl	$0x2, %edx
               	movb	%dl, (%rax)
               	movl	(%rax), %esi
               	andq	$-0x1d, %rsi
               	orq	%rcx, %rsi
               	movl	%esi, (%rax)
               	movl	%esi, %esi
               	andq	$-0x1e1, %rsi           # imm = 0xFE1F
               	orq	%rcx, %rsi
               	movl	%esi, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	sarq	%rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movb	%dl, 0x8(%rax)
               	movzbq	0x8(%rax), %rcx
               	sarq	%rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x25, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movzbq	0x8(%rax), %rcx
               	andq	$-0x3, %rcx
               	orq	$0x0, %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x8(%rax), %rax
               	sarq	%rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x26, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
