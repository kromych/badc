
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
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	movl	$0x2, %ecx
               	movb	%cl, (%rax)
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	movl	$0x1, %esi
               	movb	%sil, (%rax)
               	movb	%cl, (%rax)
               	movb	%cl, (%rax)
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	xorq	%rsi, %rsi
               	movb	%sil, (%rax)
               	movb	%cl, (%rax)
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	movb	%cl, (%rax)
               	movl	$0x2, %esi
               	movb	%sil, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movb	%cl, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	andq	$0x1, %rdx
               	shlq	%rdx
               	orq	$0x1, %rdx
               	movb	%dl, (%rax)
               	sarq	%rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movq	%rdx, %xmm14
               	cvttsd2si	%xmm14, %rdx
               	andq	$0x7, %rdx
               	movl	(%rax), %esi
               	andq	$-0x1d, %rsi
               	shlq	$0x2, %rdx
               	orq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	%edx, %esi
               	movq	%rsi, %rdi
               	sarq	$0x2, %rdi
               	andq	$0x7, %rdi
               	xorq	$0x2, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm14
               	cvttsd2si	%xmm14, %rdi
               	andq	$0xf, %rdi
               	movq	%rsi, %rdx
               	andq	$-0x1e1, %rdx           # imm = 0xFE1F
               	movq	%rdi, %rsi
               	shlq	$0x5, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	%edx, %esi
               	movq	%rsi, %rdi
               	sarq	$0x5, %rdi
               	andq	$0xf, %rdi
               	shlq	$0x3c, %rdi
               	sarq	$0x3c, %rdi
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	%rsi, %rdx
               	andq	$-0x1d, %rdx
               	orq	$0x0, %rdx
               	movl	%edx, (%rax)
               	movl	%edx, %esi
               	movq	%rsi, %rax
               	sarq	$0x2, %rax
               	andq	$0x7, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rsi, %rdx
               	andq	$-0x1d, %rdx
               	orq	$0x4, %rdx
               	movl	%edx, (%rax)
               	movl	%edx, %esi
               	movq	%rsi, %rdi
               	sarq	$0x2, %rdi
               	andq	$0x7, %rdi
               	xorq	$0x1, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movq	%rsi, %rdx
               	andq	$-0x1e1, %rdx           # imm = 0xFE1F
               	orq	$0x120, %rdx            # imm = 0x120
               	movl	%edx, (%rax)
               	movl	%edx, %edx
               	sarq	$0x5, %rdx
               	andq	$0xf, %rdx
               	shlq	$0x3c, %rdx
               	sarq	$0x3c, %rdx
               	cmpq	$-0x7, %rdx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	(%rdx), %rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	(%rdx), %rdx
               	sarq	%rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edx
               	sarq	$0x2, %rdx
               	andq	$0x7, %rdx
               	xorq	$0x1, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edx
               	sarq	$0x5, %rdx
               	andq	$0xf, %rdx
               	shlq	$0x3c, %rdx
               	sarq	$0x3c, %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movzbq	0x1(%rdx), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movzbq	0x2(%rdx), %rdx
               	cmpl	$0x1, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	0x1(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	0x2(%rdx), %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	(%rdx), %rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movzbq	(%rdx), %rdx
               	sarq	%rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	xorq	%rdx, %rdx
               	movb	%dl, (%rax)
               	movl	$0x2, %esi
               	movb	%sil, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %edi
               	andq	$-0x1d, %rdi
               	orq	%rcx, %rdi
               	movl	%edi, (%rax)
               	movl	%edi, %edi
               	andq	$-0x1e1, %rdi           # imm = 0xFE1F
               	orq	%rdi, %rcx
               	movl	%ecx, (%rax)
               	movzbq	(%rax), %rax
               	sarq	%rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	%sil, 0x8(%rax)
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
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
