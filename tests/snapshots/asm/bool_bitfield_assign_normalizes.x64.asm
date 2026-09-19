
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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x0, (%rax)
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movb	$0x0, (%rax)
               	movb	$0x2, (%rax)
               	movb	$0x3, (%rax)
               	movb	$0x1, (%rax)
               	movb	$0x3, (%rax)
               	movb	$0x3, (%rax)
               	movb	$0x1, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movb	$0x0, (%rax)
               	movb	$0x1, (%rax)
               	movb	$0x3, (%rax)
               	movb	$0x3, (%rax)
               	movb	$0x2, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movb	$0x3, (%rax)
               	xorl	%esi, %esi
               	movq	%rdx, %xmm14
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	andq	$0x1, %rcx
               	shlq	%rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	sarq	%rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
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
               	sarq	$0x2, %rdx
               	andq	$0x7, %rdx
               	xorq	$0x2, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rdx, %xmm14
               	cvttsd2si	%xmm14, %rdx
               	andq	$0xf, %rdx
               	andq	$-0x1e1, %rcx           # imm = 0xFE1F
               	movq	%rdx, %rdi
               	shlq	$0x5, %rdi
               	orq	%rdi, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %edx
               	sarq	$0x5, %rdx
               	andq	$0xf, %rdx
               	shlq	$0x3c, %rdx
               	sarq	$0x3c, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	andq	$-0x1d, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %eax
               	sarq	$0x2, %rax
               	andq	$0x7, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	andq	$-0x1d, %rcx
               	orq	$0x4, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %edx
               	sarq	$0x2, %rdx
               	andq	$0x7, %rdx
               	xorq	$0x1, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	andq	$-0x1e1, %rcx           # imm = 0xFE1F
               	orq	$0x120, %rcx            # imm = 0x120
               	movl	%ecx, (%rax)
               	movl	%ecx, %ecx
               	sarq	$0x5, %rcx
               	andq	$0xf, %rcx
               	shlq	$0x3c, %rcx
               	sarq	$0x3c, %rcx
               	cmpl	$-0x7, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movzbq	(%rcx), %rdx
               	sarq	%rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	(%rcx), %edx
               	sarq	$0x2, %rdx
               	andq	$0x7, %rdx
               	xorq	$0x1, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	(%rcx), %ecx
               	sarq	$0x5, %rcx
               	andq	$0xf, %rcx
               	shlq	$0x3c, %rcx
               	sarq	$0x3c, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	cmpb	$0x0, 0x1(%rcx)
               	jne	<addr>
               	movzbq	0x2(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	cmpb	$0x0, 0x1(%rcx)
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	movzbq	0x2(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	movzbq	(%rcx), %rcx
               	sarq	%rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movb	%sil, (%rax)
               	movb	$0x2, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x1d, %rcx
               	movl	%ecx, (%rax)
               	andq	$-0x1e1, %rcx           # imm = 0xFE1F
               	movl	%ecx, (%rax)
               	movzbq	(%rax), %rax
               	sarq	%rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x2, 0x8(%rax)
               	movzbq	0x8(%rax), %rcx
               	andq	$-0x3, %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x8(%rax), %rax
               	sarq	%rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x26, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
